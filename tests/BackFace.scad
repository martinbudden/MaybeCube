//!Displays the back face.

include <NopSCADlib/utils/core/core.scad>

//include <../scad/utils/CoreXYBelts.scad>
//use <../scad/printed/PSU.scad>
//use <../scad/printed/XY_MotorMount.scad>
use <../scad/assemblies/BackFace.scad>
//use <../scad/assemblies/BasePlate.scad>
//use <../scad/assemblies/FaceLeft.scad>
//use <../scad/assemblies/FaceRight.scad>
//include <../scad/assemblies/FaceRightExtras.scad>
//use <../scad/assemblies/FaceTop.scad>
use <../scad/vitamins/Panels.scad>

use <../scad/config/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
module BackFace_test() {
    //PSU_Cover_assembly();
    //PSU_Cover_stl();
    //PSU_Upper_Mount_stl();
    //PSU_Lower_Mount_stl();
    //psuAssembly(psuVertical=(eX==300), useMounts=true);
    //pcbAssembly(pcbType());
    //PSU_Cover_assembly();
    //let($hide_pcb=true)
    //Base_Plate_assembly();
    //Left_Side_assembly();
    //Left_Side_Channel_Spacers();
    //Right_Side_assembly();
    //Face_Top_Stage_1_assembly();
    //printheadWiring();
    /*showPartition = !true;
    if (showPartition) {
        CoreXYBelts(carriagePosition());
        XY_Motor_Mount_Left_assembly();
        XY_Motor_Mount_Right_assembly();
        partitionPC();
    }*/
    //Back_Panel_Channel_Spacers();
    //Back_Panel_assembly();
    backPanelAssembly();
    //Back_Panel_dxf();
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
