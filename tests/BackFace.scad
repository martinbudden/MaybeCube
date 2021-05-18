//!Displays the back face.

include <NopSCADlib/core.scad>

use <../scad/printed/PSU.scad>
use <../scad/BackFace.scad>
use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>
use <../scad/FaceTop.scad>

include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
module BackFace_test() {
    PSUPosition() PSU();
    PSUPosition() PSUBoltPositions() cylinder(r=3,h=2);
    //PSU_Cover_assembly();
    //PSU_Cover_stl();
    //PSU_Upper_Mount_stl();
    //PSU_Lower_Mount_stl();
    if (eX == 300) {
        PSU_Upper_Mount_assembly();
        PSU_Lower_Mount_assembly();
    } else {
        PSU_Left_Mount_assembly();
        PSU_Right_Mount_assembly();
    }

    PSU_Cover_assembly();
    //PCB_Mount_stl();
    //let($hide_pcb=true)
    Base_Plate_assembly();
    //Left_Side_assembly();
    Right_Side_assembly();
    //Face_Top_assembly();
    faceRightExtras();
    Back_Panel_assembly();
    //Back_Panel_dxf();
    Partition_assembly();

}

if ($preview)
    BackFace_test();
