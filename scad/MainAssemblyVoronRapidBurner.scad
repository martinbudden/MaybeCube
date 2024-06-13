    //!# Voron Rapid Burner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/e3d.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronRapidBurner.scad>

include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>

//$explode=1;

module Voron_Rapid_Burner_Adapter_assembly()
assembly("Voron_Rapid_Burner_Adapter", big=true) {
    explode = 20;
    stl_colour(pp3_colour)
        Voron_Rapid_Burner_Adapter_stl();
    hidden() Voron_Rapid_Burner_Adapter_ST_stl();
    explode(explode, true, show_line=false)
        xCarriageVoronDragonBurnerAdapter_inserts();
}

module Extruder_assembly()
assembly("Extruder", big=true) {
    voronRapidBurnerExtruderAssembly();
}

module voronRapidBurnerExtruderAssembly(extruderDescriptor="LGX_Lite") {
    not_on_bom()
        if (extruderDescriptor == "LGX_Lite") {
            color(voronColor())
                vrb_LGX_Lite_Mount_stl();
            explode(-20, true)
                vrb_LGX_Lite_Mount_hardware();
            explode(30)
                translate_z(voronRapidToDragonOffsetZ())
                    bondtechLGXLite();
        }
}


module Hotend_assembly()
assembly("Hotend", big=true) {
    voronRapidBurnerHotendAssembly();
}
module voronRapidBurnerHotendAssembly(hotendDescriptor=undef) {
    explode([0, 60, 0], true) {
        rotate([90, 0, 0])
            color(voronColor())
                vrb_LGX_Lite_Hotend_Mount_stl();
        not_on_bom() {
            vrb_LGX_Lite_Hotend_Mount_hardware(inserts=true, cableTies=false);
            vrb_LGX_Lite_Hotend_Mount_attachmentBolts();
            explode(-30)
                phaetusRapido();
        }
        translate([0, -23.3, 11.25])
            rotate([90, 0, 180]) {
                Voron_Rapid_Burner_Adapter_assembly();
                xCarriageVoronDragonBurnerAdapter_topBolt();
            }
    }
}

module Extruder_and_Hotend_assembly()
assembly("Extruder_and_Hotend", big=true) {
    explode(20, show_line=false)
        Extruder_assembly();
    Hotend_assembly();
    explode(30, true)
        vrb_LGX_Lite_Mount_hotendBolts();
}

module xCarriageVoronRapidBurnerAdapterAttachmentBolts() {
    explode = 20;
    translate([0, -37.3, 61.25])
        translate([0, 14, -50])
            rotate([90, 0, 180])
                explode(explode, true)
                    xCarriageVoronDragonBurnerAdapter_cowlingBolts();
}


module voronRapidBurnerAssembly(extruderDescriptor="LGX_Lite", hotendDescriptor=undef) {
    not_on_bom()
        explode([0, 80, 0], true) {
            color(voronAccentColor())
                rotate([90, 0, 0])
                    vrb_Cowl_NoProbe_stl();
                explode([0, 40, 0])
                    vrb_Cowl_NoProbe_bolts();
            no_explode() {
                vdb_Cowl_fans(fanOffsetZ=-11.5);
                vdb_Cowl_inserts();
            }
        }
    //voronRapidBurnerExtruderAndHotendAssembly(extruderDescriptor, hotendDescriptor);
    Extruder_and_Hotend_assembly();
    explode([0, -20, 0], true, show_line=false)
        xCarriageVoronRapidBurnerAdapterAttachmentBolts();
}

module Rapid_Burner_assembly()
assembly("Rapid_Burner", big=true) {
    translate([0, 37.3, -61.25])
        voronRapidBurnerAssembly();
}

module Voron_Rapid_Burner_assembly()
assembly("Voron_Rapid_Burner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    hidden() 
        color(voronColor())
            vrb_LGX_Lite_Hotend_Mount_ST_stl();

    rotate(0) {
        translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
            *if (!exploded())
                not_on_bom()
                    CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
            xRailCarriagePosition(carriagePosition, rotate=0) {
                Rapid_Burner_assembly();
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
    Voron_Rapid_Burner_assembly();

