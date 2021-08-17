include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pillar.scad>
include <NopSCADlib/vitamins/pcbs.scad>
include <NopSCADlib/vitamins/psus.scad>
use <NopSCADlib/vitamins/sheet.scad>

use <printed/extruderBracket.scad>
use <printed/PSU.scad>
use <printed/WiringGuide.scad>

use <utils/bezierTube.scad>
use <utils/FrameBolts.scad>
use <utils/printheadOffsets.scad>

use <vitamins/bolts.scad>
use <vitamins/nuts.scad>

use <Parameters_Positions.scad>
use <Parameters_CoreXY.scad>
include <Parameters_Main.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];
//PC3 = ["PC3", "Sheet polycarbonate", 3, "red", false];
accessHoleRadius = 2.5;
psuVertical = eX == 300;

function backPanelSize() = [eX + 2*eSize, eZ, 3];
function partitionSize() = [eX + 2*eSize, eZ-51.5, 3];
//function pcbType() = BTT_SKR_V1_4_TURBO;
function pcbType() = eX == 250 ? BTT_SKR_MINI_E3_V2_0 : BTT_SKR_E3_TURBO;
//function pcbType() = BTT_SKR_MINI_E3_V2_0;
pcbOffsetZ = eX == 250 ? 155 : 100;


module Back_Panel_dxf() {
    size = backPanelSize();
    fillet = 1;
    sheet = PC3;
    thickness = sheet_thickness(sheet);

    dxf("Back_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                backPanelCutouts(PSUType(), pcbType(), cncSides=0);
            }
}

//!There are three options for the back panel: use a polycarbonate sheet, use an aluminium sheet, or use the three
//!mounts **PCB_Mount**, **PSU_Lower_Mount**, and **PSU_Upper_Mount**. If you have access to a CNC, you can machine
//!the back sheet using **Back_Panel.dxf**, if not you can use the **Panel_Jig** and the PCB and PSU mounts as
//!templates to drill the holes in the back sheet.
//!
//!Once you have the back sheet prepared:
//!1. Bolt the PSU to the back sheet.
//!2. Bolt the mainboard to the back sheet, using the nylon standoffs.
//!3. Add the bolts and t-nuts in preparation for later attachment to the frame. Take take to use the correct holes
//!and don't place bolts into the access holes for the hidden bolts used to assemble the frame.
//
module Back_Panel_assembly()
assembly("Back_Panel") {

    size = backPanelSize();
    countersunk = true;

    pcbAssembly(pcbType());

    psuAssembly(psuVertical);

    PSUPosition(psuVertical)
        PSUBoltPositions()
            translate_z(-size.z)
                vflip()
                    if (countersunk)
                        boltM4Countersunk(_sideBoltLength);
                    else
                        boltM4Buttonhead(_sideBoltLength);

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0]) {
            backPanelBoltHolePositions(size)
                translate_z(-size.z)
                    vflip()
                        if (countersunk)
                            translate_z(eps)
                                boltM4CountersunkHammerNut(_sideBoltLength);
                        else
                            boltM4ButtonheadHammerNut(_sideBoltLength);
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
    for (y = [_upperZRodMountsExtrusionOffsetZ - eSize/2, _upperZRodMountsExtrusionOffsetZ + eSize/2])
        translate([eSize/2, y])
            children();
}

