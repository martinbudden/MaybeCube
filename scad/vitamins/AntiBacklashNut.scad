include <NopSCADlib/utils/core/core.scad>

include <bolts.scad>
use <nuts.scad>

function antiBacklashNutSize() = [34, 33, 12];
function antiBacklashNutBoltSeparation() = 20;

boltOffsetX = 10;
hexCutoutDepth = 5;

module antiBacklashNut() {
    size = [34, 33, 12];
    nutHoleOffset = 33 / 2 - 7.5;
    slotOffset = 6;

    translate([0, -size.z / 2, -nutHoleOffset])
        rotate([90, 0, 180]) {
            color(grey(20))
                //render(convexity = 2)
                    difference() {
                        linear_extrude(size.z, convexity = 2)
                            difference() {
                                rounded_square([size.x, size.y], 2);
                                for (x = [boltOffsetX, -boltOffsetX])
                                    translate([x, nutHoleOffset])
                                        circle(r = M5_clearance_radius);
                                translate([5, -size.y / 2 + slotOffset])
                                    rounded_square([28, 5], 2);
                            }
                        translate_z(size.z / 2) {
                            rotate([90, 0, 0])
                                cylinder(d = 8, h = size.y + eps, center = true);
                            translate([boltOffsetX, -size.y / 2 + slotOffset, 0])
                                rotate([90, 0, 0])
                                    cylinder(r = M4_tap_radius, h = slotOffset + eps, center = false);
                        }
                        for (x = [boltOffsetX, -boltOffsetX])
                            translate([x, nutHoleOffset, 0])
                                cylinder(d = 9, h = hexCutoutDepth, $fn = 6);
                    }
            translate([boltOffsetX, -size.x / 2 - 3, size.z / 2])
                rotate([90, 0, 0])
                    not_on_bom() no_explode()
                        screw(M4_grub_screw, 12);
        }
}

module antiBacklashNutBoltPositions() {
    for (x = [boltOffsetX, -boltOffsetX])
        translate([x, -1, 0])
            rotate([90, 0, 0])
                children();
}

/*
module antiBacklashNut_assembly()
assembly("antiBacklashNut") {
    size = antiBacklashNutSize();
    antiBacklashNut();
    boltLength = 10;
    for (x=[boltOffsetX, -boltOffsetX])
        translate([x, antiBacklashNutHoleOffset(), 0])
            boltM4ButtonheadTNut(boltLength);
}

module antiBacklashNutSpacer() {
    size = antiBacklashNutSpacerSize();
    color(pp1_colour) difference() {
        filletedYCube(size, 1);
        epsilon = 1/128;
        translate([boltOffsetX, 0, size.z-extrusionSize/2]) rotate([-90, 0, 0]) boltHoleM4(size.y);
        translate([size.x-boltOffsetX, 0, size.z-extrusionSize/2]) rotate([-90, 0, 0]) boltHoleM4(size.y);
    }
}
function antiBacklashNutSpacerSize() = [antiBacklashNutSize().x, antiBacklashNutSize().y-antiBacklashNutHoleOffset()*2, antiBacklashNutSize().z];

module antiBacklashSpacer(sizeZ=3.6) {
    size = [34, 33, sizeZ];
    difference() {
        rounded_cube_xy(size, 3.04);
        translate([(size.x-20)/2, 10, 0]) boltHoleM4(sizeZ);
        translate([(size.x + 20)/2, 10, 0]) boltHoleM4(sizeZ);
    }
}
*/
