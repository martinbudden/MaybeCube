//!Display the left and right idlers.

include <../scad/printed/XY_Idler.scad>
use <../scad/utils/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>

include <../scad/utils/carriageTypes.scad>
//use <../scad/assemblies/FaceTop.scad>
use <../scad/config/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module XY_Idler_test() {
    // top thickness for small idler is 1.75
    //faceTopFront(use2040=true);
    XY_Idler_Left_assembly();
    XY_Idler_Right_assembly();
    CoreXYBelts(carriagePosition(), show_pulleys=![1, 0, 0]);
    translate([coreXYPosBL().x, xyIdlerRailOffset() + _yRailLength/2, eZ - eSize])
        rotate([180, 0, 90])
            rail_assembly(carriageType(_yCarriageDescriptor), _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
}

module XY_Idler_test1() {
    translate([100, -eZ + 40, eZ])
        rotate(-90)
            XY_Idler_Left_RB4_stl();
    translate([0, -eZ + 40, eZ])
        XY_Idler_Right_RB4_stl();
}

if ($preview)
    translate_z(-eZ)
        XY_Idler_test();
