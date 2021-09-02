include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/vitamins/ball_bearing.scad>
use <NopSCADlib/vitamins/o_ring.scad>
use <NopSCADlib/vitamins/rod.scad>
use <NopSCADlib/utils/tube.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/e3d.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>
include <NopSCADlib/vitamins/washers.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
use <X_CarriageAssemblies.scad>

use <../vitamins/bolts.scad>
use <../vitamins/inserts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

toolChangerAxelOffsetZ = 15.6 + 5.55/2 + 1.15;

module toolChangerImportStl(file) {
    import(str("../stlimport/jubilee/toolchanger/toolchange_carriage/", file, ".stl"));
}

module toolChangerPenImportStl(file) {
    import(str("../stlimport/jubilee/toolchanger/pen/", file, ".stl"));
}

module toolChangerBondtechImportStl(file) {
    import(str("../stlimport/jubilee/toolchanger/bondtech/", file, ".stl"));
}

module toolChangerToolPostImportStl(file) {
    import(str("../stlimport/jubilee/toolchanger/tool_posts/", file, ".stl"));
}

module toolChangerLockingMechanismImportStl(file) {
    import(str("../stlimport/jubilee/toolchanger/toolchanger_locking_mechanism/", file, ".stl"));
}

module lock_actuator_base_plate_stl() {
    stl("lock_actuator_base_plate")
        color(pp2_colour)
            translate([-150, 0, 163.5])
                rotate([-90, 0, 0])
                    toolChangerLockingMechanismImportStl("lock_actuator_base_plate");
}

//                                   corner  body    boss    boss          shaft
//                     side, length, radius, radius, radius, depth, shaft, length,      holes, cap heights
NEMA11  = ["NEMA11",   27.94,32,     46.4/2, 21,     13.97,    32-eps,     6,     36+20,          26,    [8,     8], 3,    false, false, 0,       0];

module lock_actuator_base_plate_hardware() {
    translate([54, 0, 27])
        rotate([-90, 90, 0])
            NEMA(NEMA11);
    for (y = [7.95, 46.9])
        translate([10.1, y, 0])
            vflip()
                boltM4ButtonheadHammerNut(14);
}

module fixed_half_pulley_stl() {
    stl("fixed_half_pulley")
        color(pp1_colour)
            translate([-150, -126, 0])
                toolChangerLockingMechanismImportStl("fixed_half_pulley");
}

module floating_half_pulley_stl() {
    stl("floating_half_pulley")
        color(pp3_colour)
            translate([-150, -174, 0])
                toolChangerLockingMechanismImportStl("floating_half_pulley");
}

module knob_stl() {
    stl("knob")
        toolChangerLockingMechanismImportStl("knob");
}

module lock_actuator_motor_clip_stl() {
    stl("lock_actuator_motor_clip")
        color(pp1_colour)
            translate([-150, -159, 0])
                toolChangerLockingMechanismImportStl("lock_actuator_motor_clip");
}

module spring_guide_anchor_block_stl() {
    stl("spring_guide_anchor_block")
        color(pp1_colour)
            translate([-150, -150+34, 0])
                toolChangerLockingMechanismImportStl("spring_guide_anchor_block");
}

module spring_guide_anchor_block_hardware() {
    translate([4.5, 3.75, 3]) {
        boltM3Buttonhead(8);
        translate([-9, 26.5, 0])
            boltM3Buttonhead(8);
    }
}

module lock_actuator_assembly()
assembly("lock_actuator") {
    translate([55, eSize, 9]) {
        rotate([180, 0, -90]) {
            stl_colour(pp2_colour)
                lock_actuator_base_plate_stl();
            lock_actuator_base_plate_hardware();
        }
        translate([0, -23, -27])
            rotate([90, 0, -90])
                stl_colour(pp1_colour)
                    lock_actuator_motor_clip_stl();
    }
    translate([0, -34, -18]) {
        rotate([0, 90, 0])
            stl_colour(pp3_colour)
                fixed_half_pulley_stl();
        translate([7.5, 0, 0])
            rotate([0, 90, 0])
                stl_colour(pp1_colour)
                    floating_half_pulley_stl();
    }
    translate([10.85, -51, 9]) {
        stl_colour(pp1_colour)
            spring_guide_anchor_block_stl();
        spring_guide_anchor_block_hardware();
    }
}

