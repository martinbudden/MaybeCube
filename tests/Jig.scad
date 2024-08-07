//!Display the Extrusion Drill Jig

include <NopSCADlib/utils/core/core.scad>

use <../scad/assemblies/FaceLeft.scad>
use <../scad/assemblies/FaceRight.scad>

use <../scad/jigs/ExtrusionDrillJig.scad>
use <../scad/jigs/PanelJig.scad>
include <../scad/config/Parameters_Main.scad>


//$pose = 1;
//$explode = 1;
module Jig_test() {
    ///Extrusion_Drill_Jig_50_5_stl();
    translate([80, 0, 0])
        Extrusion_Drill_Jig_E40_stl();
    //Extrusion_Drill_Jig_90_2_stl();
    //Extrusion_Drill_Jig_90_4_stl();
    //Extrusion_Drill_Jig_120_2_stl();
}

module Jig_test2() {
    Left_Side_assembly();
    translate([35, -5, -5])
        rotate([0, 90, 180])
            Extrusion_Drill_Jig_Z_Rods_stl();
    translate([-5, eY + 2*eSize + 15 + eps, eZ + 5])
        rotate([0, -90, 90])
            Extrusion_Drill_Jig_Z_Rods_stl();
    Right_Side_assembly();
    translate([eX + 2*eSize + 5, -15, eZ + 5])
        rotate([0, -90, -90])
            Extrusion_Drill_Jig_Z_Rods_stl();
}

//Panel_Jig_stl();
Jig_test2();
