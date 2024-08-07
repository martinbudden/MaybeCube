include <../config/global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>

use <../printed/extrusionChannels.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../config/Parameters_CoreXY.scad>


axisOffset = coreXYPosBL().x - eSize;
upperBoltOffset = 11;
lowerBoltOffset = 5; // so does not interfere with pulley axel bolt
frontOffset = 0.5; // so idler does not interfere with sliding front panel
function useRB40() = !is_undef(_useRB40) && _useRB40; // use reversed belts with 2040 extrusion on front

function xyIdlerSize() = [eSize - 1 - frontOffset + (pulley_hub_dia(coreXY_toothed_idler(coreXY_type())) > 15 ? 4 : 0), pulley_hub_dia(coreXY_toothed_idler(coreXY_type())) > 15 ? 65 : (useRB40() ? 45 : 60), 5]; // eSize - 1 to allow for imprecisely cut Y rails
function xyIdlerRailOffset() = eSize - 1 - (pulley_hub_dia(coreXY_toothed_idler(coreXY_type())) > 15 ? 0 : 0);
// armSize.x reduced to make assembly of pullies easier
armSize = [xyIdlerSize().x - 2, useRB40() ? (coreXYIdlerBore() == 3 ? 8 : coreXYIdlerBore() == 4 ? 9 : 11) : 5.5, 17.5]; // 5.5 y size so 30mm bolt fits exactly
tabThickness = 5;
tabBoltOffset = 6;


module trapezium(baseX, topX, heightY, lengthZ, center=true) {
    linear_extrude(lengthZ, center=center)
        polygon([ [-baseX/2, 0], [baseX/2, 0], [topX/2, heightY], [-topX/2, heightY] ]);
}

module xyIdlerOld() {
    size = xyIdlerSize();
    separation = coreXYSeparation();
    sizeY1 = (coreXYPosBL().z - separation.z) - (eZ - eSize - size.y);
    sizeY2 = size.y - sizeY1 - 2*separation.z;

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
    translate([0, coreXYPosBL().z - separation.z - armSize.y, 0]) {
        difference() {
            rounded_cube_xy(armSize, 1);
            translate([size.x/2, 0, axisOffset])
                rotate([-90, 180, 0])
                    boltHoleM3(armSize.y, horizontal=true);
        }
        translate([0, armSize.y + 2*separation.z, 0])
            difference() {
                rounded_cube_xy(armSize, 1);
                translate([size.x/2, 0, axisOffset])
                    rotate([-90, 180, 0])
                        boltHoleM3Tap(armSize.y, horizontal=true);
            }
    }
}

module xyIdler(size, left=true, useReversedBelts=false, M5=false, coreXYIdlerBore=3) {
    separation = coreXYSeparation();
    sizeY1 = (coreXYPosBL().z - (left || !useReversedBelts ? separation.z : 0)) - (eZ - size.y - (useRB40() ? 2*eSize : eSize));
    washerClearance = 0.25; // to make assembly easier
    sizeY2 = size.y - sizeY1 - (useReversedBelts ? separation.z : 2*separation.z)  - washerClearance + yCarriageBraceThickness()/2;
    baseThickness = 1.5;
    // cutout for y rail
    cutoutFillet = 0.5;
    cutoutSize = [size.x >= eSize ? 4 : 0, 8.5 + cutoutFillet, 13];
    tabLength = size.y - armSize.z - 3; //was 27