module parking_post_base_47mm_stl() {
    stl("parking_post_base_47mm")
        translate([-150, -130, 0])
            color(pp2_colour)
                toolChangerToolPostImportStl("parking_post_base_47mm");
}

module tool_holder_47mm_stl() {
    stl("tool_holder_47mm")
        translate([-150, -139, 0])
            color(pp1_colour)
                toolChangerToolPostImportStl("tool_holder_47mm");
}

module tool_holder_47mm_hardware() {
    for (x= [-47/2, 47/2])
        translate([x, 4.75, 0])
            rod(5, 60, center=false);
}

module parking_post_47mm_assembly()
assembly("parking_post_47mm") {
    rotate(180) {
        stl_colour(pp2_colour)
            parking_post_base_47mm_stl();
        translate_z(47.85 - toolChangerAxelOffsetZ)
            rotate([-90, 0, 0]) {
                stl_colour(pp1_colour)
                    tool_holder_47mm_stl();
                tool_holder_47mm_hardware();
            }
    }
}

module parking_post_base_55mm_stl() {
    stl("parking_post_base_55mm")
        translate([-150, -130, 0])
            color(pp2_colour)
                toolChangerToolPostImportStl("parking_post_base_55mm");
}

module tool_holder_55mm_stl() {
    stl("tool_holder_55mm")
        translate([-150, -139, 0])
            color(pp1_colour)
                toolChangerToolPostImportStl("tool_holder_55mm");
}

module tool_holder_55mm_hardware() {
    for (x= [-55/2, 55/2])
        translate([x, 4.75, 0])
            rod(5, 60, center=false);
}

module parking_post_55mm_assembly()
assembly("parking_post_55mm") {
    rotate(180) {
        stl_colour(pp2_colour)
            parking_post_base_55mm_stl();
        translate_z(47.85 - toolChangerAxelOffsetZ)
            rotate([-90, 0, 0]) {
                stl_colour(pp1_colour)
                    tool_holder_55mm_stl();
                tool_holder_55mm_hardware();
            }
    }
}


toolDockSizeZ = 14;
toolDockBoltSeparation = 30;

module toolDock(separation) {
    size = [separation + 8, eSize, toolDockSizeZ];
    fillet = 3;

    difference() {
        translate([-size.x/2, 0, 0])
            rounded_cube_xy(size, fillet);
        for (x = [-separation/2, separation/2])
            translate([x, 4.75, 0])
                boltHole(5, size.z+10);
        for (x = [-toolDockBoltSeparation/2, toolDockBoltSeparation/2])
            translate([x, eSize/2, 0])
                boltHoleM4(size.z);
    }
}

module toolDockHardware(separation) {
    for (x = [-separation/2, separation/2])
        translate([x, 4.75, 0])
            rod(5, 60, center=false);
    for (x = [-toolDockBoltSeparation/2, toolDockBoltSeparation/2])
        translate([x, eSize/2, toolDockSizeZ])
            boltM4ButtonheadHammerNut(20);
}

module tool_dock_47mm_stl() {
    stl("tool_dock_47mm")
        color(pp1_colour)
            toolDock(47);
}

module tool_dock_47mm_assembly()
assembly("tool_dock_47mm") {
    translate_z(47.85 - toolChangerAxelOffsetZ)
        rotate([-90, 0, 180]) {
            stl_colour(pp1_colour)
                tool_dock_47mm_stl();
            toolDockHardware(47);
        }
}

module tool_dock_55mm_stl() {
    stl("tool_dock_55mm")
        color(pp1_colour)
            toolDock(55);
}

module tool_dock_55mm_assembly()
assembly("tool_dock_55mm") {
    translate_z(47.85 - toolChangerAxelOffsetZ)
        rotate([-90, 0, 180]) {
            stl_colour(pp1_colour)
                tool_dock_55mm_stl();
            toolDockHardware(55);
        }
}

