#!/bin/bash
set -x

#user=builduser uid=1000 gid=1000 buildah unshare ./buildYoctoContainer.sh 2>&1 | tee buildlog


container=$(buildah from ubuntu:22.04)
echo "The container is $container"

mountpoint=$(buildah mount ${container})
echo "Mount point: $mountpoint"

# Check wether squid-deb-proxy-client's APT avahi discover is installed.
if [[ -z "${http_proxy}" ]]; then
  aad="/usr/share/squid-deb-proxy-client/apt-avahi-discover"
  if [ -f "$aad" ]; then
    export http_proxy=$($aad)
    echo "APT proxy/cacher detected at $http_proxy"
  fi
fi

#Setup config env for timezone so apt can succeed noninteractive
buildah config --env DEBIAN_FRONTEND=noninteractive $container
buildah config --env TZ=America/Los_Angeles $container

# Be sure to have the latest metadata.
buildah run $container apt update

# Install the software we need for Yocto and some extra tools.
buildah run $container apt-get install --yes \
    bc bison bsdmainutils build-essential curl locales \
    flex g++-multilib gcc-multilib git gnupg gperf lib32ncurses5-dev \
    lib32z1-dev libncurses5-dev git-lfs \
    libsdl1.2-dev libxml2-utils lzop \
    openjdk-8-jdk lzop wget git-core unzip \
    genisoimage sudo socat xterm gawk cpio texinfo \
    gettext vim diffstat chrpath rsync \
    python-mako libusb-1.0-0-dev exuberant-ctags \
    pngcrush schedtool xsltproc zip zlib1g-dev libswitch-perl \
    p7zip-full lsb-release python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 \
    libegl1-mesa pylint3 xterm python3-subunit mesa-common-dev qemu \
    liblz4-tool device-tree-compiler quilt patchelf zstd htop vim ncdu \
    libgbm-dev clang bmap-tools

# Optional tools that are useful in development environments
buildah run $container apt-get install --yes tree tmux

buildah run $container apt-get clean

if [[ -z "${user}" ]]; then
  user=$USER
fi

if [[ -z "${uid}" ]]; then
  uid=$(id -u)
fi

if [[ -z "${gid}" ]]; then
  gid=$(id -g)
fi

echo "Using user $user with UID $uid and GID $gid"

# ===== create user/setup environment =====
mkdir -p ${mountpoint}/home/${user} && \
echo "${user}:x:${uid}:${gid}:${user},,,:/home/${user}:/bin/bash" >> ${mountpoint}/etc/passwd && \
echo "${user}:x:${uid}:" >> ${mountpoint}/etc/group && \
echo "${user} ALL=(ALL) NOPASSWD: ALL" > ${mountpoint}/etc/sudoers.d/${user} && \
chmod 0440 ${mountpoint}/etc/sudoers.d/${user} && \
chown ${uid}:${gid} -R ${mountpoint}/home/${user}

# Configure ccache.
buildah config --env USE_CCACHE=1 $container
buildah config --env CCACHE_DIR=/home/${user}/.ccache $container

# some QT-Apps/Gazebo do not show controls without this
buildah config --env QT_X11_NO_MITSHM=1 $container

# Set the locale
buildah run $container locale-gen en_US.UTF-8
buildah config --env LANG=en_US.UTF-8 $container

# Clean up apt.
buildah run $container apt clean
buildah run $container apt autoremove
buildah run $container rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

buildah config --env HOME=/home/${user} $container
buildah config --env USER=${user} $container
buildah config --user ${user} $container
buildah config --workingdir /home/${user} $container

#git clone projects
buildah run $container git clone -b kirkstone --depth=1 git://git.yoctoproject.org/poky /home/${user}/poky
buildah run $container git clone -b kirkstone --depth=1 https://github.com/openembedded/meta-openembedded.git /home/${user}/meta-openembedded
buildah run $container git clone -b kirkstone --depth=1 https://github.com/kraj/meta-clang.git /home/${user}/meta-clang
buildah run $container git clone -b kirkstone --depth=1 https://github.com/guster32/meta-arcadia.git /home/${user}/meta-arcadia
buildah run $container git clone -b master --depth=1 https://github.com/meta-rust/meta-rust.git /home/${user}/meta-rust

buildah run $container chown -R ${user} /home/${user}

# Finally save the running container to an image
buildah commit --format docker $container yocto_ubuntu_22.04:latest
buildah unmount $container
