include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <NopSCADlib/vitamins/iec.scad>

use <extruderBracket.scad> // for spoolHeight()

include <../vitamins/bolts.scad>
use <../vitamins/iec320c14.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


function iecHousingSize() = [70, 50, 42 + 3];
//function iecHousingMountSize() = [iecHousingSize().x + eSize, iecHousingSize().y + 2*eSize, 3];
//function iecHousingMountSize() = [iecHousingSize().x + eSize, spoolHeight() + (eX < 350 ? 0 : eSize), 3];
function iecHousingMountSize() = [iecHousingSize().x + eSize, iecHousingSize().y + 2*eSize, 3];
function iecCutoutSize() = [50, 27.5];
function iecType() = iec320c14FusedSwitchedType();

module IEC_Housing_stl() {
    size = iecHousingSize();
    fillet = 2;
    cutoutSize = [size.x - 10, 27.5];
    baseThickness = 3;

    stl("IEC_Housing")
        color(pp2_colour) {
            triangleSize = [8, 7];
            difference() {
                rounded_cube_xy([size.x, size.y, baseThickness], fillet);
                translate([size.x + eps, -eps, -eps])
                    rotate(90)
                        right_triangle(triangleSize.x + 2*eps, triangleSize.y + 2*eps, baseThickness + 2*eps, center = false);
            }
            translate([size.x/2, size.y/2, baseThickness])
                difference() {
                    linear_extrude(size.z - baseThickness, convexity=8)
                        difference() {
                            rounded_square([size.x, size.y], fillet);
                            rounded_square(cutoutSize, 1);
                            translate([size.x/2, -size.y/2])
                                rotate(90)
                                    right_triangle(triangleSize.x, triangleSize.y, 0);
                        }
                    rotate(90)
                        translate_z(size.z)
                            iec_screw_positions(iecType())
                                vflip()
                                    boltHoleM4Tap(10);
                    cableCutoutSize = [8, (size.y-cutoutSize.y)/2 + 2*eps, 8];
                    translate([size.x/2 - 12 - cableCutoutSize.x/2, -size.y/2 - eps, -eps])
                        cube(cableCutoutSize);
                }
            lugFillet = 1;
            lugSize = [size.x, 10 + fillet + lugFillet, 5];
            translate([0, size.y - fillet - lugFillet, size.z - lugSize.z])
                difference() {
                    hull() {
                        rounded_cube_xy(lugSize, lugFillet);
                        translate_z(-lugSize.y)
                            cube([lugSize.x, eps, eps]);
                    }
                    for (x = [5, size.x - 35])
                        translate([x, lugSize.y/2 + (fillet + lugFillet)/2, -2])
                            boltHoleM4Tap(lugSize.z + 2);
                }
        }
}

module IEC_housing_hardware() {
    iecHousingSize = iecHousingSize();
    sidePanelSizeZ = 3;

    translate([iecHousingSize.x/2, iecHousingSize.y/2, iecHousingSize.z + sidePanelSizeZ +2*eps])
        rotate(-90) {
            iec320c14FusedSwitched();
            translate_z(3)
                iec_screw_positions(iecType())
                    boltM4Buttonhead(12);
        }
}

module iecHousing() {
    iecHousingSize = iecHousingSize();
    sidePanelSizeZ = 3;

    explode([-30, 0, 0])
        translate([-iecHousingSize.z, -iecHousingSize().x, 0])
            rotate([90, 0, 90])
                stl_colour(pp2_colour)
                    IEC_Housing_stl();
    explode([40, 0, 0], true)
        translate([sidePanelSizeZ + 2*eps, -iecHousingSize.x/2, iecHousingSize.y/2])
            rotate([0, 90, 0]) {
                iec320c14FusedSwitched();
                iec_screw_positions(iecType())
                    translate_z(sidePanelSizeZ)
                        boltM4Buttonhead(12);
            }
}

module iecHousingMountAttachmentHolePositions(z=0) {
    size = iecHousingMountSize();

    translate([0, -2*eSize, z]) {
        for (x = [eSize/2, size.x - 3*eSize/2])
            translate([x, eSize/2, 0])
                children();
        for (y = [eSize, size.y - eSize/2])
            translate([size.x - eSize/2, y, 0])
                children();
        if (size.y >= spoolHeight())
            translate([eSize/2, size.y - eSize/2])
                children();
    }
}

module IEC_Housing_Mount_stl() {
    size = iecHousingMountSize();
    iecHousingSize = iecHousingSize();
    iecCutoutSize = [iecCutoutSize().x, iecCutoutSize().y, size.z + 2*eps];
    fillet = 3;

    stl("IEC_Housing_Mount")
        color(pp1_colour)
            difference() {
                translate([0, -2*eSize, 0])
                    rounded_cube_xy(size, fillet);

                if (size.y >= spoolHeight()) {
                    // cutout to access TF card
                    tfCutoutSize = [40, 50, size.z + 2*eps];
                    translate([size.x - eSize - tfCutoutSize.x, size.y -3*eSize - tfCutoutSize.y, -eps])
                        rounded_cube_xy(tfCutoutSize, 2);
                }
                translate([iecHousingSize.x/2 - iecCutoutSize.x/2, iecHousingSize.y/2 - iecCutoutSize.y/2, -eps])
                    rounded_cube_xy(iecCutoutSize, fillet);
                translate([iecHousingSize.x/2, iecHousingSize.y/2, 0])
                    rotate(90)
                        iec_screw_positions(iecType())
                            boltHoleM4Tap(size.z);
                iecHousingMountAttachmentHolePositions()
                    boltHoleM4(size.z);
                // access holes
                for (y = [eSize/2, 3*eSize/2])
                    translate([size.x - eSize/2, y - 2*eSize, 0])
                        boltHole(5, size.z);
            }
}

module IEC_Housing_Mount_hardware() {

    iecHousingMountAttachmentHolePositions(iecHousingMountSize().z)
        boltM4ButtonheadHammerNut(_sideBoltLength, rotate=90);
/*    iecHousingSize = iecHousingSize();
    size = [iecHousingSize.x + eSize, iecHousingSize.y + 2*eSize, 3];

    translate([0, -2*eSize,0]) {
        // attachment holes
        for (x = [eSize/2, size.x - 3*eSize/2])
            translate([x, eSize/2, size.z])
                boltM4ButtonheadTNut(_sideBoltLength);
        for (y = [eSize, size.x - eSize/2])
            translate([size.x - eSize/2, y, size.z])
                boltM4ButtonheadHammerNut(_sideBoltLength, rotate=90);
    }
*/
}

//!1. Attach the power cables to the IEC connector.
//!2. Thread the power cables through the hole in the **IEC_Housing** and bolt the **IEC_Housing_Mount** to the **IEC_housing**.
//!3. Add the bolts and t-nuts in preparation for attachment to the frame.
//
module IEC_Housing_assembly()
assembly("IEC_Housing", ngb=true) {

    translate([0, -iecHousingSize().x, 0])
        rotate([90, 0, 90]) {
            stl_colour(pp1_colour)
                IEC_Housing_Mount_stl();
            IEC_Housing_Mount_hardware();
        }

    translate([-iecHousingSize().z, -iecHousingSize().x, 0])
        rotate([90, 0, 90]) {
            explode(-30)
                stl_colour(pp2_colour)
                    IEC_Housing_stl();
            explode(30, true)
                IEC_housing_hardware();
        }
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