module wedge_plate_stl() {
    stl("wedge_plate")
        translate([-14.4, -16, 0])
            color(pp2_colour)
                import(str("../stlimport/jubilee/toolchanger/wedge_plate", ".stl"));
}

module wedge_plate_hardware() {
    for (a = [0, 120, 240])
        rotate(a + 60)
            translate([0, 12, 0])
                vflip()
                    boltM3Countersunk(8);
}

module pen_tool_base_tool_plate_stl() {
    stl("pen_tool_base_tool_plate")
        stl_colour(pp1_colour)
            translate([-32.08, -21.84, 0])
               toolChangerPenImportStl("pen_tool_base_tool_plate");
}

module pen_tool_base_tool_plate_hardware() {
    for (a = [0, 120, 240])
        rotate(a) {
            translate([0, 30, 0]) {
                bearing_ball(8);
                translate_z(7)
                    boltM3Countersunk(6);
            }
            translate([0, -12, 8])
                _threadedInsertM3();
        }
}

module pen_holder_stl() {
    stl("pen_holder")
        color(pp2_colour)
            translate([-8.5, 0, 0])
                rotate([90, 0, 90])
                    toolChangerPenImportStl("pen_holder");
}

module pen_left_parking_wing_stl() {
    stl("pen_left_parking_wing")
        color(pp2_colour)
            translate([-26.5, 0, 0])
               toolChangerPenImportStl("left_parking_wing");
}

module pen_left_parking_wing_hardware() {
    for (y = [0, 13.5])
        translate([-21, y + 19, 4])
            rotate([0, -90, 0])
                boltM3Countersunk(8);
}

module pen_right_parking_wing_stl() {
    stl("pen_right_parking_wing")
        color(pp2_colour)
            translate([0, 0, 0])
               toolChangerPenImportStl("right_parking_wing");
}

module pen_right_parking_wing_hardware() {
    for (y = [0, 13.5])
        translate([21, y + 19, 4])
            rotate([0, 90, 0])
                boltM3Countersunk(8);
}

module pen_assembly()
assembly("pen") {
    translate([0, 22, -toolChangerAxelOffsetZ])
        rotate([90, 0, 180]) {
            pen_tool_base_tool_plate_stl();
            pen_tool_base_tool_plate_hardware();
            stl_colour(pp2_colour)
                wedge_plate_stl();
            wedge_plate_hardware();
            stl_colour(pp2_colour)
                pen_left_parking_wing_stl();
            pen_left_parking_wing_hardware();
            stl_colour(pp2_colour)
                pen_right_parking_wing_stl();
            pen_right_parking_wing_hardware();
            translate([0, -2.5, 8])
                stl_colour(pp2_colour)
                    pen_holder_stl();
        }
}

module bondtech_tool_plate_stl() {
    stl("bondtech_tool_plate")
        color(pp1_colour)
            translate([150, 190.5, 0])
                rotate(180)
                    toolChangerBondtechImportStl("tool_plate");
}

module bondtech_tool_plate_hardware() {
    for (a = [0, 120, 240])
        rotate(a) {
            translate([0, 30, 8]) {
                bearing_ball(8);
                translate_z(-7)
                    vflip()
                        boltM3Countersunk(6);
            }
            translate([0, 12, 0])
                vflip()
                    _threadedInsertM3();
        }
}

module bondtech_left_parking_wing_stl() {
    stl("bondtech_left_parking_wing")
        color(pp2_colour)
            translate([0, 15, 0])
                toolChangerBondtechImportStl("left_parking_wing");
}

module bondtech_left_parking_wing_hardware() {
    for (y = [0, 13.5, 33.5, 47])
        translate([4, y + 19, 2.8])
            boltM3Countersunk(6);
    for(x = [0, 18])
        translate([x + 13.4, 28.2, 5.75])
            color("FireBrick")
                O_ring(5, 2);
}

