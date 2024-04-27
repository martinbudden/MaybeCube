//!Displays the baseplate.

include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
//include <NopSCADlib/vitamins/pcbs.scad>

//use <../scad/jigs/PanelJig.scad>

//use <../scad/printed/BaseFrontCover.scad>
//use <../scad/printed/ControlPanel.scad>
include <../scad/printed/BaseCover.scad>

include <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
//use <../scad/vitamins/Panels.scad>
//use <../scad/Printbed.scad>
//include <../scad/FaceRightExtras.scad>

include <../scad/Parameters_Main.scad>
//use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module Base_test() {
    //BaseAL();
    //Base_Plate_Stage_1_assembly();
    //basePlateAssembly(rightExtrusion=false, hammerNut=false);
    //translate([eX + eSize, eSize, 0]) extrusionOY(eY);
    //pcbAssembly(BTT_SKR_V1_4_TURBO, pcbOnBase=true);
    //baseCoverTopAssembly();
    //baseCoverSideSupportsAssembly();
    //baseCoverFrontSupportsAssembly();
    //Base_Plate_Stage_1_assembly();
    Base_Plate_assembly();
    //Left_Base_Channel_Spacers();
    //BaseAL();
    //translate_z(-3) Panel_Jig_stl();
    //translate([eX + 2*eSize, 0, -3]) rotate(90) Panel_Jig_stl();
    //Front_Display_Wiring_Cover_stl();
    //Front_Cover_stl();
    //Left_Side_assembly();
    //translate_z(bedHeight(7)) Printbed_assembly();
    //Right_Side_assembly();
    //Base_Extrusions_assembly();
    //basePlate();
    //controlPanel();
    //BigTreeTechTFT_3_5v3_0_bracket_stl();
    //bigTreeTechTFT_3_5v3_0();
    //pcb(BTT_B1_Box_V1_0);
    //pcb(BTT_SKR_V1_4_TURBO);
    //Foot_LShaped_12mm_stl();
}

if ($preview)
    Base_test();
