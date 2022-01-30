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

vaHoleSeparationTop = 31;
vaHoleSeparationBottom = 32.5;
vaExtruderMotorPlateHoleSeparation = 32.4;


module vaImportStl(file) {
    import(str("../stlimport/voron/X_Carriage/", file, ".stl"), convexity=10);
}

squash = 0;//11;
offset = [0, 20.85 + squash, 11];
module frame(left=true) {
    size = [20, 26.6, 8];
    sizeB = [9.5, size.y, size.z];
    fillet = 1;
    zOffset = -1.81;
    translate_z(zOffset)
        difference() {
            union() {
                translate_z(-zOffset)
                    if (left)
                        va_x_carriage_frame_left_cut();
                    else
                        mirror([1, 0, 0])
                            va_x_carriage_frame_right_cut();
                size1 = [11.7-1, 17.8, 20.75];
                translate([22.5 - size1.x, 1, -1])
                    difference() {
                        rounded_cube_yz(size1, 0.5);
                        if (!left) {
                            size = [size1.x + 4*eps, 4.3, 10];
                            translate([-eps, 10.75, size1.z-5.25]) {
                                rounded_cube_yz(size, size.y/2-eps);
                                translate([0, 0, 5.25]) {
                                    rotate([90, 180, 90])
                                        fillet(1.5, size.x);
                                    translate([0, size.y, 0])
                                        rotate([0, 90, 0])
                                            fillet(1, size.x);
                                }
                            }
                        }
                    }
                sizeE = [5, 26.60, 8];
                translate([22.5-sizeE.x, 0, 7.12 - sizeE.z])
                    rounded_cube_yz(sizeE, 0.5);

                sizeA = [22.5, 11.75, 17.75];
                translate([0, 0, 19.75 - sizeA.z])
                    rounded_cube_yz(sizeA, fillet);
                sizeA2 = [22.5, 10.4, 39.05];
                translate([0, 0, 19.75 - sizeA2.z])
                    rounded_cube_yz(sizeA2, fillet);
                sizeA3 = [13.15, 5, 62];
                translate([22.5-sizeA3.x, 0, 19.75 - sizeA3.z])
                    rounded_cube_yz(sizeA3, fillet);
                size2 = [11.7, 26.60, 50];
                translate([22.5-size2.x, 0, -49])
                    rounded_cube_yz(size2, fillet);
                size3 = [size2.x, 37.5 - 4.5 - squash, size.z];
                *translate([0, 0, -size2.z + size.z])
                    rounded_cube_yz(size3, fillet);
                size4 = [size2.x, size2.y + 1.75, 4.75];
                translate([22.5 - size4.x, 0, -49])
                    rounded_cube_yz(size4, fillet);
                size5 = [size.x, 8.35, size.z + 4];
                translate([0, 0, -49])
                    rounded_cube_yz(size5, fillet);
            } // end union
            translate([-eps, 0, -49])
                rotate([90,0,90])
                    fillet(1, 22.5 + 2*eps);
            //translate([-size.x + sizeB.x, 0, 0])
            translate([vaExtruderMotorPlateHoleSeparation/2, 0, 12])
                rotate([-90, 90, 0])
                    boltHoleM3Counterbore(19, horizontal=true);
            *translate([vaHoleSeparationTop/2, size.y + 0.25, 4])
                rotate([90, -90, 0])
                    boltHoleM3Tap(10, horizontal=true);
            translate([vaHoleSeparationBottom/2, size.y + 0.25, -49 + 9.75])
                rotate([90, -90, 0])
                    boltHoleM3Tap(10, horizontal=true);
            // bolt holes to connect to the belt side
            translate([0, 0, 5]) {
                translate([xCarriageBoltSeparation.x/2, 0, 0])
                    rotate([-90, 90, 0])
                        boltHoleM3Tap(10, horizontal=true);
                translate([xCarriageBoltSeparation.x/2, 0, -xCarriageBoltSeparation.y])
                    rotate([-90, 90, 0])
                        boltHoleM3Tap(10, horizontal=true);
            }
        }
}

