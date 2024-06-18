//!# Voron Dragon Burner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageAssemblies.scad>
use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronDragonBurner.scad>


include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>

//$explode=1;

module Voron_Dragon_Burner_Adapter_assembly()
assembly("Voron_Dragon_Burner_Adapter", big=true) {
    explode = 20;
    stl_colour(pp3_colour)
        Voron_Dragon_Burner_Adapter_stl();
    explode(explode, true, show_line=false)
        xCarriageVoronDragonBurnerAdapter_inserts();
}

module xCarriageVoronDragonBurnerAdapterAssembly(inserts=true) {
    translate([0, 13.97, -50])
        rotate([90, 0, 180])
            if (inserts) {
                Voron_Dragon_Burner_Adapter_assembly();
                hidden() Voron_Dragon_Burner_Adapter_ST_stl();
            } else {
                stl_colour(pp3_colour)
                    Voron_Dragon_Burner_Adapter_ST_stl();
            }
}

module xCarriageVoronDragonBurnerAdapterAttachmentBolts() {
    explode = 20;
    translate([0, 13.95, -50])
        rotate([90, 0, 180])
            explode(explode, true) {
                xCarriageVoronDragonBurnerAdapter_topBolt();
                xCarriageVoronDragonBurnerAdapter_cowlingBolts();
            }
}

module voronDragonBurnerExtruderAssembly(extruderDescriptor="LGX_Lite") {
    if (extruderDescriptor == "LGX_Lite") {
        color(voronColor())
            vdb_LGX_Lite_Mount_stl();
        vdb_LGX_Lite_Mount_hardware();
        bondtechLGXLite();
    }
}

module voronDragonBurnerHotendAssembly(hotendDescriptor="RevoVoron") {
    if (hotendDescriptor == "E3DV6") {
        color(voronColor())
            rotate([90, 0, 0])
                vdb_V6_Mount_Front_stl();
        color(voronColor())
            rotate([-90, 0, 0])
                vdb_V6_Mount_Rear_stl();
        vdbE3DV6();
    } else if (hotendDescriptor == "RevoVoron") {
        color(voronColor())
            rotate([90, 0, 0])
                vdb_RevoVoron_Mount_stl();
        vdb_RevoVoron_Mount_hardware();
        revoVoron();
    }
}

module voronDragonBurnerAssembly(extruderDescriptor="LGX_Lite", hotendDescriptor="RevoVoron") {
    not_on_bom() no_explode() {
        voronDragonBurnerExtruderAssembly(extruderDescriptor);
        voronDragonBurnerHotendAssembly(hotendDescriptor);
        color(voronAccentColor())
            rotate([90, 0, 0])
                vdb_Cowl_NoProbe_stl();
        vdb_Cowl_fans();
        vdb_Cowl_inserts();
    }
}

module Dragon_Burner_assembly()
assembly("Dragon_Burner", big=true) {
    voronDragonBurnerAssembly();
}

module Printhead_Voron_Dragon_Burner_assembly()
assembly("Printhead_Voron_Dragon_Burner", big=true) {
    translate([0, railCarriageGap() - 0.5, 0]) {
        translate([0, 37.3, -61.25]) {
            voronDragonBurnerAssembly();
            //Dragon_Burner_assembly();
        }
        explode([0, 100, 0])
            vdb_Cowl_NoProbe_Attachment_Bolts();
        explode([0, -200, 0], true, show_line=false)
            xCarriageVoronDragonBurnerAdapterAttachmentBolts();
        explode([0, -100, 0], show_line=false)
            xCarriageVoronDragonBurnerAdapterAssembly(inserts=true);
    }
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
            xRailCarriagePosition(carriagePosition, rotate=0)
                Printhead_Voron_Dragon_Burner_assembly();
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
