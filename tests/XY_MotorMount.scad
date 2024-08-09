//!Display the left and right motor mounts.

include <../scad/config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

include <../scad/printed/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>

use <../scad/config/Parameters_Positions.scad>


//$explode = 1;
//$pose=1;
module XY_Motor_Mount_test() {
    //XY_Motor_Mount_Left_RB_stl();
    //xyMotorMountLeft(useReversedBelts=true, cnc=true);

    //XY_Motor_Mount_Brace_Left_16_stl();
    //XY_Motor_Mount_Right_16_stl();
    //XY_Motor_Mount_Left_Base_RB4_stl();
    //XY_Motor_Mount_Left_Middle_RB4_stl();
    //XY_Motor_Mount_Left_Upper_RB4_stl();
    //XY_Motor_Mount_Right_Base_RB4_stl();
    //vflip() XY_Motor_Mount_Right_Middle_RB4_stl();
    //XY_Motor_Mount_Right_Upper_RB4_stl();
    //XY_Motor_Mount_Left_Upper_Extended_RB4_stl();    //XY_Motor_Mount_Brace_Left_Upper_RB3_stl();    //XY_Motor_Mount_Left_Base_RB4_stl();
    //XY_Motor_Mount_Right_RB4_stl();
    //XY_Motor_Mount_Right_Base_stl();
    //XY_Motor_Mount_Left_Base_dxf();
    translate_z(-eZ + eSize) {
        if (is_undef($explode))
            CoreXYBelts(carriagePosition(), show_pulleys=![1, 0, 0]);
            //XYMotorMountLeftAssembly(NEMA17_61_KRAKEN, GT2x20um_pulley);
            //XYMotorMountRightAssembly(NEMA17_61_KRAKEN, GT2x30po_pulley);
        XY_Motor_Mount_Left_assembly();
        XY_Motor_Mount_Right_assembly();
    }
}

//let($hide_bolts=true)
if ($preview)
    translate([0, -eY - eSize, 0])
        XY_Motor_Mount_test();
