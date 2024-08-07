include <config/global_defs.scad>

include <NopSCADlib/utils/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>
include <NopSCADlib/vitamins/psus.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../utils/PSU.scad>

include <Parameters_CoreXY.scad>


module psuLowerMount(size, psuType, counterSunk, offsetX=0) {
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
                                poly_circle(r=M4_clearance_radius);
                        *for (y = [3*eSize/2, 2*eSize + 5, size.y - 8])
                            translate([eSize/2, y])
                                poly_circle(r=M4_clearance_radius);
                        backPanelAccessHolePositions(backPanelSize())
                            poly_circle(r=accessHoleRadius);
                        if (counterSunk) {
                            backPanelBoltHolePositions(backPanelSize())
                                poly_circle(r=M4_clearance_radius);
                        } else {
                            translate([backPanelSize().x/2, backPanelSize().y/2])
                                backPanelCutouts(psuType, pcbType());
                            translate([eSize/2, size.y - eSize/2])
                                poly_circle(r=M4_clearance_radius);
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
                            PSUPosition(psuType, psuVertical)
                                PSUBoltPositions(psuType)
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
            psuLowerMount(size, PSUType(), counterSunk);
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
                                        poly_circle(r=M4_clearance_radius);
                                *for (y = [3*eSize/2, 2*eSize + 5, size.y - 8])
                                    translate([eSize/2, y])
                                        poly_circle(r=M4_clearance_radius);
                                backPanelAccessHolePositions(backPanelSize())
                                    poly_circle(r=accessHoleRadius);
                                if (counterSunk) {
                                    backPanelBoltHolePositions(backPanelSize())
                                        poly_circle(r=M4_clearance_radius);
                                } else {
                                    translate([backPanelSize().x/2, backPanelSize().y/2])
                                        backPanelCutouts(PSUType(), pcbType());
                                    translate([eSize/2, size.y - eSize/2])
                                        poly_circle(r=M4_clearance_radius);
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
                                                poly_circle(r=M4_clearance_radius);
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
                                    PSUBoltPositions(PSUType())
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
            psuLowerMount(size, PSUType(), counterSunk);
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
            psuLowerMount(size, PSUType(), counterSunk, 202.5 - size.x/2);
}

module PSU_Right_Mount_assembly()
assembly("PSU_Right_Mount", ngb=true) {

    translate([0, eY + 2*eSize + 2*eps, 0])
        rotate([-90, 0, 0])
            stl_colour(pp2_colour)
                PSU_Right_Mount_stl();
}

/*
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
                                            poly_circle(r=M4_clearance_radius);
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
                        PSUPosition(PSUType(), psuVertical) {
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
