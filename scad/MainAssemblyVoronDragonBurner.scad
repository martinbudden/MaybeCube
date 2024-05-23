//!# Voron Dragon Burner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronDragonBurner.scad>


include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>

//$explode=1;

module xCarriageVoronDragonBurnerAssembly(inserts=true) {
    explode = 20;
    translate([0, 13.97, -50])
        rotate([90, 0, 180]) {
            stl_colour(pp3_colour)
                if (inserts)
                    X_Carriage_Voron_Dragon_Burner_stl();
                else
                    X_Carriage_Voron_Dragon_Burner_ST_stl();
            explode(explode, true)
                xCarriageVoronDragonBurner_hardware(inserts=inserts);
        }
}

module printheadVoronDragonBurnerAssembly(extruderDescriptor="LGX_Lite", hotendDescriptor="RevoVoron") {
    translate([0, 37.3, -61.25]) 
        rotate([0, 0, 0]) {
            if (extruderDescriptor == "LGX_Lite") {
                color(voronColor())
                    vdb_LGX_Lite_Mount();
                bondtechLGXLite();
            }
            if (hotendDescriptor == "E3DV6") {
                color(voronColor())
                    vdb_V6_Mount_Front();
                color(voronColor())
                    vdb_V6_Mount_Rear();
                vdbE3DV6();
            } else if (hotendDescriptor == "RevoVoron") {
                color(voronColor())
                    vdb_RevoVoron_Mount();
                revoVoron();
            }
            color(voronAccentColor())
                vdb_Cowl_NoProbe();
            vdb_Cowl_NoProbe_hardware();
        }
}

module Printhead_Voron_Dragon_Burner_assembly()
assembly("Printhead_Voron_Dragon_Burner", big=true) {
    printheadVoronDragonBurnerAssembly();
    xCarriageVoronDragonBurnerAssembly(inserts=true);
}

module Voron_Dragon_Burner_assembly()
assembly("Voron_Dragon_Burner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    rotate(0) {
        translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
            *if (!exploded())
                not_on_bom()
                    CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
            xRailCarriagePosition(carriagePosition, rotate=0) {
                printheadPosition()
                    Printhead_Voron_Dragon_Burner_assembly();
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
    Voron_Dragon_Burner_assembly();
