include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pillar.scad>
include <NopSCADlib/vitamins/psus.scad>
include <NopSCADlib/vitamins/pcbs.scad>
use <NopSCADlib/printed/psu_shroud.scad>
use <NopSCADlib/vitamins/sheet.scad>

use <printed/extruderBracket.scad>
use <printed/PSU.scad>

use <utils/FrameBolts.scad>

use <vitamins/bolts.scad>
use <vitamins/nuts.scad>

use <Parameters_CoreXY.scad>
include <Parameters_Main.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];
//PC3 = ["PC3", "Sheet polycarbonate", 3, "red", false];

function backPanelSize() = [eX + 2*eSize, eZ, 3];
function partitionSize() = [eX + 2*eSize, eZ-51.5, 3];
function pcbType() = BTT_SKR_V1_4_TURBO;
//function pcbType() = BTT_SKR_E3_TURBO;
//function pcbType() = BTT_SKR_MINI_E3_V2_0;


module Back_Panel_dxf() {
    size = backPanelSize();
    fillet = 1;
    sheet = PC3;
    thickness = sheet_thickness(sheet);

    dxf("Back_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                backPanelCutouts(PSUtype(), pcbType(), cncSides=0);
            }
}

module Back_Panel_assembly()
assembly("Back_Panel") {

    pcbAssembly(pcbType());
    hidden() PCB_Mount_stl();

    psuAsssembly();
    hidden() PSU_Left_Mount_stl();
    hidden() PSU_Top_Mount_stl();

    size = backPanelSize();

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0]) {
            backPanelBoltHolePositions(size)
                translate_z(-size.z/2)
                    vflip()
                        boltM4ButtonheadHammerNut(_sideBoltLength);
            translate([psuOffset(PSUtype()).x, psuOffset(PSUtype()).z])
                rotate(-90)
                    PSUBoltPositions()
                        vflip()
                            boltM4Buttonhead(_sideBoltLength);
            translate([size.x/2, size.y/2, -size.z/2])
                render_2D_sheet(PC3, w=size.x, d=size.y)
                    Back_Panel_dxf();
        }
}

module backPanelAccessHolePositions(size) {
    for (x = [eSize/2, eX + 3*eSize/2], y = [eSize/2, 3*eSize/2, size.y - eSize/2])
        translate([x, y])
            children();
    for (x = [3*eSize/2, size.x - 3*eSize/2])
        translate([x, size.y -eSize/2])
            children();
    for (y = [spoolHeight() - eSize/2, spoolHeight() + eSize/2])
        translate([size.x - eSize/2, y])
            children();
    for (y = [middleExtrusionOffsetZ() - eSize/2, middleExtrusionOffsetZ() + eSize/2])
        translate([eSize/2, y])
            children();
}

