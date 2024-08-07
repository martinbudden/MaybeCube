//!Display partial implementation to test bounds for printing.
/*
!!TODO


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
add filament runout sensor to extruder bracket
reinforce idler shelves
add more cable vitamins
complete assembly instructions
complete top level blurb

// Not Doing
add BTT_B1_Box_V1_0 to baseplate
z endstop
*/

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/utils/PSU.scad>
use <../scad/utils/XY_MotorMount.scad>


include <../scad/utils/printParameters.scad>
include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>

use <../scad/vitamins/PrintheadBIQU_B1.scad>

use <../scad/assemblies/BasePlate.scad>
use <../scad/assemblies/FaceLeft.scad>
use <../scad/assemblies/FaceRight.scad>
use <../scad/assemblies/Printbed.scad>

use <../scad/config/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module PrintBounds_test() {
    echoPrintSize();


    union() {
        *let($hide_extrusions=true)
            Base_Plate_assembly();

        let($hide_extrusions=true)
            Left_Side_assembly();

        let($hide_extrusions=true)
            Right_Side_assembly();
    }

    PSUPosition(PSUType())
        PSU_S_360_24();
    *translate_z(bedHeight())
        Printbed_assembly();
    //zRods();

    CoreXYBelts(carriagePosition(), x_gap = 0, show_pulleys = !false);
    translate_z(eZ) {
        xRail(carriagePosition());
        //xRailCarriagePosition(carriagePosition())
        //    xCarriagePrintheadOffset()
        //        PrintheadBIQU_B1();
    }
}

if ($preview)
    translate([-(eX + 2*eSize)/2, -(eY + 2*eSize)/2, -eZ/2])
        PrintBounds_test();
