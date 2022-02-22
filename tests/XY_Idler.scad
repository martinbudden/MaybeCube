//!Display the left and right idlers.

include <../scad/printed/XY_Idler.scad>
include <../scad/utils/CoreXYBelts.scad>

include <../scad/utils/carriageTypes.scad>
use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module XY_Idler_test() {
    XY_Idler_Left_assembly();
    XY_Idler_Right_assembly();
    CoreXYBelts(carriagePosition(), show_pulleys=![1, 0, 0]);
    translate([coreXYPosBL().x, xyIdlerRailOffset() + _yRailLength/2, eZ - eSize])
        rotate([180, 0, 90])
            rail_assembly(carriageType(_yCarriageDescriptor), _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");

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
