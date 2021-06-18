//!# JIGS Assembly Instructions
//
include <NopSCADlib/core.scad>

use <jigs/E2020ThreadTappingJig.scad>
use <jigs/ExtrusionDrillJig.scad>
use <jigs/PCB_Hole_Jig.scad>
use <jigs/PSU_Hole_Jig.scad>
use <jigs/RailCenteringJig.scad>
use <jigs/SidePanelJig.scad>


jigColor = rr_green;

module jigs_assembly()
assembly("jigs") {

    translate([-205, 0, 0])
        stl_colour(jigColor)
            E2020_Thread_Tapping_Jig_5mm_stl();
    translate([-165, 0, 0])
        stl_colour(jigColor)
            E2020_Thread_Tapping_Jig_6mm_stl();
    translate([120, 0, 0])
        Extrusion_Drill_Jig_Pilot_stl();
    translate([260, 0, 0])
        Extrusion_Drill_Jig_stl();
    translate([320, 0, 0])
        Extrusion_Drill_Jig_Extension_Pilot_stl();
    translate([380, 0, 0])
        Extrusion_Drill_Jig_Extension_stl();
    translate([-115, 0, 0])
        stl_colour(jigColor)
            Rail_Centering_Jig_stl();
    translate([-40, -60, 0])
        stl_colour(jigColor)
            Side_Panel_Jig_stl();
    //PCB_Hole_Jig_stl();
    //PSU_Hole_Jig_stl();
}

if ($preview)
    jigs_assembly();
