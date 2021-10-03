//! Display the XChange X carriage

include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/MainAssemblyXChange.scad>

use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/X_Rail.scad>

include <../scad/vitamins/bolts.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
t = 2;

module XChange_test() {
    xCarriageType = MGN12H_carriage;
    translate(-[eSize + eX/2, carriagePosition(t).y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
        //CoreXYBelts(carriagePosition() + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        printheadBeltSide();
        printheadXChange();
        xRailCarriagePosition(carriagePosition())
            translate_z(-carriage_height(xCarriageType))
                carriage(xCarriageType);
        translate_z(eZ)
            xRail(carriagePosition(), xCarriageType);
    }
}

if ($preview)
    XChange_test();
else
    X_Carriage_XChange_stl();
