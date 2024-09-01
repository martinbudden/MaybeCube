include <../config/global_defs.scad>

use <NopSCADlib/vitamins/blower.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <../utils/extruderBracket.scad> // for spoolHeight()

include <../config/Parameters_Main.scad>

holeOffsetY = 15;
fanOffsetY = eZ - 450 + 70;
bambuFanBracketSize = [165, spoolHeight() - 40, 3];
bambuFanBracketSize400 = [165, 150, 3];
bambuFanBracketSize450 = bambuFanBracketSize400 + [0, 50, 0];

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
    for (pos = [ [8, holeOffsetY, z], [size.x - 8, holeOffsetY, z], [size.x - 8, size.y - 30, z] ])
    //[8, size.x - 8], y = [holeOffsetY, size.y - 35])
        translate(pos)
            children();
}

module bambuFanBracket(size=bambuFanBracketSize) {
    fillet = 4;
    difference() {
        union() {
            size2 = [22, size.y - 125];
            rounded_cube_xy([size.x, size2.y, size.z], fillet);
            size3 = [14, 31];
            rounded_cube_xy([size3.x, size3.y, size.z], fillet);
            translate([size3.x, size2.y, 0])
                fillet(2, size.z); 
            translate([size.x - size2.x, 0, 0]) {
                rounded_cube_xy([size2.x, size.y, size.z], fillet);
                translate([0, size2.y, 0])
                    rotate(90)
                        fillet(fillet, size.z);
            }
            
            *rounded_cube_xy(size, fillet);
            *translate([0, fanOffsetY, 0])
                bambuFanHolePositions()
                    cylinder(r=4, h=size.z + 1);
        }
        *if (size.y > 200) {
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
                translate([0, 8+1, 0])
                    boltHoleM4(size.z);
                translate([0, -8, 0])
                    boltHoleM4(size.z);
            }
        translate([0, fanOffsetY, 0])
            bambuFanHolePositions()
                boltHoleM3Tap(size.z + 1);
    }
}

module Bambu_Fan_Bracket_hardware(size=bambuFanBracketSize) {
    bambuFanBracketHolePositions(size, size.z)
        boltM4ButtonheadHammerNut(_frameBoltLength);
    translate([0, fanOffsetY, 0]) {
        boltLength = 12;
        bambuFanHolePositions(boltLength + 1)
            boltM3Caphead(boltLength);
        translate_z(size.z - 1) // allow some compression of mounts
            bambuFan();
    }
}

module Bambu_Fan_Bracket_150_stl() {
    stl("Bambu_Fan_Bracket_150")
        color(pp3_colour)
            bambuFanBracket(bambuFanBracketSize400);
}

module Bambu_Fan_Bracket_200_stl() {
    stl("Bambu_Fan_Bracket_200")
        color(pp3_colour)
            bambuFanBracket(bambuFanBracketSize450);
}

module bambuFanBracketAssembly() {
    size = eZ == 400 ? bambuFanBracketSize400 : bambuFanBracketSize450;
    offsetY = eY/2 + eSize + 20 + (eZ == 350 ? 155/2 : 205/2);

    translate([eX + eSize - 4*eps, offsetY, 100 - holeOffsetY])
        rotate([90, 0, -90]) {
            stl_colour(pp3_colour)
                if (eZ==400)
                    Bambu_Fan_Bracket_150_stl();
                else
                    Bambu_Fan_Bracket_200_stl();
            Bambu_Fan_Bracket_hardware(size);
        }
}
