//! Display the right face

include <NopSCADlib/core.scad>

use <../scad/printed/extruderBracket.scad>
use <../scad/printed/IEC_Housing.scad>

use <../scad/utils/Z_Rods.scad>
use <../scad/utils/xyBelts.scad>

use <../scad/vitamins/SidePanels.scad>

use <../scad/FaceRight.scad>
use <../scad/FaceRightExtras.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceTop.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Face_Right_test() {
    //xyBelts(carriagePosition, show_pulleys=!true);
    Face_Right_assembly();
    //Face_Left_assembly();
    //Face_Top_assembly();
    //faceRightSpoolHolder();
    //faceRightSpool();
    //zRods(left=false);
    Extruder_Bracket_assembly();
    //IEC_assembly();
    //IEC_Housing_stl();
    //IEC_Housing_Mount_stl();
    IEC_Housing_Mount_assembly();

    //faceRightExtras();
    //Extruder_Bracket_stl();
    //faceRightSpool();

    // always add the side panel last, so it is transparent to other items
    Right_Side_Panel_assembly();
}

if ($preview)
    translate([-eX - 2*eSize, 0, 0])
        Face_Right_test();
