include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/bldc_motors.scad>
include <NopSCADlib/vitamins/pulleys.scad>

include <../utils/motorTypes.scad>

include <../vitamins/bolts.scad>
use <../vitamins/cables.scad>

use <XY_MotorMount.scad>

include <../Parameters_Main.scad>
use <../Parameters_CoreXY.scad>


NEMA17_60  = ["NEMA17_60",   42.3, 60,     53.6/2, 25,     11,     2,     5,     24,          31,    [11.5,  9]];

NEMA_hole_depth = 5;

bracketHeightRight = eZ - eSize - (coreXYPosBL().z + washer_thickness(M3_washer));
bracketHeightLeft = bracketHeightRight + coreXYSeparation().z;

stepdown4250 = true;

//                                     shaft  shaft shaft      body   base             holes                 base            side  bell             holes          boss   prop shaft   thread
//                      diameter height diam length offset   colour   diam   h1    h2  diam position         open  wire    colour  diam   h1    h1  d  pos  spokes  d  h  length diam  length  diam
BLDC4933  = ["BLDC4933",   49.0, 33,      6,    60,    27, grey(20),   38,   5,    5.5,2.5,  [32,32,32],     true,  3.0, grey(20),   49,   8,    8, 2.5,12,      5, 12, 0,     5,   4,      0,     0];


module XY_Motor_Mount_4250_Left_stl() {
    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = leftDrivePulleyOffset();

    stl("XY_Motor_Mount_4250_Left")
        color(pp1_colour)
            xyMotorMount(motorType, basePlateThickness, offset, stepdown=stepdown4250, left=true);
}

module XY_Motor_Mount_4250_Left_assembly()
assembly("XY_Motor_Mount_4250_Left", ngb=true) {

    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = leftDrivePulleyOffset();
    corkDamperThickness = 0;

    translate_z(eZ - eSize - basePlateThickness - bracketHeightLeft) {
        stl_colour(pp1_colour)
            XY_Motor_Mount_4250_Left_stl();
        XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, corkDamperThickness, stepdown=stepdown4250, left=true);
    }
}

module XY_Motor_Mount_4250_Right_stl() {
    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = rightDrivePulleyOffset();

    stl("XY_Motor_Mount_4250_Right")
        color(pp1_colour)
            translate([eX + 2*eSize, 0, 0])
                mirror([1, 0, 0])
                    xyMotorMount(motorType, basePlateThickness, -offset, stepdown=stepdown4250, left=false);
}

module XY_Motor_Mount_4250_Right_assembly()
assembly("XY_Motor_Mount_4250_Right", ngb=true) {

    motorType = BLDC4250;
    basePlateThickness = stepdown4250 ? 6 : 5;
    offset = rightDrivePulleyOffset();
    corkDamperThickness = 0;

    translate_z(eZ - eSize - basePlateThickness - bracketHeightRight) {
        stl_colour(pp1_colour)
            XY_Motor_Mount_4250_Right_stl();
        XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, corkDamperThickness, stepdown=stepdown4250, left=false);
    }
}

module XY_Motor_Mount_4933_Left_stl() {
    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [40.303, 0];

    stl("XY_Motor_Mount_4933_Left")
        color(pp1_colour)
            xyMotorMount(motorType, basePlateThickness, offset, stepdown=true, left=true);
}

module XY_Motor_Mount_4933_Left_assembly()
assembly("XY_Motor_Mount_4933_Left", ngb=true) {

    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [40.303, 0];
    corkDamperThickness = 0;

    translate_z(eZ - eSize - basePlateThickness - bracketHeightLeft) {
        stl_colour(pp1_colour)
            XY_Motor_Mount_4933_Left_stl();
        XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, corkDamperThickness, stepdown=true, left=true);
    }
}

module XY_Motor_Mount_4933_Right_stl() {
    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [-45.3595, 0];

    stl("XY_Motor_Mount_4933_Right")
        color(pp1_colour)
            translate([eX + 2*eSize, 0, 0])
                mirror([1, 0, 0])
                    xyMotorMount(motorType, basePlateThickness, -offset, stepdown=true, left=false);
}

module XY_Motor_Mount_4933_Right_assembly()
assembly("XY_Motor_Mount_4933_Right", ngb=true) {

    motorType = BLDC4933;
    basePlateThickness = 6;
    offset = [-45.3595, 0];
    corkDamperThickness = 0;

    translate_z(eZ - eSize - basePlateThickness - bracketHeightRight) {
        stl_colour(pp1_colour)
            XY_Motor_Mount_4933_Right_stl();
        XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, corkDamperThickness, stepdown=true, left=false);
    }
}

module encoderMagnetHolder(motorType) {
    magnetDiameter = 6 + 0.1;
    magnetHeight = 2.5;
    diameter = 20;
    offsetZ = 0.5;
    height = BLDC_prop_shaft_length(motorType) + magnetHeight + offsetZ;
    translate_z(-height)
        difference() {
            cylinder(d=diameter, h=height);
            translate_z(offsetZ-0.1)
                rotate(15)
                    poly_cylinder(r=magnetDiameter/2, h=height);
            holes = BLDC_bell_holes(motorType);
            holeOffset = is_list(holes) ? holes[0] : holes / 2;
            for (x = [-holeOffset, holeOffset])
                translate([x, 0, 0])
                    rotate(45)
                        boltHoleM2p5HangingCounterboreButtonhead(height, boreDepth=height - 2, boltHeadTolerance=0.2);
        }
}

module Encoder_Magnet_Holder_4250_stl() {
    motorType = BLDC4250;

    stl("Encoder_Magnet_Holder_4250")
        color(pp3_colour)
            encoderMagnetHolder(motorType);
}

module Encoder_Magnet_Holder_4933_stl() {
    motorType = BLDC4933;

    stl("Encoder_Magnet_Holder_4933")
        color(pp3_colour)
            encoderMagnetHolder(motorType);
}