module backPanelBoltHolePositions(size) {
    for (x = [3*eSize/2, size.x/3 - eSize/6, 2*size.x/3 - eSize/6, size.x - 3*eSize/2], y = [eSize/2, size.y - eSize/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
    for (x = [eSize/2, size.x - eSize/2], y = [eSize, size.y - eSize])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
    for (x = [eSize/2, size.x - eSize/2], y = [2*size.y/3 - eSize/6, size.y/3 - eSize/6])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
}

module backPanelCutouts(PSUtype, pcbType, cncSides = undef) {
    size = backPanelSize();
    psuSize = [psu_length(PSUtype), psu_width(PSUtype), psu_height(PSUtype)];

    translate([-size.x/2, -size.y/2]) {
        //translate([eSize + psuSize.y/2, psuSize.x/2 + 2*eSize + 20])
        translate([psuOffset(PSUtype).x, psuOffset(PSUtype).z])
            rotate(-90) {
                PSUBoltPositions()
                    poly_circle(r = M4_clearance_radius, sides=cncSides);
                *mirror([0, 1, 0])
                    rotate(180) {
                        psu_shroud_hole_positions(PSUtype)
                            circle(r = M3_clearance_radius);
                        cutoutWidth = 1.5;
                        psu_shroud_cable_positions(PSUtype, psuShroudCableDiameter())
                            for (y = [-psuShroudCableDiameter()/2 - cutoutWidth/2, psuShroudCableDiameter()/2 + cutoutWidth/2])
                                translate([0, y])
                                    rounded_square([4, cutoutWidth], 0.25, center=true);
                    }
                }

        pcbOffsetZ = 100;
        translate([eX + eSize, pcbOffsetZ])
            if (pcbType == BTT_SKR_E3_TURBO || pcbType == BTT_SKR_MINI_E3_V2_0) {
                pcbSize = pcb_size(BTT_SKR_E3_TURBO);
                translate([-pcbSize.x/2, pcbSize.y/2])
                    pcb_screw_positions(pcbType)
                        poly_circle(r = M3_clearance_radius, sides=cncSides);
            } else {
                pcbSize = pcb_size(pcbType);
                rotate(90)
                    translate([pcbSize.x/2, pcbSize.y/2])
                        pcb_screw_positions(pcbType)
                        poly_circle(r = M3_clearance_radius, sides=cncSides);
            }
        backPanelAccessHolePositions(size)
            poly_circle(r = M4_clearance_radius, sides=cncSides);
        backPanelBoltHolePositions(size)
            poly_circle(r = M4_clearance_radius, sides=cncSides);
    }
}

/*
module backPanelCutouts3D(size, PSUtype, pcbType) {
    PSUPosition(psuOnBase=false) {
        PSUBoltPositions()
            boltHoleM4(size.z);
        mirror([0, 1, 0])
            rotate(180) {
                psu_shroud_hole_positions(PSUtype)
                    boltHoleM3(size.z);
                cutoutWidth = 1.5;
                psu_shroud_cable_positions(PSUtype, psuShroudCableDiameter())
                    for (y = [-psuShroudCableDiameter()/2 - cutoutWidth/2, psuShroudCableDiameter()/2 + cutoutWidth/2])
                        translate([0, y, -eps])
                            rounded_cube_xy([4, cutoutWidth, size.z + 2*eps], 0.25, xy_center=true);
            }
        }
}
*/
module PSU_Left_Mount_stl() {
    psuShroudWall = 1.8;
    size = [eSize + psuShroudWall + psu_width(PSUtype()), 120, 3];
    fillet = 3;

    stl("PSU_Left_Mount")
        color(pp2_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        rounded_square([size.x, size.y], fillet, center=false);
                        for (x = [eSize/2, eSize + 5, size.x - 5], y = [eSize/2])
                            translate([x, y, 0])
                                poly_circle(r = M4_clearance_radius);
                        for (y = [3*eSize/2, 2*eSize + 5, size.y - eSize/2])
                            translate([eSize/2, y])
                                poly_circle(r = M4_clearance_radius);
                        translate([backPanelSize().x/2, backPanelSize().y/2])
                            backPanelCutouts(PSUtype(), pcbType());
                    }
}

module PSU_Left_Mount_assembly()
assembly("PSU_Left_Mount") {

    translate([0, eY + 2*eSize + 2*eps, 0])
        rotate([90, 0, 0]) {
            stl_colour(pp2_colour)
                PSU_Left_Mount_stl();
        }
}

module PSU_Top_Mount_stl() {
    size = [110, 30, 3];
    fillet = 3;

    stl("PSU_Top_Mount")
        color(pp2_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        offsetY = psuOffset(PSUtype()).z + 75;
                        translate([0, offsetY - size.y/2])
                            rounded_square([size.x, size.y], fillet, center=false);
                        translate([0, offsetY - size.y/2])
                            for (y = [6, size.y - 6])
                                translate([eSize/2, y])
                                    poly_circle(r = M4_clearance_radius);
                        translate([backPanelSize().x/2, backPanelSize().y/2])
                            backPanelCutouts(PSUtype(), pcbType());
                    }
}

module PSU_Top_Mount_assembly()
assembly("PSU_Top_Mount") {

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0]) {
            stl_colour(pp2_colour)
                PSU_Top_Mount_stl();
        }
}

module PCB_Mount_stl() {
    size = [110, 120, 3];
    fillet = 1;

    stl("PCB_Mount")
        color(pp2_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        offsetY = 155;
                        translate([eX + 2*eSize - size.x, offsetY -size.y/2])
                            rounded_square([size.x, size.y], fillet, center=false);
                        translate([eX + eSize, offsetY -size.y/2])
                            for (y = [6, size.y/2, size.y - 6])
                                translate([eSize/2, y])
                                    poly_circle(r = M4_clearance_radius);
                        translate([backPanelSize().x/2, backPanelSize().y/2])
                            backPanelCutouts(PSUtype(), pcbType());
                    }
}

module PCB_Mounting_Plate_assembly()
assembly("PCB_Mounting_Plate") {

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0]) {
            stl_colour(pp2_colour)
                PCB_Mount_stl();
        }
}

/*
module PSU_Right_Mount_stl() {
    size = psuRightMountSize;
    fillet = 3;

    stl("PSU_Right_Mount")
        color(pp2_colour)
            difference() {
                translate([eX + 2*eSize - size.x, 0, 0])
                    rounded_cube_xy(size, fillet);
                translate([eX + 2*eSize - size.x, 0, 0]) {
                    for (x = [eSize/2, size.x - eSize - 5, size.x - eSize/2], y = [eSize/2])
                        translate([x, y, 0])
                            boltHoleM4(size.z);
                    for (y = [3*eSize/2, 2*eSize + 5, size.y - eSize/2])
                        translate([size.x - eSize/2, y])
                            boltHoleM4(size.z);
                }
                rotate([-90, 0, 0])
                    translate([0, -eY - 2*eSize, 0])
                        PSUPosition(psuOnBase=false) {
                            PSUBoltPositions()
                                boltHoleM4(size.z);
                            rotate(180) {
                                psu_shroud_hole_positions(PSUtype)
                                    boltHoleM3(size.z);
                                cutoutWidth = 1.5;
                                psu_shroud_cable_positions(PSUtype, psuShroudCableD)
                                    for (y = [-psuShroudCableD/2 - cutoutWidth/2, psuShroudCableD/2 + cutoutWidth/2])
                                        translate([0, y, -eps])
                                            rounded_cube_xy([4, cutoutWidth, size.z + 2*eps], 0.25, xy_center=true);
                            }
                        }
            }
}

module PSU_Right_Mount_hardware() {
}

module PSU_Right_Mount_assembly()
assembly("PSU_Right_Mount") {

    translate([0, eY + 2*eSize + psuRightMountSize.z + 2*eps, 0])
        rotate([90, 0, 0]) {
            stl_colour(pp2_colour)
                PSU_Right_Mount_stl();
            PSU_Right_Mount_hardware();
        }
}
*/

