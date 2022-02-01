include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/vitamins/hot_ends.scad>
include <NopSCADlib/vitamins/inserts.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

include <../utils/X_Carriage.scad>
include <../vitamins/bolts.scad>
//include <../vitamins/inserts.scad>
include <../vitamins/nuts.scad>

xCarriageType = MGN12H_carriage;

module X_Carriage_Voron_Mini_Afterburner_stl() {
    stl("X_Carriage_Voron_Mini_Afterburner")
        color(pp3_colour)
            xCarriageVoronMiniAfterburner();
}

module xCarriageVoronMiniAfterburner() {
    size = [xCarriageSize.x, xCarriageSize.z + 5.35, xCarriageSize.y];
    size2 = [35, 20, size.z + 4.25];
    translate([-size.x/2, 0, 0])
        difference() {
            union() {
                rounded_cube_xy(size, 1);
                translate([size.x/2-size2.x/2, size.y - size2.y, 0])
                    rounded_cube_xy(size2, 1);
            }
            for (x = [0, xCarriageBoltSeparation.x], y = [0])
                translate([x + (size.x - xCarriageBoltSeparation.x)/2, y + 4, 0])
                    boltHoleM3Tap(xCarriageSize.y);
            for (x = [0, xCarriageBoltSeparation.x], y = [xCarriageBoltSeparation.y])
                translate([x + (size.x - xCarriageBoltSeparation.x)/2, y + 4, 0])
                    boltHoleM3Tap(xCarriageSize.y - 1);
            r = 18.58;
            translate([size.x/2, 76.57, -eps])
                cylinder(r=r, h=size2.z + 2*eps);

            translate([6.27 + size.x/2, 51.33, size2.z]) {
                *translate_z(size2.z - 5)
                    boltHole(2*insert_hole_radius(F1BM3), 5);
                vflip()
                    boltHoleM3Tap(size2.z - 1);
            }
            for (x = [-13, 13])
                translate([x + size.x/2, 48.05, size2.z]) {
                    *translate_z(-5)
                        boltHole(2*insert_hole_radius(F1BM3), 5);
                    vflip()
                        boltHoleM3Tap(size2.z - 1);
                }
            for (x = [-11.65, 11.65])
                translate([x + size.x/2, 57.95, size2.z])
                    vflip()
                        boltHoleM2Tap(8);
        }
}

module vmaImportStl(file) {
    import(str("../stlimport/voron-0/", file, ".stl"), convexity=10);
}

module vma_x_carriage_90_x1() {
    translate([-109 + 13/2, 0, 43.7])
        rotate([0, 90, -90])
            color(pp3_colour)
                vmaImportStl("X_Carriage_90_x1");
}

module vma_motor_frame_x1() {
    translate([5.75, 35, 8.5])
        rotate([0, 90, 90])
            color(pp2_colour)
                vmaImportStl("Toolheads/Mini_Afterburner/Motor_Frame_x1");
}

module vma_mid_body_x1() {
    translate([-198.8,16.75,232.8])
        rotate([0,90,-90])
            color(pp4_colour)
                vmaImportStl("Toolheads/Mini_Afterburner/[a]_Mid_Body_x1");
}

module vma_cowling_mosquito_x1() {
    translate([60, 32.2, 51])
        rotate([-90, 0, 180]) {
            color(pp1_colour)
                vmaImportStl("Toolheads/Mini_Afterburner/Mosquito_Toolhead_DD/[a]_Cowling_Mosquito_x1");
            if ($preview) {
                translate([45, 94, 31])
                    rotate([180, 90, 0])
                        blower(BL30x10);
                translate([76, 94, 2])
                    rotate([180, -90, 0])
                        blower(BL30x10);
                translate([60, 73, 8])
                    fan(fan30x10);
            }
        }
}
