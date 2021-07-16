include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>

include <NopSCADlib/vitamins/belts.scad> // required for pulleys
include <NopSCADlib/vitamins/pulleys.scad>

use <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>
use <../Parameters_CoreXY.scad>


axisOffset = coreXYPosBL().x - eSize;
upperBoltOffset = 11;
lowerBoltOffset = 6;
frontOffset = 1; // so idler does not interfere with sliding front panel
function xyIdlerSize() = [eSize - 1 - frontOffset, 60, 5]; // eSize -1 to allow for imprecisely cut Y rails
armSize = [xyIdlerSize().x, 5.5, 17.5]; // 5.5 y size so 30mm bolt fits exactly
tabLength = xyIdlerSize().y - armSize.z; //was 27
tabThickness = 5;
tabBoltOffset = 6;


module trapezium(baseX, topX, heightY, lengthZ, center=true) {
    linear_extrude(lengthZ, center=center)
        polygon([ [-baseX/2, 0], [baseX/2, 0], [topX/2, heightY], [-topX/2, heightY] ]);
}

module xyIdlerOld() {
    size = xyIdlerSize();
    sizeY1 = (coreXYPosBL().z - coreXYSeparation().z) - (eZ - eSize - size.y);
    sizeY2 = size.y - sizeY1 - 2*coreXYSeparation().z;

    translate([0, eZ - eSize - size.y, 0]) {
        difference() {
            union() {
                fillet = 2;
                rounded_cube_xy([size.x, size.y, 2], fillet);
                rounded_cube_xy([size.x, sizeY1, size.z], fillet);
                translate([0, size.y - sizeY2, 0])
                    rounded_cube_xy([size.x, sizeY2, size.z], fillet);
            }
            translate([size.x/2, lowerBoltOffset, 0])
                boltHoleM4(size.z);
            translate([size.x/2, size.y - upperBoltOffset, 0])
                boltHoleM4(size.z);
        }
    }
    translate([0, coreXYPosBL().z - coreXYSeparation().z - armSize.y, 0]) {
        difference() {
            rounded_cube_xy(armSize, 1);
            translate([size.x/2, 0, axisOffset])
                rotate([-90, 180, 0])
                    boltHoleM3(armSize.y, horizontal=true);
        }
        translate([0, armSize.y + 2*coreXYSeparation().z, 0])
            difference() {
                rounded_cube_xy(armSize, 1);
                translate([size.x/2, 0, axisOffset])
                    rotate([-90, 180, 0])
                        boltHoleM3Tap(armSize.y, horizontal=true);
            }
    }
}

module xyIdler() {
    size = xyIdlerSize();
    sizeY1 = (coreXYPosBL().z - coreXYSeparation().z) - (eZ - eSize - size.y);
    washerClearance = 0.25; // to make assembly easier
    sizeY2 = size.y - sizeY1 - 2*coreXYSeparation().z  - washerClearance + yCarriageBraceThickness()/2;
    baseThickness = 2;

