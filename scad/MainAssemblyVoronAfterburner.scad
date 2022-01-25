//!# Voron Afterburner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronAfterburner.scad>

include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>

$explode=1;
module printheadVoronAfterburner(rotate=0, explode=100, t=undef) {
    translate([0, 13.956, 1.81])
        xRailCarriagePosition(carriagePosition(t), rotate) {
            explode([50, 0, explode])
                frameLeft();
            explode([-50, 0, explode])
                frameRight();
            explode(explode, false) not_on_bom() {
                //va_x_carriage_frame_left();
                //va_x_carriage_frame_right();
                va_extruder_motor_plate();
                va_extruder_body();
                va_blower_housing_rear();
                va_blower_housing_front();
                va_hotend_fan_mount();
                va_printhead_rear_e3dv6();
                va_printhead_front_e3dv6();
            }
        }
}

module Voron_Afterburner_assembly()
assembly("Voron_Afterburner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
        if (!exploded())
            not_on_bom()
                CoreXYBelts(carriagePosition + [2, 0], x_gap=-25, show_pulleys=![1, 0, 0]);
        printheadVoronAfterburner();
        no_explode() not_on_bom()
            printheadBeltSide();
    }
    not_on_bom()
        rail_assembly(xCarriageType, _xRailLength, pos=-2, carriage_end_colour="green", carriage_wiper_colour="red");
}

if ($preview)
    rotate(180)
        Voron_Afterburner_assembly();
