include <../global_defs.scad>

include <../vitamins/displays.scad>
use <NopSCADlib/vitamins/pcb.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <../../../BabyCube/scad/printed/DisplayHousing.scad>

include <../Parameters_Main.scad>


displayHousingOffsetZ = 5;
displayBracketBackThickness = 10;
displayAngle = 60;


module Display_Housing_TFT35_stl() {
    display_type = BigTreeTech_TFT35v3_0;

    stl("Display_Housing_TFT35")
        color(pp2_colour)
            displayHousing(display_type, displayBracketBackThickness);
}

module Display_Housing_TFT35_E3_stl() {
    display_type = BTT_TFT35_E3_V3_0();

    stl("Display_Housing_TFT35_E3")
        color(pp2_colour)
            displayHousing(display_type, displayBracketBackThickness);
}

//!1. Bolt the TFT35 E3 display to the **Display_Housing_TFT35_E3**.
//!2. Attach the knob to the display.
//
module Display_Cover_TFT35_E3_assembly() pose(a=[55 + 45, 0, 25 + 95])
assembly("Display_Cover_TFT35_E3", ngb=true) {

    display_type = BTT_TFT35_E3_V3_0();

    stl_colour(pp2_colour)
        Display_Housing_TFT35_E3_stl();
    displayHousingHardware(display_type);

    pcb_screw_positions(display_pcb(display_type))
        translate_z(7.6)
            explode(40, true)
                boltM3Caphead(6);
}

module Display_Housing_Bracket_TFT35_E3_stl() {
    display_type = BTT_TFT35_E3_V3_0();

    stl("Display_Housing_Bracket_TFT35_E3")
        color(pp1_colour)
            difference() {
                rotate([-90, 0, 0])
                    displayHousingBracket(display_type, displayBracketBackThickness, displayAngle, enclosed=true);
                // bolt holes on the back of the bracket
                *displayBracketHolePositions(display_type, displayBracketBackThickness, displayAngle)
                    boltHoleM3Tap(8);
                for (x= [-35, 35], y = [3*eSize/2, 7*eSize/2])
                    translate([x, y - displayHousingOffsetZ, -displayBracketBackThickness])
                        boltHoleM4(displayHousingOffsetZ);
                // outlet for cable
                cutoutSize = [20, 10, 5 + 2*eps];
                gapY = 2;
                translate([-cutoutSize.x/2, 80 + gapY - cutoutSize.y, -displayBracketBackThickness - eps])
                    rounded_cube_xy(cutoutSize, 1.5);
            }
}

module Display_Housing_Bracket_TFT35_E3_hardware() {
    for (x= [-35, 35], y = [3*eSize/2, 7*eSize/2])
        translate([x, y - displayHousingOffsetZ, -displayHousingOffsetZ])
            boltM4ButtonheadHammerNut(_frameBoltLength);
}

module displayHousingTFT35E3Assembly() {

    display_type = BTT_TFT35_E3_V3_0();

    translate([eX/2 + eSize + displayHousingSize(display_type).x/2, -displayBracketBackThickness, displayHousingOffsetZ]) {
        displayHousingLocate(displayHousingSize(display_type), displayAngle)
            explode(-150, true) {
                Display_Cover_TFT35_E3_assembly();
                displayHousingBoltPositions(display_type)
                    vflip()
                        boltM3Caphead(useCounterbore() ? 25 : 30);
            }
        rotate([90, 0, 0])
            translate_z(-eps) {
                stl_colour(pp1_colour)
                    Display_Housing_Bracket_TFT35_E3_stl();
                Display_Housing_Bracket_TFT35_E3_hardware();
            }
    }
}
