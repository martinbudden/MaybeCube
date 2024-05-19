//!Displays the baseplate.

include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
//include <NopSCADlib/vitamins/pcbs.scad>

//use <../scad/jigs/PanelJig.scad>

//use <../scad/printed/BaseFrontCover.scad>
//use <../scad/printed/ControlPanel.scad>
include <../scad/printed/BaseCover.scad>

include <../scad/assemblies/BasePlate.scad>
use <../scad/assemblies/FaceLeft.scad>
use <../scad/assemblies/FaceRight.scad>
use <../scad/assemblies/FaceTop.scad>
//use <../scad/vitamins/Panels.scad>
use <../scad/assemblies/Printbed.scad>
//include <../scad/assemblies/FaceRightExtras.scad>

include <../scad/Parameters_Main.scad>
use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module Base_test() {
    Base_Plate_assembly();
    //Base_Plate_Stage_1_assembly();
    //IEC_Housing_assembly();
    //basePlateAssembly(rightExtrusion=false, hammerNut=false);
    //BaseAL();
    //translate([eX + eSize, eSize, 0]) extrusionOY(eY);
    //pcbAssembly(BTT_SKR_V1_4_TURBO, pcbOnBase=true);
    //baseCoverTopAssembly(!false);
    //baseCoverLeftSideSupportsAssembly();
    //baseCoverRightSideSupportAssembly();
    //baseCoverFrontSupportsAssembly();
    //baseCoverBackSupportsAssembly();
    //baseFanMountAssembly();
    //printheadWiring(hotendDescriptor="OrbiterV3");

    //Left_Base_Channel_Spacers();
    //translate_z(-3) Panel_Jig_stl();
    //translate([eX + 2*eSize, 0, -3]) rotate(90) Panel_Jig_stl();
    //Front_Display_Wiring_Cover_stl();
    //Front_Cover_stl();
    //Left_Side_assembly();
    *translate([eSize + _zRodOffsetX, eSize + zRodSeparation()/2 + _zRodOffsetY, bedHeight($t)])
        rotate(-90)
            Printbed_Frame_assembly();

    //translate_z(bedHeight($t)) Printbed_assembly();
    //Right_Side_assembly();
    //controlPanel();
    //BigTreeTechTFT_3_5v3_0_bracket_stl();
    //bigTreeTechTFT_3_5v3_0();
    //pcb(BTT_B1_Box_V1_0);
    //pcb(BTT_SKR_V1_4_TURBO);
    //Foot_LShaped_12mm_stl();
}

if ($preview)
    Base_test();
