//!# Parts redone with M5 bolt holes
//
include <NopSCADlib/utils/core/core.scad>

use <printed/XY_Idler.scad>
use <printed/XY_MotorMount.scad>

include <Parameters_Main.scad>


module M5_assembly()
assembly("M5") {

    translate([0, -eY, 0])
        rotate(-90)
            XY_Idler_Left_M5_stl();
    translate([eX, -eY, 0])
        XY_Idler_Right_M5_stl();
    XY_Motor_Mount_Left_M5_stl();
    XY_Motor_Mount_Right_M5_stl();
}

if ($preview)
    M5_assembly();
