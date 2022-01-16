//! Display the tool changer

include <../scad/global_defs.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/XY_MotorMount.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

include <../scad/vitamins/extrusion.scad>

use <../scad/MainAssemblyJubileeToolChanger.scad>

use <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
t = 2;
carriagePosition = carriagePosition(t);


module toolchanger_test() {
    toolChanger(t, tool="bondtech", plate="jubilee");
    //tools();
    CoreXYBelts(carriagePosition);
    //printheadBeltSide(t=t);
    translate_z(eZ)
        xRail(carriagePosition, MGN12H_carriage);
    *translate([eSize, eX + eSize, eZ - 2*eSize])
        extrusionOX2040V(eY);
    *for (x=[0, eX + eSize], y=[0, eY + eSize])
        translate([x, y, 250])
            extrusionOZ(eZ - 250);
    //XY_Motor_Mount_Left_assembly();
    //XY_Motor_Mount_Right_assembly();
}

if ($preview)
    translate(-[eSize + eX/2, carriagePosition.y])
        translate_z(-(eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))))
            JubileeToolChanger_assembly();
            //toolchanger_test();
