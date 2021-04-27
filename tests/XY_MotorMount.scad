//!Display the left and right motormounts.

use <../scad/printed/XY_MotorMount.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose=1;
module XY_Motor_Mount() {
    translate([0, -eY - eSize, -eZ + eSize]) {
        XY_Motor_Mount_Left_assembly();
        //XY_Motor_Mount_Left_stl();
        //XY_Motor_Mount_Left_hardware(30);
    }
    translate([-eX + 160, -eY - eSize, -eZ + eSize]) {
        XY_Motor_Mount_Right_assembly();
        //XY_Motor_Mount_Right_stl();
        //XY_Motor_Mount_Right_hardware();
    }
}

if ($preview)
    XY_Motor_Mount();
