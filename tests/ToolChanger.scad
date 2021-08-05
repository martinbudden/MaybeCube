//! Display the tool changer

include <../scad/global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageToolChanger.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>
use <../scad/printed/XY_Idler.scad>
use <../scad/printed/XY_MotorMount.scad>

use <../scad/utils/carriageTypes.scad>
use <../scad/utils/CoreXYBelts.scad>
use <../scad/utils/X_Rail.scad>

use <../scad/vitamins/bolts.scad>
use <../scad/vitamins/extrusion.scad>

use <../scad/FaceTop.scad>

use <../scad/Parameters_CoreXY.scad>
use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
t = 11;
carriagePosition = carriagePosition(t);

module toolChanger() {
    translate([130, eY + eSize, eZ])
        mirror([1, 0, 0])
            lock_actuator_assembly();
    for (i= eX <= 350 ? [0, 1] : [0, 1, 2])
        translate([xToolPos(i), eY + eSize, eZ - 28.5]) {
            tool_dock_55mm_assembly();
            if (i == 0 || i == 2) {
                translate([0, -82, 8.5])
                    bondtech_assembly();
                //parking_post_47mm_assembly();
                //tool_dock_47mm_assembly();
                *translate([0, -72, 8.5])
                    pen_assembly();
            } else if (i == 2) {
                //parking_post_55mm_assembly();
                tool_dock_55mm_assembly();
            }
        }
    xRailCarriagePosition(t)
        rotate(180) {
            carriage_top_plate_assembly();
            carriage_back_plate_assembly();
            //carriage_center_plate_assembly();
            carriage_coupler_plate_assembly();
            //E3D_TC_PLATE_assembly();
            translate([0, 2, 0])
                if (t==8 || t==9)
                    pen_assembly();
                else
                    bondtech_assembly();
        }
}

module toolChanger_test() {
    toolChanger();
    CoreXYBelts(carriagePosition + [-4, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
    //printheadBeltSide(t=t);
    translate_z(eZ)
        xRail(carriagePosition, MGN12H_carriage);
    translate([eSize, eX + eSize, eZ - 2*eSize])
        extrusionOX2040V(eY);
    for (x=[0, eX + eSize], y=[0, eY + eSize])
        translate([x, y, 250])
            extrusionOZ(eZ-250);
    XY_Motor_Mount_Left_assembly();
    XY_Motor_Mount_Right_assembly();
}

module toolChanger_test2() {
    toolChanger();
    Face_Top_Stage_2_assembly();
    CoreXYBelts([eX + 2*eSize - 10 - carriagePosition.x, carriagePosition.y]);
}
//carriage_back_plate_stl();
//carriage_back_plate_assembly();
//carriage_coupler_plate_stl();
//translate_z(8) E3D_TC_PLATE_stl();
//carriage_center_plate_stl();
//carriage_coupler_plate_assembly();

//pen_tool_base_tool_plate_stl();
//parking_post_base_47mm_stl();
//tool_holder_47mm_stl();
//parking_post_47mm_assembly();
//tool_holder_55mm_stl();
//tool_dock_55mm_stl();
//toolDockHardware(55);
//parking_post_55mm_assembly();
//tool_dock_55mm_assembly();
//pen_left_parking_wing_stl();
//pen_left_parking_wing_hardware();
//pen_right_parking_wing_stl();
//pen_right_parking_wing_hardware();
//pen_holder_stl();
//pen_assembly();
//bondtech_tool_plate_stl();
//bondtech_tool_plate_hardware();
//bondtech_left_parking_wing_stl();
//bondtech_left_parking_wing_hardware();
//bondtech_right_parking_wing_stl();
//bondtech_right_parking_wing_hardware();
//bondtech_extruder_holder_stl();
//bondtech_extruder_holder_hardware();
//bondtech_groovemount_clip_stl();
//bondtech_groovemount_clip_hardware();
//wedge_plate_stl();
//wedge_plate_hardware();
//bondtech_blower_fan_shroud_stl();
//bondtech_blower_fan_shroud_hardware();
//bondtech_assembly();
//lock_actuator_base_plate_stl();
//lock_actuator_base_plate_hardware();
//lock_actuator_motor_clip_stl();
//fixed_half_pulley_stl();
//floating_half_pulley_stl();
//spring_guide_anchor_block_stl();
//lock_actuator_assembly();
//carriage_top_plate_assembly();
//carriage_pulley_stl();

if ($preview)
    translate(-[eSize + eX/2, carriagePosition.y])
        translate_z(-(eZ - yRailOffset().x - carriage_clearance(xCarriageType())))
            toolChanger_test();
