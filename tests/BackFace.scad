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
    psuVertical = eX == 300;
    //PSUPosition(psuVertical) PSU();
    //PSUPosition(psuVertical) PSUBoltPositions() cylinder(r=3,h=2);
    //PSU_Cover_assembly();
    //PSU_Cover_stl();
    //PSU_Upper_Mount_stl();
    //PSU_Lower_Mount_stl();
    *if (psuVertical) {
        PSU_Upper_Mount_assembly();
        PSU_Lower_Mount_assembly();
        *PSU_Hole_Jig_assembly();
    } else {
        PSU_Left_Mount_assembly();
        PSU_Right_Mount_assembly();
    }

    //PSU_Cover_assembly();
    //PCB_Mount_stl();
    //let($hide_pcb=true)
    //Base_Plate_assembly();
    //Left_Side_assembly();
    //Right_Side_assembly();
    //faceRightExtras();
    //Face_Top_assembly();
    //printHeadWiring();
    Back_Panel_assembly();
    //Back_Panel_dxf();
    //Partition_assembly();
}

module BackFace_test2() {
    PSU_Hole_Jig_assembly();
    Right_Side_assembly();
    PCB_Hole_Jig_assembly();
   //Back_Panel_assembly();
}


//PSU_Hole_Jig_stl();
//PCB_Hole_Jig_stl();

if ($preview)
    BackFace_test();
