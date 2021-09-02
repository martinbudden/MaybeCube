include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/hot_ends.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../../../BabyCube/scad/printed/X_Carriage.scad>

use <X_CarriageAssemblies.scad>

use <../vitamins/bolts.scad>

xCarriageType = MGN12H_carriage;

vaHoleSeparationTop = 31.5;
vaHoleSeparationBottom = 33;
vaExtruderMotorPlateHoleSeparation = 32.4;


module vaImportStl(file) {
    import(str("../stlimport/voron/X_Carriage/", file, ".stl"));
}

squash = 0;//11;
offset = [0, 10 + squash, 11];
module va_x_carriage_frame_left() {
    // width of frame is 20, width of new X_Carriage should be 20
    //let($hide_bolts=true)
    translate(offset) {
        if (squash == 0)
            translate([-5.5, -42, -35])
                rotate([90, 0, 0])
                    boltM3Caphead(20);
        translate([-vaHoleSeparationTop/2, -50.5, -7.3])
            rotate([90, 0, 0])
                boltM3Buttonhead(16);
        translate([-vaExtruderMotorPlateHoleSeparation/2, -24, 1])
            rotate([-90, 30, 0])
                boltM3Caphead(20);
        translate([-20, 0, 68.8 - 60])
            rotate([-90, 0, -90])
                translate([-89.3, -79.6, 0])
                    color(pp1_colour)
                        vaImportStl("x_carriage_frame_left");
    }
    frameLeft();
}

module frameLeft() {
    size = [20, 37.5 - squash, 8];
    fillet = 1;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    translate([-size.x, -size.y, 0])
        difference() {
            union() {
                sizeB = [9.5, size.y, size.z];
                rounded_cube_yz(sizeB, fillet);
                translate([0, 7.75, 0])
                    difference() {
                        sizeA = [size.x - 2, min(19, 29.5 - squash), 17.75];
                        translate_z(2)
                            rounded_cube_yz(sizeA, fillet);
                        #translate([size.x - vaExtruderMotorPlateHoleSeparation/2, sizeA.y, 12])
                            rotate([90, 90, 0])
                                boltHoleM3Counterbore(sizeA.y, horizontal=true);
                    }
                size2 = [9.5, 23 -  squash, 49 + size.z];
                translate([0, 0, -size2.z + size.z])
                    rounded_cube_yz(size2, fillet);
                size3 = [size2.x, 37.5-4.5 - squash, size.z];
                translate([0, 0, -size2.z + size.z])
                    rounded_cube_yz(size3, fillet);
                size4 = [size2.x, size3.y + 1.5, 4.5];
                translate([0, -1.5, -size2.z + size.z])
                    rounded_cube_yz(size4, fillet);
                size5 = [size.x, 14.5, size.z];
                translate([0, size.y-4.5-size5.y, -size2.z + size.z])
                    rounded_cube_yz(size5, fillet);
            }
            translate([size.x - vaHoleSeparationTop/2, 0, 4])
                rotate([-90, -90, 0])
                    boltHoleM3Tap(10, horizontal=true);
            translate([size.x - vaHoleSeparationBottom/2, 0, -49+9.75])
                rotate([-90, -90, 0])
                    boltHoleM3Tap(10, horizontal=true);
            translate([size.x - holeSeparationTop/2, size.y, 3])
                rotate([90, 90, 0])
                    boltHoleM3Tap(10, horizontal=true);
            translate([size.x - holeSeparationBottom/2, size.y, -49 + size.z/2])
                rotate([90, 90, 0])
                    boltHoleM3Tap(10, horizontal=true);
        }
}
module va_x_carriage_frame_right() {
    translate(offset) {
        if (squash == 0)
            translate([5.5, -42, -35])
                rotate([90, 0, 0])
                    boltM3Caphead(20);
        translate([vaHoleSeparationTop/2, -50.5, -7.3])
            rotate([90, 0, 0])
                boltM3Buttonhead(16);
        translate([vaExtruderMotorPlateHoleSeparation/2, -24, 1])
            rotate([-90, 30, 0])
                boltM3Caphead(30);
        translate([20, 0, -60])
            rotate([90, 0, -90])
                translate([-118.85, -84.2, 0])
                    color(pp3_colour)
                        vaImportStl("x_carriage_frame_right");
    }
}

module va_extruder_motor_plate() {
    translate(offset) {
        translate([0, -39.9, 29.5])
            rotate([90, 90, 0])
                NEMA(NEMA17P, jst_connector=true);
        translate([22.1, -39.9, -8.9])
            rotate([0, -90, 90])
                translate([-95.1, -82.9, 0])
                    color(pp2_colour)
                        vaImportStl("Direct_Feed/extruder_motor_plate");
    }
}

module va_printhead_rear_e3dv6() {
    translate(offset) {
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
}
