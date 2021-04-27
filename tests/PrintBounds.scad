//!Display partial implementation to test bounds for printing.
/*
!!TODO

add more cable vitamins
complete assembly instructions
complete top level blurb
add BTT_B1_Box_V1_0 to baseplate
add filament runout sensor to extruderbracket
z endstop
reinforce idler shelves


//DONE
reduce coreXY z separation
remove middle shelf on idler brackets
cutout from idler
simpler brackets for printbed
fans for BIQU B1 printhead
endstop for BIQU B1 printhead
add nozzle and heat block to hotend assembly
integrated insulation for heatbed
cable connector for heatbed
endstop on left yCarriage
finish xCarriage
y endstop
convert extruder bracket to BIQU B1 form
add belt fragments for x carriage
move motors to back, ie swap left and right face arrangement

*/

include <NopSCADlib/core.scad>

include <../scad/Parameters_Main.scad>
include <../scad/Parameters_Positions.scad>
use <../scad/Parameters_CoreXY.scad>

use <../scad/utils/printParameters.scad>
use <../scad/utils/xyBelts.scad>
use <../scad/utils/X_Rail.scad>

use <../scad/printed/PSU.scad>
use <../scad/vitamins/PrintHeadBIQU_B1.scad>

use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/PrintBed.scad>

//$explode = 1;
//$pose = 1;
module PrintBounds_test() {
    echoPrintSize();


    union() {
        *let($hide_extrusions=true)
            Base_Plate_assembly();

        let($hide_extrusions=true)
            Face_Left_assembly();

        let($hide_extrusions=true)
            Face_Right_assembly();
    }

    PSUPosition()
        PSU();
    *translate_z(bedHeight())
        Printbed_assembly();
    //zRods();

    xyBelts(carriagePosition, x_gap = 0, show_pulleys = !false);
    translate_z(eZ) {
        xRail();
        //xRailCarriagePosition()
        //    xCarriagePrintHeadOffset()
        //        PrintHeadBIQU_B1();
    }
}

if ($preview)
    translate([-(eX+2*eSize)/2, -(eY+2*eSize)/2, -eZ/2])
        PrintBounds_test();