    fillet = 0.5;
    translate([0, eZ - size.y - (useRB40() ? 2*eSize : eSize), 0]) {
        difference() {
            translate([frontOffset, 0, 0])
                union() {
                    rounded_cube_yz([size.x, size.y, baseThickness], fillet);
                    // side block below pulley
                    rounded_cube_yz([size.x, sizeY1 - 1, size.z], fillet);
                    // block above pulley
                    translate([0, size.y - sizeY2, 0])
                        rounded_cube_yz([size.x, sizeY2, !left && useRB40() ? size.y : armSize.z], fillet);
                    if (!left && useRB40()) {
                        translate([0, size.y - tabThickness, size.y - tabLength]) {
                            rounded_cube_yz([size.x - cutoutSize.x, tabThickness, tabLength], fillet);
                            translate([0, tabThickness-sizeY2, 0])
                                rotate([90, 180, 90])
                                    fillet(1, size.x);
                        }
                    } else {
                        translate([0, size.y - tabThickness, 0]) {
                            rounded_cube_yz([size.x - cutoutSize.x, tabThickness, size.y], fillet);
                            translate_z(armSize.z)
                                rotate([90, -90, 90])
                                    fillet(1, size.x);
                        }
                    }
                    sideThickness = 1.5;
                    *translate([0, sizeY1 - armSize.y, 0])
                        rounded_cube_yz([sideThickness, size.y - sizeY1 + armSize.y, armSize.z], fillet);
                    rotate([0, -90, 0])
                        translate_z(-sideThickness)
                            linear_extrude(sideThickness)
                                offset(fillet) offset(-fillet)
                                    //polygon([ [0, 0], [0, size.y], [armSize.z + tabLength, size.y], [armSize.z + tabLength, size.y-tabThickness], [armSize.z, sizeY1 - armSize.y], [size.z, 0] ]);
                                    polygon([ [0, 0], [0, size.y], [size.y, size.y], [size.y, size.y-tabThickness], [size.z, 0] ]);
                    // fillet to help threading belts
                    translate([sideThickness, size.y - sizeY2, baseThickness])
                        rotate([90, 0, 0])
                            fillet(5, size.y - sizeY1 - sizeY2);
                    *#translate([0, size.y - sizeY2, baseThickness])
                        rotate([90, -90, 90])
                            fillet(0.75, size.x);
                    tNutWidth = 10.25;
                    cubeHeight = 1.5;
                    triangleHeight = 4;
                    *translate([(size.x + triangleHeight - cubeHeight)/2, lowerBoltOffset + tNutWidth/2, 0])
                        rotate([-90, 90, 0]) {
                            right_triangle(triangleHeight, triangleHeight, size.y - lowerBoltOffset - upperBoltOffset - tNutWidth, center=false);
                            translate([0, -cubeHeight, 0])
                                cube([triangleHeight, cubeHeight, size.y - lowerBoltOffset - upperBoltOffset - tNutWidth]);
                        }
                } // end union
            // cutout for y rail
            if (size.x >= eSize) {
                translate([frontOffset + size.x - cutoutSize.x, size.y - cutoutSize.y + cutoutFillet, size.z + 1.5])
                    rounded_cube_yz(cutoutSize + [eps, 0, 0], cutoutFillet);
                translate([frontOffset + size.x - cutoutSize.x, size.y, size.z + 1.5])
                    rotate([90, 180, 90])
                        fillet(cutoutFillet, cutoutSize.x + eps);
                translate([frontOffset + size.x - cutoutSize.x, size.y - cutoutSize.y + cutoutFillet, size.z + cutoutSize.z - cutoutFillet + eps])
                    rotate([90, 180, 90])
                        fillet(cutoutFillet, cutoutSize.x + eps);
            }
            translate([eSize/2, lowerBoltOffset, 0])
                boltHole(M5 ? M5_clearance_radius*2 : M4_clearance_radius*2, size.z, horizontal=true, rotate=-90);
            if (useRB40()) {
                translate([axisOffset, size.y - sizeY2, axisOffset])
                    rotate([-90, -90, 0])
                        if (coreXYIdlerBore==3)
                            boltHoleM3(sizeY2, horizontal=true);
                        else
                            boltHole(coreXYIdlerBore, sizeY2, horizontal=true);
            } else {
                translate([axisOffset, size.y - sizeY2, axisOffset])
                    rotate([-90, -90, 0])
                        boltHoleM3Tap(sizeY2 - eSize/2, horizontal=true, chamfer_both_ends=false);
                translate([eSize/2, size.y - upperBoltOffset, armSize.z])
                    vflip()
                        rotate(-90)
                            if (M5)
                                boltHoleM5CounterboreButtonhead(armSize.z, boreDepth=armSize.z - 5, horizontal=true);
                            else
                                boltHoleM4CounterboreButtonhead(armSize.z, boreDepth=armSize.z - 5, horizontal=true);
                translate([eSize/2, size.y, eSize/2])
                    rotate([90, 90, 0])
                        boltHole(M5 ? M5_tap_radius*2 : M4_tap_radius*2, sizeY2/2, horizontal=true, chamfer_both_ends=false);
            }
            translate([eSize/2, size.y - tabThickness, size.y - tabBoltOffset])
                rotate([-90, -90, 0])
                    boltHole(M5 ? M5_clearance_radius*2 : M4_clearance_radius*2, tabThickness, horizontal=true);
        } // end difference
    }
    translate([frontOffset, coreXYPosBL().z - armSize.y + yCarriageBraceThickness()/2 - washerClearance - (left || !useReversedBelts ? separation.z : 0), 0]) {
        difference() {
            union() {
                rounded_cube_yz(armSize, fillet);
                rounded_cube_yz([size.x, armSize.y, size.z], fillet);
            }
            if (left && useRB40() && size.y == 40)
                translate([-eps, -eps, armSize.z + eps])
                    rotate([90, 90, 90])
                        right_triangle(armSize.y - 5.25 + 2*eps, armSize.y - 5.25 + 2*eps, size.x + 2*eps, center=false);
            translate([axisOffset - frontOffset, 0, axisOffset])
                rotate([-90, -90, 0])
                    if (coreXYIdlerBore==3)
                        boltHoleM3(armSize.y, horizontal=true);
                    else
                        boltHole(coreXYIdlerBore, armSize.y, horizontal=true);
        }
        *#translate([0, armSize.y, baseThickness])
            rotate([90, 0, 90])
                fillet(0.75, size.x);
        translate([0, 0, size.z])
            rotate([90, -90, 90])
                fillet(1, armSize.x);
        *translate([0, armSize.y + 2*separation.z, 0])
            difference() {
                rounded_cube_yz(armSize, fillet);
                translate([eSize/2, 0, axisOffset])
                    rotate([-90, -90, 0])
                        boltHoleM3Tap(armSize.y, horizontal=true, chamfer_both_ends=false);
            }
    }
}

