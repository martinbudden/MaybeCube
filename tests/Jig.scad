//!Display the Extrusion Drill Jig

include <NopSCADlib/core.scad>

use <../scad/FaceLeft.scad>

use <../scad/printed/extrusionDrillJig.scad>
include <../scad/Parameters_Main.scad>


//$pose = 1;
//$explode = 1;
module Jig_test() {
    ///Extrusion_Drill_Jig_50_5_stl();
    translate([80, 0, 0])
        Extrusion_Drill_Jig_Extension_stl();
    //Extrusion_Drill_Jig_90_2_stl();
    //Extrusion_Drill_Jig_90_4_stl();
    //Extrusion_Drill_Jig_120_2_stl();
}

module Jig_test2() {
    Left_Side_assembly();
    //let($hide_bolts=true)
        translate([35, -5, -5])
            rotate([0, -90, 0])
                Extrusion_Drill_Jig_120_2_stl();
    //let($hide_bolts=true)
        translate([-5, eY + 2*eSize + 15 + eps, eZ+5])
            rotate([0, 90, -90]) {
                //Extrusion_Drill_Jig_90_2_stl();
                Extrusion_Drill_Jig_120_2_stl();
            }
}

Jig_test();
