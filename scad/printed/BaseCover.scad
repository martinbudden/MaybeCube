include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/fans.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <extruderBracket.scad> // for iecHousingMountSize()

include <../Parameters_Main.scad>

supportHeight = 70;
baseCoverTopSize = [eX > 300 ? 260 : 210, eY + eSize, 3];
baseCoverBackSupportSize = [baseCoverTopSize.x, eSize, supportHeight - 2*eSize];
baseCoverSideSupportSize = [8, eY/2, supportHeight];
baseCoverFrontSupportSize = [baseCoverTopSize.x - baseCoverSideSupportSize.x, 12, 3*eSize/2];

module Base_Cover_Back_Support_stl() {
    stl("Base_Cover_Back_Support")
        color(pp1_colour) {
            size = baseCoverBackSupportSize;
            difference() {
                rounded_cube_xy(baseCoverBackSupportSize, 2);
                for (x = [10, size.x/2, size.x - 10])
                    translate([x, size.y/2, size.z])
                        vflip()
                            boltHoleM3(10);
                for (x = [size.x/4, 3*size.x/4])
                    translate([x, size.y/2, size.z])
                        vflip()
                            boltHoleM3Counterbore(size.z, boreDepth = size.z - 5);
            }
        }
}

module Base_Cover_Back_Support_hardware() {
    size = baseCoverBackSupportSize;
    for (x = [size.x/4, 3*size.x/4])
        translate([x, size.y/2, 5])
            explode(30, true)
                boltM3ButtonheadHammerNut(8, nutExplode=50);
}

module Base_Cover_Front_Support_stl() {
    stl("Base_Cover_Front_Support")
        color(pp2_colour) {
            size = baseCoverFrontSupportSize;
            difference() {
                rounded_cube_xy([size.x, size.z, 3], 1);
                for (x = [10, size.x/2, size.x - 10])
                    translate([x, 20, 0])
                        boltHoleM3(3);
            }
            difference() {
                rounded_cube_xy([size.x, 5, size.y], 1);
                for (x = [10, size.x/2, size.x - 10])
                    translate([x, 0, 7.5])
                        rotate([-90, 180, 0])
                            boltHoleM3(5, horizontal=true);
            }
        }
}

module Base_Cover_Front_Support_hardware() {
    size = baseCoverFrontSupportSize;
    for (x = [10, size.x/2, size.x - 10])
        translate([x, 20, 3])
            explode(30, true)
                boltM3ButtonheadHammerNut(8, nutExplode=40);
}

module baseCoverSideSupport(tap=false) {
    size = baseCoverSideSupportSize;
    overlap = 5;
    difference() {
        union() {
            rounded_cube_xy([size.z, size.y + overlap, size.x/2], 1);
            rounded_cube_xy([size.z, size.y - overlap, size.x], 1);
        }
        for (y = [size.y/4, 3*size.y/4]) {
            translate([0, y, size.x/2])
                rotate([0, 90, 0])
                    boltHoleM3Tap(10, horizontal=true, rotate=90, chamfer_both_ends=false);
            translate([size.z, y, size.x/2])
                rotate([0, -90, 0])
                    boltHoleM3Tap(10, horizontal=true, rotate=-90, chamfer_both_ends=false);
        }
        for (x = [size.z/4, 3*size.z/4])
            translate([x, size.y, 0])
                if (tap)
                    boltHoleM3Tap(size.x/2);
                else
                    boltHoleM3(size.x/2);
    }
}

module Base_Cover_Side_Support_1_stl() {
    stl("Base_Cover_Side_Support_1")
        color(pp1_colour)
            baseCoverSideSupport(tap=false);
}

module Base_Cover_Side_Support_2_stl() {
    stl("Base_Cover_Side_Support_2")
        color(pp2_colour)
            baseCoverSideSupport(tap=true);
}

module Base_Cover_Top_stl() {
    stl("Base_Cover_Top")
        color(pp3_colour)
            rounded_cube_xy(baseCoverTopSize, 2);
}

BaseCover = ["BaseCover", "Sheet perspex", 3, pp3_colour, false];

module baseCoverTopHolePositions(size) {
    xFront = baseCoverFrontSupportSize.x;
    for (x = [10, xFront/2, xFront - 10])
        translate([x - size.x/2 + baseCoverSideSupportSize.x, 8 - size.y/2, 0])
            children();
    yLeft = baseCoverSideSupportSize.y/4;
    for (y = [yLeft, 3*yLeft, 5*yLeft, 7*yLeft])
        translate([4 -size.x/2, y -size.y/2, 0])
            children();
    xBack = baseCoverBackSupportSize.x;
    for (x = [10, xBack/2, xBack - 10])
        translate([x - size.x/2, size.y/2 - 10, 0])
            children();
}

module baseCoverTopAssembly(addBolts=true) {
    size = baseCoverTopSize;

