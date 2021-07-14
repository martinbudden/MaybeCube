//!# EVA adaptors
//
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageEVA.scad>
use <utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>


//$explode = 1;
module EVA_assembly()
assembly("EVA", big=true) {

    hidden()
        stl_colour(evaColorGrey())
            evaPrintheadList();

    xCarriageType = MGN12H_carriage;

    translate_z(carriage_height(xCarriageType)) {
        stl_colour(evaColorGrey())
            evaHotendBase(top="bmg_mgn12");
        translate([0, 18.5, -20.5]) {
            explode([0, 30, 0])
                stl_colour(evaColorGreen())
                    evaImportStl("back_corexy");
            *explode([0, -30, 0])
                translate([0, -32, 0])
                    stl_colour(evaColorGreen())
                        evaImportStl("universal_face");
        }
    }
    carriage(xCarriageType, end_colour="green", wiper_colour="red");
    rail(MGN12, _xRailLength);
    carriagePosition = carriagePosition();
    if (!exploded())
        translate(-[eSize + eX/2, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)])
            CoreXYBelts(carriagePosition + [-2, 0], x_gap=-25);
}

if ($preview)
    EVA_assembly();
