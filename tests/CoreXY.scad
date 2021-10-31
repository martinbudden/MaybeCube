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
use <../scad/printed/X_CarriageEVA.scad>

include <../scad/utils/printParameters.scad>
include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

include <../scad/vitamins/bolts.scad>
use <../scad/vitamins/extrusion.scad>

use <../scad/Parameters_CoreXY.scad>
use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>

//$vpr = [55,0,25];
//$vpr = [70,0,315]; // for tests
yCarriageType = MGN12H_carriage;
rail_type = MGN12;
t = 2;

module CoreXY_test() {

    echoPrintSize();
    echo(vpr=$vpr);

    NEMA_width = _xyMotorDescriptor == "NEMA14" ? 35.2 : 42.3;
    coreXYSize = coreXYPosTR(NEMA_width) - coreXYPosBL();
    #CoreXYBelts(carriagePosition(t), x_gap = -20, show_pulleys = ![1, 0, 0]);
    printheadBeltSide(t=t);
    //fullPrinthead(t=t);

    *xRailCarriagePosition(carriagePosition(t))
        evaHotendTop();

    translate_z(eZ)
        xRail(carriagePosition(t));

    for (x=[0, eX + eSize], y=[0, eY + eSize])
        translate([x, y, 250])
            extrusionOZ(eZ-250);

    *translate([eSize, 0, eZ - eSize])
        extrusionOX(eX);
    *translate([eSize, eY + eSize, eZ - 2*eSize])
        extrusionOX2040V(eX);
    *if (_use2060ForTop)
        for (x=[0, eX - eSize])
            translate([x, eSize, eZ - eSize])
                extrusionOY2060H(eY);
    else
        for (x=[0, eX])
            translate([x, eSize, eZ - eSize])
                extrusionOY2040H(eY);

    translate([coreXYPosBL().x, eSize + _yRailLength/2, eZ - eSize])
        rotate([180, 0, 90])
            rail_assembly(yCarriageType, _yRailLength, carriagePosition(t).y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
    translate([0, carriagePosition(t).y - carriagePosition().y, eZ - eSize])
        Y_Carriage_Left_assembly();
    translate([eX + 2*eSize - coreXYPosBL().x, eSize + _yRailLength/2, eZ - eSize])
        rotate([180, 0, 90])
            rail_assembly(yCarriageType, _yRailLength, carriagePosition(t).y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
    translate([eX + 2*eSize, carriagePosition(t).y - carriagePosition().y, eZ - eSize])
        Y_Carriage_Right_assembly();

    XY_Idler_Left_assembly();
    XY_Idler_Right_assembly();

    //XY_Motor_Mount_Left_stl();
    XY_Motor_Mount_Left_assembly();
    XY_Motor_Mount_Right_assembly();
}

if ($preview)
    rotate($vpr.z == 315 ? -90 + 30 : 0)
        translate([-eX/2 - eSize, -eY/2 - eSize, -coreXYPosBL().z])
            CoreXY_test();
