//! Display the Voron Afterburner X carriage

include <../scad/global_defs.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageVoronMiniAfterburner.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/MainAssemblyVoronMiniAfterburner.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
t = 2;

module VoronMiniAfterburner_test() {
    carriagePosition = carriagePosition();
    translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {
        //CoreXYBelts(carriagePosition, x_gap = -25, show_pulleys = ![1, 0, 0]);
        rotate = 0;
        printheadBeltSide(rotate);
        //printheadHotendSide(rotate);
        *xRailCarriagePosition(carriagePosition, rotate) // rotate is for debug, to see belts better
            translate([-6, -5, 7])
                printheadAssembly(full=false);

        printheadVoronMiniAfterburner(rotate);
        translate_z(eZ)
            xRail(carriagePosition, MGN12H_carriage);
        *translate([0, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Left_assembly();
        *translate([2*eSize + eX, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Right_assembly();
    }
}

//xCarriageVoronMiniAfterburner();
//vma_x_carriage_90_x1();
//vma_vlatch_dd_x1();
//vma_vlatch_shuttle_dd_x1();
//vma_guidler_dd_x1();
//vma_motor_frame_x1();
//vma_mid_body_x1();
//vma_cowling_mosquito_x1();
if ($preview)
    VoronMiniAfterburner_test();
