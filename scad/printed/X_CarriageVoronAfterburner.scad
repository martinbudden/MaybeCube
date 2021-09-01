include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/utils/tube.scad>
include <NopSCADlib/vitamins/hot_ends.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
use <X_CarriageAssemblies.scad>

use <../vitamins/bolts.scad>


voronAfterburnerHoleSeparationTop = 34;
voronAfterburnerHoleSeparationBottom = 26;

module vaImportStl(file) {
    import(str("../stlimport/voron/X_Carriage/", file, ".stl"));
}

module va_x_carriage_frame_left() {
    // width of frame is 20, width of new X_Carriage should be 20
    translate([-5.5, -42, -35])
        rotate([90, 0, 0])
            boltM3Caphead(20);
    translate([-15.5, -50.5, -7.3])
        rotate([90, 0, 0])
            boltM3Buttonhead(16);
    translate([-16.2, -24, 1])
        rotate([-90, 30, 0])
            boltM3Caphead(20);
    translate([-20, 0, 68.8 - 60])
        rotate([-90, 0, -90])
            translate([-89.3, -79.6, 0])
                color(pp1_colour)
                    vaImportStl("x_carriage_frame_left");
}

module va_x_carriage_frame_right() {
    translate([5.5, -42, -35])
        rotate([90, 0, 0])
            boltM3Caphead(20);
    translate([15.5, -50.5, -7.3])
        rotate([90, 0, 0])
            boltM3Buttonhead(16);
    translate([16.2, -24, 1])
        rotate([-90, 30, 0])
            boltM3Caphead(30);
    translate([20, 0, -60])
        rotate([90, 0, -90])
            translate([-118.85, -84.2, 0])
                color(pp3_colour)
                    vaImportStl("x_carriage_frame_right");
}

module va_extruder_motor_plate() {
    translate([0, -39.9, 29.5])
        rotate([90, 90, 0])
            NEMA(NEMA17P, jst_connector=true);
    translate([22.1, -39.9, -8.9])
        rotate([0, -90, 90])
            translate([-95.1, -82.9, 0])
                color(pp2_colour)
                    vaImportStl("Direct_Feed/extruder_motor_plate");
}

module va_printhead_rear_e3dv6() {
    translate([-20, 0, 68.8 - 60])
        rotate([-90, 0, -90]) {
            translate([62, 17.75, 19.8])
                rotate([90, -90, 0])
                    hot_end(E3Dv6, filament=1.75, naked=true, bowden=false);
            translate([47.5, 13, 0])
                rotate([90, 0, 90])
                    translate([-96, -138, 0])
                        color(pp4_colour)
                            vaImportStl("Printheads/E3D_V6/printhead_rear_e3dv6");
        }
}
