//! Display the EVA X carriage

include <../scad/global_defs.scad>
$pp1_colour = grey(25);
$pp2_colour = "LimeGreen";
$pp3_colour = grey(25);
$pp4_colour = "SteelBlue";

include <../scad/vitamins/bolts.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/e3d.scad>

use <../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageEVA.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>

include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/X_Rail.scad>


use <../scad/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;
t = 2;
zOffset = 5;
tensionerOffsetX = X_CarriageEVATensionerOffsetX();

module evaImportStl(file) {
    eva_3_0_ImportStl(file);
}

module EVA_3_0_test() {
    offsetZ = 0;
    translate(-[eSize + eX/2, carriagePosition(t).y, eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))]) {
        //CoreXYBelts(carriagePosition() + [2, 0], x_gap = -25, show_pulleys = ![1, 0, 0]);
        *translate_z(offsetZ) printheadEVA_3_0(top="mgn12");
        *translate_z(eZ)
            xRail(carriagePosition(), MGN12H_carriage);
        *translate([0, 0, eZ - eSize])
            Y_Carriage_Left_assembly();
        *translate([2*eSize + eX, 0, eZ - eSize])
            Y_Carriage_Right_assembly();
    }
    //translate_z(13 + offsetZ) rotate(180) 
    evaHotend();
    *rotate([90, 0, 0])
        EVA_MC_mgn12_bottom_horns_fi_stl();
}

module evaHotend(full=false) {
    translate([0, 0, 0])
        color(pp1_colour)
            evaImportStl("top_endstop_fi");
    translate([0, 0, 0])
        color(pp4_colour)
            rotate([90, 0, 0])
                EVA_MC_mgn12_bottom_horns_fi_stl();
    translate([0, 1, 0]) {
        color(pp2_colour)
            evaImportStl("back_core_xy_fi");
        *translate([9.5, 14, -26])
            rotate([90, -25, 180])
                blower(RB5015);
    }
    translate([0, 0, 0]) {
        color(pp2_colour)
            evaImportStl("front_universal_fi");
    }
}

//if ($preview)
    EVA_3_0_test();
