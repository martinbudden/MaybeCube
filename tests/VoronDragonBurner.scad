//! Display the Voron Dragon Burner X carriage

include <../scad/global_defs.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageVoronDragonBurner.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/MainAssemblyVoronDragonBurner.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;

module VoronDragonBurner_test(full=true) {
    vorongDragonBurnerOffsetZ = 47.8;
    carriagePosition = carriagePosition();
    translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor)) - vorongDragonBurnerOffsetZ]) {
        explode([0, 50, 0], true)
            xRailCarriagePosition(carriagePosition) {
                Printhead_Voron_Dragon_Burner_assembly();
                //Printhead_OrbiterV3_assembly();
                //Printhead_E3DV6_assembly();
            }
        if (full) {
            //CoreXYBelts(carriagePosition, x_gap = -25, show_pulleys = ![1, 0, 0]);
            no_explode() printheadBeltSide(rotate=180);
            printheadBeltSideBolts(rotate=180);
            translate_z(eZ)
                xRail(carriagePosition, MGN12H_carriage);
            *translate([0, carriagePosition.y - carriagePosition().y, eZ - eSize]) {
                Y_Carriage_Left_assembly();
                translate([2*eSize + eX, 0])
                    Y_Carriage_Right_assembly();
            }
        }
    }
}

//dragonBurnerMountTemplate();
*translate([0, -24, 0]){
X_Carriage_Voron_Dragon_Burner_stl();
xCarriageVoronDragonBurner_hardware();
}

*translate([0.15, -32.25, 0])  {
    X_Carriage_Voron_Rapid_Burner_stl();
    xCarriageVoronDragonBurner_hardware();
}

//vdb_Carriage_Base_Short();
//vdb_MGN12H_X_Carriage_Lite();
//vdb_Boop_Front_Extended();
//vdb_LGX_Lite_Mount();
//bondtechLGXLite();
//vdb_V6_Mount_Front();
//vdb_V6_Mount_Rear();
//vdbE3DV6();
//vdb_RevoVoron_Mount();
//revoVoron();
//vdb_Cowl_NoProbe();
//vdb_Cowl_NoProbe_hardware();
//rotate([-90, 0, 0]) vrb_LGX_Lite_Mount_stl();
//vrb_LGX_Lite_Mount_hardware();
//X_Carriage_Voron_Dragon_Burner_assembly();
//Printhead_Voron_Dragon_Burner_assembly();

if ($preview)
    rotate(180)
        VoronDragonBurner_test();