module backPanelBoltHolePositionsX(size) {
    //xPositions = size.x == 300 + 2*eSize
    //? [eSize + 50, size.x/2, size.x - eSize - 50]
    //: [-size.x/2 + 1.5*eSize, -(size.x - eSize)/6, (size.x - eSize)/6, size.x/2 - 1.5*eSize];
    xPositions = [eSize + 50, size.x/2, size.x - eSize - 50];
    for (x = xPositions, y = [eSize/2, size.y - eSize/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
}

module backPanelBoltHolePositions(size) {
    for (x = [eSize/2, size.x - eSize/2], y = [eSize, size.y - eSize])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
    *for (x = [3*eSize/2, size.x/3 - eSize/6, 2*size.x/3 - eSize/6, size.x - 3*eSize/2], y = [eSize/2, size.y - eSize/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
    backPanelBoltHolePositionsX(size)
        children();
    for (x = [eSize/2, size.x - eSize/2], y = [size.y - eSize - (size.y - 2*eSize)/3, eSize + (size.y - 2*eSize)/3])
    //for (x = [eSize/2, size.x - eSize/2], y = [2*size.y/3 - eSize/6, size.y/3 - eSize/6])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
}

module backPanelCutouts(psuType, pcbType, cncSides = undef, radius = undef) {
    size = backPanelSize();

    translate([-size.x/2, -size.y/2]) {
        if (psuVertical)
            translate([psuOffset(psuType).x, psuOffset(psuType).z])
                rotate(-90)
                    PSUBoltPositions()
                        poly_circle(r = is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
        else
            translate([eSize + psu_length(psuType)/2, 2*eSize + 3 + psu_width(psuType)/2])
                PSUBoltPositions()
                    poly_circle(r = is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
                /*mirror([0, 1, 0])
                    rotate(180) {
                        psu_shroud_hole_positions(psuType)
                            circle(r = M3_clearance_radius);
                        cutoutWidth = 1.5;
                        psu_shroud_cable_positions(psuType, psuShroudCableDiameter())
                            for (y = [-psuShroudCableDiameter()/2 - cutoutWidth/2, psuShroudCableDiameter()/2 + cutoutWidth/2])
                                translate([0, y])
                                    rounded_square([4, cutoutWidth], 0.25, center=true);
                    }*/

        translate([eX + eSize, pcbOffsetZ])
            if (pcbType == BTT_SKR_E3_TURBO || pcbType == BTT_SKR_MINI_E3_V2_0) {
                pcbSize = pcb_size(BTT_SKR_E3_TURBO);
                translate([-pcbSize.x/2, pcbSize.y/2])
                    pcb_screw_positions(pcbType)
                        poly_circle(r = is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
            } else {
                pcbSize = pcb_size(pcbType);
                rotate(90)
                    translate([pcbSize.x/2, pcbSize.y/2])
                        pcb_screw_positions(pcbType)
                            poly_circle(r = is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
            }
        backPanelAccessHolePositions(size)
            poly_circle(r = accessHoleRadius, sides=cncSides);
        backPanelBoltHolePositions(size)
            poly_circle(r = M4_clearance_radius, sides=cncSides);
    }
}

module psuLowerMount(size, counterSunk, offsetX=0) {
    fillet = 3;

    vflip()
        translate_z(-size.z)
            difference() {
                linear_extrude(size.z)
                    difference() {
                        translate([offsetX, 0])
                            rounded_square([size.x, size.y], fillet, center=false);
                        *for (x = [eSize/2, eSize + 5, size.x - 5], y = [eSize/2])
                            translate([x, y, 0])
                                poly_circle(r = M4_clearance_radius);
                        *for (y = [3*eSize/2, 2*eSize + 5, size.y - 8])
                            translate([eSize/2, y])
                                poly_circle(r = M4_clearance_radius);
                        backPanelAccessHolePositions(backPanelSize())
                            poly_circle(r = accessHoleRadius);
                        if (counterSunk) {
                            backPanelBoltHolePositions(backPanelSize())
                                poly_circle(r = M4_clearance_radius);
                        } else {
                            translate([backPanelSize().x/2, backPanelSize().y/2])
                                backPanelCutouts(PSUType(), pcbType());
                            translate([eSize/2, size.y - eSize/2])
                                poly_circle(r = M4_clearance_radius);
                        }
                    }
                if (counterSunk) {
                    backPanelBoltHolePositions(backPanelSize())
                        boltPolyholeM4Countersunk(size.z);
                    if (offsetX == 0) {
                        if (size.y < 100)
                            translate([eSize/2, size.y - 8])
                                boltPolyholeM4Countersunk(size.z);
                        else
                            translate([size.x - 10, eSize/2])
                                boltPolyholeM4Countersunk(size.z);

                    } else {
                        for (y = [eSize/2, 3*eSize/2])
                            translate([size.x/2 + offsetX, y])
                                boltPolyholeM4Countersunk(size.z);
                    }
                    rotate([-90, 0, 0])
                        translate([0, -eY - 2*eSize - 2*eps, 0])
                            PSUPosition(psuVertical)
                                PSUBoltPositions()
                                    boltPolyholeM4Countersunk(3);
                }
            }
}

module PSU_Lower_Mount_stl() {
    coverThickness = 3;

    size = [eSize + 2*coverThickness + psu_width(PSUType()), 95, 3];
    counterSunk = true;
    stl("PSU_Lower_Mount")
        color(pp2_colour)
            psuLowerMount(size, counterSunk);
}
/*    fillet = 3;
    stl("PSU_Lower_Mount")
        color(pp2_colour)
            vflip()
                translate_z(-size.z)
                    difference() {
                        linear_extrude(size.z)
                            difference() {
                                rounded_square([size.x, size.y], fillet, center=false);
                                *for (x = [eSize/2, eSize + 5, size.x - 5], y = [eSize/2])
                                    translate([x, y, 0])
                                        poly_circle(r = M4_clearance_radius);
                                *for (y = [3*eSize/2, 2*eSize + 5, size.y - 8])
                                    translate([eSize/2, y])
                                        poly_circle(r = M4_clearance_radius);
                                backPanelAccessHolePositions(backPanelSize())
                                    poly_circle(r = accessHoleRadius);
                                if (counterSunk) {
                                    backPanelBoltHolePositions(backPanelSize())
                                        poly_circle(r = M4_clearance_radius);
                                } else {
                                    translate([backPanelSize().x/2, backPanelSize().y/2])
                                        backPanelCutouts(PSUType(), pcbType());
                                    translate([eSize/2, size.y - eSize/2])
                                        poly_circle(r = M4_clearance_radius);
                                }
                            }
                        if (counterSunk) {
                            backPanelBoltHolePositions(backPanelSize())
                                boltPolyholeM4Countersunk(size.z);
                            translate([eSize/2, size.y - 8])
                                boltPolyholeM4Countersunk(size.z);
                            translate([psuOffset(PSUType()).x, psuOffset(PSUType()).z])
                                rotate(-90)
                                    PSUBoltPositions()
                                        boltPolyholeM4Countersunk(size.z);
                        }
                    }
    }
*/

module PSU_Lower_Mount_assembly()
assembly("PSU_Lower_Mount", ngb=true) {

    translate([0, eY + 2*eSize + 2*eps, 0])
        rotate([-90, 0, 0])
            stl_colour(pp2_colour)
                PSU_Lower_Mount_stl();
}

module PSU_Upper_Mount_stl() {
    size = [115, 30, 3];
    fillet = 3;
    offsetY = psuOffset(PSUType()).z + 75;
    counterSunk = true;

    stl("PSU_Upper_Mount")
        color(pp2_colour)
            vflip()
                translate_z(-size.z)
                    difference() {
                        linear_extrude(size.z)
                            difference() {
                                translate([0, offsetY - size.y/2])
                                    rounded_square([size.x, size.y], fillet, center=false);
                                if (!counterSunk) {
                                    translate([0, offsetY - size.y/2])
                                        for (y = [6, size.y - 6])
                                            translate([eSize/2, y])
                                                poly_circle(r = M4_clearance_radius);
                                    translate([backPanelSize().x/2, backPanelSize().y/2])
                                        backPanelCutouts(PSUType(), pcbType());
                                }
                            }
                        if (counterSunk) {
                            translate([0, offsetY - size.y/2])
                                for (y = [6, size.y - 6])
                                    translate([eSize/2, y])
                                        boltPolyholeM4Countersunk(size.z);
                            translate([psuOffset(PSUType()).x, psuOffset(PSUType()).z])
                                rotate(-90)
                                    PSUBoltPositions()
                                        boltPolyholeM4Countersunk(size.z);
                        }
                    }
}

module PSU_Upper_Mount_assembly()
assembly("PSU_Upper_Mount", ngb=true) {

    translate([0, eY + 2*eSize, 0])
        rotate([-90, 0, 0])
            stl_colour(pp2_colour)
                PSU_Upper_Mount_stl();
}

module PSU_Left_Mount_stl() {
    size = [70, 140, 3];
    counterSunk = true;

    stl("PSU_Left_Mount")
        color(pp2_colour)
            psuLowerMount(size, counterSunk);
}

module PSU_Left_Mount_assembly()
assembly("PSU_Left_Mount", ngb=true) {

    translate([0, eY + 2*eSize + 2*eps, 0])
        rotate([-90, 0, 0])
            stl_colour(pp2_colour)
                PSU_Left_Mount_stl();
}

module PSU_Right_Mount_stl() {
    size = [30, 140, 3];
    counterSunk = true;

    stl("PSU_Right_Mount")
        color(pp2_colour)
            psuLowerMount(size, counterSunk, 202.5 - size.x/2);
}

module PSU_Right_Mount_assembly()
assembly("PSU_Right_Mount", ngb=true) {

    translate([0, eY + 2*eSize + 2*eps, 0])
        rotate([-90, 0, 0])
            stl_colour(pp2_colour)
                PSU_Right_Mount_stl();
}

module PCB_Mount_stl() {
    skrV1_4 = pcbType() == BTT_SKR_V1_4_TURBO;
    size = [skrV1_4 ? 110 : 130, pcbOffsetZ + 20, 3];
    fillet = 1;
    countersunk = true;
    offsetY = 155;

    stl("PCB_Mount")
        color(pp2_colour)
            translate_z(-size.z)
                difference() {
                    linear_extrude(size.z)
                        difference() {
                            translate([eX + 2*eSize - size.x, offsetY -size.y/2])
                                rounded_square([size.x, size.y], fillet, center=false);
                                if (!countersunk) {
                                    for (y = [6, size.y/2, size.y - 6])
                                        translate([eX + 3*eSize/2, y + offsetY -size.y/2])
                                            poly_circle(r = M4_clearance_radius);
                                    translate([backPanelSize().x/2, backPanelSize().y/2])
                                        backPanelCutouts(PSUType(), pcbType());
                                }
                        }
                    if (countersunk) {
                        for (y = [6, size.y/2, size.y - 6])
                            translate([eX + 3*eSize/2, y + offsetY -size.y/2])
                                boltPolyholeM4Countersunk(size.z);
                        pcbSize = pcb_size(pcbType());
                        translate([eX + eSize, pcbOffsetZ + (pcbOffsetZ == 100 ? 0 : 10)])
                            rotate(skrV1_4 ? [0, 0, 90] : [0, 0, 0])
                                translate([skrV1_4 ? pcbSize.x/2 : -pcbSize.x/2, pcbSize.y/2, 0])
                                    pcb_screw_positions(pcbType())
                                        boltPolyholeM3Countersunk(size.z);
                    }
                }
}

module PCB_Mounting_Plate_assembly()
assembly("PCB_Mounting_Plate", ngb=true) {

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0])
            stl_colour(pp2_colour)
                PCB_Mount_stl();
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
                        PSUPosition(psuVertical) {
                            PSUBoltPositions()
                                boltHoleM4(size.z);
                            rotate(180) {
                                psu_shroud_hole_positions(psuType)
                                    boltHoleM3(size.z);
                                cutoutWidth = 1.5;
                                psu_shroud_cable_positions(psuType, psuShroudCableD)
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

M3x20_nylon_hex_pillar = ["M3x20_nylon_hex_pillar", "hex nylon", 3, 20, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -6, -6 + eps];

module pcbAssembly(pcbType, useMounts = false) {
    pcbOffsetFromBase = 20;

    explode = 40;
    if (is_undef($hide_pcb) || $hide_pcb == false)
        pcbPosition(pcbType, pcbOffsetFromBase) {
            explode(explode)
                pcb(pcbType);
            pcb_screw_positions(pcbType) {
                translate_z(pcb_thickness(pcbType))
                    explode(explode, true)
                        boltM3Caphead(6);
                translate_z(-pcbOffsetFromBase) {
                    explode(10)
                        pillar(M3x20_nylon_hex_pillar);
                    translate_z(-_basePlateThickness)
                        vflip()
                            boltM3Buttonhead(10);
                }
            }
        }
    if (useMounts)
        PCB_Mounting_Plate_assembly();
    else
        hidden() PCB_Mount_stl();
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

module printHeadWiring() {
    // don't show the incomplete cable if there are no extrusions to obscure it
    wireRadius = 2.5;
    if (is_undef($hide_extrusions))
        color(grey(20))
            bezierTube([eX/2 + eSize, eY + eSize - 5, eZ - 2*eSize], [carriagePosition().x, carriagePosition().y, eZ] + printheadWiringOffset(), tubeRadius=wireRadius);

    /*translate([carriagePosition().x, carriagePosition().y, eZ] + printheadWiringOffset())
        for (z = [11, 21])
            translate([0, -3.5, z])
                rotate([0, 90, 90])
                    cable_tie(cable_r = 3, thickness = 4.5);*/

    wiringGuidePosition()
        explode(20, true)
            translate_z(wireRadius) {
                stl_colour(pp2_colour)
                    Wiring_Guide_Clamp_stl();
                Wiring_Guide_Clamp_hardware();
            }
}

module psuAssembly(psuVertical, useMounts=false) {
    PSUPosition(psuVertical)
        explode(80)
            PSU();

    *if (psuVertical)
        PSU_Cover_assembly();
    if (psuVertical) {
        if (useMounts) {
            PSU_Upper_Mount_assembly();
            PSU_Lower_Mount_assembly();
        } else {
            hidden() PSU_Lower_Mount_stl();
            hidden() PSU_Upper_Mount_stl();
        }
    } else {
        if (useMounts) {
            PSU_Left_Mount_assembly();
            PSU_Right_Mount_assembly();
        } else {
            hidden() PSU_Left_Mount_stl();
            hidden() PSU_Right_Mount_stl();
        }
    }
}

/*
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
assembly("Partition", ngb=true) {
    size = partitionSize();

    translate([0, eY + 2*eSize - 59, 0])
        rotate([90, 0, 0])
            translate([size.x/2, size.y/2, -size.z/2])
                render_2D_sheet(PC3, w=size.x, d=size.y)
                    Partition_dxf();
}

module partitionCutouts(cncSides) {
    size = partitionSize();

    translate([-size.x/2, -size.y/2]) {
        square([eSize, 2*eSize]);
        translate([0, _upperZRodMountsExtrusionOffsetZ - eSize])
            square([eSize, 2*eSize]);
        translate([eX + eSize, 0])
            square([eSize, 2*eSize]);
        translate([eX + eSize, spoolHeight() - eSize])
            square([eSize, 2*eSize]);
        leftTop = [245, coreXYSeparation().z];
        translate([0, size.y - leftTop.y])
            square(leftTop);
        centerTopOffsetX = 86;
        centerTop = [leftTop.x - centerTopOffsetX, 40];
        translate([centerTopOffsetX, size.y - centerTop.y])
            square(centerTop);
    }
}
*/
