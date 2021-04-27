//!Display the left and right Y carriages.

include <../scad/global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/utils/xyBelts.scad>
use <../scad/utils/X_Rail.scad>

include <../scad/Parameters_Main.scad>
include <../scad/Parameters_Positions.scad>

use <../scad/Parameters_CoreXY.scad>




yCarriageType = MGN12H_carriage;
rail_type = MGN12;

//$explode = 1;
//$pose = 1;
module Y_Carriage_test0() {
    translate_z(-eZ + eSize)
        xyBelts(carriagePosition, x_gap = 20, show_pulleys = [1,0,0]);
    translate([coreXYPosBL().x, eSize + _yRailLength/2, 0]) {
        rotate([180, 0, 90]) {
            translate([carriagePosition.y - eSize - _yRailLength/2, 0, carriage_height(yCarriageType)])
                Y_Carriage_Left_assembly();
        }
    }
    translate([eSize/2 + eX, eSize + _yRailLength/2, 0]) {
        rotate([180, 0, 90]) {
            translate([carriagePosition.y - eSize - _yRailLength/2, 0, carriage_height(yCarriageType)])
                Y_Carriage_Right_assembly();
        }
    }
}

module Y_Carriage_test1() {
    *Y_Carriage_Left_stl();
    *translate([150, 0, 0])
        rotate(180)
            Y_Carriage_Right_stl();
    Y_Carriage_Left_assembly();
    translate([100, 0, 0])
        Y_Carriage_Right_assembly();
}

if ($preview)
    Y_Carriage_test0();
