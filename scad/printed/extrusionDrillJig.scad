include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>

include <NopSCADlib/vitamins/extrusions.scad>

use <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>


function extrusionDrillJigHoles(length) =
    let(eSize = 20)
        length == 50 ? [eSize/2, 3*eSize/2] :
        length == 90 ? [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2] :
        [40, 100];



module extrusionDrillJig(length, holeSize) {
    eSize = 20;
    sideThickness = 5;
    baseThickness = 15;
    fillet = 1;
    size = [length, eSize + sideThickness, eSize + baseThickness];
    centerWidth = 5;
    centerHeight = 5;
    holes = extrusionDrillJigHoles(length);

    difference() {
        union() {
            rounded_cube_xy([size.x, size.y, baseThickness], fillet);
            translate([0, sideThickness + eSize/2 - centerWidth/2, 0])
                rounded_cube_xy([size.x, centerWidth, baseThickness + centerHeight], fillet);
            rounded_cube_xy([sideThickness, size.y, size.z], fillet);
            rounded_cube_xy([size.x, sideThickness, size.z], fillet);
            tNutWidth = 10.25;
            cubeHeight = 1.5;
            triangleHeight = 4;
            translate([size.x - fillet, sideThickness, baseThickness + (eSize + triangleHeight - cubeHeight)/2])
                rotate([-90, 0, 90]) {
                    length = size.x - holes[len(holes) - 1] - fillet - sideThickness - tNutWidth/2;
                    right_triangle(triangleHeight, triangleHeight, length, center=false);
                    translate([0, -cubeHeight, 0])
                        cube([triangleHeight, cubeHeight, length]);
                    if (size.x != 120)
                    for (i = [1 : len(holes) - 1]) {
                        length = holes[i] -holes[i - 1] - tNutWidth;
                        translate([0, 0, size.x - fillet - sideThickness - i*eSize - length/2]) {
                            right_triangle(triangleHeight, triangleHeight, length, center=false);
                            translate([0, -cubeHeight, 0])
                                cube([triangleHeight, cubeHeight, length]);
                        }
                    }
                }
        }
        translate([sideThickness, sideThickness, 0])
            boltHoleM4(size.z);
        for (x = holes) {
            translate([sideThickness + x, sideThickness + eSize/2, 0])
                if (holeSize==2)
                    boltHoleM2(baseThickness + centerHeight, twist=3);
                else
                    translate_z(-eps)
                        poly_cylinder(r=holeSize/2, h=baseThickness + centerHeight + 2*eps);
            translate([sideThickness + x, 0, baseThickness + eSize/2])
                rotate([-90, 180, 0])
                    boltHoleM4(sideThickness, horizontal=true);
        }
    }
}

module extrusionDrillJig_hardware(length) {
    eSize = 20;
    sideThickness = 5;
    baseThickness = 15;
    holes = extrusionDrillJigHoles(length);

    for (x = holes)
        translate([sideThickness + x, 0, baseThickness + eSize/2])
            rotate([90, 180, 0])
                boltM4ButtonheadHammerNut(10);
}

module Extrusion_Drill_Jig_50_2_stl() {
    stl("Extrusion_Drill_Jig_50_2")
        extrusionDrillJig(50, 2);
    extrusionDrillJig_hardware(50);
}

module Extrusion_Drill_Jig_50_5_stl() {
    stl("Extrusion_Drill_Jig_50_5")
        extrusionDrillJig(50, 5);
    extrusionDrillJig_hardware(50);
}

module Extrusion_Drill_Jig_90_2_stl() {
    stl("Extrusion_Drill_Jig_90_2")
        extrusionDrillJig(90, 2);
    extrusionDrillJig_hardware(90);
}

module Extrusion_Drill_Jig_90_4_stl() {
    stl("Extrusion_Drill_Jig_90_4")
        extrusionDrillJig(90, 4);
    extrusionDrillJig_hardware(90);
}

module Extrusion_Drill_Jig_120_2_stl() {
    stl("Extrusion_Drill_Jig_120_2")
        extrusionDrillJig(120, 2);
    extrusionDrillJig_hardware(120);
}

module Extrusion_Drill_Jig_120_7_stl() {
    stl("Extrusion_Drill_Jig_120_7")
        extrusionDrillJig(120, 7);
    extrusionDrillJig_hardware(120);
}


module railCenteringJig() {
    rail_type = MGN12;
    eSize = 20;
    size = [2*eSize + 20, eSize + 15, 10];

    translate([0, -eSize, 0])
    linear_extrude(size.z)
        offset(1.5) offset(-1.5) difference() {
            translate([-(size.x-2*eSize)/2, 0])
                square([size.x, size.y]);
            translate([(-rail_width(rail_type) + eSize)/2, eSize])
                square([rail_width(rail_type), rail_height(rail_type)], center=false);
            square([2*eSize, eSize], center=false);
        }
}
