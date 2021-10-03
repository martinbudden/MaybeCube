include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


wiringDiameter = 7;
sideThickness = 6.5;
wiringGuideSize = [40, eSize, 5];
wiringGuideClampSize = [wiringDiameter + 2*sideThickness, eSize, 2.5];

module Wiring_Guide_stl() {
    size = wiringGuideSize;
    fillet = 1.5;

    stl("Wiring_Guide")
        color(pp1_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy([size.x, size.y, 3], fillet);
                        rounded_cube_xy([(size.x - wiringDiameter)/2, size.y, size.z], fillet);
                        translate([(size.x + wiringDiameter)/2, 0, 0]) {
                            rounded_cube_xy([(size.x - wiringDiameter)/2, size.y, size.z], fillet);
                            rounded_cube_xy([sideThickness, size.y, wiringDiameter + 2], fillet);
                        }
                        translate([(size.x - wiringDiameter)/2 - sideThickness, 0, 0])
                            rounded_cube_xy([sideThickness, size.y, wiringDiameter + 2], fillet);
                    }
                    for (x = [5, size.x - 5])
                        translate([x, size.y/2, 0])
                            boltHoleM3(size.z, twist=3);
                    for (x = [(size.x - wiringDiameter - sideThickness)/2, (size.x + wiringDiameter + sideThickness)/2])
                        translate([x, size.y/2, 0])
                            boltHoleM3Tap(size.z + wiringDiameter);
                }
}

module Wiring_Guide_hardware() {
    size = wiringGuideSize;

    for (x = [5 - size.x/2, size.x/2 - 5])
        translate([x, size.y/2, size.z])
            boltM3ButtonheadHammerNut(_frameBoltLength);
}

module Wiring_Guide_Clamp_stl() {
    size = wiringGuideClampSize;
    fillet = 1.5;

    stl("Wiring_Guide_Clamp")
        color(pp2_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    rounded_cube_xy(size, fillet);
                    for (x = [sideThickness/2, size.x - sideThickness/2])
                        translate([x, size.y/2, 0])
                            boltHoleM3(size.z, twist=3);
                }
}

module Wiring_Guide_Clamp_hardware() {
    size = wiringGuideClampSize;

    for (x = [-size.x/2 + sideThickness/2, size.x/2 - sideThickness/2])
        translate([x, size.y/2, size.z])
            boltM3Buttonhead(8);
}

module wiringGuidePosition(offset=wiringDiameter) {
    translate([eX/2 + eSize, eY + eSize, eZ - 2*eSize])
        rotate([90, 0, 0])
            translate_z(offset)
                children();
}
