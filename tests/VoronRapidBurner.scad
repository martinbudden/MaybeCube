//! Display the Voron Rapid Burner X carriage

include <../scad/global_defs.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageVoronDragonBurner.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/MainAssemblyVoronDragonBurner.scad>
use <../scad/MainAssemblyVoronRapidBurner.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;

module VoronRapidBurner_test(full=true) {
    carriagePosition = carriagePosition();
    translate(-[carriagePosition.x, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {

        explode([0, 50, 0], true)
            xRailCarriagePosition(carriagePosition) {
                Printhead_Voron_Rapid_Burner_assembly();
                //printheadVoronRapidBurnerAssembly();
                //xCarriageVoronRapidBurnerAssembly(inserts=true);

                //Printhead_OrbiterV3_assembly();
                //Printhead_E3DV6_assembly();
            }
        if (full) {
            //CoreXYBelts(carriagePosition, x_gap = -25, show_pulleys = ![1, 0, 0]);
            no_explode()
                printheadBeltSide(rotate=180);
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

//translate_z(voronRapidToDragonOffsetZ()) bondtechLGXLite();
//vrb_LGX_Lite_Mount();
//vrb_LGX_Lite_Mount_hardware();
inserts=true;
//phaetusRapido();
//vrb_LGX_Lite_Hotend_Mount(inserts=inserts);
//vrb_LGX_Lite_Hotend_Mount_hardware(inserts=inserts);
//vrb_Cowl_NoProbe();
//vrb_Cowl_NoProbe_hardware();
//vrb_Cowl_NoProbe_stl();
//vrb_LGX_Lite_Mount_stl();
//vrb_LGX_Lite_Hotend_Mount_stl();

if ($preview)
    rotate(180)
        VoronRapidBurner_test();
