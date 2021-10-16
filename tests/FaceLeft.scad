//! Display the left face

include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/extruderBracket.scad>
use <../scad/printed/IEC_Housing.scad>
use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/printParameters.scad>
use <../scad/utils/Z_Rods.scad>
use <../scad/vitamins/Panels.scad>

use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceTop.scad>
use <../scad/PrintBed.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Left_Side_test() {
    t = 3;
    echoPrintSize();
    //CoreXYBelts(carriagePosition(t=t), show_pulleys=[1, 0, 0]);
    //let($hide_extrusions=true)
    //let($hide_rails=true)
    Left_Side_assembly(); zRods();
    //Right_Side_assembly(); if(is_true(_useDualZRods))zRods(left=false);
    //Extruder_Bracket_assembly();
    //let($hide_extrusions=true)
    translate_z(bedHeight(t=t)) Printbed_assembly();
    //let($hide_corexy=true)
    //let($hide_extrusions=true)
    //Face_Top_Stage_1_assembly();
    //fullPrinthead(t=3);
    //printheadBeltSide();
    //printheadHotendSide(t=t);

    // always add the panels last, so it is transparent to other items
    //Left_Side_Panel_assembly();
    //Left_Side_Channel_Nuts();
    leftSidePanelPC();
    //partitionPC();
}

if ($preview)
    Left_Side_test();
