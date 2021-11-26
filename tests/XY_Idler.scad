//!Display the left and right idlers.
include <../scad/printed/XY_Idler.scad>
include <../scad/utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$pose = 1;
//$explode = 1;
module XY_Idler_test() {
    XY_Idler_Left_assembly();
    XY_Idler_Right_assembly();
    CoreXYBelts(carriagePosition(), show_pulleys=[1, 0, 0]);

    *translate(-[0, eZ - eSize - 60, 0])
        xyIdler();
        *translate([0, -eZ, eZ]) {
            XY_Idler_Left_stl();
            XY_Idler_hardware(left=true);
        }
    *translate([-120, -eZ, eZ]) {
        XY_Idler_Right_stl();
        translate([0, 0, eSize])
            rotate([0, 180, 0])
                XY_Idler_hardware(left=false);
    }
}

if ($preview)
    translate_z(-eZ)
        XY_Idler_test();
