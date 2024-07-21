//! Display the right face

include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/AccessPanel.scad>
use <../scad/printed/BaseCover.scad>
use <../scad/printed/BambuFanBracket.scad>
use <../scad/printed/extruderBracket.scad>
use <../scad/utils/XY_MotorMount.scad>

use <../scad/vitamins/Panels.scad>

include <../scad/assemblies/FaceRight.scad>
include <../scad/assemblies/FaceRightExtras.scad>
//use <../scad/assemblies/FaceLeft.scad>
//use <../scad/assemblies/FaceTop.scad>
//include <../scad/printed/XY_MotorMount.scad>

use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module Right_Side_test() {
    //CoreXYBelts(carriagePosition(), show_pulleys=!true);
    Right_Side_assembly();
    //bambuFanBracketAssembly();
    baseFanMountAssembly();
    //accessPanelAssembly();
    //Left_Side_assembly();
    //Face_Top_assembly();
    //Extruder_Bracket_assembly();
    //iecHousing();
    //IEC_Housing_stl();
    //IEC_Housing_Mount_stl();
    //IEC_Housing_assembly();

    //Extruder_Bracket_stl();
    //faceRightSpoolHolder(sidePanelSize().z);
    //faceRightSpoolHolderBracket(sidePanelSize().z);
    //faceRightSpoolHolderBracketHardware(sidePanelSize().z);
    //faceRightSpool(sidePanelSize().z);
    //XY_Motor_Mount_Left_assembly();
    //XY_Motor_Mount_Right_assembly();
    //partitionTopAssembly();

    //Right_Side_Channel_Nuts();
    // always add the panels last, so they are transparent to other items
    //Right_Side_Channel_Spacers();
    Right_Side_Panel_assembly();
    //rightSidePanelPC(hammerNut=false);
    //Partition_assembly();
}

if ($preview)
    translate([-eX - 2*eSize, 0, 0])
        Right_Side_test();