    fillet = 0.5;
    translate([0, eZ - eSize - size.y, 0]) {
        difference() {
            translate([frontOffset, 0, 0])
                union() {
                    sideThickness = 2;
                    rounded_cube_yz([size.x, size.y, baseThickness], fillet);
                    rounded_cube_yz([size.x, sizeY1, size.z], fillet);
                    translate([0, size.y - sizeY2, 0])
                        rounded_cube_yz([size.x, sizeY2, armSize.z], fillet);
                    translate([0, size.y - tabThickness, 0])
                        rounded_cube_yz([size.x, tabThickness, armSize.z + tabLength], fillet);
                    *translate([0, sizeY1 - armSize.y, 0])
                        rounded_cube_yz([sideThickness, size.y - sizeY1 + armSize.y, armSize.z], fillet);
                    rotate([0, -90, 0])
                        translate_z(-sideThickness)
                            linear_extrude(sideThickness)
                                offset(fillet) offset(-fillet)
                                    //polygon([ [0, 0], [0, size.y], [armSize.z + tabLength, size.y], [armSize.z + tabLength, size.y-tabThickness], [armSize.z, sizeY1 - armSize.y], [size.z, 0] ]);
                                    polygon([ [0, 0], [0, size.y], [armSize.z + tabLength, size.y], [armSize.z + tabLength, size.y-tabThickness], [size.z, 0] ]);
                    translate([sideThickness, size.y-sizeY2, baseThickness])
                        rotate([90, 0, 0])
                            fillet(6, size.y - sizeY1 -sizeY2);
                    translate([0, size.y-sizeY2, baseThickness])
                        rotate([90, -90, 90])
                            fillet(1, size.x);
                    translate([0, size.y - tabThickness, armSize.z])
                        rotate([90, -90, 90])
                            fillet(1, size.x);
                    tNutWidth = 10.25;
                    cubeHeight = 1.5;
                    triangleHeight = 4;
                    *translate([(size.x + triangleHeight - cubeHeight)/2, lowerBoltOffset + tNutWidth/2, 0])
                        rotate([-90, 90, 0]) {
                            right_triangle(triangleHeight, triangleHeight, size.y - lowerBoltOffset - upperBoltOffset - tNutWidth, center=false);
                            translate([0, -cubeHeight, 0])
                                cube([triangleHeight, cubeHeight, size.y - lowerBoltOffset - upperBoltOffset - tNutWidth]);
                        }
                }
            translate([eSize/2, 0, 0]) {
                translate([0, lowerBoltOffset, 0])
                    boltHoleM4(size.z, horizontal=true, rotate=-90);
                translate([0, size.y - upperBoltOffset, armSize.z])
                    vflip()
                        rotate(-90)
                            boltHoleM4CounterboreButtonhead(armSize.z, boreDepth=armSize.z - 5, horizontal=true);
                translate([0, size.y - sizeY2, axisOffset])
                    rotate([-90, -90, 0])
                        boltHoleM3Tap(sizeY2/2, horizontal=true, chamfer_both_ends=false);
                translate([0, size.y, axisOffset])
                    rotate([90, 90, 0])
                        boltHoleM4Tap(sizeY2/2, horizontal=true, chamfer_both_ends=false);
                translate([0, size.y - tabThickness, armSize.z + tabLength - tabBoltOffset])
                    rotate([-90, -90, 0])
                        boltHoleM4(tabThickness, horizontal=true);
            }
        }
    }
    translate([frontOffset, coreXYPosBL().z - coreXYSeparation().z - armSize.y + yCarriageBraceThickness()/2, 0]) {
        difference() {
            rounded_cube_yz(armSize, fillet);
            translate([eSize/2 - frontOffset, 0, axisOffset])
                rotate([-90, -90, 0])
                    boltHoleM3(armSize.y, horizontal=true);
        }
        translate([0, armSize.y, baseThickness])
            rotate([90, 0, 90])
                fillet(1, size.x);
        translate([0, 0, size.z])
            rotate([90, -90, 90])
                fillet(1, size.x);
        *translate([0, armSize.y + 2*coreXYSeparation().z, 0])
            difference() {
                rounded_cube_yz(armSize, fillet);
                translate([eSize/2, 0, axisOffset])
                    rotate([-90, -90, 0])
                        boltHoleM3Tap(armSize.y, horizontal=true, chamfer_both_ends=false);
            }
    }
}

module XY_Idler_hardware(left = true) {

    module doubleWasher(left) {
        if (coreXYIdlerBore() == 3)
            explode([left ? 20 : -20, 10, 0], true)
                washer(M3_washer)
                    explode([0, -10, 0], true)
                        washer(M3_washer)
                            explode([left ? -20 : 20, 0, 0], true)
                                children();
        else
            washer(M5_washer)
                children();
    }

    size = xyIdlerSize();
    coreXY_type = coreXY_type();
    toothed_idler = coreXY_toothed_idler(coreXY_type);

