//!# Jigs
//!
//!Jigs to aid with the assembly of the MaybeCube.


include <NopSCADlib/vitamins/rails.scad>

use <vitamins/extrusion.scad>
use <jigs/E20ThreadTappingJig.scad>
use <jigs/ExtrusionDrillJig.scad>
use <jigs/PanelJig.scad>
//use <jigs/PCB_Hole_Jig.scad>
//use <jigs/PSU_Hole_Jig.scad>
use <jigs/RailCenteringJig.scad>


jigColor = rr_green;

module Jigs_assembly()
assembly("Jigs") {

    translate([-205, 0, 0])
        stl_colour(jigColor)
            E20_Thread_Tapping_Jig_5mm_stl();
    translate([-165, 0, 0])
        stl_colour(jigColor)
            E20_Thread_Tapping_Jig_6mm_stl();
    translate([120, 0, 0]) {
        stl_colour(jigColor)
            Extrusion_Drill_Jig_Z_Rods_Pilot_stl();
        Extrusion_Drill_Jig_Z_Rods_Pilot_hardware();
    }
    translate([260, 0, 0]) {
        stl_colour(jigColor)
            Extrusion_Drill_Jig_Z_Rods_stl();
        Extrusion_Drill_Jig_Z_Rods_hardware();
    }
    translate([120, 50, 0]) {
        stl_colour(jigColor)
            Extrusion_Drill_Jig_Corner_Pilot_stl();
        Extrusion_Drill_Jig_Corner_Pilot_hardware();
    }
    translate([260, 50, 0]) {
        stl_colour(jigColor)
            Extrusion_Drill_Jig_Corner_stl();
        Extrusion_Drill_Jig_Corner_hardware();
    }
    translate([120 - 90, 50, 0]) {
        stl_colour(pp2_colour)
            Extrusion_Drill_Jig_Pilot_stl();
        Extrusion_Drill_Jig_Pilot_hardware();
    }
    translate([260 - 90, 50, 0]) {
        stl_colour(pp2_colour)
            Extrusion_Drill_Jig_stl();
        Extrusion_Drill_Jig_hardware();
    }
    translate([-115, 0, 0])
        stl_colour(jigColor)
            Rail_Centering_Jig_MGN12_2040_stl();
    translate([-115, 50, 0])
        stl_colour(jigColor)
            Rail_Centering_Jig_MGN12_2060_stl();
    translate([-40, -60, 0])
        stl_colour(jigColor)
            Panel_Jig_stl();
    //PCB_Hole_Jig_stl();
    //PSU_Hole_Jig_stl();
}

module Rail_Centering_Jigs_assembly()
assembly("Rail_Centering_Jigs") {
    jigColor = "gold";
    eSize = 20;
    eLength = 150;

    rotate([90, 0, 0]) {
        translate([0, 0, 0]) {
            stl_colour(jigColor)
                Rail_Centering_Jig_MGN12_2020_stl();
            translate([0, -eSize, -eLength/2])
                extrusionOZ(eLength);
            translate([eSize/2, 0, 0])
                rotate([0, 90, 90])
                    rail(MGN12, eLength);
        }
        translate([50, 0, 0]) {
            stl_colour(jigColor)
                Rail_Centering_Jig_MGN12_2040_stl();
            translate([0, -eSize, -eLength/2])
                extrusionOZ2040X(eLength);
            translate([eSize/2, 0, 0])
                rotate([0, 90, 90])
                    rail(MGN12, eLength);
        }
        translate([120, 0, 0]) {
            stl_colour(jigColor)
                Rail_Centering_Jig_MGN12_2060_stl();
            translate([0, -eSize, -eLength/2])
                extrusionOZ2060X(eLength);
            translate([3*eSize/2, 0, 0])
                rotate([0, 90, 90])
                    rail(MGN12, eLength);
        }
    }
}

module jigs_assembly() {
    //Rail_Centering_Jigs_assembly();
    Jigs_assembly();
}

if ($preview)
    jigs_assembly();
