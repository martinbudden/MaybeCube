//!Display the left and right Y carriages.

include <../scad/printed/Y_CarriageAssemblies.scad>

use <../scad/utils/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

use <../scad/config/Parameters_Positions.scad>


yCarriageType = MGN12H_carriage;
rail_type = MGN12;

//$explode = 1;
//$pose = 1;
module Y_Carriage_test() {
    translate([-20 - eX/2, 10 - eY/2, 20]) {
        if (!exploded())
            translate_z(-eZ + eSize)
                CoreXYBelts(carriagePosition(), x_gap = 20, show_pulleys = [1,0,0]);
        Y_Carriage_Left_assembly();
        translate([eX + 2*eSize, 0, 0])
            Y_Carriage_Right_assembly();
    }
}

module Y_Carriage_test1() {
    translate([-20 - eX/2, 10 - eY/2, 20]) {
        if (!exploded())
            translate_z(-eZ + eSize)
                CoreXYBelts(carriagePosition(), x_gap = 20, show_pulleys = [1,0,0]);
        railOffsetX = coreXYPosBL().x;
        translate([railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
            vflip()
                Y_Carriage_Left_RB4_stl();
        translate([eX + 2*eSize - railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
            rotate([180, 0, 180])
                Y_Carriage_Right_RB4_stl();
    }
}

module Y_Carriage_test2(braces=false) {
    translate([-68.5, 0, 0]) {
        Y_Carriage_Left_RB4_stl();
        if (braces)
            translate_z(18.75)
                Y_Carriage_Brace_Left_RB4_stl();
    }
    //Y_Carriage_Left_AL_dxf();
    translate([68.5, 0, 0])
        rotate(180) {
            Y_Carriage_Right_RB4_stl();
            //Y_Carriage_Right_AL_dxf();
            if (braces)
                translate_z(18.75)
                    Y_Carriage_Brace_Right_RB4_stl();
        }
}

module Y_Carriage_test3() {
    translate([-15.5-85, carriagePosition().y, -13])
        vflip() Y_Carriage_Left_assembly();
    translate([15.5+85, carriagePosition().y, -13])
        vflip()
            Y_Carriage_Right_assembly();
}

if ($preview)
    Y_Carriage_test();