    rotate([0, -90, 0]) {
        translate([eSize/2, eZ - eSize - size.y, 0]) {
            for (y = [lowerBoltOffset, size.y - upperBoltOffset])
                translate([0, y, size.z])
                    explode(20, true)
                        boltM4ButtonheadHammerNut(_frameBoltLength, rotate=90, nutExplode=60);

            translate([0, size.y - tabThickness, armSize.z + tabLength - tabBoltOffset])
                rotate([90, 0, 0])
                    boltM4ButtonheadHammerNut(_frameBoltLength, rotate=90);
            translate([0, size.y + 2, axisOffset])
                rotate([-90, 0, 0]) {
                    explode(10, true)
                        washer(M4_washer)
                            boltM4Buttonhead(10);
                }
        }

        washer = coreXYIdlerBore() == 3 ? M3_washer : M5_washer;
        translate([eSize/2, coreXYPosBL().z - coreXYSeparation().z + yCarriageBraceThickness()/2, axisOffset])
            rotate([-90, 0, 0]) {
                vflip()
                    translate_z(armSize.y + eps)
                        explode(20, true)
                            boltM3Caphead(30);
                explode = 35;
                explode([left ? explode + 20 : -explode - 20, 0, 0])
                    washer(washer);
                explode([left ? explode : -explode, 0, 0], true)
                    translate_z(washer_thickness(washer)) {
                        pulley(toothed_idler);
                        translate_z(pulley_height(toothed_idler)) {
                            doubleWasher(left)
                                if (yCarriageBraceThickness() == 0) {
                                    pulley(toothed_idler)
                                        washer(washer);
                                } else {
                                    doubleWasher(left)
                                        pulley(toothed_idler)
                                    explode([left ? 20 : -20, 0, 0])
                                            washer(washer);
                                }
                        }
                    }
            }
    }
}

module XY_Idler_Left_stl() {
    // rotate for printing, so that base filament pattern aligns with main diagonal
    stl("XY_Idler_Left")
        color(pp1_colour)
            rotate([90, -90, 0])
                xyIdler();
}

module XY_Idler_Right_stl() {
    stl("XY_Idler_Right")
        color(pp1_colour)
            rotate([0, 90, 0])
                mirror([1, 0, 0])
                    xyIdler();
}

//!1. Bolt the pulley stack into the **XY_Idler_Left**. Note that there are 4 washers between the two pulleys and one
//!washer at the top and the bottom of the pulley stack.
//!2. Tighten the bolt until the pulleys no longer turn freely, and then loosen the bolt by about 1/4 turn to allow the pulleys
//!to turn freely again.
//!3. Add the bolts and t-nuts in preparation for later attachment to the frame.
//!4. Add the button head bolt and washer.
//
module XY_Idler_Left_assembly() pose(a=[70, 0, -180 + 30])
assembly("XY_Idler_Left", big=true, ngb=true) {

    translate([eSize, 0, 0]) {
        rotate([0, 90, 90])
            stl_colour(pp1_colour)
                XY_Idler_Left_stl();
        rotate([90, 0, 180])
            XY_Idler_hardware(left=true);
    }
}

//!1. Bolt the pulley stack into the **XY_Idler_Right**. Note that there are 4 washers between the two pulleys and one
//!washer at the top and the bottom of the pulley stack.
//!2. Tighten the bolt until the pulleys no longer turn freely, and then loosen the bolt by about 1/4 turn to allow the pulleys
//!to turn freely again.
//!3. Add the bolts and t-nuts in preparation for later attachment to the frame.
//!4. Add the button head bolt and washer.
//
module XY_Idler_Right_assembly() pose(a=[70, 0, -180 + 30])
assembly("XY_Idler_Right", big=true, ngb=true) {

    translate([eX + eSize, 0, 0])
        rotate([90, 0, 180]) {
            stl_colour(pp1_colour)
                XY_Idler_Right_stl();
            translate_z(eSize)
                hflip()
                    XY_Idler_hardware(left=false);
        }
}
