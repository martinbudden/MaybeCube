//!Displays the baseplate.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

use <../scad/jigs/PanelJig.scad>

use <../scad/printed/BaseFoot.scad>
use <../scad/printed/BaseFrontCover.scad>
use <../scad/printed/ControlPanel.scad>

use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>

include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Base_test() {
    //Base_Plate_Stage_1_assembly();
    Base_Plate_assembly();
    //BaseAL();
    //translate_z(-3) Panel_Jig_stl();
    //translate([eX + 2*eSize, 0, -3]) rotate(90) Panel_Jig_stl();
    //Front_Display_Wiring_Cover_stl();
    //Front_Cover_stl();
    //Left_Side_assembly();
    //Right_Side_assembly();
    //Base_Extrusions_assembly();
    //basePlate();
    //controlPanel();
    //BigTreeTechTFT_3_5v3_0_bracket_stl();
    //bigTreeTechTFT_3_5v3_0();
    //pcb(BTT_B1_Box_V1_0);
    //pcb(BTT_SKR_V1_4_TURBO);
    //Foot_LShaped_12mm_stl();
}

if ($preview)
    Base_test();
