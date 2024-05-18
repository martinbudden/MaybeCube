//!# Voron Dragon Burner adaptor
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

module X_Carriage_Voron_Dragon_Burner_assembly()
assembly("X_Carriage_Voron_Dragon_Burner") {
    explode = 20;
    rotate(180) {
        translate([0, 14, -50])
            rotate([90, 0, 180]) {
                stl_colour(pp3_colour)
                    X_Carriage_Voron_Dragon_Burner_stl();
                stl_colour(pp3_colour)
                    X_Carriage_Voron_Dragon_Burner_ST_stl();
                explode(explode, true)
                    xCarriageVoronDragonBurner_hardware();
            }
        }
}

module Printhead_Voron_Dragon_Burner_assembly()
assembly("Printhead_Voron_Dragon_Burner") {
    explode = 50;
    rotate([90, 0, 0])
        explode([0, explode, 0], true)
            translate([0, -26, 14]) {
                color(voronColor())
                    vdb_LGX_Lite_Mount();
                //vdb_RevoVoron_Mount();
                color(voronColor())
                    vdb_V6_Mount_Front();
                color(voronColor())
                    vdb_V6_Mount_Rear();
                translate([0.2, 22.8, 23.4])
                    rotate([-90, 180, 0])
                        e3d_hot_end(E3Dv6, filament=1.75, naked=true, bowden=false);
                color(voronAccentColor())
                    vdb_Cowl_NoProbe();
                vdb_Cowl_NoProbe_hardware();
            }
    X_Carriage_Voron_Dragon_Burner_assembly();
}

module Voron_Dragon_Burner_assembly()
assembly("Voron_Dragon_Burner", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    rotate(180) {
        translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
            *if (!exploded())
                not_on_bom()
                    CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
            xRailCarriagePosition(carriagePosition)
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
