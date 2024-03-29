include <../vitamins/bolts.scad>
include <NopSCADlib/vitamins/bearing_blocks.scad>

include <../printed/Z_Carriage.scad>
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
                *if (size.x != 120 && endStop == true) {
                    tNutWidth = 10.25;
                    cubeHeight = 1.5;
                    triangleHeight = 4;
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
            }
            if (endStop)
                translate([sideThickness, sideThickness, 0])
                    boltHoleM4(size.z);
            for (x = holes)
                translate([sideThickness + x, sideThickness + eSize/2, 0])
                    if (holeSize==2)
                        boltHole(2, baseThickness + centerHeight, twist=4);
                    else if (holeSize==3)
                        boltHole(3, baseThickness + centerHeight, twist=4);
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
            extrusionDrillJig(40, 3, holes, endStop=false);
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
            extrusionDrillJig(120, 3, holes, fixingHoles);
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
            extrusionDrillJig(85, 3, holes, fixingHoles);
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

module Extrusion_Drill_Jig_Printbed_stl() {
    scsType = SCS12LUU;
    scsSize = scs_size(scsType);
    //holes = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, 85, 105];
    holes = [scsSize.x/2 - scs_screw_separation_x(scsType)/2, scsSize.x/2 + scs_screw_separation_x(scsType)/2,
        scsSize.x/2 + printbedFrameCrossPieceOffset() + eSize/2, scsSize.x/2 + printbedFrameCrossPieceOffset() + 3*eSize/2];
    fixingHoles = [eSize/2, 90 - eSize];
    stl("Extrusion_Drill_Jig_Printbed")
        color(jigColor)
        translate([scsSize.x/2 + 5, 0, 0])
            extrusionDrillJig(90, 4, holes, fixingHoles);
}

module Extrusion_Drill_Jig_Printbed_hardware() {
    fixingHoles = [eSize/2, 90 - eSize];
    translate([scs_size(SCS12LUU).x/2 + 5, 0, 0])
        extrusionDrillJig_hardware(120, fixingHoles);
}

module E2040_End_Connector_stl() {
    stl("E2040_End_Connector")
        difference() {
            size = [50, 30, 5];
            fillet = 2;
            union() {
                rounded_cube_xy(size, fillet);
                rounded_cube_xy([size.x, 5, size.z + 5], fillet);
                rounded_cube_xy([5, size.y, size.z + 5], fillet);
            }
            for (x = [15, size.x -  15])
                translate([x, size.y/2, 0])
                    boltHole(5, size.z, twist=4);
        }
}

module Right_Size_Spacer_70_stl() {
    stl("Right_Size_Spacer_70")
        difference() {
            size = [70, 20, 4];
            rounded_cube_xy(size, 2);
            for (x = [10, size.x -  10])
                translate([x, size.y/2, 0])
                    boltHole(4, size.z, twist=4);
        }
}
if ($preview)
    Extrusion_Drill_Jig_stl();
