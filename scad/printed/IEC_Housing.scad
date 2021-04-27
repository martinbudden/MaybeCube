include <../global_defs.scad>

include <NopSCADlib/core.scad>

use <NopSCADlib/vitamins/iec.scad>

include <../Parameters_Main.scad>

use <../vitamins/bolts.scad>
use <../vitamins/iec320c14.scad>


function iecHousingSize() = [70, 50, 42 + 3];
function iecCutoutSize() = [50, 27.5];
function iecType() = iec320c14FusedSwitchedType();

module IEC_Housing_stl() {
    size = iecHousingSize();
    fillet = 2;
    cutoutSize = [size.x - 10, 27.5];
    iec = iec320c14FusedSwitchedType();
    baseThickness = 3;

    stl("IEC_Housing")
        color(pp1_colour) {
            triangleSize = [8, 7];
            difference() {
                rounded_cube_xy([size.x, size.y, baseThickness], fillet);
                translate([size.x + eps, -eps, -eps])
                    rotate(90)
                        right_triangle(triangleSize.x + 2*eps, triangleSize.y + 2*eps, baseThickness + 2*eps, center = false);
            }
            translate([size.x/2, size.y/2, baseThickness])
                render() difference() {
                    linear_extrude(size.z - baseThickness)
                        difference() {
                            rounded_square([size.x, size.y], fillet);
                            rounded_square(cutoutSize, 1);
                            translate([size.x/2, -size.y/2])
                                rotate(90)
                                    right_triangle(triangleSize.x, triangleSize.y, 0);
                        }
                    rotate(90)
                        translate_z(size.z)
                            iec_screw_positions(iec)
                                vflip()
                                    boltHoleM4Tap(10);
                    cableCutoutSize = [8, (size.y-cutoutSize.y)/2 + 2*eps, 8];
                    translate([size.x/2 - 12 - cableCutoutSize.x/2, -size.y/2 - eps, -eps])
                        cube(cableCutoutSize);
                }
        }
}

module IEC_assembly()
assembly("IEC", ngb=true) {
    iec = iec320c14FusedSwitchedType();
    iecHousingSize = iecHousingSize();
    sidePanelSizeZ = 3;

    stl_colour(pp1_colour)
        translate([eX + 2*eSize - iecHousingSize.z, eY + eSize - iecHousingSize.x, 2*eSize])
            rotate([90, 0, 90])
                IEC_Housing_stl();
    translate([eX + 2*eSize + sidePanelSizeZ + 2*eps, eY + eSize - iecHousingSize.x/2, 2*eSize + iecHousingSize.y/2])
        rotate([0, 90, 0]) {
            iec320c14FusedSwitched();
                iec_screw_positions(iec)
                    translate_z(sidePanelSizeZ)
                        boltM4Buttonhead(12);
        }
}

module IEC_Housing_Mount_stl() {
    iecHousingSize = iecHousingSize();
    size = [iecHousingSize.x + eSize, iecHousingSize.y + 2*eSize, 3];
    fillet = 2;
    cutoutSize = [iecCutoutSize().x, iecCutoutSize().y, size.z + 2*eps];

    stl("IEC_Housing_Mount")
        color(pp2_colour) {
            difference() {
                translate([0, iecHousingSize.y - size.y, 0])
                    rounded_cube_xy(size, fillet);
                translate([iecHousingSize.x/2 - cutoutSize.x/2, iecHousingSize.y/2 - cutoutSize.y/2, -eps])
                    rounded_cube_xy(cutoutSize, fillet);
                translate([iecHousingSize.x/2, iecHousingSize.y/2, 0])
                    rotate(90)
                        iec_screw_positions(iecType())
                            boltHoleM4Tap(size.z);
                translate([0, iecHousingSize.y - size.y,0]) {
                    // attachment holes
                    for (x = [eSize/2, size.x - 3*eSize/2])
                        translate([x, eSize/2, 0])
                            boltHoleM4(size.z);
                    for (y = [eSize, size.x - eSize/2])
                        translate([size.x - eSize/2, y, 0])
                            boltHoleM4(size.z);
                    // access holes
                    for (y = [eSize/2, 3*eSize/2])
                        translate([size.x - eSize/2, y, 0])
                            boltHoleM4(size.z);
                }
            }
        }
}

module IEC_Housing_Mount_assembly()
assembly("IEC_Housing_Mount") {

    stl_colour(pp2_colour)
        translate([eX + 2*eSize, eY + eSize - iecHousingSize().x, 2*eSize])
            rotate([90, 0, 90])
                IEC_Housing_Mount_stl();
}

/*
module IEC320_C14_Cutout() {
    // snap-in 3 pin fused Power Socket Connector with Rocker Switch
    // position given by center
    square([50, 27.5], center=true);
}
function IEC320_C14_CutoutSize() = [50, 27.5];

module IEC320_C14_CutoutWithBoltHoles(boltHoleSpacing) {
    // bolt-in 3 pin fused Power Socket Connector with Rocker Switch
    // position given by center
    size = [48.4, 27.2];
    translate(-size/2) rounded_square(size, 1);
    translate([0, -boltHoleSpacing/2, 0]) circle(r=M4_tap_radius);
    translate([0, boltHoleSpacing/2, 0]) circle(r=M4_tap_radius);
}
*/