module bondtech_right_parking_wing_stl() {
    stl("bondtech_right_parking_wing")
        color(pp2_colour)
            translate([127.5, 192.5, 0])
                rotate(180)
                    toolChangerBondtechImportStl("right_parking_wing");
}

module bondtech_right_parking_wing_hardware() {
    for (y = [0, 13.5, 33.5, 47])
        translate([-4, y + 19, 2.8])
            boltM3Countersunk(6);
    for(x = [0, -18])
        translate([x - 13.4, 28.2, 5.75])
            color("FireBrick")
                O_ring(5, 2);
}

module bondtech_extruder_holder_stl() {
    stl("bondtech_extruder_holder")
        color(pp3_colour)
            translate([150, 150 - 4.5, 0])
                rotate(180)
                    toolChangerBondtechImportStl("bondtech_bmg_adaptor_plate");
}

module bondtech_extruder_holder_hardware() {
    for(x = [-17, 17], y=[-11.5, 3])
        translate([x, y, -5])
            vflip()
                boltM3Caphead(10);
    translate([4.5, 0, 23])
        rotate([-90, 180, 0])
            E3Dv6plusFan();
}

module bondtech_groovemount_clip_stl() {
    stl("bondtech_groovemount_clip")
        color(pp1_colour)
            translate([154.5, 150, 24])
                rotate(180)
                    toolChangerBondtechImportStl("groovemount_clip");
}

module bondtech_groovemount_clip_hardware() {
    for (x = [-12, 12])
        translate([x + 4.5, 0, 24 + 6])
            boltM3Caphead(10);
}

module bondtech_blower_fan_shroud_stl() {
    stl("bondtech_blower_fan_shroud")
        color(pp3_colour)
            translate([-150, -139+24/2, 0])
                toolChangerBondtechImportStl("blower_fan_shroud");
}

module bondtech_blower_fan_shroud_hardware() {
    for (z = [0, 10])
    translate([-5, 20, z + 20])
        rotate([0, 90, -90])
            boltM3Buttonhead(8);
    translate([25, -8, 93])
        rotate([0, 90, 0]) {
            boltM3Buttonhead(20);
            translate_z(-16.5)
                washer(M3_washer);
            translate_z(-19)
                nut(M3_nut);
        }
    translate([9, -12.75, 47.75])
        rotate([90, 0, 90])
            blower(RB5015);
}

module bondtech_assembly()
assembly("bondtech") {
    translate([0, 30, -toolChangerAxelOffsetZ])
        rotate([90, 0, 0]) {
            stl_colour(pp1_colour)
                bondtech_tool_plate_stl();
            bondtech_tool_plate_hardware();
            translate([-22.5, -30, -23])
                rotate([-90, 180, 0]) {
                    stl_colour(pp3_colour)
                        bondtech_blower_fan_shroud_stl();
                    bondtech_blower_fan_shroud_hardware();
                }
            vflip()
                translate_z(-8) {
                    stl_colour(pp2_colour)
                        wedge_plate_stl();
                    wedge_plate_hardware();
                }
            translate([0, 23, 0])
                rotate([180, 0, 180]) {
                    stl_colour(pp3_colour)
                        bondtech_extruder_holder_stl();
                    bondtech_extruder_holder_hardware();
                    stl_colour(pp1_colour)
                        bondtech_groovemount_clip_stl();
                    bondtech_groovemount_clip_hardware();
                }
            translate([0, 62, 8])
                rotate([180, 0, 180]) {
                    NEMA(NEMA17P);
            }
            translate([22, 0, 8])
                rotate([0, 90, 0]) {
                    stl_colour(pp2_colour)
                        bondtech_left_parking_wing_stl();
                    bondtech_left_parking_wing_hardware();
                }
            translate([-22, 0, 8])
                rotate([0, -90, 0]) {
                    stl_colour(pp2_colour)
                        bondtech_right_parking_wing_stl();
                    bondtech_right_parking_wing_hardware();
                }
        }
}

module carriage_top_plate_stl() {
    xCarriageType = MGN12H_carriage;
    size = [carriage_size(xCarriageType).x, carriage_size(xCarriageType).y + 1, 9];
    fillet = 1.5;

