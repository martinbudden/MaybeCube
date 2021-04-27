//!Display the Extrusion Drill Jig

use <../scad/printed/extrusionDrillJig.scad>
include <../scad/Parameters_Main.scad>


//$pose = 1;
//$explode = 1;
module Jig_test() {
    Extrusion_Drill_Jig_50_5_stl();
    //Extrusion_Drill_Jig_90_2_stl();
    //Extrusion_Drill_Jig_90_4_stl();
    //Extrusion_Drill_Jig_120_2_stl();
    //Extrusion_Drill_Jig_120x7_stl();
}

//if ($preview)
    Jig_test();
