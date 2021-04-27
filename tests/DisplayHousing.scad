//! Display the Display housing

include <../scad/global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/vitamins/display.scad>

include<../scad/vitamins/displays.scad>
include <../scad/printed/DisplayHousingAssemblies.scad>

use <../../BabyCube/scad/printed/DisplayHousing.scad>

display_type = BTT_TFT35_E3_V3_0();
//display_type = BigTreeTech_TFT35v3_0;

//$explode = 1;
//$pose = 1;
module Display_Housing_test() {
    Display_Housing_TFT35_E3_assembly();
    //displayHousing(display_type);
    //displayHousingBase(display_type, testLayer=0);
    //displayHousingSides(display_type);
    *displayHousingLocate(displayHousingSize(display_type), angle=60)
        displayHousingHardware(display_type);
    *translate([-1.05, 8.75, 0])
        display_aperture(display_type, clearance=0, clear_pcb=false);
    *displayHousingLocate(displayHousingSize(display_type), angle=60)
        Display_Housing_TFT35_E3_stl();
    *rotate([90, 0, 0])
        Display_Housing_Bracket_TFT35_E3_stl();
    *displayHousingBracket(display_type, displayBracketBackThickness=10, angle=60, enclosed=true);
}

if ($preview)
    Display_Housing_test();
else
    displayHousingBase(display_type, testLayer=1);
