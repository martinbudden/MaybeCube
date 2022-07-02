include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/extrusions.scad>

include <../vitamins/nuts.scad>


eSize = 20;
jigColor = rr_green;

module Panel_Jig_stl() {
    offset = 5;
    fillet = 1.5;
    size = [178, 80, 3];

    stl("Panel_Jig")
        color(jigColor)
            translate_z(-size.z)
                difference() {
                    translate([-offset, -offset, 0]) {
                        rounded_cube_xy([size.x, eSize + offset, size.z], fillet);
                        rounded_cube_xy([eSize + offset, size.y, size.z], fillet);
                        rounded_cube_xy([size.x, offset, 2*size.z], fillet);
                        rounded_cube_xy([offset, size.y, 2*size.z], fillet);
                    }
                    translate([size.x - offset-18, -10, -eps])
                        rotate(-45)
                            cube([20, 30, 2*size.z + 2*eps]);
                    boltHole(3, 2*size.z, twist=4);
                    translate([size.x/2, 1, 0])
                        hull() {
                            for (x = [-5, 5])
                                translate([x, 0, 0])
                                    boltHole(2, 2*size.z, cnc=true);
                        }
                    translate([1, size.y/2, 0])
                        hull() {
                            for (y = [-5, 5])
                                translate([0, y, 0])
                                    boltHole(2, 2*size.z, cnc=true);
                        }
                    //for (x = [eSize, 3*eSize/2, 35, eSize + 50, eSize + 105, eSize + 120, eSize + 150]) // old
                    //for (x = [eSize, 3*eSize/2, 5*eSize/2, 7*eSize/2, 125, 133.5, 140, 150, 170]) // add 133.5 and 150 for MC350
                    for (x = [eSize, 3*eSize/2, 5*eSize/2, 7*eSize/2, 125, 140, 170])
                        translate([x, eSize/2, 0])
                            boltHole(2, size.z, twist=4);
                    //for (y = [eSize/2, eSize, 3*eSize/2, eSize + 15, eSize + 50]) // old
                    for (y = [eSize/2, eSize, 3*eSize/2, 5*eSize/2, 7*eSize/2])
                        translate([eSize/2, y, 0])
                            boltHole(2, size.z, twist=4);
                }
}

if ($preview)
    Panel_Jig_stl();
