//!Display the X-axis linear rail.

include <../scad/config/global_defs.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>

include <../scad/utils/X_Rail.scad>
use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/PrintheadAssemblyE3DV6.scad>

include <../scad/config/Parameters_CoreXY.scad>
use <../scad/config/Parameters_Positions.scad>


//$explode = 1;
module xRail_test() {
    translate(-[eSize + eX/2, carriagePosition().y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {
        //fullPrinthead(accelerometer=true);
        printheadBeltSide();
        xRailPrintheadPosition()
            Printhead_E3DV6_assembly();
        translate_z(eZ)
            xRail(carriagePosition());
    }
}

if ($preview)
    xRail_test();
