include <NopSCADlib/utils/core/core.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>


eSize = 20;
jigColor = rr_green;

function extrusionDrillJigHoles(length) =
    let(eSize = 20)
        length == 50 ? [eSize/2, 3*eSize/2] :
        length == 90 ? [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2] :
        [40, 100];


module extrusionDrillJig(length, holeSize, holes, fixingHoles, endStop=true) {
    eSize = 20;
    sideThickness = 5;
    baseThickness = 15;
    fillet = 1;
    size = [length, eSize + sideThickness, eSize + baseThickness];
    centerWidth = 5;
    centerHeight = 5;
    holes2 = is_undef(fixingHoles) ? holes : fixingHoles;

    rotate(180)
        difference() {
            union() {
                rounded_cube_xy([size.x, size.y, baseThickness], fillet);
                translate([0, sideThickness + eSize/2 - centerWidth/2, 0])
                    rounded_cube_xy([size.x, centerWidth, baseThickness + centerHeight], fillet);
                if (endStop)
                    rounded_cube_xy([sideThickness, size.y, size.z], fillet);
                rounded_cube_xy([size.x, sideThickness, size.z], fillet);
                tNutWidth = 10.25;
                cubeHeight = 1.5;
                triangleHeight = 4;
                *if (size.x != 120 && endStop == true)
                    translate([size.x - fillet, sideThickness, baseThickness + (eSize + triangleHeight - cubeHeight)/2])
                        rotate([-90, 0, 90]) {
                            length = size.x - holes[len(holes) - 1] - fillet - sideThickness - tNutWidth/2;
                            right_triangle(triangleHeight, triangleHeight, length, center=false);
                            translate([0, -cubeHeight, 0])
                                cube([triangleHeight, cubeHeight, length]);
                            for (i = [1 : len(holes2) - 1]) {
                                length = holes2[i] -holes2[i - 1] - tNutWidth;
                                translate([0, 0, size.x - fillet - sideThickness - i*eSize - length/2]) {
                                    right_triangle(triangleHeight, triangleHeight, length, center=false);
                                    translate([0, -cubeHeight, 0])
                                        cube([triangleHeight, cubeHeight, length]);
                                }
                            }
                        }
            }
            if (endStop)
                translate([sideThickness, sideThickness, 0])
                    boltHoleM4(size.z);
            for (x = holes)
                translate([sideThickness + x, sideThickness + eSize/2, 0])
                    if (holeSize==2)
                        boltHoleM2(baseThickness + centerHeight, twist=3);
                    else
                        translate_z(-eps)
                            poly_cylinder(r=holeSize/2, h=baseThickness + centerHeight + 2*eps);
            for (x = holes2)
                translate([sideThickness + x, 0, baseThickness + eSize/2])
                    rotate([-90, 180, 0])
                        boltHoleM4(sideThickness, horizontal=true);
        }
}

module extrusionDrillJig_hardware(length, holes) {
    eSize = 20;
    sideThickness = 5;
    baseThickness = 15;

    if ($preview)
        rotate(180)
            for (x = holes)
                translate([sideThickness + x, 0, baseThickness + eSize/2])
                    rotate([90, 180, 0])
                        boltM4ButtonheadHammerNut(10);
}

module Extrusion_Drill_Jig_Pilot_stl() {
    holes = [5, 25];
    stl("Extrusion_Drill_Jig_Pilot")
        color(jigColor)
            extrusionDrillJig(40, 2, holes, endStop=false);
}

module Extrusion_Drill_Jig_Pilot_hardware() {
    holes = [5, 25];
    extrusionDrillJig_hardware(50, holes);
}

module Extrusion_Drill_Jig_stl() {
    holes = [5, 25];
    stl("Extrusion_Drill_Jig")
        color(jigColor)
            extrusionDrillJig(40, 4, holes, endStop=false);
}

module Extrusion_Drill_Jig_hardware() {
    holes = [5, 25];
    extrusionDrillJig_hardware(50, holes);
}

