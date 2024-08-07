//! Display the Voron Afterburner X carriage

include <../scad/global_defs.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/PrintheadAssemblyE3DV6.scad>
use <../scad/printed/X_CarriageVoronMiniAfterburner.scad>
use <../scad/printed/X_CarriageVoronMiniAfterburnerLGXLite.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/MainAssemblyVoronMiniAfterburner.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/config/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;

module VoronMiniAfterburner_test(full=!true) {
    carriagePosition = carriagePosition();
    translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {
        explode([0, 50, 0], true)
            xRailCarriagePosition(carriagePosition)
                Printhead_Voron_Mini_Afterburner_assembly();
        if (full) {
            //CoreXYBelts(carriagePosition, x_gap = -25, show_pulleys = ![1, 0, 0]);
            no_explode() printheadBeltSide(rotate=180);
            //printheadE3DV6();
            printheadBeltSideBolts(rotate=180);
            xRailCarriagePosition(carriagePosition) // rotate is for debug, to see belts better
                *translate([-6, -5, 7])
                    printheadE3DV6Assembly(full=false);
        }
        *translate_z(eZ)
            xRail(carriagePosition, MGN12H_carriage);
        *translate([0, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Left_assembly();
        *translate([2*eSize + eX, carriagePosition.y - carriagePosition().y, eZ - eSize])
            Y_Carriage_Right_assembly();
    }
}

//Printhead_Voron_Mini_Afterburner_assembly();
//xCarriageVoronMiniAfterburner();
rotate(180) translate([0, 14 + 7.3 + 4.25, 2.2]) {
//vma_x_carriage_90_x1();
//vma_vlatch_dd_x1();
//vma_vlatch_shuttle_dd_x1();
//vma_guidler_dd_x1();
//vma_mid_body_x1();
//vma_motor_frame_x1();
//vma_motor_frame_x1_hardware();
//xCarriageVoronMiniAfterburner_hardware();
//vma_cowling_mosquito_x1();
//vmalgxl_cowling_universal();
//vmalgxl_x_carriage_sls();
//vmalgxl_hotend_mount_mosquito_3010_fan();
}

if ($preview)
    VoronMiniAfterburner_test();
