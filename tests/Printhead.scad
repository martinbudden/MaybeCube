//! Display the print head

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageAssemblies.scad>

use <../scad/utils/carriageTypes.scad>
use <../scad/utils/xyBelts.scad>
use <../scad/utils/X_Rail.scad>

use <../scad/Parameters_CoreXY.scad>
use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


function  blzX(yCarriageType) = coreXYSeparation().z + yRailSupportThickness() + yCarriageThickness() + carriage_height(yCarriageType);
function  blz(yCarriageType) = yCarriageThickness() + carriage_height(yCarriageType);

//$explode = 1;
//$pose = 1;
module Printhead_test() {
    echo(beltOffsetZ=beltOffsetZ());
    echo(blz=blz(MGN12H_carriage));
    echo(coreXYPosBL=coreXYPosBL());
    echo(coreXYSeparation=coreXYSeparation());

    translate(-[eSize + eX/2, carriagePosition().y, eZ - yRailOffsetXYZ().x - carriage_clearance(xCarriageType())]) {
        fullPrinthead();
        xyBelts(carriagePosition(), x_gap = 20, show_pulleys = [1, 0, 0]);
        translate_z(eZ)
            xRail(carriagePosition());
    }
    //Printhead_assembly();
    //X_Carriage_Front_assembly();
    //X_Carriage_assembly();
    //X_Carriage_stl();
    //Fan_Duct_stl();
    //Hotend_Clamp_stl();
    //Hotend_Clamp_hardware();
    //Hotend_Strain_Relief_Clamp_stl();
}

if ($preview)
    Printhead_test();
