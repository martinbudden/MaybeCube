//!Display the x axis linear rail.

include <../scad/global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/utils/carriageTypes.scad>
use <../scad/utils/X_Rail.scad>
use <../scad/printed/PrintheadAssemblies.scad>

use <../scad/Parameters_CoreXY.scad>
use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
module xRail_test() {
    translate(-[eSize + eX/2, carriagePosition().y, eZ - yRailOffset().x - carriage_clearance(xCarriageType())]) {
        fullPrinthead(accelerometer=true);
        translate_z(eZ)
            xRail(carriagePosition());
    }
}

if ($preview)
    xRail_test();
