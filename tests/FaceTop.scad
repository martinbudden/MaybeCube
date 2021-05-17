//! Display the top face

include <NopSCADlib/core.scad>

use <../scad/printed/extruderBracket.scad>

use <../scad/utils/CoreXYBelts.scad>

use <../scad/FaceTop.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Face_Top_test() {
    CoreXYBelts(carriagePosition(), show_pulleys=[1, 0, 0]);

    //let($hide_extrusions=true)
    //let($hide_rails=true)
    //let($hide_corexy=true)
    //Face_Top_Stage_1_assembly();
    Face_Top_assembly();
    //Top_Corner_Piece_stl();
    //Top_Corner_Piece_hardware();
    //Top_Corner_Piece_assembly();
    //faceTopBack();
    //Left_Side_Upper_Extrusion_assembly();
    //Right_Side_Upper_Extrusion_assembly();
    //Extruder_Bracket_assembly();
}

if ($preview)
    translate_z(-eZ)
        Face_Top_test();
