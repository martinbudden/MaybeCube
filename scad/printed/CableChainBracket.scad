include <../global_defs.scad>

use <NopSCADlib/vitamins/wire.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

//cableChainBracketSize = [25, eY - (_zRodOffsetY + (zRodSeparation() + _printbedArmSeparation)/2) - 5, eSize];
cableChainBracketSize = [25, 55, eSize];

/*
module cableChainBracketHolePositions(size=cableChainBracketSize) {
    for (x = [0, 8])
        translate([x - size.x/2 + 4.5, size.y - 9, 0])
            children();
}
*/

module cableChainBracketHolePositions(size=cableChainBracketSize) {
    for (z = [0, 8])
        translate([-size.x/2, size.y - 10, z + 7])
            children();
}

module cableChainBracket(size=cableChainBracketSize) {
    tabSize = [50, 5, eSize];
    fillet = 1;
    cutout = [8, 15 + fillet];
    endStopSizeY = 4;

    difference() {
        union() {
            translate([-size.x/2, 0, 0])
                rounded_cube_xy([size.x, size.y - cutout.y, size.z], fillet);
            translate([-size.x/2, size.y - endStopSizeY, 0])
                rounded_cube_xy([size.x, endStopSizeY, size.z], fillet);
            translate([-size.x/2, 0, 0])
                rounded_cube_xy([size.x - cutout.x, size.y, size.z], fillet);
        }
        cableChainBracketHolePositions(size)
            rotate([0, 90, 0])
                boltHoleM3Tap(size.x - cutout.x - 2);
        translate([size.x/2, size.y - cutout.y, size.z])
            rotate([180, 90,  0])
                fillet(8, cutout.x);
        // cutouts for cable ties
        for (x = [-4.5, 2], y = [12, 30])
            translate([x + size.x/4 + 1.5, size.y - cutout.y - y, -eps])
                rounded_cube_xy([2, 5, size.z + 2*eps], 0.25, xy_center=true);
        translate([0, size.y - cutout.y/2 - endStopSizeY/2, -eps]) {
            translate([-size.x/2 - eps, 0, 0])
                rotate([90, 0, 0])
                    right_triangle(2, 2, cutout.y - endStopSizeY +2*eps);
            translate([size.x/2 - cutout.x + eps, 0, 0])
                rotate([90, 0, 180])
                    right_triangle(2, 2, cutout.y - endStopSizeY + 2*eps);
        }


    }
    translate([size.x/2, tabSize.y, 0])
        fillet(1.5, size.z);
    translate([-size.x/2, tabSize.y, 0])
        rotate(90)
            fillet(1.5, size.z);
    translate([-tabSize.x/2, 0, 0])
        difference() {
            rounded_cube_xy(tabSize, 1);
            for (x = [5, tabSize.x - 5])
                translate([x, 0, tabSize.z/2])
                    rotate([90, 0, 180])
                        boltHoleM4(tabSize.y, horizontal=true);
        }
}

module Cable_Chain_Bracket_hardware(size=cableChainBracketSize) {
    tabSize = [50, 5, eSize];
    cutout = [8, 15];

    for (x = [5, tabSize.x - 5])
        translate([x - tabSize.x/2, tabSize.y, tabSize.z/2])
            rotate([-90, 0, 0])
                boltM4ButtonheadHammerNut(_frameBoltLength);
}
module Cable_Chain_Bracket_cable_ties(size=cableChainBracketSize) {
    cutout = [8, 15];
    for (y = [12, 30])
        translate([size.x/4 + 0.25, size.y - cutout.y - y - 1, 20])
            rotate(90)
                cable_tie(cable_r = 2.75, thickness = 20);
    translate([-2, 0, 0])
        cableChainBracketHolePositions()
            rotate([0, -90, 0])
                boltM3Countersunk(8);
}

module Cable_Chain_Bracket_stl() {
    stl("Cable_Chain_Bracket")
        color(pp1_colour)
            cableChainBracket();
}

module cableChainBracketAssembly() {
//size 250:49, 300:51, 350:54, 400:55
    stl_colour(pp1_colour)
        Cable_Chain_Bracket_stl();
    Cable_Chain_Bracket_hardware();
}
