include <../config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/fillet.scad>

include <extrusionCornerBracket.scad>
use <../vitamins/AntiBacklashNut.scad>

include <../config/Parameters_Main.scad>


//braceY = eSize + _zLeadScrewOffset + antiBacklashNutSize().z/2;
//function braceY() = braceY;
firstBracketSizeX = _zLeadScrewOffset + antiBacklashNutSize().z/2 - 1;

module printbedBracket() {
    fSize = eSize;
    braceThickness = 3;
    bracketThickness = 4;
    bracketSizeY = 30;
    sizeY = fSize + braceThickness;
    fillet = 1;

    no_explode()
        color(pp2_colour) {
            extrusionCornerBracket(holeOffsetFromTop=7, holeLength=0, size=[sizeY, firstBracketSizeX, 30], fillet=fillet);
            translate([sizeY, -fSize, 0])
                rotate(180)
                    extrusionCornerBracket(holeOffsetFromTop=7, holeLength=0, holeOffsetFromSide=13, size=[sizeY, 30, 30], fillet=fillet);
            translate([fSize, -fSize-2*fillet, 0])
                difference() {
                    cube([braceThickness, fSize + 4*fillet, bracketSizeY]);
                    translate([braceThickness, 0, bracketSizeY])
                        rotate([0, 90, 90])
                            fillet(fillet, fSize + 4);
                }
        }
    extrusionCornerBracketTNutsAndBolts(size=[sizeY, firstBracketSizeX, 30], holeOffsetFromTop=7, holeOffsetFromSide=10);
    translate([sizeY, -fSize, 0])
        rotate(180)
            extrusionCornerBracketTNutsAndBolts(size=[sizeY, 30, 30], holeOffsetFromTop=7, holeOffsetFromSide=13);
}

module Printbed_Corner_Bracket_stl() {
    fillet = 1;

    stl("Printbed_Corner_Bracket")
        color(pp2_colour)
            extrusionCornerBracket(holeOffsetFromTop=7, holeLength=0, size=[eSize, firstBracketSizeX, 30], fillet=fillet);
    extrusionCornerBracketTNutsAndBolts(size=[eSize, firstBracketSizeX, 30], holeOffsetFromTop=7, holeOffsetFromSide=10);
}

module printbedBracketLeft_stl() {
    stl("printbedBracketLeft")
        printbedBracket();
}

module printbedBracketRight_stl() {
    stl("printbedBracketRight")
        mirror([1, 0, 0])
            printbedBracket();
}