M3x20_nylon_hex_pillar = ["M3x20_nylon_hex_pillar", "hex nylon", 3, 20, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -6, -6+eps];

module pcbAssembly(pcbType) {
    pcbOffsetFromBase = 20;

    if (is_undef($hide_pcb) || $hide_pcb == false)
        explode(20, true)
            pcbPosition(pcbType, pcbOffsetFromBase) {
                pcb(pcbType);
                pcb_screw_positions(pcbType) {
                    translate_z(pcb_thickness(pcbType))
                        boltM3Caphead(6);
                    translate_z(-pcbOffsetFromBase) {
                        explode(10)
                            pillar(M3x20_nylon_hex_pillar);
                        translate_z(-_basePlateThickness)
                            vflip()
                                explode(20, true)
                                    boltM3Buttonhead(10);
                    }
                }
            }
}

module pcbPosition(pcbType, z=0) {
    pcbStandOffHeight = 20;

    pcbOnBase = false;
    if (pcbOnBase) {
        pcbSize = pcb_size(pcbType);
        if (eX >= 300)
            translate([eSize + eX - pcbSize.y/2 - 1, pcbSize.x + eSize - 30, z])
                rotate(90)
                    children();
        else
            translate([eSize + eX - pcbSize.y/2 - 1, pcbSize.x + eSize - 15, z])
                rotate(90)
                    children();
    } else {
        pcbOffsetZ = 100;
        if (pcbType == BTT_SKR_E3_TURBO || pcbType == BTT_SKR_MINI_E3_V2_0) {
            pcbSize = pcb_size(BTT_SKR_E3_TURBO);
            translate([eX + eSize - pcbSize.x/2, eY + 2*eSize - pcbStandOffHeight, pcbSize.y/2 + pcbOffsetZ])
                rotate([90, 0, 0])
                    children();
        } else {
            pcbSize = pcb_size(pcbType);
            translate([eX + eSize - pcbSize.y/2, eY + 2*eSize - pcbStandOffHeight, pcbSize.x/2 + pcbOffsetZ])
                rotate([90, -90, 0])
                    children();
        }
    }
}

module psuAsssembly(psuOnBase=false) {
    PSUPosition(psuOnBase)
        explode(50)
            PSU();
    if (eX >= 300)
        PSU_Shroud_assembly();
    if (psuOnBase) {
        PSUPosition(psuOnBase)
            PSUBoltPositions() {
                //Standoff_6mm_stl();
                translate_z(-_basePlateThickness)
                    vflip()
                        boltM4Buttonhead(8);
            }
    } else {
        //PSU_Left_Mount_assembly();
        //PSU_Top_Mount_assembly();
        //PCB_Mounting_Plate_assembly();
        //PSU_Right_Mount_assembly();
    }
}

module Partition_dxf() {
    size = partitionSize();
    fillet = 1;
    sheet = PC3;
    thickness = sheet_thickness(sheet);

    dxf("Partition")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                partitionCutouts(cncSides=0);
            }
}

module Partition_assembly()
assembly("Partition") {
    size = partitionSize();

    translate([0, eY + 2*eSize - 59, 0])
        rotate([90, 0, 0]) {
            translate([size.x/2, size.y/2, -size.z/2])
                render_2D_sheet(PC3, w=size.x, d=size.y)
                    Partition_dxf();
        }

}

module partitionCutouts(cncSides) {
    size = partitionSize();

    translate([-size.x/2, -size.y/2]) {
        square([eSize, 2*eSize]);
        translate([0, middleExtrusionOffsetZ() - eSize])
            square([eSize, 2*eSize]);
        translate([eX + eSize, 0])
            square([eSize, 2*eSize]);
        translate([eX + eSize, spoolHeight() - eSize])
            square([eSize, 2*eSize]);
        leftTop = [245, coreXYSeparation().z];
        translate([0, size.y - leftTop.y])
            square(leftTop);
        centerTopOffsetX = 86;
        centerTop = [leftTop.x - centerTopOffsetX, 35];
        translate([centerTopOffsetX, size.y - centerTop.y])
            square(centerTop);
    }
}
