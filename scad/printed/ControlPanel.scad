include <../config/global_defs.scad>

include <NopSCADlib/vitamins/displays.scad>

use <DisplayHousingAssemblies.scad>

include <../vitamins/bolts.scad>

include <../config/Parameters_Main.scad>


module controlPanelPosition() {
    translate([0, -eSize, 0])
        children();
}

module controlPanel() {
    display_type = BigTreeTech_TFT35v3_0;

    Display_Cover_TFT35_E3_assembly();
    *translate([eX/2 + eSize, eSize + displayHousingBracketBaseSize(display_type).y - bracketBackThickness(), legHeight + 5]) {
        rotate([90, 0, 0])
            Control_Panel_Bracket_stl();
    }
}

module Control_Panel_Bracket_stl() {
    stl("Control_Panel_Bracket");

    legHeight = 40;
    display_type = BigTreeTech_TFT35v3_0;
    color(pp1_colour)
        rotate([-90, 0, 0])
            displayHousingBracket(display_type, legHeight);
}
