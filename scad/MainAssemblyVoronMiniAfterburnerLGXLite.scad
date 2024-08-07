//!# Voron Mini Afterburner adaptor
//!


include <config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/X_CarriageVoronMiniAfterburner.scad>

include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <config/Parameters_Positions.scad>
include <target.scad>

//$explode=1;

module X_Carriage_Voron_Mini_Afterburner_LGX_Lite_assembly()
assembly("X_Carriage_Voron_Mini_Afterburner_LGX_Lite") {
    explode = 20;
    rotate(180) {
        translate([0, 14, -50])
            rotate([90, 0, 180]) {
                stl_colour(pp3_colour)
                    rotate(180)
                        X_Carriage_Voron_Mini_Afterburner_LGX_Lite_stl();
                explode(explode, true)
                    xCarriageVoronMiniAfterburnerLGXLite_hardware();
            }
        }
}

module Printhead_Voron_Mini_Afterburner_LGX_Lite_assembly()
assembly("Printhead_Voron_Mini_Afterburner_LGX_Lite") {
    explode = 50;
    rotate(180)
        explode([0, explode, 0], true)
            translate([0, 14 + 7.3 + 4.25, 2.2]) {
                //vma_x_carriage_90_x1();
                vma_cowling_universal();
            }
    X_Carriage_Voron_Mini_Afterburner_LGX_Lite_assembly();
}

module Voron_Mini_Afterburner_LGX_Lite_assembly()
assembly("Voron_Mini_Afterburner_LGX_Lite", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    rotate(180) {
        translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
            *if (!exploded())
                not_on_bom()
                    CoreXYBelts(carriagePosition, x_gap=-25, show_pulleys=![1, 0, 0]);
            xRailCarriagePosition(carriagePosition)
                Printhead_Voron_Mini_Afterburner_LGX_Lite_assembly();
            no_explode() not_on_bom()
                printheadBeltSide(rotate=180);
        }
        not_on_bom()
            rail_assembly(xCarriageType, _xRailLength, pos=-2, carriage_end_colour="green", carriage_wiper_colour="red");
    }
}

if ($preview)
    Voron_Mini_Afterburner_LGX_Lite_assembly();