    stl("carriage_top_plate")
        color(pp1_colour)
            difference() {
                translate([-size.x/2, -size.y/2, 0])
                    rounded_cube_xy(size, fillet);
                translate_z(size.z - carriage_height(xCarriageType))
                    carriage_hole_positions(xCarriageType)
                        vflip()
                            boltHoleM3Counterbore(size.z);
            }
}

module carriage_top_plate_assembly()
assembly("carriage_top_plate") {
    xCarriageType = MGN12H_carriage;

    stl_colour(pp1_colour)
        carriage_top_plate_stl();
    translate_z(-7)
        carriage_hole_positions(xCarriageType)
            boltM3Caphead(10);
}

module carriage_pulley_stl() {
    stl("carriage_pulley")
        color(pp1_colour)
            translate([-150, -133.5, 0])
                toolChangerImportStl("carriage_pulley");
}

module carriage_back_plate_stl() {
    stl("carriage_back_plate")
        color(pp3_colour)
            //render(convexity=2)
                intersection() {
                    *translate([-40, -28, -eps])
                        cube([80, 56.5, 8+2*eps]);
                    rotate(180)
                        translate([-150, -164.765, 0])
                            toolChangerImportStl("carriage_back_plate");
                }
}

module carriage_back_plate_assembly()
assembly("carriage_back_plate") {
    //rodLength = 85.25;
    rodLength = 62;
    translate([0, -14, -toolChangerAxelOffsetZ])
        rotate([90, 0, 0]) {
            stl_colour(pp3_colour)
                carriage_back_plate_stl();
            translate_z(8.5)
                stl_colour(pp1_colour)
                    carriage_pulley_stl();
            translate_z(-45)
                rod(5, rodLength, center=false);
        }
}

module carriage_center_plate_stl() {
    stl("carriage_center_plate")
        color(pp4_colour)
            translate([-150, -159, 0])
                toolChangerImportStl("carriage_center_plate");
}

module carriage_center_plate_assembly() {
    translate([0, -14, -toolChangerAxelOffsetZ])
        rotate([90, 0, 180])
            stl_colour(pp4_colour)
                carriage_center_plate_stl();
}

module carriage_coupler_plate_stl() {
    stl("carriage_coupler_plate")
        color(pp3_colour)
            translate([-37.15, -27.568, 0])
                toolChangerImportStl("carriage_coupler_plate");
}

module carriage_coupler_plate_assembly() {
    translate([0, 14, -toolChangerAxelOffsetZ])
        rotate([90, 0, 180]) {
            stl_colour(pp3_colour)
                carriage_coupler_plate_stl();
            for (a = [0, 120, 240])
                rotate(a)
                    translate([0, 29, 0])
                        rotate([0, 90, 90])
                            for (y = [4.35, -4.35])
                                translate([-5.75, y, 0])
                                    rod(4, 20);
        }
}

module E3D_TC_PLATE_stl() {
    size = [40, 60, 4.5];
    fillet = 4;
    centerOffsetY = 15;

    stl("E3D_TC_PLATE")
        color(pp4_colour)
            difference() {
                union() {
                    translate([-size.x/2, -centerOffsetY, 0])
                        rounded_cube_xy(size, fillet);
                    for (a = [120, 240])
                        rotate(a)
                            hull() {
                                cylinder(d=15, h=size.z);
                                translate([0, 30, 0])
                                    cylinder(d=15, h=size.z);
                            }
                }
                boltHole(10, size.z);
                for (a = [0, 120, 240])
                    rotate(a)
                        translate([0, 30, 0])
                            boltHole(8, size.z);
                for (x = [-15, 15], y = [-10, 12.5, 35])
                    translate([x, y, size.z])
                        boltPolyholeM3Countersunk(size.z);
            }
}

module E3D_TC_PLATE_assembly()
assembly("E3D_TC_PLATE") {
    translate([0, 14, -toolChangerAxelOffsetZ])
        rotate([90, 0, 180])
            stl_colour(pp4_colour)
                E3D_TC_PLATE_stl();
}
