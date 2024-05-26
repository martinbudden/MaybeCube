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

module VoronDragonBurner_test(full=!true) {
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
    Voron_Rapid_Burner_Adapter_stl();
    xCarriageVoronDragonBurner_hardware();
}

//vdb_Carriage_Base_Short();
//vdb_MGN12H_X_Carriage_Lite();
//vdb_Boop_Front_Extended();
//vdb_LGX_Lite_Mount();
//vdb_LGX_Lite_Mount_hardware();
//bondtechLGXLite();
//vdb_V6_Mount_Front();
//vdb_V6_Mount_Rear();
//vdbE3DV6();
//-55.23 is offset from nozzle to center of attachment holes
*translate([0, 12, -56.93+3.4/2]) {
vdb_RevoVoron_Mount();
//vdb_RevoVoron_Mount_hardware();
revoVoron();
}
//vdb_Cowl_inserts();
//vdb_Cowl_NoProbe();
//vdb_Cowl_NoProbe_hardware();
//voronDragonBurnerExtruderAssembly();
//voronDragonBurnerHotendAssembly();
//voronDragonBurnerAssembly();
*translate([0, -23.30, 11.1]) rotate([90, 0, 180])
Voron_Dragon_Burner_Adapter_stl();

*translate([0,-69.22+0.134,23.3])
rotate([90, 0, 180]){
vdb_Cowl_NoProbe();
rotate([90, 0, 0]) vdb_RevoVoron_Mount_stl();
vdb_LGX_Lite_Mount_stl();
}
//vdb_Cowl_NoProbe_stl();
//vdb_LGX_Lite_Mount_hardware();
//vdb_V6_Mount_Front_stl();
//vdb_V6_Mount_Rear_stl();
//rotate([-90, 0, 0]) vrb_LGX_Lite_Mount_stl();
//X_Carriage_Voron_Dragon_Burner_assembly();
//Printhead_Voron_Dragon_Burner_assembly();
//xCarriageVoronDragonBurnerAdapter();
//xCarriageVoronDragonBurnerAdapter_hardware();

if ($preview)
    rotate(180)
        VoronDragonBurner_test();
