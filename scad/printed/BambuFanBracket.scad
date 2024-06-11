include <../global_defs.scad>

use <NopSCADlib/vitamins/blower.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <../printed/extruderBracket.scad>

include <../Parameters_Main.scad>

holeOffsetY = 15;
fanOffsetY = 134;
bambuFanBracketSize = [165, spoolHeight() - 40, 3];
bambuFanBracketSize300 = [165, 155, 3];
bambuFanBracketSize350 = [165, 205, 3];

SN120x32=["SN120x32","Snowfan YY12032",      120,  120, 32, 115,   M3_cap_screw, 70, [60,   60  ], 2.4, [[6,6],[112,6],[6,112],[112,112]], 58, 29.5, 1.5, 1.5, 1.1, 1.5, 1.1];

module bambuFanHolePositions(z=0) {
    translate([39, 0, 0]) {
        translate([0, 0, z])
            children();
        translate([78, 0, z])
            children();
        translate([78 + 22.5 + 9.5, 112 + 9, z])
            rotate(90)
                children();
    }
}

module bambuFan() {
    vitamin(str(": Bambu Lab X1 & P1 Auxiliary Part Cooling Fan"));

    color(grey(20))
        translate([15, 11, 0]) {
            blower_fan(SN120x32, casing_is_square=true);
            translate([60, 60, 1])
                cylinder(r=21, h= 28);
        }
    color(grey(40)) {
        translate([15, 6, 0]) {
            size = [127, 127, 35];
            difference() {
                rounded_cube_xy(size, 5);
                translate([60, 65, 4 + eps])
                    cylinder(r=38, h=size.z - 4);
                translate([60, 65, 4])
                    cylinder(r=60, h=size.z - 6);
            }
            size2 = [65, 10, size.z];
            size3 = [127, 9, 15];
            hull() {
                translate([size.x - size2.x, size.y - 5, 0])
                    cube(size2);
                translate([size3.x/2 - size2.x/2, size.y + 75, 0])
                    rounded_cube_xy(size3, 3);
            }
            translate([size3.x/2 - size2.x/2, size.y + 75, 0])
                difference() {
                    rounded_cube_xy([size3.x, size3.y, 25], 3);
                    thickness = 2;
                    translate([thickness/2, thickness/2, -eps])
                        rounded_cube_xy([size3.x - thickness, size3.y - thickness, 25 + 2*eps], 3);
                }
        }
        bambuFanHolePositions(z=1)
            difference() {
                hull() {
                    cylinder(r=5, h=9);
                    translate([0, 10, 0])
                        cylinder(r=5, h=9);
                }
                boltHole(3.5, 10, cnc=true);
            }
    }
}

module bambuFanBracketHolePositions(size, z=0) {
    for (x = [8, size.x - 8], y = [holeOffsetY, size.y - 35])
        translate([x, y, z])
            children();
}

module bambuFanBracket(size=bambuFanBracketSize) {
    fillet = 4;
    difference() {
        union() {
            rounded_cube_xy(size, fillet);
            translate([0, size.y - fanOffsetY, 0])
                bambuFanHolePositions()
                    cylinder(r=4, h=size.z + 1);
        }
        if (size.y > 200) {
            cutoutSize1 = [size.x - 50, 40, size.z + 2*eps];
            translate([(size.x - cutoutSize1.x)/2, 20, -eps])
                rounded_cube_xy(cutoutSize1, 3);
            cutoutSize2 = [size.x - 50, 100, size.z + 2*eps];
            translate([(size.x - cutoutSize2.x)/2, 85, -eps])
                rounded_cube_xy(cutoutSize2, 3);
        } else {
            cutoutSize= [size.x - 50, size.y - 70, size.z + 2*eps];
            translate([(size.x - cutoutSize.x)/2, 40, -eps])
                rounded_cube_xy(cutoutSize, 3);
        }
        bambuFanBracketHolePositions(size)
            hull() {
                translate([0, 8 - holeOffsetY, 0])
                    boltHoleM4(size.z);
                translate([0, holeOffsetY - 8, 0])
                    boltHoleM4(size.z);
            }
        translate([0, size.y - fanOffsetY, 0])
            bambuFanHolePositions()
                boltHoleM3Tap(size.z + 1);
    }
}

module Bambu_Fan_Bracket_hardware(size=bambuFanBracketSize) {
    bambuFanBracketHolePositions(size, size.z)
        boltM4ButtonheadHammerNut(_frameBoltLength);
    translate([0, size.y - fanOffsetY, 0]) {
        boltLength = 12;
        bambuFanHolePositions(boltLength + 1)
            boltM3Caphead(boltLength);
        translate_z(size.z)
            bambuFan();
    }
}

module Bambu_Fan_Bracket_155_stl() {
    stl("Bambu_Fan_Bracket_155")
        color(pp3_colour)
            bambuFanBracket(bambuFanBracketSize300);
}

module Bambu_Fan_Bracket_205_stl() {
    stl("Bambu_Fan_Bracket_205")
        color(pp3_colour)
            bambuFanBracket(bambuFanBracketSize350);
}

module bambuFanBracketAssembly() {
    size = eX==300 ? bambuFanBracketSize300 : bambuFanBracketSize350;
    translate([eX + eSize - 4*eps, eY/2 + eSize + size.x/2 + 20, 100 - holeOffsetY])
        rotate([90, 0, -90]) {
            stl_colour(pp3_colour)
                if (eX==300)
                    Bambu_Fan_Bracket_155_stl();
                else
                    Bambu_Fan_Bracket_205_stl();
            Bambu_Fan_Bracket_hardware(size);
        }
}
