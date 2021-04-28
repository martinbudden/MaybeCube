//!Displays the back face.

include <NopSCADlib/core.scad>

use <../scad/BackFace.scad>
use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>


//$explode = 1;
//$pose = 1;
module BackFace_test() {
    //PSU();
    //backPanel();
    //PSU_Top_Mount_stl();
    //PSU_Left_Mount_stl();
    //PCB_Mount_stl();
    //let($hide_pcb=true)
    //Base_Plate_assembly();
    //Left_Side_assembly();
    //Right_Side_assembly();
    //faceRightExtras();
    Back_Panel_assembly();
}

if ($preview)
    BackFace_test();
