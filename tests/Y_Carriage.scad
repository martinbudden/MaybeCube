//!Display the left and right Y carriages.

include <../scad/printed/Y_CarriageAssemblies.scad>

use <../scad/printed/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>


yCarriageType = MGN12H_carriage;
rail_type = MGN12;

//$explode = 1;
//$pose = 1;
module Y_Carriage_test0() {
    if (!exploded())
        translate_z(-eZ + eSize)
            CoreXYBelts(carriagePosition(), x_gap = 20, show_pulleys = [1,0,0]);
    Y_Carriage_Left_assembly();
    translate([eX + 2*eSize, 0, 0])
        Y_Carriage_Right_assembly();
}

module Y_Carriage_test1() {
    Y_Carriage_Left_RB4_stl();
    //Y_Carriage_Left_AL_dxf();
    translate([150, 0, 0])
        rotate(180) {
            Y_Carriage_Right_RB4_stl();
            //Y_Carriage_Right_AL_dxf();
        }
}

//translate([-15.5, 0, 0]) Y_Carriage_Left_RB4_stl();
//translate([-15.5, 55, 0]) Y_Carriage_Right_RB4_stl();
module Y_Carriage_test2() {
    translate([-15.5-90, carriagePosition().y, -13])
        vflip() Y_Carriage_Left_assembly();
    translate([100, carriagePosition().y, -13])
        vflip()
            Y_Carriage_Right_assembly();
}

if ($preview)
    Y_Carriage_test0();
