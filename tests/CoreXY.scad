//! Displays a reduced implementation to focus on the coreXY part.

include <../scad/global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>
include <NopSCADlib/vitamins/belts.scad>
include <NopSCADlib/vitamins/pulleys.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/printed/XY_Idler.scad>
use <../scad/printed/XY_MotorMount.scad>

use <../scad/utils/printParameters.scad>
use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/X_Rail.scad>

use <../scad/vitamins/extrusion.scad>
use <../scad/vitamins/bolts.scad>

use <../scad/Parameters_CoreXY.scad>
use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


yCarriageType = MGN12H_carriage;
xCarriageType = MGN12H_carriage;
rail_type = MGN12;


module CoreXY_test() {

    echoPrintSize();

    NEMA_width = _xyMotorDescriptor == "NEMA14" ? 35.2 : 42.3;
    coreXYSize = coreXYPosTR(NEMA_width) - coreXYPosBL();
    CoreXYBelts(carriagePosition(), x_gap = 20, show_pulleys = [1, 0, 0]);
    fullPrinthead(xCarriageType);

    for (x=[0, eX + eSize], y=[0, eY + eSize])
        translate([x, y, 250])
            extrusionOZ(eZ-250);

    *translate([eSize, 0, eZ - eSize])
        extrusionOX(eX);
    *translate([eSize, eY + eSize, eZ - 2*eSize])
        extrusionOX2040V(eX);
    *for (x=[0, eX])
        translate([x, eSize, eZ - eSize])
            extrusionOY2040H(eY);

    translate([1.5*eSize, eSize + _yRailLength/2, eZ - eSize])
        rotate([180, 0, 90])
            rail_assembly(yCarriageType, _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
    Y_Carriage_Left_assembly();
    translate([eSize/2+eX, eSize+_yRailLength/2, eZ - eSize])
        rotate([180, 0, 90])
            rail_assembly(yCarriageType, _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
    Y_Carriage_Right_assembly();

    //XY_Idler_Left_assembly();
    //XY_Idler_Right_assembly();

    //XY_Motor_Mount_Left_stl();
    XY_Motor_Mount_Left_assembly();
    XY_Motor_Mount_Right_assembly();
}

if ($preview)
    translate_z(-coreXYPosBL().z)
        CoreXY_test();
