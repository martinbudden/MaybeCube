//!# Voron Rapid Burner adaptor
//!


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/e3d.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronDragonBurner.scad>


include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>

//$explode=1;

module X_Carriage_Voron_Rapid_Burner_assembly()
assembly("X_Carriage_Voron_Rapid_Burner") {
    explode = 20;
    rotate(180) {
        translate([0, 14, -50])
            rotate([90, 0, 180]) {
                stl_colour(pp3_colour)
                    X_Carriage_Voron_Rapid_Burner_stl();
                stl_colour(pp3_colour)
                    X_Carriage_Voron_Rapid_Burner_ST_stl();
                explode(explode, true)
                    xCarriageVoronDragonBurner_hardware();
            }
        }
}

module Printhead_Voron_Rapid_Burner_assembly()
assembly("Printhead_Voron_Rapid_Burner") {
    explode = 50;
    rotate([90, 0, 0])
        explode([0, explode, 0], true)
            translate([0, -18, 14]) {
                rotate([-90, 0, 0])
                    color(voronColor())
                        vrb_LGX_Lite_Mount_stl();
                vrb_LGX_Lite_Mount_hardware();
                vflip()
                    color(voronColor())
                        vrb_Orbiter2_Hotend_Mount_ST_stl();
                vrb_Orbiter2_Hotend_Mount_hardware(inserts=false);
                color(voronAccentColor())
                    vflip()
                        vrb_Cowl_NoProbe_stl();
                vrb_Cowl_NoProbe_hardware(inserts=true);
            }
    X_Carriage_Voron_Rapid_Burner_assembly();
}

module Voron_Rapid_Burner_assembly()
assembly("Voron_Rapid_Burner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    rotate(180) {
        translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
            *if (!exploded())
                not_on_bom()
                    CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
            xRailCarriagePosition(carriagePosition)
                Printhead_Voron_Rapid_Burner_assembly();
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
