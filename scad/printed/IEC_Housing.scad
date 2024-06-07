include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

use <NopSCADlib/vitamins/iec.scad>
use <NopSCADlib/vitamins/sheet.scad>

use <extruderBracket.scad> // for spoolHeight()

include <../vitamins/bolts.scad>

use <../vitamins/iec320c14.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

function partitionSize() = [eX, eZ, 2];
PC2 = ["PC2", "Sheet polycarbonate", 2, [1,   1,   1,   0.25], false];

function iecCutoutSize() = [50, 27.5];
function iecType() = iec320c14FusedSwitchedType();

guideWidth = 7;
guideLength = (_upperZRodMountsExtrusionOffsetZ - 3 * eSize)/2;
partitionTolerance = 0.5;

module IEC_Housing_Bevelled_stl() {
    stl("IEC_Housing_Bevelled")
        color(pp4_colour)
            iecHousingStl(bevelled=true);
}

module IEC_Housing_stl() {
    stl("IEC_Housing")
        color(pp4_colour)
            rotate(180) // rotate so rear seam underneath and so hidden when assembled
                translate([iecHousingSize().x, 0, 0])
                    mirror([1, 0, 0])
                        iecHousingStl(bevelled=false, extension=0);
}

module iecHousingStl(bevelled=false, extension=0) {
    size = iecHousingSize();
    fillet = 2;
    cutoutSize = [size.x - 10, 27.5];
    baseThickness = 3;
    blockHeight = size.z - eSize - baseThickness - 5;

