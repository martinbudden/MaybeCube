//! Display the top face

include <NopSCADlib/core.scad>

use <../scad/printed/extruderBracket.scad>

use <../scad/utils/CoreXYBelts.scad>

use <../scad/FaceTop.scad>
use <../scad/BackFace.scad>
use <../scad/printed/WiringGuide.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Face_Top_test() {
    //if(!exploded()) CoreXYBelts(carriagePosition(), show_pulleys=[1, 0, 0]);

    //let($hide_extrusions=true)
    //let($hide_rails=true)
    //let($hide_corexy=true)
    //faceTopBack();
    *if (!exploded())
        printHeadWiring();
    *translate_z(eZ) {
        Wiring_Guide_stl();
        Wiring_Guide_hardware();
        translate_z(9) {
            Wiring_Guide_Clamp_stl();
            Wiring_Guide_Clamp_hardware();
        }
    }
    //Face_Top_Stage_1_assembly();
    //let($hide_extrusions=true)
    Face_Top_assembly();
    //Top_Corner_Piece_stl();
    //Top_Corner_Piece_hardware();
    //Top_Corner_Piece_assembly();
    //Left_Side_Upper_Extrusion_assembly();
    //Right_Side_Upper_Extrusion_assembly();
    //Extruder_Bracket_assembly();
}

if ($preview)
    rotate(-90 + 30)
        translate([-eX/2 - eSize, -eY/2 - eSize, -eZ])
            Face_Top_test();
