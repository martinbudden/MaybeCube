//! Display the XChange X carriage

include <../scad/config/global_defs.scad>

include <../scad/vitamins/bolts.scad>

include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/PrintheadAssemblies.scad>
include <../scad/printed/X_CarriageXChange.scad>
use <../scad/MainAssemblyXChange.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

use <../scad/config/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
t = 2;

module XChange_test() {
    xCarriageType = MGN12H_carriage;
    rotate(180)
    translate(-[carriagePosition(t).x, carriagePosition(t).y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
        //CoreXYBelts(carriagePosition() + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        //printheadBeltSide();
        printheadXChange();
        *xRailCarriagePosition(carriagePosition())
            translate_z(-carriage_height(xCarriageType))
                carriage(xCarriageType);
        *translate_z(eZ)
            xRail(carriagePosition(), xCarriageType);
    }
}

if ($preview)
    XChange_test();
else
    X_Carriage_XChange_16_stl();
