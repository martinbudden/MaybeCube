//!# Voron Afterburner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageVoronAfterburner.scad>

use <utils/CoreXYBelts.scad>
use <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>


module printheadVoronAfterburner(rotate=180, explode=0, t=undef) {
    xRailCarriagePosition(carriagePosition(t), rotate)
        explode(explode, true) {
            va_x_carriage_frame_left();
            va_x_carriage_frame_right();
            //va_extruder_motor_plate();
            //va_printhead_rear_e3dv6();
        }
}

module Voron_Afterburner_assembly()
assembly("Voron_Afterburner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    translate(-[eSize + eX/2, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
        if (!exploded())
            not_on_bom()
                CoreXYBelts(carriagePosition + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        printheadVoronAfterburner();
    }
    not_on_bom()
        rail_assembly(xCarriageType, _xRailLength, pos=-2, carriage_end_colour="green", carriage_wiper_colour="red");
}

if ($preview)
    Voron_Afterburner_assembly();
