include <../config/global_defs.scad>

use <NopSCADlib/vitamins/wire.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../config/Parameters_Main.scad>

//cableChainBracketSize = [25, eY - (_zRodOffsetY + (zRodSeparation() + _printbedArmSeparation)/2) - 5, eSize];
cableChainBracketSize = [20, 55, eSize];
cableChainBracketTabSize = [38, 5, eSize];

/*
module cableChainBracketHolePositions(size=cableChainBracketSize) {
    for (x = [0, 8])
        translate([x - size.x/2 + 4.5, size.y - 9, 0])
            children();
}
*/

module cableChainBracketDragChainHolePositions(size=cableChainBracketSize) {
    for (z = [0, 8])
        translate([-size.x/2, size.y - 10, z + 7])
            children();
}

module cableChainBracketHolePositions(size=cableChainBracketTabSize, y=0) {
    for (x = [4.5, size.x - 4.5])
        translate([x - size.x/2, y, size.z/2])
            rotate([90, 0, 180])
                children();
}

module cableChainBracket(size=cableChainBracketSize) {
    tabSize = cableChainBracketTabSize;
    fillet = 1;
    cutout = [9, 15 + fillet];
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
        cableChainBracketDragChainHolePositions(size)
            rotate([90, 0, 90])
                boltHoleM3Tap(size.x - cutout.x - 2, horizontal=true);
        translate([size.x/2, size.y - cutout.y, size.z])
            rotate([180, 90,  0])
                fillet(8, cutout.x);
        // cutouts for cable ties
        for (x = [-4.5, 2], y = [12, 30])
            translate([x + size.x/4 + 0.5, size.y - cutout.y - y, -eps])
                rounded_cube_xy([2, 5, size.z + 2*eps], 0.25, xy_center=true);
        for (y = [-3.5, 3.5])
            translate([-4.5, y + size.y - 10, -eps])
                rounded_cube_xy([5, 2, size.z + 2*eps], 0.25, xy_center=true);
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
        fillet(0.5, size.z);
    translate([-size.x/2, tabSize.y, 0])
        rotate(90)
            fillet(0.5, size.z);
    difference() {
        translate([-tabSize.x/2, 0, 0])
            rounded_cube_xy(tabSize, 1);
        cableChainBracketHolePositions(tabSize)
            boltHoleM4(tabSize.y, horizontal=true);
    }
}

module Cable_Chain_Bracket_hardware() {
    cableChainBracketHolePositions(cableChainBracketTabSize, cableChainBracketTabSize.y)
        boltM4ButtonheadHammerNut(_frameBoltLength);

}

module Cable_Chain_Bracket_cable_ties(size=cableChainBracketSize) {
    cutout = [8, 15];
    for (y = [12, 30])
        translate([size.x/4 + 0.25, size.y - cutout.y - y - 1, 20])
            rotate(90)
                cable_tie(cable_r = 2.75, thickness = 20);
    translate([-4, size.y - 10, 16])
        cable_tie(cable_r = 2.75, thickness = 20);

    translate([-2, 0, 0])
        cableChainBracketDragChainHolePositions()
            rotate([0, -90, 0])
                explode(110, true)
                    boltM3Countersunk(8);
}

module Cable_Chain_Bracket_stl() {
    stl("Cable_Chain_Bracket")
        color(pp3_colour)
            cableChainBracket();
}

module cableChainBracketAssembly() {
//size 250:49, 300:51, 350:54, 400:55
    stl_colour(pp3_colour)
        Cable_Chain_Bracket_stl();
    Cable_Chain_Bracket_hardware();
}
