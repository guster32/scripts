# scripts
NOTEs:

 Create scripts for visualizing package dependencies
 bitbake -g <your-target> && cat pn-depends.dot | grep -B2 -A2 gobject-introspection | dot -Tpng > depends.png


Reminder on how to create a patch:
clone repo and make changes then:
git add .
git commit -m "Updated Assembly directives"
git format-patch -1 HEAD
mv 0001-Updated-Assembly-directives.patch ~/git/guster32/meta-odroid/recipes-kernel/linux/linux-hardkernel-4.14
git reset --soft HEAD~1 && git restore --staged .

then add file to recipe.