include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/e3d.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../printed/X_CarriageEVA.scad>
use <../printed/PrintheadAssemblies.scad>
use <../printed/X_CarriageAssemblies.scad>

use <../utils/carriageTypes.scad>
use <../utils/CoreXYBelts.scad>
use <../utils/X_Rail.scad>

use <../vitamins/bolts.scad>

use <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>
include <../Parameters_Main.scad>

function evaColorGrey() = grey(25);
function evaColorGreen() = "LimeGreen";
function X_CarriageEVATensionerOffsetX() = 1;

X_Carriage_Belt_Tensioner_size = [25, 10, 7.2];


module X_Carriage_EVA_Top_stl() {
    size = [44.1, 27, 8];
    carriageType = MGN12H_carriage;

    stl("X_Carriage_EVA_Top")
        color(evaColorGrey())
            difference() {
                rounded_cube_xy(size, 1, xy_center=true);
                translate_z(size.z - carriage_height(carriageType))
                    carriage_hole_positions(carriageType)
                        vflip()
                            boltHoleM3Counterbore(8, twist=4);
                for (x = [-size.x/2 + 5, size.x/2 -5])
                    translate([x, size.y/2, 3])
                            rotate([90, 0, 0])
                                boltHoleM3(size.y, horizontal=true);
                fillet = 1 + eps;
                translate([-size.x/2 - eps, 0, size.z + eps])
                    rotate([90, 90, 0])
                        right_triangle(fillet, fillet, size.y + 2*eps, center=true);
                translate([size.x/2 + eps, 0, size.z + eps])
                    rotate([90, 180, 0])
                        right_triangle(fillet, fillet, size.y + 2*eps, center=true);
            }
}

toothHeight = 0.75;

module teeth(sizeZ, n, horizontal=false) {
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
                            teeth(size.z, 7);
                    translate([0, offsetY, 0])
                        rounded_cube_xy([size.x, size.y - offsetY, size.z], fillet);
                    translate([0, offsetY2, 0])
                        rounded_cube_xy([2.5, size.y - offsetY2, size.z], 0.5);
                    translate([2.5, offsetY, 0])
                        rotate(270)
                            fillet(fillet, size.z);
                    translate([size.x - 5, 0, 0])
                        rounded_cube_xy([5, size.y, size.z], fillet);
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
    translate([size.x + 15 + X_CarriageEVATensionerOffsetX(), (size.y + offsetY)/2, size.z/2])
        rotate([90, 0, 90])
            boltM3Caphead(40);
}

module X_Carriage_EVA_Bottom_stl() {
    size = [8.2, 44.1, 27];
    tabSizeZ = 3;
    fillet = 0;
    offsetY = 4.5;
    carriageType = MGN12H_carriage;

    stl("X_Carriage_EVA_Bottom")
        color(evaColorGrey()) {
            difference() {
                union() {
                    rounded_cube_xy(size, fillet);
                    translate([size.x + 10, size.y/2, 0])
                        rounded_cube_xy([8, 38, tabSizeZ], 4 - eps, xy_center=true);
                    translate([0, 10, 0]) {
                        cube([20, size.y - 20, tabSizeZ]);
                        translate([size.x, 0, 0])
                            rotate(270)
                                fillet(2, tabSizeZ);
                        translate([size.x + 6, 0, 0])
                            rotate(180)
                                fillet(2, tabSizeZ);
                        translate([size.x, size.y - 20, 0])
                            fillet(2, tabSizeZ);
                        translate([size.x + 6, size.y - 20, 0])
                            rotate(90)
                                fillet(2, tabSizeZ);
                    }
                }
                translate([15.4, size.y/2, -eps])
                    rounded_cube_xy([10.6, 20, tabSizeZ + 2*eps], 1.5, xy_center=true);
                translate([size.x + eps, -eps, -eps])
                    rotate(90)
                        right_triangle(2, 2, size.z + 2*eps, center=false);
                translate([size.x + eps, size.y + eps, -eps])
                    rotate(180)
                        right_triangle(2, 2, size.z + 2*eps, center=false);
                for (y = [9, size.y - 9])
                    translate([size.x - 4, y, 0])
                        boltHoleM3(size.z, twist=4);
                for (y = [7, size.y - 7])
                    translate([size.x + 10, y, 0])
                        boltHoleM3(tabSizeZ, twist=4);
            }
            cSize1 = [23, 18 - toothHeight, size.y];
            difference() {
                union() {
                    rotate([-90, 180, 0])
                        linear_extrude(cSize1.z)
                            difference() {
                                square([cSize1.x, cSize1.y]);
                                for (y = [0, 9.25])
                                    translate([y + 0.5, 0.5])
                                        hull(){
                                            square([7.35, 9.25]);
                                            translate([1, 0])
                                                square([5.35, 10.25]);
                                        }
                            }
                    translate([0, size.y - 0.5, cSize1.y])
                        rotate([90, 0, -90])
                            teeth(8*2+2, 21, horizontal=true);
                    translate([-cSize1.x, 0, cSize1.y])
                        cube([5, cSize1.z, toothHeight]);
                    translate([-8.8 - 3/2, 0, cSize1.y])
                        cube([3, cSize1.z, toothHeight]);
                    translate([-9, 0, 0])
                        cube([9, 5, 12]);
                    translate([-18.5, size.y-5, 0])
                        cube([9, 5, 12]);
                }
                for (x = [0, -11], y = [3*size.y/10, 7*size.y/10])
                    translate([x - 8.8, y, cSize1.y + toothHeight])
                        vflip()
                            boltHoleM3Tap(6);
                translate([-4.2, 0, 3.3])
                    rotate([-90, 180, 0])
                        boltHoleM3(5, horizontal=true);
                translate([-4.2 - 9.2, size.y, 3.3])
                    rotate([90, 0, 0])
                        boltHoleM3(5, horizontal=true);
            }
        }
}

module evaHotendBase() {
    translate_z(2*eps)
        X_Carriage_EVA_Top_stl();
    translate([-22.1, 13.5, -40.8])
        rotate([90, 90, 0])
            X_Carriage_EVA_Bottom_stl();
    evaTensioners();
}

module evaTensioners(color=pp2_colour) {
    translate([-18 - X_CarriageEVATensionerOffsetX(), 2.95, -31]) {
       X_Carriage_Belt_Tensioner_stl();
       X_Carriage_Belt_Tensioner_hardware();
    }
    translate([18 + X_CarriageEVATensionerOffsetX(), 2.95, -33])
        rotate([0, -180, 0]) {
            X_Carriage_Belt_Tensioner_stl();
            X_Carriage_Belt_Tensioner_hardware();
        }
}
