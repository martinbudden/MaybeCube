include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>

include <NopSCADlib/vitamins/extrusions.scad>

use <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>


eSize = 20;
jigColor = rr_green;

module Side_Panel_Jig_stl() {
    offset = 5;
    fillet = 1.5;
    size = [185, 85, 3];

    stl("Side_Panel_Jig")
        color(jigColor)
            translate_z(-size.z)
                difference() {
                    translate([-offset, -offset, 0]) {
                        rounded_cube_xy([size.x, eSize + offset, size.z], fillet);
                        rounded_cube_xy([eSize + offset, size.y, size.z], fillet);
                        rounded_cube_xy([size.x, offset, 2*size.z], fillet);
                        rounded_cube_xy([offset, size.y, 2*size.z], fillet);
                    }
                    boltHole(3, 2*size.z, twist=3);
                    //sizeX = eZ;
                    for (x = [eSize, 3* eSize/2, eSize + 50, eSize + 120, eSize + 150])
                        translate([x, eSize/2, 0])
                            boltHole(2, size.z, twist=3);
                    for (y = [eSize/2, eSize, 3* eSize/2, eSize + 50])
                        translate([eSize/2, y, 0])
                            boltHole(2, size.z, twist=3);
                }
}

if ($preview)
    Side_Panel_Jig_stl();
