//!Displays the baseplate.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

use <../scad/printed/BaseFoot.scad>
use <../scad/printed/BaseFrontCover.scad>
use <../scad/printed/ControlPanel.scad>
use <../scad/printed/PSU.scad>

use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>

include <../scad/vitamins/pcbs.scad>


//$explode = 1;
//$pose = 1;
module Base_test() {
    //PSU();
    //Base_Plate_Stage_1_assembly();
    Base_Plate_assembly();
    //Front_Display_Wiring_Cover_stl();
    //Front_Cover_stl();
    //Left_Side_assembly();
    //Right_Side_assembly();
    //faceRightExtras();
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
