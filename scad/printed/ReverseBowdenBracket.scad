include <../global_defs.scad>

use <NopSCADlib/vitamins/e3d.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

reverseBowdenBracketSize = [eSize + 15, eSize, 5];
reverseBowdenBracketBowdenOffset = [(eSize + reverseBowdenBracketSize.x)/2, reverseBowdenBracketSize.y/2, reverseBowdenBracketSize.z];

function reverseBowdenBracketOffset() = [eX + eSize, eY - 2*eSize, eZ] + reverseBowdenBracketBowdenOffset;;


module reverseBowdenBracket() {
    size = reverseBowdenBracketSize;
    sizeY = 30;
    fillet = 2;

    difference() {
        union() {
            rounded_cube_xy(size, fillet);
            translate([0, size.y - sizeY, 0])
                rounded_cube_xy([eSize, sizeY, size.z], fillet);
            translate([eSize, 0, 0])
                rotate(-90)
                    fillet(fillet, size.z);
        }
        translate([(eSize + size.x)/2, size.y/2, 0])
            boltHoleM6Tap(size.z);
        for (y = [size.y - 7, size.y - sizeY + 7])
            translate([eSize/2, y, size.z])
                boltPolyholeM4Countersunk(size.z);
    }
}

module Reverse_Bowden_Bracket_stl() {
    stl("Reverse_Bowden_Bracket")
        color(pp3_colour)
            reverseBowdenBracket();
}

module Reverse_Bowden_Bracket_hardware() {
    size = reverseBowdenBracketSize;
    sizeY = 30;

    translate(reverseBowdenBracketBowdenOffset)
        explode(20)
            bowden_connector();
    for (y = [size.y - 7, size.y - sizeY + 7])
        translate([eSize/2, y, size.z])
            boltM4CountersunkHammerNut(10);
}

module Reverse_Bowden_Bracket_assembly()
assembly("Reverse_Bowden_Bracket") {
    translate(reverseBowdenBracketOffset() - reverseBowdenBracketBowdenOffset) {
        color(pp3_colour)
            Reverse_Bowden_Bracket_stl();
        Reverse_Bowden_Bracket_hardware();
    }
}

translate([-eX,-eY,-eZ])
Reverse_Bowden_Bracket_assembly();