//!Display the left and right motor mounts.

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/printed/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose=1;
module XY_Motor_Mount_test() {
    //XY_Motor_Mount_Left_RB_stl();
    //xyMotorMountLeft(useReversedBelts=true, cnc=true);

    //XY_Motor_Mount_Brace_Left_16_stl();
    //XY_Motor_Mount_Right_16_stl();
    //XY_Motor_Mount_Left_RB3_stl();
    //XY_Motor_Mount_Left_Base_RB3_stl();
    //XY_Motor_Mount_Brace_Left_Lower_RB3_stl();
    //XY_Motor_Mount_Brace_Left_Upper_RB3_stl();    //XY_Motor_Mount_Left_Base_RB4_stl();
    //XY_Motor_Mount_Right_RB4_stl();
    //XY_Motor_Mount_Right_Base_stl();
    //XY_Motor_Mount_Left_Base_dxf();
    translate_z(-eZ + eSize) {
        if (is_undef($explode))
            CoreXYBelts(carriagePosition(), show_pulleys=![1, 0, 0]);
        XY_Motor_Mount_Left_assembly();
        XY_Motor_Mount_Right_assembly();
    }
}

//let($hide_bolts=true)
if ($preview)
    translate([0, -eY - eSize, 0])
        XY_Motor_Mount_test();
