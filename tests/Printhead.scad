//! Display the print head

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageAssemblies.scad>

use <../scad/utils/carriageTypes.scad>
use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/X_Rail.scad>
use <../scad/vitamins/bolts.scad>

use <../../BabyCube/scad/printed/X_Carriage.scad>

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

    *translate(-[eSize + eX/2, carriagePosition().y, eZ - yRailOffset().x - carriage_clearance(xCarriageType())]) {
        fullPrinthead();
        CoreXYBelts(carriagePosition(), x_gap = 20, show_pulleys = [1, 0, 0]);
        translate_z(eZ)
            xRail(carriagePosition());
    }
    *translate(-[eSize + eX/2, carriagePosition().y, eZ - yRailOffset().x - carriage_clearance(xCarriageType())])
        xRailCarriagePosition() {
            Printhead_MGN12H_assembly();
            X_Carriage_Front_MGN12H_assembly();
            //X_Carriage_MGN12H_assembly();
        }
    let($hide_bolts=true) Printhead_MGN12H_assembly();
    //translate([-11.4, 0, 8]) rotate(180)    xCarriageTop();
    //X_Carriage_Front_MGN12H_assembly();
    //X_Carriage_MGN12H_assembly();
    //X_Carriage_MGN12H_stl();
    //Fan_Duct_stl();
    //rotate([90, 0, -90]) Hotend_Clamp_stl();
    //Hotend_Clamp_hardware();
    //Hotend_Strain_Relief_Clamp_stl();
}

module xCarriageTop() {
    xCarriageType = MGN12H_carriage;
    topThickness = xCarriageTopThickness();
    fillet = 1;

    extraY = xCarriageFrontOffsetY(xCarriageType) - carriage_size(xCarriageType).y/2 - xCarriageFrontSize(xCarriageType).y;
    carriageSize = carriage_size(xCarriageType);
    carriageOffsetY = carriageSize.y/2;
    size =  [xCarriageBackSize(xCarriageType).x/2, extraY + carriageSize.y + xCarriageBackSize(xCarriageType).y, 4];

    difference() {
        translate([-size.x/2, 10.5 - extraY - carriageSize.y, 0]) {
            rounded_cube_xy(size, fillet);
            difference() {
                tabSize = [15, 5, 25];
                rounded_cube_xy(tabSize, fillet);
                for (x = [tabSize.x/2 - 4, tabSize.x/2 + 4], z = [5+2, 15+2])
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


if ($preview)
    Printhead_test();
