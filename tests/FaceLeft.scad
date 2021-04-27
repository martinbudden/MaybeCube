//! Display the left face

include <NopSCADlib/core.scad>

use <../scad/printed/extruderBracket.scad>
use <../scad/utils/xyBelts.scad>
use <../scad/utils/printParameters.scad>
use <../scad/utils/Z_Rods.scad>
use <../scad/vitamins/SidePanels.scad>

use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceTop.scad>
use <../scad/PrintBed.scad>

include <../scad/Parameters_Main.scad>
include <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
module Face_Left_test() {
    echoPrintSize();
    //xyBelts(carriagePosition, show_pulleys=[1, 0, 0]);

    //let($hide_extrusions=true)
    //let($hide_rails=true)
    Face_Left_assembly(); zRods();
    //Face_Right_assembly(); zRods(left=false);
    //Extruder_Bracket_assembly();
    //translate_z(_bedHeight) Printbed_assembly();
    //let($hide_corexy=true)
    //let($hide_extrusions=true)
    //Face_Top_assembly();

    // always add the side panel last, so it is transparent to other items
    Left_Side_Panel_assembly();
}

if ($preview)
    Face_Left_test();
