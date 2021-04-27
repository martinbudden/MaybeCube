//!Displays the baseplate.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/d_connectors.scad>
include <NopSCADlib/vitamins/pcbs.scad>

use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>
use <../scad/printed/ControlPanel.scad>
use <../scad/printed/PSU.scad>
use <../scad/printed/BaseFoot.scad>
include <../scad/vitamins/pcbs.scad>


//$explode = 1;
//$pose = 1;
module Base_test() {
    //PSU();
    Base_Plate_assembly();
    //Face_Left_assembly();
    //Face_Right_assembly();
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
