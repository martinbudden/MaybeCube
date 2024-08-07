//! Display the EVA X carriage

include <../scad/config/global_defs.scad>
$pp1_colour = grey(25);
$pp2_colour = "LimeGreen";
$pp3_colour = grey(25);
$pp4_colour = "SteelBlue";

include <../scad/vitamins/bolts.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/e3d.scad>

use <../scad/printed/X_CarriageEVA.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/config/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
t = 2;
zOffset = 5;
tensionerOffsetX = X_CarriageEVATensionerOffsetX();

module EVA_2_4_2_test() {
    offsetZ = 0;
    translate(-[eSize + eX/2, carriagePosition(t).y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {
        //CoreXYBelts(carriagePosition() + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        translate_z(offsetZ) printheadEVA_2_4_2(top="mgn12");
        *translate_z(eZ)
            xRail(carriagePosition(), MGN12H_carriage);
        *translate([0, 0, eZ - eSize])
            Y_Carriage_Left_assembly();
        *translate([2*eSize + eX, 0, eZ - eSize])
            Y_Carriage_Right_assembly();
    }
    translate_z(13 + offsetZ) rotate(180) evaHotend();
}

module evaImportStl(file) {
    eva_2_4_2_ImportStl(file);
}

module evaHotend(full=false) {
    *translate_z(2*eps)
        color(pp1_colour) {
            EvaTopConvert("top_mgn12");
            //EvaTopConvert("top_orbiter_mgn12");
            //EvaTopConvert("top_titan_mgn12");
            //EvaTopConvert("top_bmg_mgn12");
            //EvaTopConvert("top_lgx_mgn12_a");
        }
    *translate_z(-5)
        color(pp4_colour) evaImportStl("top_orbiter_mgn12");
    translate([0, -13.5, -39.9 - zOffset])
        color(pp1_colour)
            evaBottom();
    translate([0, 19.5, -15.5 - zOffset]) {
        color(pp2_colour)
            evaImportStl("back_corexy");
        if (full)
            translate([0, 3, 14.5]) {
                color(pp1_colour)
                    evaImportStl("universal_cable_mount");
                translate([0, 20, 54])
                    rotate([0, 180, 0])
                        color(pp2_colour)
                            evaImportStl("cable_holder");
            }
        //evaTensioners();
        *translate([9.5, 14, -26])
            rotate([90, -25, 180])
                blower(RB5015);
    }
    translate([0, -13.5, -15.5 - zOffset]) {
        color(pp2_colour)
            evaImportStl("universal_face");
        if (full) {
            *color(pp3_colour)
                evaImportStl("face_belt_grabber");
            *translate_z(-17.2)
                rotate([0, 180, 0])
                    color(pp3_colour)
                        evaImportStl("face_belt_grabber");
            e3d();
        }
    }
    if (full)
        translate([15, 10.5, -54 - zOffset])
            color(pp2_colour)
                evaImportStl("Duct v2.1 Straight");
    *if (full)
        translate([-10, 0, 9])
            color(pp2_colour)
                evaImportStl("top_endstop_angled");
}

module e3d() {
    translate([0, -8, 10.25])
        color(pp3_colour)
            evaImportStl("v6_face_clamp");
    translate([0, -8, 10.25])
        color(pp3_colour)
            evaImportStl("v6_support");
    translate([0, -18, 13])
        rotate(180)
            hot_end(E3Dv6, filament=1.75, naked=true, bowden=false);
    translate([0, -8, 10.25])
        color(pp4_colour)
            evaImportStl("v6_face");
    translate([0, -35.5, -5.75])
        rotate([90,0,0])
            fan(fan40x11);
    translate([0, -44, -5.75])
        color(pp2_colour)
            evaImportStl("shroud");
}

module universal_face() {
    render(convexity=2)
    difference() {
        union() {
            mirror([1, 0, 0])
                evaImportStl("universal_face");
            cubeSize = [44.1, 5, 8];
            translate([-cubeSize.x/2, -cubeSize.y, 20.5])
                cube([cubeSize.x, cubeSize.y, cubeSize.z - 2]);
            translate_z(5)
                //render(convexity=4)
                    intersection() {
                        evaImportStl("universal_face");
                        translate([-cubeSize.x/2, -cubeSize.y, 20.5])
                            cube(cubeSize);
                    }
        }
        for (x = [17.05, -17.05])
            translate([x, -6.5, 28.5])
                rotate([-90, 0, 0])
                    boltHoleCounterbore(M3_cap_screw, 8, cnc=true);
    }
}

module evaTensionersOld(color=pp4_colour) {
    *translate([12, -2, -20.05 + zOffset]) {
        rotate([90, 0, 0])
            importTensioner(color);
        translate([-24, 0, 7.1])
            rotate([-90, 0, 180])
                importTensioner(color);
    }
    *translate([12, -25.5, -23.45 + zOffset]) {
        rotate([-90, 0, 0])
            importTensioner(color);
        translate([-24, 0, 13.9])
            rotate([90, 0, 180])
                importTensioner(color);
    }
}


module importTensioner(color=pp4_colour) {
    translate([12.5, 13.5, 2.5])
        rotate([-90, 0, 180])
            color(color)
                render(convexity=2)
                    difference() {
                        evaImportStl("tension_slider_6mm_belt_M3s");
                        cSize = [25, 7.2, 3];
                        translate([-cSize.x/2, -cSize.y + 2.5, 0])
                            cube(cSize);
                    }
}

module evaBottom() {
    evaImportStl("bottom_mgn12_short_duct");
}

module evaImportStlBottom() {
    translate([4.1, 22.05, 27])
        rotate([-90, 0, 90])
            evaImportStl("bottom_mgn12_short_duct");
}

//universal_face();
//importTensioner();
//EvaTopConvert("top_orbiter_mgn12", horizontal=false);
//EvaTopConvert("top_lgx_mgn12_a");
//EvaTopConvert("top_bmg_mgn12");
//translate_z(-8)evaImportStl("top_lgx_mgn12_a");
//EVA_MC_top_lgx_mgn12_a_stl();
//EVA_MC_top_mgn12_stl();
//evaImportStlBottom();
//translate([0,-13.5,5])rotate([0,90,90])
//EVA_MC_bottom_mgn12_short_duct_stl();
//xCarriageBeltAttachment(30);
//teeth(8, 5, horizontal=!true);
//evaHotendTop();
//translate([-43.7, 22, 16]) rotate([-90, 0, 90]) evaImportStl("contributors/dual_5015_bottom_mgn12_wide");
//EVA_MC_dual_5015_bottom_mgn12_wide_stl();
//translate([4.1, 22.1, 27]) rotate([-90,0,90]) evaImportStl("contributors/7530_fan_mgn12_bottom_wide");
//X_Carriage_Belt_Clamp_stl();
//X_Carriage_Belt_Tensioner_stl();
if ($preview)
    EVA_2_4_2_test();
