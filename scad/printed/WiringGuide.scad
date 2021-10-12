include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


wiringDiameter = 7;
sideThickness = 6.5;
wiringGuideSize = [30, 15, 5];
wiringGuideClampSize = [wiringDiameter + 2*sideThickness, wiringGuideSize.y, 2.5];

module Wiring_Guide_stl() {
    stl("Wiring_Guide")
        color(pp1_colour)
            wiringGuide(wiringGuideSize);
}

module wiringGuide(size) {
    fillet = 1.5;
    translate([-size.x/2, eSize - size.y, 0])
        difference() {
            union() {
                rounded_cube_xy([size.x, size.y, 3], fillet);
                for (x = [0, (size.x + wiringDiameter)/2])
                    translate([x, 0, 0])
                        rounded_cube_xy([(size.x - wiringDiameter)/2, size.y, size.z - 0.25], fillet);
                for (x = [(size.x + wiringDiameter)/2, (size.x - wiringDiameter)/2 - sideThickness])
                    translate([x, 0, 0])
                        rounded_cube_xy([sideThickness, size.y, wiringDiameter + 2], fillet);
            }
            if (size.y >= eSize)
                for (x = [5, size.x - 5])
                    translate([x, size.y/2, 0])
                        boltHoleM3(size.z, twist=4);
            for (x = [(size.x - wiringDiameter - sideThickness)/2, (size.x + wiringDiameter + sideThickness)/2])
                translate([x, size.y/2, 0])
                    boltHoleM3Tap(size.z + wiringDiameter);
        }
}

module Wiring_Guide_hardware() {
    size = wiringGuideSize;

    if (size.y >= eSize)
        for (x = [5 - size.x/2, size.x/2 - 5])
            translate([x, size.y/2, size.z])
                boltM3ButtonheadHammerNut(_frameBoltLength);
}

module Wiring_Guide_Clamp_stl() {
    stl("Wiring_Guide_Clamp")
        color(pp2_colour)
            wiringGuideClamp(wiringGuideClampSize);
}

module wiringGuideClamp(size) {
    fillet = 1.5;
    translate([-size.x/2, eSize - size.y, 0])
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
        translate([x, eSize - size.y/2, size.z])
            boltM3Buttonhead(8);
}

module Wiring_Guide_Socket_stl() {
    size = [wiringGuideSize.x + eSize, eSize, 10];
    fillet = 1.5;

    stl("Wiring_Guide_Socket")
        color(pp3_colour)
            vflip()
                translate([-size.x/2, 0, 0])
                    difference() {
                        union() {
                            rounded_cube_xy([size.x, 5, 3], fillet);
                            size1 = [eSize, 5, size.z];
                            for (x = [0, size.x - size1.x])
                                translate([x, 0, 0])
                                    rounded_cube_xy(size1, fillet);
                            size2 = [(size.x - wiringGuideSize.x)/2, size.y, size.z];
                            for (x = [0, size.x - size2.x])
                                translate([x, 0, 0])
                                    rounded_cube_xy(size2, fillet);
                            size3 = [(size.x - wiringGuideSize.x)/2 + 5, size.y, size.z/2];
                            for (x = [0, size.x - size3.x])
                                translate([x, 0, size.z/2])
                                    rounded_cube_xy(size3, fillet);
                        }
                        for (x = [5, size.x - 5])
                            translate([x, size.y/2, size.z])
                                vflip()
                                    boltHoleM3HangingCounterbore(size.z - 5, boreDepth=size.z - 5);
                    }
}

module Wiring_Guide_Socket_hardware() {
    size = [wiringGuideSize.x + eSize, eSize, 10];
    vflip()
        for (x = [5, size.x - 5])
            translate([x - size.x/2, size.y/2, size.z/2])
                boltM4ButtonheadHammerNut(_frameBoltLength);
}

module wiringGuidePosition(offset=wiringDiameter) {
    translate([eX/2 + eSize, eY + eSize - offset, eZ - eSize])
        rotate([90, 0, 0])
            children();
}
