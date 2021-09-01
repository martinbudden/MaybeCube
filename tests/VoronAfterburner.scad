//! Display the Voron Afterburner X carriage

include <../scad/global_defs.scad>
$pp1_colour = grey(25);
$pp2_colour = "limegreen";
$pp3_colour = grey(25);
$pp4_colour = "steelblue";

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/e3d.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageAssemblies.scad>
use <../scad/printed/X_CarriageVoronAfterburner.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>

use <../scad/utils/carriageTypes.scad>
use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/X_Rail.scad>

use <../scad/vitamins/bolts.scad>

use <../scad/Parameters_CoreXY.scad>
use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
t = 2;

module VA_test() {
    carriagePosition = carriagePosition(t);
    translate(-[eSize + eX/2, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType())]) {
        //CoreXYBelts(carriagePosition + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        printheadBeltSide();
        //printheadHotendSide();
        translate([0, -10-4, 11])
            xRailCarriagePosition(carriagePosition(t)) {
                va_x_carriage_frame_left();
                va_x_carriage_frame_right();
                va_extruder_motor_plate();
                va_printhead_rear_e3dv6();
            }
        translate_z(eZ)
            xRail(carriagePosition, MGN12H_carriage);
        *translate([0, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Left_assembly();
        *translate([2*eSize + eX, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Right_assembly();
    }
}

//va_x_carriage_frame_left();
//va_x_carriage_frame_right();
//va_extruder_motor_plate();
//va_printhead_rear_e3dv6();
if ($preview)
    VA_test();
