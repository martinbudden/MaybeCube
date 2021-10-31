//!Display the left and right motor mounts.

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose=1;
module XY_Motor_Mount_test() {
    //XY_Motor_Mount_Left_stl();
    //XY_Motor_Mount_Right_stl();
    translate_z(-eZ + eSize) {
        if (is_undef($explode))
            CoreXYBelts(carriagePosition(), show_pulleys=[1, 0, 0]);
        XY_Motor_Mount_Left_assembly();
        XY_Motor_Mount_Right_assembly();
    }
}

if ($preview)
    translate([0, -eY - eSize, 0])
        XY_Motor_Mount_test();
