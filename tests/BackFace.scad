//!Displays the back face.

include <NopSCADlib/utils/core/core.scad>

include <../scad/utils/CoreXYBelts.scad>
use <../scad/printed/PSU.scad>
use <../scad/printed/XY_MotorMount.scad>
use <../scad/BackFace.scad>
use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>
use <../scad/FaceTop.scad>
use <../scad/vitamins/Panels.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
module BackFace_test() {
    Back_Panel_assembly();
    //Back_Panel_dxf();
    psuVertical = eX == 300;
    //PSUPosition(psuVertical) PSU();
    //PSUPosition(psuVertical) PSUBoltPositions() cylinder(r=3,h=2);
    //PSU_Cover_assembly();
    //PSU_Cover_stl();
    //PSU_Upper_Mount_stl();
    //PSU_Lower_Mount_stl();
    //psuAssembly(psuVertical, useMounts=true);
    //pcbAssembly(pcbType(), useMounts=true);
    //PSU_Cover_assembly();
    //PCB_Mount_stl();
    //let($hide_pcb=true)
    //Base_Plate_assembly();
    //Left_Side_assembly();
    //Right_Side_assembly();
    //Face_Top_Stage_1_assembly();
    //printHeadWiring();
    showPartition = !true;
    if (showPartition) {
        CoreXYBelts(carriagePosition());
        XY_Motor_Mount_Left_assembly();
        XY_Motor_Mount_Right_assembly();
        partitionPC();
    }
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
