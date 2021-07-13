include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/core_xy.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../vitamins/bolts.scad>

X_Carriage_Belt_Tensioner_size = [21, 10, 7.2];


toothHeight = 0.75;
function xCarriageBeltAttachmentSizeX() = 24;
xCarriageBeltClampHoleSeparation = 12;

module GT2Teeth(sizeZ, n, horizontal=false) {
    fillet = 0.35;
    size = [1, toothHeight];
    linear_extrude(sizeZ)
        for (x = [0 : 2 : 2*n])
            translate([x, 0]) {
                rotate(90)
                    fillet(fillet);
                translate([size.x, 0])
                    fillet(fillet);
                difference() {
                    square(size);
                    if (!horizontal) {
                        translate([0, size.y])
                            rotate(270)
                                fillet(fillet);
                        translate([size.x, size.y])
                            rotate(180)
                                fillet(fillet);
                    }
                }
            }
}

module X_Carriage_Belt_Tensioner_stl() {
    size = X_Carriage_Belt_Tensioner_size;
    fillet = 1;
    offsetX = 4;
    toothOffsetX = 2+3.93125;
    offsetY = 4.5;
    offsetY2 = 2.5;

    stl("X_Carriage_Belt_Tensioner")
        color(pp2_colour)
            difference() {
                union() {
                    rounded_cube_xy([size.x, size.y, 1], fillet);
                    translate([offsetX, 0, 0])
                        rounded_cube_xy([size.x - offsetX, 2.83118, size.z], fillet);
                    //translate([toothOffsetX, 2.83118, 0])
                    translate([toothOffsetX, offsetY, 0])
                        mirror([0, 1, 0])
                            GT2Teeth(size.z, floor((size.x - 10)/2));
                    translate([0, offsetY, 0])
                        rounded_cube_xy([size.x, size.y - offsetY, size.z], fillet);
                    translate([0, offsetY2, 0])
                        rounded_cube_xy([2.5, size.y - offsetY2, size.z], 0.5);
                    translate([2.5, offsetY, 0])
                        rotate(270)
                            fillet(fillet, size.z);
                    endSizeX = 4.5;
                    translate([size.x - endSizeX, 0, 0])
                        rounded_cube_xy([endSizeX, size.y, size.z], fillet);
                }
                //translate([0, 4.35, size.z/2])
                threadLength = 8;
                translate([0, (size.y + offsetY)/2, size.z/2])
                    rotate([90, 0, 90])
                        boltHoleM3Tap(threadLength, horizontal=true);
                translate([size.x, (size.y + offsetY)/2, size.z/2])
                    rotate([90, 0, -90])
                        boltHoleM3(size.x - threadLength, horizontal=true, chamfer_both_ends=false);
                translate([0, -eps, -eps])
                    rotate([90, 0, 90])
                        right_triangle(fillet, fillet, size.x + 2*eps, center=false);
                translate([size.x, -eps, size.z + eps])
                    rotate([-90, 0, 90])
                        right_triangle(fillet, fillet, size.x + 2*eps, center=false);
            }
}

module X_Carriage_Belt_Tensioner_hardware() {
    size = X_Carriage_Belt_Tensioner_size;
    offsetY = 4.5;
    translate([41, (size.y + offsetY)/2, size.z/2])
        rotate([90, 0, 90])
            boltM3Caphead(40);
}

module xCarriageBeltAttachment(sizeZ) {
    size = [xCarriageBeltAttachmentSizeX(), 18 - toothHeight, sizeZ];

    difference() {
        union() {
            rotate([-90, 180, 0])
                linear_extrude(size.z)
                    difference() {
                        square([size.x, size.y]);
                        for (y = [0, 9.25])
                            translate([y + 0.5, 0.5])
                                hull(){
                                    square([7.35, 9.25]);
                                    translate([1, 0])
                                        square([5.35, 10.25]);
                                }
                    }
            translate([0, size.z - 0.5, size.y])
                rotate([90, 0, -90])
                    GT2Teeth(8*2+2.5, 21, horizontal=true);
            translate([-size.x, 0, size.y])
                cube([xCarriageBeltAttachmentSizeX() - 18, size.z, toothHeight]);
            translate([-8.8 - 3/2, 0, size.y])
                cube([3, size.z, toothHeight]);
            translate([-9, 0, 0])
                cube([9, 5, 12]);
            translate([-18.5, size.z - 5, 0])
                cube([9, 5, 12]);
        }
        for (x = [0, -xCarriageBeltClampHoleSeparation], y = [3*size.z/10, 7*size.z/10])
            translate([x - 8.8, y, size.y + toothHeight])
                vflip()
                    boltHoleM3Tap(6);
        translate([-4.2, 0, 3.3])
            rotate([-90, 180, 0])
                boltHoleM3(5, horizontal=true);
        translate([-4.2 - 9.2, size.z, 3.3])
            rotate([90, 0, 0])
                boltHoleM3(5, horizontal=true);
    }
}
module X_Carriage_Belt_Clamp_stl() {
    size = [xCarriageBeltAttachmentSizeX() - 0.5, 8, 4.5];
    fillet = 1;

    stl("X_Carriage_Belt_Clamp")
        color(pp2_colour)
            translate([0, -size.y/2, 0])
                difference() {
                    rounded_cube_xy(size, fillet);
                    for (x = [0, xCarriageBeltClampHoleSeparation])
                        translate([x + 3.2, size.y/2, 0])
                            boltHoleM3(size.z, twist=4);
                }
}

module X_Carriage_Belt_Clamp_hardware() {
    size = [xCarriageBeltAttachmentSizeX() - 0.5, 6, 4.5];

    for (x = [0, xCarriageBeltClampHoleSeparation])
        translate([x + 3.2, 0, size.z])
            boltM3Buttonhead(10);
}

module xCarriageBeltAttachmentTest_stl() {
    stl("xCarriageBeltAttachmentTest")
        xCarriageBeltAttachment(44.1);
}

module xCarriageFrontBeltAttachment(xCarriageType, beltWidth, beltOffsetZ, coreXYSeparationZ) {
    assert(is_list(xCarriageType));

    size = xCarriageFrontSize(xCarriageType, beltWidth);
}
