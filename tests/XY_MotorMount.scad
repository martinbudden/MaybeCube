//!Display the left and right motormounts.

use <../scad/printed/XY_MotorMount.scad>
use <../scad/utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose=1;
module XY_Motor_Mount_test() {
    CoreXYBelts(carriagePosition(), show_pulleys=[1, 0, 0]);
    XY_Motor_Mount_Left_assembly();
    //XY_Motor_Mount_Left_stl();
    //XY_Motor_Mount_Left_hardware();
    XY_Motor_Mount_Right_assembly();
    //XY_Motor_Mount_Right_stl();
    //XY_Motor_Mount_Right_hardware();
}

if ($preview)
    translate([0, -eY - eSize, -eZ + eSize])
        XY_Motor_Mount_test();
