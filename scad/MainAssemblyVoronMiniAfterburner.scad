//!# Voron Mini Afterburner adaptor
//!


include <config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageAssemblies.scad>
use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronMiniAfterburner.scad>

include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <config/Parameters_Positions.scad>
include <target.scad>

//$explode=1;

module xCarriageVoronMiniAfterburnerAssembly(inserts=true) {
    explode = 20;
    translate([0, 14 + railCarriageGap(), -50])
        rotate([90, 0, 180]) {
            stl_colour(pp3_colour)
                rotate(180)
            if (inserts)
                X_Carriage_Voron_Mini_Afterburner_stl();
            else
                X_Carriage_Voron_Mini_Afterburner_stl();
            explode(explode, true)
                xCarriageVoronMiniAfterburner_hardware(inserts=inserts);
        }
        *explode([0, explode, 0],  true)
            translate([0, 14 + 7.3 + 4.25, 2.2])
                vma_motor_frame_x1_assembly();
}

module printheadVoronMiniAfterburnerAssembly(extruderDescriptor=undef, hotendDescriptor=undef) {
    explode = 50;
    explode([0, explode, 0], true)
        translate([0, 14 + 7.3 + 4.25 + railCarriageGap() - 0.2, 2.2]) {
            //vma_x_carriage_90_x1(); // to check with original
            vma_motor_frame_x1();
            vma_mid_body_x1();
            vma_vlatch_dd_x1();
            vma_vlatch_shuttle_dd_x1();
            vma_guidler_dd_x1();
            vma_cowling_mosquito_x1();
        }
}

module Printhead_Voron_Mini_Afterburner_assembly()
assembly("Printhead_Voron_Mini_Afterburner", big=true) {
    printheadVoronMiniAfterburnerAssembly();
    xCarriageVoronMiniAfterburnerAssembly(inserts=true);
}


module Voron_Mini_Afterburner_assembly()
assembly("Voron_Mini_Afterburner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    rotate(0) {
        translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
            *if (!exploded())
                not_on_bom()
                    CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
            xRailCarriagePosition(carriagePosition, rotate=0) {
                printheadPosition()
                    Printhead_Voron_Mini_Afterburner_assembly();
                //xCarriageVoronMiniAfterburnerAssembly();
            }
            no_explode() not_on_bom() {
                printheadBeltSide();
                printheadBeltSideBolts();
            }
        }
        not_on_bom()
            rail_assembly(xCarriageType, _xRailLength, pos=-2, carriage_end_colour="green", carriage_wiper_colour="red");
    }
}

if ($preview)
    Voron_Mini_Afterburner_assembly();
