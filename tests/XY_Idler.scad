//!Display the left and right idlers.

include <NopSCADlib/core.scad>

use <../scad/printed/XY_Idler.scad>

include <../scad/Parameters_Main.scad>


//$pose = 1;
//$explode = 1;
module XY_Idler_test() {
    //XY_Idler_Left_assembly();
    //XY_Idler_Right_assembly();

    translate(-[0, eZ - eSize - 60, 0])
        xyIdler();
        *translate([0, -eZ, eZ]) {
            XY_Idler_Left_stl();
            XY_Idler_hardware();
        }
    *translate([-120, -eZ, eZ]) {
        XY_Idler_Right_stl();
        translate([0, 0, eSize])
            rotate([0, 180, 0])
                XY_Idler_hardware();
    }
}

if ($preview)
    translate_z(-eZ)
        XY_Idler_test();
