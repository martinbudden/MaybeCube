include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/vitamins/hot_ends.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

include <../utils/X_Carriage.scad>
include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

xCarriageType = MGN12H_carriage;

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
        rotate([-90, 0, 180])
            color(pp1_colour)
                vmaImportStl("Toolheads/Mini_Afterburner/Mosquito_Toolhead_DD/[a]_Cowling_Mosquito_x1");
}