    triangleSize = [8, 7];
    difference() {
        translate([0, bevelled ? 0 : -extension, 0])
            rounded_cube_xy([size.x, size.y + (bevelled ? 0 : extension), baseThickness], fillet);
        if (bevelled) {
            translate([size.x + eps, -eps, -eps])
                rotate(90)
                    right_triangle(triangleSize.x + 2*eps, triangleSize.y + 2*eps, baseThickness + 2*eps, center=false);
        } else {
            cableCutoutSize = [10, 10, baseThickness + 2*eps];
            *translate([size.x - cableCutoutSize.x - (size.x - cutoutSize.x)/2, -extension + 5, -eps])
                rounded_cube_xy(cableCutoutSize, fillet);
        }
    }
    translate([size.x/2, size.y/2, baseThickness])
        difference() {
            union() {
                linear_extrude(size.z - baseThickness, convexity=8)
                    difference() {
                        rounded_square([size.x, size.y], fillet);
                        rounded_square(cutoutSize, 1);
                        if (bevelled)
                            translate([size.x/2, -size.y/2])
                                rotate(90)
                                    right_triangle(triangleSize.x, triangleSize.y, 0);
                    }
                if (extension)
                    translate([-size.x/2, -size.y/2 - extension, 0])
                        rounded_cube_xy([size.x, extension + 2*fillet, blockHeight], fillet);
            }

            if (bevelled || extension==0) {
                cableCutoutSize = [11, (size.y-cutoutSize.y)/2 + 2*eps, 9];
                translate([size.x/2 - 12 - cableCutoutSize.x/2, -size.y/2 - eps, -eps])
                    cube(cableCutoutSize);
            } else {
                translate([size.x/2 - eSize - 5, -size.y/2 - extension + 5, -eps])
                    rounded_cube_xy([eSize, extension + 10, blockHeight - 5], fillet);
                translate([size.x/2 - eSize - 5, -cutoutSize.y/2, -eps])
                    rotate(180)
                        fillet(fillet, blockHeight - 5 + 2*eps);
                holeSize = [5, 10, 10];
                translate([size.x/2 - holeSize.x + eps, -size.y/2 - extension + 5, eps]) {
                    translate([-fillet, 0, 0])
                        cube(holeSize + [fillet, 0, 0]);
                    translate([0, holeSize.y, 0])
                        fillet(fillet, holeSize.z);
                    translate([holeSize.x, holeSize.y, 0])
                        rotate(90)
                            fillet(fillet, holeSize.z);
                    translate([holeSize.x, 0, 0])
                        rotate(180)
                            fillet(fillet, holeSize.z);
                }

            }
            rotate(90)
                translate_z(size.z)
                    iec_screw_positions(iecType())
                        vflip()
                            boltHoleM4Tap(10);
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

module IEC_Housing_hardware() {
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

/*
module iecHousing() {
    iecHousingSize = iecHousingSize();
    sidePanelSizeZ = 3;

    explode([-30, 0, 0])
        translate([-iecHousingSize.z, -iecHousingSize().x, 0])
            rotate([90, 0, 90])
                stl_colour(pp4_colour)
                    IEC_Housing_Bevelled_stl();
    explode([40, 0, 0], true)
        translate([sidePanelSizeZ + 2*eps, -iecHousingSize.x/2, iecHousingSize.y/2])
            rotate([0, 90, 0]) {
                iec320c14FusedSwitched();
                iec_screw_positions(iecType())
                    translate_z(sidePanelSizeZ)
                        boltM4Buttonhead(12);
            }
}
*/

module iecHousingMountAttachmentHolePositions(eX=eX, extended=false, z=0) {
    size = iecHousingMountSize(eX);

    translate([0, -2*eSize, z]) {
        for (x = [eSize/2, size.x - 3*eSize/2])
            translate([x, eSize/2, 0])
                children();
        for (y = [eSize, size.y - eSize/2])
            translate([size.x - eSize/2, y, 0])
                children();
        if (extended) {
            translate([eSize/2, 3*eSize/2, 0])
                children();
            for (x = [eSize/2, 3*eSize/2])
                translate([x, spoolHeight(eX) + eSize/2, 0])
                    children();
        } else {
            translate([eSize/2, size.y - eSize/2])
                children();
        }
    }
}

module IEC_Housing_Mount_Extended_110_stl() {
    stl("IEC_Housing_Mount_Extended_110")
        color(pp1_colour)
            iceHousingMount(eX=350, extended=true);
}

module IEC_Housing_Mount_Extended_130_stl() {
    stl("IEC_Housing_Mount_Extended_130")
        color(pp1_colour)
            iceHousingMount(eX=300, extended=true);
}

module IEC_Housing_Mount_stl() {
    stl("IEC_Housing_Mount")
        color(pp1_colour)
            iceHousingMount(eX);
}

module partitionGuideTabs(size, gapWidth=partitionSize().z + partitionTolerance, gapHeight=2.5) {
    rounded_cube_xy(size, 1);
    size2 = [(size.x - gapWidth)/2, size.y, size.z + gapHeight];
    translate_z(size.z - size2.z)
        rounded_cube_xy(size2, 0.5);
    translate([size.x - size2.x, 0, size.z - size2.z])
        rounded_cube_xy(size2, 0.5);
}

module iceHousingMount(eX, extended=false) {
    size = iecHousingMountSize(eX);
    iecHousingSize = iecHousingSize();
    iecCutoutSize = [iecCutoutSize().x, iecCutoutSize().y, size.z + 2*eps];
    fillet = 3;
    vflip()
        difference() {
            union() {
                partitionTolerance = 0.5;
                translate([0, -2*eSize, 0])
                    rounded_cube_xy(size, fillet);
                /*if (extended) {
                    size2 = [size.x - partitionOffsetY() + guideWidth/2 - partitionSize().z/2, spoolHeight(eX) - eSize, size.z];
                    rounded_cube_xy(size2, fillet);
                    translate([size2.x, iecHousingSize.y, 0])
                        fillet(5, size.z);
                    size3 = [guideWidth, size2.y - iecHousingSize.y - eSize, eSize];
                    translate([size.x - partitionOffsetY() - partitionSize().z/2 - size3.x/2, iecHousingSize.y, -size3.z])
                        partitionGuideTabs(size3);
                }*/
            } // end union

            if (size.y >= spoolHeight() && eX > 250) {
                // cutout to access TF card
                tfCutoutSize = [40, 50, size.z + 2*eps];
                translate([size.x - eSize - tfCutoutSize.x, size.y -3*eSize - tfCutoutSize.y, -eps])
                    rounded_cube_xy(tfCutoutSize, 2);
            }
            translate([iecHousingSize.x/2 - iecCutoutSize.x/2, iecHousingSize.y/2 - iecCutoutSize.y/2 - (extended ? 0 : eSize), -eps])
                rounded_cube_xy(iecCutoutSize, fillet);
            translate([iecHousingSize.x/2, iecHousingSize.y/2 - (extended ? 0 : eSize), 0])
                rotate(90)
                    iec_screw_positions(iecType())
                        boltHoleM4(size.z);
            iecHousingMountAttachmentHolePositions(eX, extended)
                boltHoleM4(size.z);
            // access holes
            for (y = [eSize/2, 3*eSize/2, 5*eSize/2])
                translate([size.x - eSize/2, y - 2*eSize, 0])
                    boltHole(5, size.z);
        } // end difference
}

module IEC_Housing_Mount_hardware(eX=eX, extended=false) {

    iecHousingMountAttachmentHolePositions(eX, extended, iecHousingMountSize().z)
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

    extended = is_undef(_useElectronicsInBase) || _useElectronicsInBase == false;

    translate([eX + 2*eSize, eY + eSize, 2*eSize])
        translate([0, eSize - iecHousingMountSize().x, 0])
            rotate([90, 0, 90]) {
                stl_colour(pp1_colour)
                    vflip()
                        if (!extended)
                            IEC_Housing_Mount_stl();
                        else if (eX==300)
                            IEC_Housing_Mount_Extended_130_stl();
                        else if (eX > 300)
                            IEC_Housing_Mount_Extended_110_stl();
                if (eX >= 250)
                    IEC_Housing_Mount_hardware(eX, extended);
            }
    iecHousing(bevelled=extended);
}

module iecHousing(bevelled) {
    translate([eX + 2*eSize, eY + eSize, bevelled ? 2*eSize : eSize])
        translate([-iecHousingSize().z, eSize - iecHousingMountSize().x, 0])
            rotate([90, 0, 90]) {
                explode(-30)
                    stl_colour(pp4_colour)
                        if (bevelled)
                            IEC_Housing_Bevelled_stl();
                        else
                            rotate(180)
                                IEC_Housing_stl();
                explode(30, true)
                    IEC_Housing_hardware();
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