module XY_Idler_Channel_Nut_stl() {
    size = xyIdlerSize();
    stl("XY_Idler_Channel_Nut");
    color(pp2_colour)
        extrusionChannel(size.y, boltHoles=[lowerBoltOffset, size.y - upperBoltOffset]);
}

module XY_Idler_Channel_Nut_16_stl() {
    size = xyIdlerSize();
    stl("XY_Idler_Channel_Nut_16");
    color(pp2_colour)
        extrusionChannel(size.y, boltHoles=[lowerBoltOffset, size.y - upperBoltOffset]);
}

module XY_Idler_hardware(size, left=true, useReversedBelts=false) {

    module doubleWasher(left) {
        washer = coreXYIdlerBore() == 3 ? M3_washer : coreXYIdlerBore() == 4 ? M4_shim : M5_shim;
        explode([left ? 20 : -20, 10, 0], true)
            washer(washer)
                explode([0, -10, 0], true)
                    washer(washer)
                        explode([left ? -20 : 20, 0, 0], true)
                            children();
    }
    coreXY_type = coreXY_type();
    toothed_idler = coreXY_toothed_idler(coreXY_type);

    rotate([0, -90, 0]) {
        translate([eSize/2, eZ - eSize - size.y, 0]) {
            if (useRB40()) {
                translate([0, lowerBoltOffset - eSize, size.z])
                    explode(20, true)
                        boltM4ButtonheadTNut(_frameBoltLength, rotate=90, nutExplode=60);
            } else {
                for (y = [lowerBoltOffset, size.y - upperBoltOffset])
                    translate([0, y, size.z])
                        explode(20, true)
                            boltM4Buttonhead(_frameBoltLength);
                explode(-50)
                    stl_colour(pp2_colour)
                        XY_Idler_Channel_Nut_stl();
                translate([0, size.y + 2, eSize/2])
                    rotate([-90, 0, 0]) {
                        explode(10, true)
                            washer(M4_washer)
                                boltM4Buttonhead(10);
                    }
            }

            translate([0, size.y - tabThickness - (useRB40() ? eSize : 0), size.y - tabBoltOffset])
                rotate([90, 0, 0])
                    boltM4ButtonheadTNut(_frameBoltLength, rotate=90);
        }

        washer = coreXYIdlerBore() == 3 ? M3_washer : coreXYIdlerBore() == 4 ? M4_washer : M5_washer;
        translate([left ? axisOffset : eSize - axisOffset, coreXYPosBL().z - coreXYSeparation().z + yCarriageBraceThickness()/2, axisOffset])
            rotate([-90, 0, 0]) {
                washerClearance = 0.25;
                if (useReversedBelts) {
                    translate_z(left ? 0 : coreXYSeparation().z) {
                        vflip()
                            translate_z(armSize.y + washerClearance)
                                explode(20, true)
                                    if (useRB40()) {
                                        if (coreXYIdlerBore() == 3)
                                            boltM3CapheadHammerNut(left ? 35 : 25, rotate=90);
                                        else if (coreXYIdlerBore() == 4)
                                            boltM3ShoulderTNut(left ? 30 : 20, rotate=90);
                                        else if (coreXYIdlerBore() == 5)
                                            boltM4ShoulderTNut(left ? 30 : 20, rotate=90);
                                    } else {
                                        boltM3Caphead(20);
                                    }
                        explode([left ? 25 : -25, 0, -7.5], true)
                            bearingStack(coreXYBearing());
                    }
                } else {
                    vflip()
                        translate_z(armSize.y + washerClearance)
                            explode(20, true)
                                boltM3Caphead(pulley_height(toothed_idler) >= 11 ? 35 : 30);
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
}

module XY_Idler_Left_16_stl() {
    // rotate for printing, so that base filament pattern aligns with main diagonal
    stl("XY_Idler_Left_16")
        color(pp1_colour)
            rotate([90, -90, 0])
                xyIdler(xyIdlerSize());
}

module XY_Idler_Left_RB3_stl() {
    // rotate for printing, so that base filament pattern aligns with main diagonal
    stl("XY_Idler_Left_RB3");
    color(pp1_colour)
        rotate([90, -90, 0])
            xyIdler(xyIdlerSize(), left=true, useReversedBelts=true, coreXYIdlerBore=3);
}

module XY_Idler_Left_RB4_stl() {
    // rotate for printing, so that base filament pattern aligns with main diagonal
    stl("XY_Idler_Left_RB4");
    color(pp1_colour)
        rotate([90, -90, 0])
            xyIdler(xyIdlerSize(), left=true, useReversedBelts=true, coreXYIdlerBore=4);
}

module XY_Idler_Left_RB_20_stl() {
    // rotate for printing, so that base filament pattern aligns with main diagonal
    stl("XY_Idler_Left_RB_20");
    color(pp1_colour)
        rotate([90, -90, 0])
            xyIdler(xyIdlerSize(), left=true, useReversedBelts=true);
}

module XY_Idler_Left_M5_stl() {
    // rotate for printing, so that base filament pattern aligns with main diagonal
    stl("XY_Idler_Left_M5")
        color(pp1_colour)
            rotate([90, -90, 0])
                xyIdler(xyIdlerSize(), M5=true);
}

module XY_Idler_Right_16_stl() {
    stl("XY_Idler_Right_16")
        color(pp1_colour)
            rotate([0, 90, 0])
                mirror([1, 0, 0])
                    xyIdler(xyIdlerSize());
}

module XY_Idler_Right_RB3_stl() {
    stl("XY_Idler_Right_RB3");
    color(pp1_colour)
        rotate([0, 90, 0])
            mirror([1, 0, 0])
                xyIdler(xyIdlerSize(), left=false, useReversedBelts=true, coreXYIdlerBore=3);
}

module XY_Idler_Right_RB4_stl() {
    stl("XY_Idler_Right_RB4");
    color(pp1_colour)
        rotate([0, 90, 0])
            mirror([1, 0, 0])
                xyIdler(xyIdlerSize(), left=false, useReversedBelts=true, coreXYIdlerBore=4);
}

module XY_Idler_Right_RB_20_stl() {
    stl("XY_Idler_Right_RB_20");
    color(pp1_colour)
        rotate([0, 90, 0])
            mirror([1, 0, 0])
                xyIdler(xyIdlerSize(), left=false, useReversedBelts=true);
}

module XY_Idler_Right_M5_stl() {
    stl("XY_Idler_Right_M5")
        color(pp1_colour)
            rotate([0, 90, 0])
                mirror([1, 0, 0])
                    xyIdler(xyIdlerSize(), M5=true);
}

//!1. Bolt the pulley stack into the **XY_Idler_Left**. Note that there are 4 washers between the two pulleys and one
//!washer at the top and the bottom of the pulley stack.
//!2. Tighten the bolt until the pulleys no longer turn freely, and then loosen the bolt by about 1/4 turn to allow the pulleys
//!to turn freely again.
//!3. Add the bolts and t-nuts in preparation for later attachment to the frame.
//
module XY_Idler_Left_assembly() pose(a=[70, 0, -180 + 30])
assembly("XY_Idler_Left", big=true, ngb=true) {
    translate([eSize, 0, 0]) {
        rotate([0, 90, 90])
            stl_colour(pp1_colour)
                if (useRB40()) {
                    if (coreXYIdlerBore() == 3)
                        XY_Idler_Left_RB3_stl();
                    else if (coreXYIdlerBore() == 4)
                        XY_Idler_Left_RB4_stl();
                } else if (useReversedBelts()) {
                    XY_Idler_Left_RB_20_stl();
                } else {
                    XY_Idler_Left_16_stl();
                }
        rotate([90, 0, 180])
            XY_Idler_hardware(xyIdlerSize(), left=true, useReversedBelts=useReversedBelts());
    }
}

//!1. Bolt the pulley stack into the **XY_Idler_Right**. Note that there are 4 washers between the two pulleys and one
//!washer at the top and the bottom of the pulley stack.
//!2. Tighten the bolt until the pulleys no longer turn freely, and then loosen the bolt by about 1/4 turn to allow the pulleys
//!to turn freely again.
//!3. Add the bolts and t-nuts in preparation for later attachment to the frame.
//
module XY_Idler_Right_assembly() pose(a=[70, 0, -180 + 30])
assembly("XY_Idler_Right", big=true, ngb=true) {
    translate([eX + eSize, 0, 0])
        rotate([90, 0, 180]) {
            stl_colour(pp1_colour)
                if (useRB40()) {
                    if (coreXYIdlerBore() == 3)
                        XY_Idler_Right_RB3_stl();
                    else if (coreXYIdlerBore() == 4)
                        XY_Idler_Right_RB4_stl();
                } else if (useReversedBelts()) {
                    XY_Idler_Right_RB_20_stl();
                } else {
                    XY_Idler_Right_16_stl();
                }
            translate_z(eSize)
                hflip()
                    XY_Idler_hardware(xyIdlerSize(), left=false, useReversedBelts=useReversedBelts());
        }
}