    translate([eX + eSize - size.x/2, eSize + size.y/2, supportHeight + size.z/2]) {
        if (addBolts)
            baseCoverTopHolePositions(size)
                translate_z(size.z/2)
                    boltM3Buttonhead(8);
        render_2D_sheet(BaseCover, w=size.x, d=size.y)
            Base_Cover_dxf();
    }
}

module Base_Cover_dxf() {
    size = baseCoverTopSize;
    fillet = 1;
    sheet = BaseCover;

    dxf("Base_Cover")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                baseCoverTopHolePositions(size)
                    circle(r=M3_clearance_radius);
            }
}

module baseCoverFrontSupportsAssembly() {
    translate([eX + eSize - baseCoverFrontSupportSize.x, eSize, supportHeight])
        rotate([-90, 0, 0]) {
            color(pp2_colour)
                Base_Cover_Front_Support_stl();
            Base_Cover_Front_Support_hardware();
        }
}

module baseCoverBackSupportsAssembly() {
    translate([eX - baseCoverBackSupportSize.x, 0, 2*eSize]) {
        color(pp1_colour)
            Base_Cover_Back_Support_stl();
        Base_Cover_Back_Support_hardware();
    }
}

module baseCoverSideSupportsAssembly() {
    size = baseCoverSideSupportSize;
    translate([eX + eSize - baseCoverBackSupportSize.x + size.x, eSize, 0])
        rotate([0, -90, 0]) {
            color(pp1_colour)
                Base_Cover_Side_Support_1_stl();
            for (x = [size.z/4, 3*size.z/4])
                translate([x, size.y, 0])
                    vflip()
                        boltM3Buttonhead(size.x);
        }
    translate([eX + eSize - baseCoverBackSupportSize.x, eSize + 2*size.y, 0])
        rotate([180, -90, 0])
            color(pp2_colour)
                Base_Cover_Side_Support_2_stl();
}

module baseCoverTopSupportsAssembly() {
    translate([eX - baseCoverBackSupportSize.x, eSize, supportHeight])
        Base_Cover_Top_stl();
}

module baseCoverSupportsAssembly() {
    baseCoverFrontSupportsAssembly();
    baseCoverBackSupportsAssembly();
    baseCoverSideSupportsAssembly();
}

module baseFanMountHolePositions(size, z=0) {
    for (x = [eSize/2, size.x - eSize/2], y = [eSize/2,  size.y - eSize/2])
        translate([x, y, z])
            rotate(exploded() ? 0 : 90)
                children();

}

module baseFanPosition(size, offsetX=0, z=0) {
    translate([offsetX > 0 ? offsetX : size.x + offsetX, size.y/2 - 2.5, z])
        children();
}

module baseFanMount(sizeX, offsetX=0) {
    size = [sizeX, iecHousingMountSize(eX).y, 3];
    fillet = 2;
    fan = fan40x11;

    difference() {
        rounded_cube_xy(size, fillet);
        baseFanPosition(size, offsetX, size.z/2)
            fan_holes(fan, h=size.z + 2*eps);
        baseFanMountHolePositions(size)
            boltHoleM4(size.z);
    }
}

module Base_Fan_Mount_1_stl() {
    stl("Base_Fan_Mount_1")
        color(pp1_colour)
            baseFanMount((eY + 2*eSize - iecHousingMountSize(eX).x)/2, 50);
}

module Base_Fan_Mount_2_stl() {
    stl("Base_Fan_Mount_2")
        color(pp2_colour)
            baseFanMount((eY + 2*eSize - iecHousingMountSize(eX).x)/2, -40);
}

module baseFanMountAssembly() {
    size = [(eY + 2*eSize - iecHousingMountSize(eX).x)/2, iecHousingMountSize(eX).y, 3];
    fan = fan40x11;

    translate([eX + 2*eSize, 0, 0])
        rotate([90, 0, 90]) 
            explode(50, true) {
                color(pp1_colour)
                    Base_Fan_Mount_1_stl();
                baseFanMountHolePositions(size, size.z)
                    boltM4ButtonheadHammerNut(8);
                baseFanPosition(size, 50, size.z/2 - fan_thickness(fan)) {
                    explode(-15)
                        fan(fan);
                    fan_hole_positions(fan) {
                        translate_z(size.z)
                            boltM3Buttonhead(16);
                        translate_z(-size.z - fan_thickness(fan))
                            explode(-30)
                                nutM3();
                    }
            }
        }
    translate([eX + 2*eSize, (eY + 2*eSize - iecHousingMountSize(eX).x)/2, 0])
        rotate([90, 0, 90])
            explode(50, true) {
                color(pp2_colour)
                    Base_Fan_Mount_2_stl();
                baseFanMountHolePositions(size, size.z)
                    boltM4ButtonheadHammerNut(8);
                baseFanPosition(size, -40, size.z/2 - fan_thickness(fan)) {
                    explode(-15)
                        fan(fan);
                    fan_hole_positions(fan) {
                        translate_z(size.z)
                            boltM3Buttonhead(16);
                        translate_z(-size.z - fan_thickness(fan))
                            explode(-30)
                                nutM3();
                    }
                }
            }
}

