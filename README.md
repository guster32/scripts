# scripts
NOTEs:

 Create scripts for visualizing package dependencies 
 bitbake -g <your-target> && cat pn-depends.dot | grep -B2 -A2 gobject-introspection | dot -Tpng > depends.png
