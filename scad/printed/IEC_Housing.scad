include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

use <NopSCADlib/vitamins/iec.scad>
use <NopSCADlib/vitamins/sheet.scad>

use <extruderBracket.scad> // for spoolHeight()

use <../utils/XY_MotorMount.scad> // for xyMotorMountSize().y

include <../vitamins/bolts.scad>
use <../vitamins/iec320c14.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

function partitionOffsetY() = xyMotorMountSize().y;
//function partitionOffsetY() = eX <=300 ? xyMotorMountSize().y : floor((eY + 2*eSize - extruderPosition().y + motorWidth(motorType(_xyMotorDescriptor))/2 + 4));
function partitionSize() = [eX, eZ, 2];
PC2 = ["PC2", "Sheet polycarbonate", 2, [1,   1,   1,   0.25], false];

function iecCutoutSize() = [50, 27.5];
function iecType() = iec320c14FusedSwitchedType();


module IEC_Housing_stl() {
    size = iecHousingSize();
    fillet = 2;
    cutoutSize = [size.x - 10, 27.5];
    baseThickness = 3;

    stl("IEC_Housing")
        color(pp4_colour) {
            triangleSize = [8, 7];
            difference() {
                rounded_cube_xy([size.x, size.y, baseThickness], fillet);
                translate([size.x + eps, -eps, -eps])
                    rotate(90)
                        right_triangle(triangleSize.x + 2*eps, triangleSize.y + 2*eps, baseThickness + 2*eps, center=false);
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
            *translate([0, size.y - fillet - lugFillet, size.z - lugSize.z])
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
                stl_colour(pp4_colour)
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

module iecHousingMountAttachmentHolePositions(z=0, eX=eX) {
    size = iecHousingMountSize();

    translate([0, -2*eSize, z]) {
        for (x = [eSize/2, size.x - 3*eSize/2])
            translate([x, eSize/2, 0])
                children();
        translate([eSize/2, 3*eSize/2, 0])
            children();
        for (x = [eSize/2, 3*eSize/2])
            translate([x, spoolHeight(eX) + eSize/2, 0])
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
    stl("IEC_Housing_Mount")
        color(pp2_colour)
            iceHousingMount(eX=350);
}

module IEC_Housing_Mount_300_stl() {
    stl("IEC_Housing_Mount_300")
        color(pp2_colour)
            iceHousingMount(eX=300);
}

module iceHousingMount(eX) {
    size = iecHousingMountSize();
    iecHousingSize = iecHousingSize();
    iecCutoutSize = [iecCutoutSize().x, iecCutoutSize().y, size.z + 2*eps];
    fillet = 3;
    vflip()
        difference() {
            union() {
                guideWidth = 6;
                partitionTolerance = 0.5;
                translate([0, -2*eSize, 0])
                    rounded_cube_xy(size, fillet);
                size2 = [size.x - partitionOffsetY() + guideWidth/2 - partitionSize().z/2, spoolHeight(eX) - eSize, size.z];
                rounded_cube_xy(size2, fillet);
                translate([size2.x, iecHousingSize.y, 0])
                    fillet(5, size.z);
                size3 = [guideWidth, size2.y - iecHousingSize.y - eSize, eSize];
                translate([size.x - partitionOffsetY() - partitionSize().z/2 - size3.x/2, iecHousingSize.y, -size3.z]) {
                    rounded_cube_xy(size3, 1);
                    size4 = [(size3.x - partitionSize().z - partitionTolerance)/2, size3.y, size3.z + 2];
                    translate_z(size3.z - size4.z)
                        rounded_cube_xy(size4, 0.5);
                    translate([size3.x - size4.x, 0, size3.z - size4.z])
                        rounded_cube_xy(size4, 0.5);
                }
            } // end union

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
                        boltHoleM4(size.z);
            iecHousingMountAttachmentHolePositions(eX=eX)
                boltHoleM4(size.z);
            // access holes
            for (y = [eSize/2, 3*eSize/2])
                translate([size.x - eSize/2, y - 2*eSize, 0])
                    boltHole(5, size.z);
        } // end difference
}

module IEC_Housing_Mount_hardware(eX=eX) {

    iecHousingMountAttachmentHolePositions(iecHousingMountSize().z, eX)
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

    translate([eX + 2*eSize, eY + eSize, 2*eSize]) {
        translate([0, -iecHousingSize().x, 0])
            rotate([90, 0, 90]) {
                stl_colour(pp2_colour)
                    vflip()
                        if (eX==300)
                            IEC_Housing_Mount_300_stl();
                        else
                            IEC_Housing_Mount_stl();
                IEC_Housing_Mount_hardware();
            }

        translate([-iecHousingSize().z, -iecHousingSize().x, 0])
            rotate([90, 0, 90]) {
                explode(-30)
                    stl_colour(pp4_colour)
                        IEC_Housing_stl();
                explode(30, true)
                    IEC_housing_hardware();
            }
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

module Partition_dxf() {
    size = partitionSize();
    fillet = 1;
    sheet = PC2;

    dxf("Partition")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                partitionCutouts(cncSides=0);
            }
}

module partitionCutouts(cncSides) {
    size = partitionSize();

    leftCutoutSize = [size.x - eSize - xyMotorMountSize(left=false).x, xyMotorMountSize(left=true).z - 2.5];
    rightCutoutSize = [eSize + xyMotorMountSize(left=false).x, xyMotorMountSize(left=false).z - 2.5];
    translate([-size.x/2, -size.y/2]) {
        if (!is_undef(_use2060ForTop) && _use2060ForTop)
            translate([0, size.y - eSize]) {
                square([2*eSize, eSize]);
                translate([size.x - 2*eSize, 0])
                    square([2*eSize, eSize]);
            }
        translate([0, size.y - leftCutoutSize.y])
            square(leftCutoutSize);
        translate(size - rightCutoutSize)
            square(rightCutoutSize);
    }
}

module partitionPC() {
    size = partitionSize();

    translate([eSize, eY + 2*eSize - partitionOffsetY() - size.z, 0])
        rotate([90, 0, 0])
            translate([size.x/2, size.y/2, -size.z/2])
                render_2D_sheet(PC2, w=size.x, d=size.y)
                    Partition_dxf();
}

module Partition_assembly()
assembly("Partition", ngb=true) {

    partitionPC();
}
