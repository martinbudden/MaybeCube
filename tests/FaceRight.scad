//! Display the right face

include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/AccessPanel.scad>
use <../scad/printed/extruderBracket.scad>
//use <../scad/printed/IEC_Housing.scad>
use <../scad/printed/XY_MotorMount.scad>

//include <../scad/utils/Z_Rods.scad>
//include <../scad/utils/CoreXYBelts.scad>

use <../scad/vitamins/Panels.scad>

include <../scad/FaceRight.scad>
include <../scad/FaceRightExtras.scad>
//use <../scad/FaceLeft.scad>
//use <../scad/FaceTop.scad>

use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module Right_Side_test() {
    //CoreXYBelts(carriagePosition(), show_pulleys=!true);
    Right_Side_assembly();
    accessPanelAssembly();
    //Left_Side_assembly();
    //Face_Top_assembly();
    //faceRightSpoolHolder();
    //faceRightSpool();
    //zRods(left=false);
    //Extruder_Bracket_assembly();
    //iecHousing();
    //IEC_Housing_stl();
    //IEC_Housing_Mount_stl();
    //IEC_Housing_assembly();

    //Extruder_Bracket_stl();
    faceRightSpoolHolder(0);
    faceRightSpoolHolderBracket(0);
    faceRightSpoolHolderBracketHardware(0);
    //faceRightSpool();
    //XY_Motor_Mount_Left_assembly();
    XY_Motor_Mount_Right_assembly();

    //Right_Side_Channel_Nuts();
    // always add the panels last, so they are transparent to other items
    rightSidePanelPC();
    Partition_assembly();
}

if ($preview)
    translate([-eX - 2*eSize, 0, 0])
        Right_Side_test();
