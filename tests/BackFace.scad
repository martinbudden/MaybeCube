//!Displays the back face.

include <NopSCADlib/core.scad>

use <../scad/printed/PSU.scad>
use <../scad/BackFace.scad>
use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>
use <../scad/FaceTop.scad>


//$explode = 1;
//$pose = 1;
module BackFace_test() {
    //PSUPosition() PSU();
    //PSU_Cover_assembly();
    //PSU_Cover_stl();
    //PSU_Top_Mount_stl();
    //PSU_Left_Mount_stl();
    //PCB_Mount_stl();
    //let($hide_pcb=true)
    Base_Plate_assembly();
    //Left_Side_assembly();
    //Right_Side_assembly();
    //Face_Top_assembly();
    //faceRightExtras();
    Back_Panel_assembly();
    //Back_Panel_dxf();
    Partition_assembly();
}

if ($preview)
    BackFace_test();