module X_Carriage_VA_Frame_Left_16_stl() {
    stl("X_Carriage_VA_Frame_Left_16")
        color(pp1_colour)
            rotate([0, 90, 0]) // align for printing
                frame(left=true);
}

module frameLeft() {
    rotate([0, -90, 0])
        stl_colour(pp1_colour)
            X_Carriage_VA_Frame_Left_16_stl();
    size = [20, 26.6, 8];
    if ($preview)
        translate_z(-1.81) {
            translate([vaExtruderMotorPlateHoleSeparation/2, 3, 12])
                rotate([90, 0, 0])
                    boltM3Caphead(20);
            translate([vaHoleSeparationTop/2, size.y + 0.25 + 3, 3.7])
                rotate([-90, 0, 0])
                    boltM3Caphead(16);
            // used to attach the hotend cooling fan
            translate([vaHoleSeparationBottom/2, size.y + 0.25 + 35, -39.6])
                rotate([-90, 0, 0])
                    boltM3Caphead(40);
        }
}

module X_Carriage_VA_Frame_Right_16_stl() {
    stl("X_Carriage_VA_Frame_Right_16")
        color(pp2_colour)
            rotate([0, -90, 0]) // align for printing
                mirror([1, 0, 0])
                    frame(left=false);
}


module frameRight() {
    rotate([0, 90, 0])
        stl_colour(pp2_colour)
            X_Carriage_VA_Frame_Right_16_stl();
    size = [20, 26.6, 8];
    if ($preview)
        translate_z(-1.81) {
            translate([-vaExtruderMotorPlateHoleSeparation/2, 3, 12])
                rotate([90, 0, 0])
                    boltM3Caphead(30);
            translate([-vaHoleSeparationTop/2, size.y + 0.25 + 3, 4])
                rotate([-90, 0, 0])
                    boltM3Caphead(16);
            // used to attach the hotend cooling fan
            translate([-vaHoleSeparationBottom/2, size.y + 0.25 + 35, -49 + 9.75])
                rotate([-90, 0, 0])
                    boltM3Caphead(40);
        }
}

module va_x_carriage_frame_left_cut(full=true) {
    intersection() {
        va_x_carriage_frame_left_raw();
        height = 72;
        translate([full ? -2 : 0, 0, 20 - height])
            cube([23, 30, height]);
    }
}

module va_x_carriage_frame_right_cut() {
    intersection() {
        va_x_carriage_frame_right_raw();
        height = 72;
        translate([-21, 0, 20 - height])
            cube([23, 28, height]);
    }
}


module va_x_carriage_frame_left_raw() {
    // width of frame is 20, width of new X_Carriage should be 20
    //let($hide_bolts=true)
    translate([20, -110.15, 97.578])
        rotate([-90, 0, 90])
            color(rr_green)
                vaImportStl("x_carriage_frame_left");
}

