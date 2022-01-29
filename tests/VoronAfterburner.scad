//! Display the Voron Afterburner X carriage

include <../scad/global_defs.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageVoronAfterburner.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/MainAssemblyVoronAfterburner.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
t = 2;

module VoronAfterburner_test() {
    carriagePosition = carriagePosition();
    translate(-[carriagePosition.x, carriagePosition.y+0*13.948, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {
        //CoreXYBelts(carriagePosition + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        rotate = 0;
        printheadBeltSide(rotate);
        //printheadHotendSide(rotate);
        printheadVoronAfterburner(rotate);
        translate_z(eZ)
            xRail(carriagePosition, MGN12H_carriage);
        *translate([0, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Left_assembly();
        *translate([2*eSize + eX, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Right_assembly();
    }
}
//translate(-[carriagePosition().x, carriagePosition().y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))])
//printheadVoronAfterburner();
//X_Carriage_VA_Frame_Left_16_stl()
//X_Carriage_VA_Frame_Right_16_stl()
//va_x_carriage_frame_left();
//va_x_carriage_frame_right();
//va_extruder_motor_plate();
//va_extruder_body();
//va_bowden_module_front();
//va_bowden_module_rear_generic();
//va_blower_housing_rear();
//va_blower_housing_front();
//va_hotend_fan_mount();
//va_printhead_rear_e3dv6();
//va_printhead_front_e3dv6();
//frame(left=false);
//va_x_carriage_frame_left_top();
//va_x_carriage_frame_right_top();
if ($preview)
    VoronAfterburner_test();
