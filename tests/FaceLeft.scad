//! Display the left face

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/extruderBracket.scad>
use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/printParameters.scad>
use <../scad/utils/Z_Rods.scad>
use <../scad/vitamins/SidePanels.scad>

use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceTop.scad>
use <../scad/PrintBed.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Left_Side_test() {
    echoPrintSize();
    //CoreXYBelts(carriagePosition, show_pulleys=[1, 0, 0]);

    //let($hide_extrusions=true)
    //let($hide_rails=true)
    Left_Side_assembly(); zRods();
    //Right_Side_assembly(); if(is_true(_useDualZRods))zRods(left=false);
    //Extruder_Bracket_assembly();
    //let($hide_extrusions=true)
    translate_z(bedHeight(t=3)) Printbed_assembly();
    //let($hide_corexy=true)
    //let($hide_extrusions=true)
    //Face_Top_assembly();
    //fullPrinthead(t=3);

    // always add the side panel last, so it is transparent to other items
    //Left_Side_Panel_assembly();
    leftSidePanelPC();
}

if ($preview)
    Left_Side_test();