module va_x_carriage_frame_left() {
    va_x_carriage_frame_left_raw();
    if ($preview) {
        for (pos = [[14, 8.05, 4.85], [14, 5.55, -44.7]])
            translate(pos)
                rotate([0, 90, 0])
                    boltM3Caphead(30);
        translate_z(-1.81)
            translate([vaExtruderMotorPlateHoleSeparation/2, 3, 12])
                rotate([90, 0, 0])
                    boltM3Caphead(20);
    }
    *translate(offset) {
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
}

module va_x_carriage_frame_right_raw() {
    translate([-20, -139.735, -135])
        rotate([90, 0, 90])
            color(crimson)
                vaImportStl("x_carriage_frame_right");
}

module va_x_carriage_frame_right() {
    va_x_carriage_frame_right_raw();
    if ($preview) {
        for (pos = [[-14, 8.05, 4.85], [-14, 5.55, -44.7]])
            translate(pos)
                rotate([0, 90, 0])
                    nutM3();
        translate_z(-1.81)
            translate([-vaExtruderMotorPlateHoleSeparation/2, 3, 12])
                rotate([90, 0, 0])
                    boltM3Caphead(30);
    }
    *translate(offset) {
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
        *translate([20, 0, -60])
            rotate([90, 0, -90])
                translate([-118.882, -84.2, 0])
                    color(pp3_colour)
                        vaImportStl("x_carriage_frame_right");
    }
}

module va_extruder_motor_plate(motor=true) {
    *translate(offset) {
        //translate([0, -39.9, 29.5])
        translate([0, -39.9, 27.5])
            rotate([-90, 90, 0])
                NEMA(NEMA17P, jst_connector=true);
        *translate([22.1, -39.9, -8.9])
            rotate([0, -90, 90])
                translate([-95.1, -82.9, 0])
                    color(pp3_colour)
                        vaImportStl("Direct_Feed/extruder_motor_plate");
    }
    translate([0, 19, 0.3]) {
        if (motor)
            translate_z(38.5)
                rotate([-90, 90, 0])
                    NEMA(NEMA17P, jst_connector=true);
        translate([-105, 0, -95.1])
            rotate([0, -90, -90])
                color(pp3_colour)
                    vaImportStl("Direct_Feed/extruder_motor_plate");
    }
}

module va_extruder_body() {
    translate([0, 19, 0.3]) {
        translate([-105, 30.4, 155.2])
            rotate([0, 90, -90])
                color(pp1_colour)
                    vaImportStl("Direct_Feed/extruder_body");
    if ($preview)
        for (pos = [[9.3, 27.4, 10.8], [15.5, 27.4, 54],  [-15.5, 27.4, 54]])
            translate(pos)
                rotate([-90, 0, 0])
                    boltM3Caphead(30);
    }
}

module va_bowden_module_front() {
    translate([0, 19, 0.3]) {
        translate([-125, 30.4, 185.2])
            rotate([0, 90, -90])
                color(pp1_colour)
                    vaImportStl("Bowden/bowden_module_front");
    }
}

module va_bowden_module_rear_generic() {
    translate([0, 19, 0.3]) {
         translate([-114, 7.7, 174.2])
            rotate([0, 90, -90])
                color(pp3_colour)
                    vaImportStl("Bowden/bowden_module_rear_generic");
    }
}

module va_blower_housing_rear() {
    translate([0, 19, 0.3]) {
        translate([125, 30.4, 125.5])
            rotate([0,90,90])
                color(pp4_colour)
                    vaImportStl("blower_housing_rear");
        if ($preview) {
            translate([20, 35, 16])
                rotate([90, 0, 180])
                    blower(PE4020);
        }
    }
}

module va_blower_housing_front() {
    translate([0, 19, 0.3]) {
        translate([130, 61.9,-95])
            rotate([0,-90,90])
                color(crimson)
                    vaImportStl("[a]_blower_housing_front");
        if ($preview)
            for (x = [-1, 1])
                translate([22.7 * x, 59, 10.35])
                    rotate([-90, 0, 0])
                        boltM3Caphead(30);
    }
}

module va_hotend_fan_mount() {
    translate([0, 19, 0.3]) {
        translate([95, 61.9,-118])
            rotate([0,-90,90])
                color(pp1_colour)
                    vaImportStl("hotend_fan_mount");
        if ($preview) {
            translate([0, 55.25, -20])
                rotate([90, 0, 0])
                    fan(fan40x11);
            for (x = [-1, 1])
                translate([23.15 * x, 58.9, -48.8])
                    rotate([-90, 0, 0])
                        boltM3Caphead(12);
        }
    }
}
module va_printhead_rear_e3dv6() {
    *translate(offset) {
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
    translate([0, 26.625, -0.25]) {
        translate([0, 14.6, 0])
            hot_end(E3Dv6, filament=1.75, naked=true, bowden=false);
        translate([157.8, 0, 100.8])
            rotate([0, 90, 90])
                color(pp4_colour)
                    vaImportStl("Printheads/E3D_V6/printhead_rear_e3dv6");
    }
}

module va_printhead_front_e3dv6() {
    translate([0, 26.625, -0.25]) {
        //translate([157.8, 0, 100.8])
        translate([60, 41.9, -88.3])
            rotate([0, -90, 90])
                color(pp2_colour)
                    vaImportStl("Printheads/E3D_V6/printhead_front_e3dv6");
    }
}
