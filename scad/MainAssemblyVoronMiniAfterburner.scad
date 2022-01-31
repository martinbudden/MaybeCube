//!# Voron Mini Afterburner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronMiniAfterburner.scad>

include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>

//$explode=1;
module printheadVoronMiniAfterburner(rotate=0, explode=100, t=undef) {
    xRailCarriagePosition(carriagePosition(t), rotate) {
        *translate([-10, 14, -40])
            cube([20, 10, 40]);
        translate([0, 14 + 5.8, 2.2]) {
            vma_x_carriage_90_x1();
            vma_motor_frame_x1();
            //vma_mid_body_x1();
            //vma_cowling_mosquito_x1();
        }
    }
}

module Voron_Mini_Afterburner_assembly()
assembly("Voron_Mini_Afterburner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
        if (!exploded())
            not_on_bom()
                CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
        printheadVoronMiniAfterburner();
        no_explode() not_on_bom()
            printheadBeltSide();
    }
    not_on_bom()
        rail_assembly(xCarriageType, _xRailLength, pos=-2, carriage_end_colour="green", carriage_wiper_colour="red");
}

if ($preview)
    rotate(180)
        Voron_Mini_Afterburner_assembly();
