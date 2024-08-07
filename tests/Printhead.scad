//! Display the print head

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/PrintheadAssemblyE3DV6.scad>
use <../scad/printed/PrintheadAssemblyOrbiterV3.scad>
use <../scad/printed/X_CarriageAssemblies.scad>
use <../scad/printed/X_CarriageE3DV6.scad>
use <../scad/printed/X_CarriageEVA.scad>
use <../scad/printed/X_CarriageOrbiterV3.scad>
use <../scad/MainAssemblyXChange.scad>
use <../scad/MainAssemblyVoronAfterburner.scad>
use <../scad/MainAssemblyVoronMiniAfterburner.scad>
use <../scad/MainAssemblyVoronDragonBurner.scad>
use <../scad/MainAssemblyVoronRapidBurner.scad>

include <../scad/vitamins/bolts.scad>

use <../scad/utils/XY_MotorMount.scad>
include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

use <../scad/config/Parameters_Positions.scad>


function  blzX(yCarriageType) = coreXYSeparation().z + yRailSupportThickness() + yCarriageThickness() + carriage_height(yCarriageType);
function  blz(yCarriageType) = yCarriageThickness() + carriage_height(yCarriageType);


//$explode = 1;
//$pose = 1;
module Printhead_test() {
    echo(beltSeparation=beltSeparation());
    echo(beltOffsetZ=beltOffsetZ());
    echo(blz=blz(MGN12H_carriage));
    echo(coreXYPosBL=coreXYPosBL());
    echo(coreXYSeparation=coreXYSeparation());
    carriagePosition = carriagePosition();

    zOffset = eZ - yRailOffset().x + carriage_height(carriageType(_xCarriageDescriptor)) - carriage_clearance(carriageType(_xCarriageDescriptor));
    halfCarriage = false;
    translate(-[eSize + eX/2, carriagePosition.y, zOffset - orbiterV3NozzleOffsetFromMGNCarriageZ()]) {
        //CoreXYBelts(carriagePosition, x_gap = -30, show_pulleys = ![1, 0, 0]);
        printheadBeltSide();
        printheadBeltSideBolts();
        xRailPrintheadPosition() {
            //Printhead_E3DV6_assembly();
            Printhead_OrbiterV3_assembly();
            //Printhead_Voron_Mini_Afterburner_assembly();
            //translate_z(-0.7) Printhead_Voron_Dragon_Burner_assembly();
            //translate_z(-0.7) Printhead_Voron_Rapid_Burner_assembly();
        }
        //printheadVoronAfterburner();
        //printheadEVA_2_4_2();
        //printheadXChange();
        *translate_z(eZ) {
            xRail(carriagePosition);
            xRailBoltPositions(carriagePosition)
                boltM3Caphead(10);
        }
    }
    *translate(-[eSize + eX/2, carriagePosition.y, zOffset]) {
        CoreXYBelts(carriagePosition, x_gap = -25, show_pulleys = ![1, 0, 0]);
        translate_z(eZ)
            xRail(carriagePosition);
        xRailCarriagePosition(carriagePosition) {
            //Printhead_E3DV6_assembly();
            X_Carriage_Beltside_assembly();
            xCarriageGroovemountAssembly();
        }
    }
    *let($hide_bolts=true) Printhead_E3DV6_assembly();
    //translate([-11.4, 0, 8]) rotate(180) xCarriageTopTest();
    //xCarriageGroovemountAssembly();
    //Fan_Duct_stl();
    //rotate([90, 0, -90]) Hotend_Clamp_stl();
    //Hotend_Clamp_hardware();
    //Hotend_Strain_Relief_Clamp_stl();
}

module Printhead_test1() {
    translate_z(orbiterV3NozzleOffsetFromMGNCarriageZ()) {
        X_Carriage_Beltside_assembly();
        *translate([-carriagePosition().x, -carriagePosition().y, xRailCarriagePositionZ()])
            printheadBeltSide();
        translate([-carriagePosition().x, -carriagePosition().y, -xRailCarriageOffsetZ()])
            xRail(carriagePosition());
        Printhead_OrbiterV3_assembly();
        Printhead_Voron_Dragon_Burner_assembly();
    }
}

module xCarriageTopTest() {
    xCarriageType = MGN12H_carriage;
    topThickness = xCarriageTopThickness();
    fillet = 1;

    extraY = xCarriageFrontOffsetY(xCarriageType) - carriage_size(xCarriageType).y/2 - xCarriageBeltSideSizeM(xCarriageType).y;
    carriageSize = carriage_size(xCarriageType);
    carriageOffsetY = carriageSize.y/2;
    size =  [xCarriageHotendSideSizeM(xCarriageType).x/2, extraY + carriageSize.y + xCarriageHotendSideSizeM(xCarriageType).y, 4];

    difference() {
        translate([-size.x/2, 10.5 - extraY - carriageSize.y, 0]) {
            rounded_cube_xy(size, fillet);
            difference() {
                tabSize = [15, 5, 25];
                rounded_cube_xy(tabSize, fillet);
                for (x = [tabSize.x/2 - 4, tabSize.x/2 + 4], z = [5 + 2, 15 + 2])
                    translate([x-1, -eps, z])
                        cube([2, tabSize.y + 2*eps, 4]);
            }
        }
        // bolt holes to connect to to the rail carriage
        translate([size.x/2, 0, -carriage_height(xCarriageType)])
            carriage_hole_positions(xCarriageType)
                boltHoleM3(size.z);
    }
}

//X_Carriage_Belt_Tensioner_stl();
//X_Carriage_Belt_Tensioner_hardware(xCarriageBeltTensionerSize(beltWidth()), 40, 22.5);
//X_Carriage_Belt_Tensioner_RB_stl();
//mirror([0, 1, 0])
//X_Carriage_Belt_Tensioner_hardware(xCarriageBeltTensionerSize(beltWidth()), 40, 22.5);
//X_Carriage_Belt_Tensioner_RB_stl();
//printheadOrbiterV3Assembly();
//smartOrbiterV3();
//Printhead_OrbiterV3_assembly();
//xCarriageGroovemountAssembly();
//X_Carriage_OrbiterV3_stl();
//Smart_Orbiter_V3_Duct_stl();
//rotate([-90, 0, 0])
//vflip() Smart_Orbiter_V3_Fan_Bracket_5015_stl();
//Smart_Orbiter_V3_Fan_Bracket_stl();
//let($hide_bolts=true)
if ($preview)
    Printhead_test();