module Extrusion_Drill_Jig_50_2_stl() {
    holes = extrusionDrillJigHoles(50);

    stl("Extrusion_Drill_Jig_50_2")
        color(jigColor)
            extrusionDrillJig(50, 2, holes);
    extrusionDrillJig_hardware(50, holes);
}

module Extrusion_Drill_Jig_50_5_stl() {
    holes = extrusionDrillJigHoles(50);

    stl("Extrusion_Drill_Jig_50_5")
        color(jigColor)
            extrusionDrillJig(50, 5, holes);
    extrusionDrillJig_hardware(50, holes);
}

module Extrusion_Drill_Jig_90_2_stl() {
    holes = extrusionDrillJigHoles(90);

    stl("Extrusion_Drill_Jig_90_2")
        color(jigColor)
            extrusionDrillJig(90, 2, holes);
    extrusionDrillJig_hardware(90, holes);
}

module Extrusion_Drill_Jig_90_4_stl() {
    holes = extrusionDrillJigHoles(90);

    stl("Extrusion_Drill_Jig_90_4")
        color(jigColor)
            extrusionDrillJig(90, 4, holes);
    extrusionDrillJig_hardware(90, holes);
}

module Extrusion_Drill_Jig_Z_Rods_Pilot_stl() {
    holes = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, 85, 105];
    fixingHoles = [eSize/2, 3*eSize/2, 85, 105];

    stl("Extrusion_Drill_Jig_Z_Rods_Pilot")
        color(jigColor)
            extrusionDrillJig(120, 2, holes, fixingHoles);
}

module Extrusion_Drill_Jig_Z_Rods_Pilot_hardware() {
    fixingHoles = [eSize/2, 3*eSize/2, 85, 105];
    extrusionDrillJig_hardware(120, fixingHoles);
}

module Extrusion_Drill_Jig_Z_Rods_stl() {
    holes = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, 85, 105];
    fixingHoles = [eSize/2, 3*eSize/2, 85, 105];
    stl("Extrusion_Drill_Jig_Z_Rods")
        color(jigColor)
            extrusionDrillJig(120, 4, holes, fixingHoles);
}

module Extrusion_Drill_Jig_Z_Rods_hardware() {
    fixingHoles = [eSize/2, 3*eSize/2, 85, 105];
    extrusionDrillJig_hardware(120, fixingHoles);
}

module Extrusion_Drill_Jig_Corner_Pilot_stl() {
    holes = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2];
    fixingHoles = [eSize/2, 7*eSize/2];
    stl("Extrusion_Drill_Jig_Corner_Pilot")
        color(jigColor)
            extrusionDrillJig(85, 2, holes, fixingHoles);
}

module Extrusion_Drill_Jig_Corner_Pilot_hardware() {
    fixingHoles = [eSize/2, 7*eSize/2];
    extrusionDrillJig_hardware(85, fixingHoles);
}

module Extrusion_Drill_Jig_Corner_stl() {
    holes = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2];
    fixingHoles = [eSize/2, 7*eSize/2];
    stl("Extrusion_Drill_Jig_Corner")
        color(jigColor)
            extrusionDrillJig(85, 4, holes, fixingHoles);
}

module Extrusion_Drill_Jig_Corner_hardware() {
    fixingHoles = [eSize/2, 7*eSize/2];
    extrusionDrillJig_hardware(85, fixingHoles);
}

module Extrusion_Drill_Jig_E20_to_E40_120_2_stl() {
    holes = extrusionDrillJigHoles(120);
    stl("Extrusion_Drill_Jig_120_2")
        color(jigColor)
            extrusionDrillJig(120, 2, holes);
    extrusionDrillJig_hardware(120, holes);
}

module Extrusion_Drill_Jig_E20_to_E40_120_7_stl() {
    holes = extrusionDrillJigHoles(120);
    stl("Extrusion_Drill_Jig_120_7")
        color(jigColor)
            extrusionDrillJig(120, 7, holes);
    extrusionDrillJig_hardware(120, holes);
}

if ($preview)
    Extrusion_Drill_Jig_stl();
