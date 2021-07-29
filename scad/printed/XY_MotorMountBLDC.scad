include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/bldc_motors.scad>
include <NopSCADlib/vitamins/pulleys.scad>

include <../utils/motorTypes.scad>

use <../vitamins/bolts.scad>
use <../vitamins/cables.scad>

use <XY_MotorMount.scad>

include <../Parameters_Main.scad>
use <../Parameters_CoreXY.scad>


NEMA17_60  = ["NEMA17_60",   42.3, 60,     53.6/2, 25,     11,     2,     5,     24,          31,    [11.5,  9]];

NEMA_hole_depth = 5;

sideSupportSizeY = 30;
bracketHeightRight = eZ - eSize - (coreXYPosBL().z + washer_thickness(M3_washer));
bracketHeightLeft = bracketHeightRight + coreXYSeparation().z;

stepdown4250 = true;

//                                     shaft  shaft shaft      body   base             holes                 base            side  bell             holes          boss  prop shaft   thread
//                      diameter height diam length offset   colour   diam   h1    h2  diam position         open  wire    colour  diam   h1    h1  d  pos   spokes  d  h  length diam  length  diam
BLDC4933  = ["BLDC4933",   49.0, 33,      8,    60,    27, grey(20),   38,   4,    6,  3,   [25,25,25],     true,  3.0, grey(20),   40,   3,    3,  3, 17,       5, 12, 2,     4,   5,      0,     0];


module XY_Motor_Mount_4250_Left_stl() {
    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = leftDrivePulleyOffset();

    stl("XY_Motor_Mount_4250_Left")
        color(pp1_colour)
            translate_z(eZ - eSize - basePlateThickness - bracketHeightLeft)
                xyMotorMount(motorType, bracketHeightLeft, basePlateThickness, offset, sideSupportSizeY, stepdown=stepdown4250, left=true);
}

module XY_Motor_Mount_4250_Left_assembly()
assembly("XY_Motor_Mount_4250_Left", ngb=true) {

    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = leftDrivePulleyOffset();
    corkDamperThickness = 0;

    stl_colour(pp1_colour)
        XY_Motor_Mount_4250_Left_stl();
    XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, sideSupportSizeY, corkDamperThickness, stepdown=stepdown4250, left=true);
}

module XY_Motor_Mount_4250_Right_stl() {
    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = rightDrivePulleyOffset();

    stl("XY_Motor_Mount_4250_Right")
        color(pp1_colour)
            translate([eX + 2*eSize, 0, eZ - eSize - basePlateThickness - bracketHeightRight])
                mirror([1, 0, 0])
                    xyMotorMount(motorType, bracketHeightRight, basePlateThickness, -offset, sideSupportSizeY, stepdown=stepdown4250, left=false);
}

module XY_Motor_Mount_4250_Right_assembly()
assembly("XY_Motor_Mount_4250_Right", ngb=true) {

    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = rightDrivePulleyOffset();
    corkDamperThickness = 0;

    stl_colour(pp1_colour)
        XY_Motor_Mount_4250_Right_stl();
    XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, sideSupportSizeY, corkDamperThickness, stepdown=stepdown4250, left=false);
}

module XY_Motor_Mount_4933_Left_stl() {
    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [40.303, 0];

    stl("XY_Motor_Mount_4933_Left")
        color(pp1_colour)
            translate_z(eZ - eSize - basePlateThickness - bracketHeightLeft)
                xyMotorMount(motorType, bracketHeightLeft, basePlateThickness, offset, sideSupportSizeY, stepdown=true, left=true);
}

module XY_Motor_Mount_4933_Left_assembly()
assembly("XY_Motor_Mount_4933_Left", ngb=true) {

    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [40.303, 0];
    corkDamperThickness = 0;

    stl_colour(pp1_colour)
        XY_Motor_Mount_4933_Left_stl();
    XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, sideSupportSizeY, corkDamperThickness, stepdown=true, left=true);
}

module XY_Motor_Mount_4933_Right_stl() {
    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [-45.3595, 0];

    stl("XY_Motor_Mount_4933_Right")
        color(pp1_colour)
            translate([eX + 2*eSize, 0, eZ - eSize - basePlateThickness - bracketHeightRight])
                mirror([1, 0, 0])
                    xyMotorMount(motorType, bracketHeightRight, basePlateThickness, -offset, sideSupportSizeY, stepdown=true, left=false);
}

module XY_Motor_Mount_4933_Right_assembly()
assembly("XY_Motor_Mount_4933_Right", ngb=true) {

    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [-45.3595, 0];
    corkDamperThickness = 0;

    stl_colour(pp1_colour)
        XY_Motor_Mount_4933_Right_stl();
    //XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, sideSupportSizeY, corkDamperThickness, stepdown=true, left=false);
}
