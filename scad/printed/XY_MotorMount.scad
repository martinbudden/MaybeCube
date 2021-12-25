include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/printed/printed_pulleys.scad>

use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/utils/rounded_triangle.scad>

use <NopSCADlib/vitamins/bldc_motor.scad>
use <NopSCADlib/vitamins/rod.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>
include <NopSCADlib/vitamins/magnets.scad>

use <../../../BabyCube/scad/vitamins/CorkDamper.scad>

include <../utils/XY_MotorMount.scad>

include <../vitamins/bolts.scad>
include <../vitamins/cables.scad>
include <../vitamins/nuts.scad>


NEMA17_60  = ["NEMA17_60",   42.3, 60,     53.6/2, 25,     11,     2,     5,     24,          31,    [11.5,  9]];

NEMA_hole_depth = 5;

partitionExtension = 6;
bracketThickness = 5;
bracketHeightRight = eZ - eSize - (coreXYPosBL().z + washer_thickness(M3_washer));
bracketHeightLeft = bracketHeightRight + coreXYSeparation().z;
braceThickness = 5;
braceCountersunk = true;
pulleyStackHeight = 2*washer_thickness(coreXYIdlerBore() == 3 ? M3_washer : coreXYIdlerBore() == 4 ? M4_washer : M5_washer) + pulley_height(coreXY_plain_idler(coreXY_type()));
sizeP = [usePulley25() ? 8.5 : 9, 8.5, pulleyStackHeight + 0.5];
sizeT = [8.5, 9, sizeP.z];
offsetP = usePulley25() ? [-4.5, -4.5, 0] : [-4.5, -5.25, 0];
offsetT = usePulley25() ? [-4.5, -5, 0] : [-3.25, -4.5, 0];


function upperBoltPositions(sizeX) = [eSize/2 + 3, sizeX - 3*eSize/2 - 8];
leftDrivePlainIdlerOffset    = [plainIdlerPulleyOffset().x, plainIdlerPulleyOffset().y, 0];
rightDrivePlainIdlerOffset   = [-plainIdlerPulleyOffset().x, plainIdlerPulleyOffset().y, 0];

frameBoltOffsetZ = 12.5; // this allows an inner corner bracket to be used
blockHeightExtra = is_undef(_use2020TopExtrusion) || _use2020TopExtrusion == false ? 0 : eSize;
boltHeadTolerance = 0.1;
sideSupportSizeY = 30;
bearingOffsetZ = 0.5;
stepdownPulleyOffsetZ = 0.5;

function encoderHolePitch(motorType) = motorType[0] == "BLDC4250" ? 56 : 66.5;

module xyMotorScrewPositions(motorType) {
    if (isNEMAType(motorType))
        NEMA_screw_positions(motorType)
            children();
    else if (is_list(motorType))
        BLDC_base_screw_positions(motorType)
            children();
    else
        rotate(45)
            BLDC_screw_positions(motorType)
                rotate(-45)
                    children();

}

module Stepdown_Pulley_40x20_stl() {
    translate_z(-pulley_height(GT2x40sd_pulley) - pulley_height(GT2x40sd_pulley) - stepdownPulleyOffsetZ -0.3+1+.2-1.6)
        stl("Stepdown_Pulley_40x20")
            color(pp2_colour) {
                printed_pulley(GT2x40sd_pulley);
                translate_z(pulley_height(GT2x40sd_pulley)) {
                    tube(pulley_flange_dia(GT2x40sd_pulley)/2, pulley_bore(GT2x40sd_pulley)/2, 0.5, center=false);
                    translate_z(-pulley_flange_thickness(GT2x20sd_pulley) + 1) {
                        printed_pulley(GT2x20sd_pulley);
                        translate_z(pulley_height(GT2x20sd_pulley)) {
                            tube(pulley_flange_dia(GT2x20sd_pulley)/2, pulley_bore(GT2x20sd_pulley)/2, 0.5, center=false);
                            translate_z(0.5)
                                tube(pulley_bore(GT2x20sd_pulley)/2 + 0.5, pulley_bore(GT2x20sd_pulley)/2, stepdownPulleyOffsetZ, center=false);
                        }
                    }
                }
            }
}

module xyMotorMountBrace(thickness, offset=[0,0]) {
    pP = coreXY_drive_plain_idler_offset(coreXY_type()) + leftDrivePlainIdlerOffset;
    pT = coreXY_drive_toothed_idler_offset(coreXY_type());
    fillet = 1;
    extra = [2, 2, 0];

    explode(25)
        difference() {
            union() {
                size = [sizeP.x, sizeP.y, thickness] + [pP.x, pT.y, 0] + offsetP - [pT.x, pP.y, 0] - offsetT + extra;
                translate([pT.x, pP.y, 0] + offsetT - extra/2) {
                    rounded_cube_xy(size, fillet);
                    // add orientation indicator
                    translate([size.x/4, size.y, 0])
                        rotate(45)
                            rounded_cube_xy([3, 3, thickness], 0.5, xy_center=true);
                }
            }
            for (pos = [pP, pT, [pP.x, pT.y], [pT.x, pP.y]])
                translate(pos)
                    if (braceCountersunk)
                        translate_z(thickness)
                            boltPolyholeM3Countersunk(thickness);
                    else
                        boltHoleM3Tap(thickness);
        }
}

module xyMotorMountBaseCutouts(motorType, left, size, offset, sideSupportSizeY=0, cnc=false, M5=false) {
    assert(left == true || left == false);
    fillet = 1.5;
    yFillet = 5;
    motorWidth = motorWidth(motorType);
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();

    translate([0, eY + eSize])
        square([eSize, eSize]);
    translate([0, eY + 2*eSize - size.y - partitionExtension])
        fillet(yFillet);
    translate([eSize, eY + 2*eSize])
        rotate(270)
            fillet(fillet);
    translate([0, eY + eSize])
        rotate(270)
            fillet(fillet);
    for (x = upperBoltPositions(size.x))
        translate([x + eSize, eY + 3*eSize/2])
            poly_circle(r=screw_head_radius(M4_dome_screw) + boltHeadTolerance);
    if (sideSupportSizeY != 0)
        translate([eSize/2, eY + 5*eSize/2 - size.y])
            poly_circle(r=screw_head_radius(M5 ? M5_dome_screw : M4_dome_screw) + boltHeadTolerance);

    translate([coreXYPosBL().x + separation.x/2, coreXYPosTR(motorWidth).y]) {
        translate([coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, left ? offset.y : -offset.y]) {
            poly_circle(r=isNEMAType(motorType) ? NEMA_boss_radius(motorType) : (pulley_flange_dia(GT2x16_pulley) + 1)/2);
            if (cnc) {
                xyMotorScrewPositions(motorType)
                    poly_circle(r=M3_clearance_radius);
            }
        }
        if (cnc) {
            translate(coreXY_drive_plain_idler_offset(coreXY_type) + (left ? leftDrivePlainIdlerOffset : rightDrivePlainIdlerOffset))
                poly_circle(r=M3_tap_radius);
            translate(coreXY_drive_toothed_idler_offset(coreXY_type))
                poly_circle(r=M3_tap_radius);
        }
    }
}

module xyMotorMountBase(motorType, left, size, offset, sideSupportSizeY, stepdown, cnc=false, M5=false, ) {
    basePlateThickness = size.z;
    baseFillet = 3;
    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(motorWidth(motorType));
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();
    pP = coreXY_drive_plain_idler_offset(coreXY_type) + (stepdown ? [0, 0, 0] : plainIdlerPulleyOffset());
    pT = coreXY_drive_toothed_idler_offset(coreXY_type);

    difference() {
        linear_extrude(size.z, convexity=2) {
            difference() {
                union() {
                    translate([0, eY + 2*eSize - size.y, 0])
                        rounded_square([size.x, size.y], baseFillet, center=false);
                        if (partitionExtension > 0)
                            translate([0, eY + 2*eSize - size.y - partitionExtension, 0]) {
                                rounded_square([2*eSize, partitionExtension + 2*baseFillet], baseFillet, center=false);
                                translate([2*eSize, partitionExtension])
                                    rotate(270)
                                        fillet(2);
                            }
                }
                xyMotorMountBaseCutouts(motorType=motorType, left=left, size=size, offset=offset, sideSupportSizeY=sideSupportSizeY, cnc=cnc, M5=M5);
            }
        }
        // groove for partition
        grooveSize = [eSize + 3, 3, 2];
        translate([eSize, eY + 2*eSize - size.y - grooveSize.y, -eps])
            rounded_cube_xy(grooveSize, 0.5);
        if (!cnc)
            translate([coreXYPosBL.x + separation.x/2, coreXYPosTR.y, 0]) {
                translate([coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, (left ? offset.y : -offset.y)]) {
                    if (isNEMAType(motorType)) {
                        NEMA_screw_positions(motorType)
                            boltHoleM3(basePlateThickness, twist=5);
                    } else {
                        mirror([left ? 0 : 1, 0, 0])
                            BLDC_base_screw_positions(motorType)
                                translate_z(basePlateThickness)
                                    vflip()
                                        if (motorType[0] == "BLDC4250")
                                            boltPolyholeM3Countersunk(size.z, sink=0.25);
                                        else
                                            boltHoleM2p5CounterboreButtonhead(size.z);
                        rotate(45)
                            BLDC_screw_positions(encoderHolePitch(motorType))
                                translate_z(basePlateThickness)
                                    vflip()
                                        boltHoleM3(basePlateThickness);
                    }
                }
                if (stepdown) {
                    translate([coreXY_drive_pulley_x_alignment(coreXY_type), 0, 0]) {
                        translate_z(-eps)
                            poly_cylinder(r=5.5/2, h=basePlateThickness + 2*eps);
                        translate_z(bearingOffsetZ)
                            poly_cylinder(r=bb_diameter(BB624)/2, h=basePlateThickness - bearingOffsetZ + eps, twist=4);
                        translate_z(basePlateThickness - 0.5)
                            poly_cylinder(r=pulley_flange_dia(GT2x20sd_pulley)/2 + 0.5, h=0.5 + eps);
                    }
                } else if (offset.x !=0) {
                    for (pos = [pP, pT, [pP.x, pT.y], [pT.x, pP.y]])
                        translate(pos)
                            boltHoleM3Tap(basePlateThickness);
                }
            }
    }
    if (!cnc && !stepdown && offset.x != 0)
        translate([coreXYPosBL.x + separation.x/2, coreXYPosTR.y, size.z])
            difference() {
                union() {
                    fillet = 1;
                    translate([pP.x, pT.y, 0] + offsetP)
                        rounded_cube_xy(sizeP, fillet);
                    translate([pT.x, pP.y, 0] + offsetT)
                        rounded_cube_xy(sizeT, fillet);
                    translate([offset.y ? 0 : 0.75, 0, 0])
                        hull() {
                            translate([pP.x, pT.y, 0])
                                cylinder(r=offset.y ? 0.5 : 0.75, h=sizeP.z);
                            translate([pT.x, pP.y, 0])
                                cylinder(r=offset.y ? 0.5 : 0.75, h=sizeP.z);
                        }
                } // end union
                translate([pP.x, pT.y, 0])
                    boltHoleM3Tap(sizeP.z);
                translate([pT.x, pP.y, 0])
                    boltHoleM3Tap(sizeP.z);
            } // end difference
}

module xyMotorMountBlock(motorType, size, basePlateThickness, offset=[0, 0], sideSupportSizeY, blockHeightExtra=0, stepdown=false, left=true, M5=false) {
    fillet = 1.5;
    yFillet = 5;
    baseFillet = 3;

    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(motorWidth(motorType));
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();

    bracketHeight = left ? bracketHeightLeft : bracketHeightRight;
    tabHeight = bracketHeight - eSize;
    height = tabHeight + blockHeightExtra;

    difference() {
        union() {
            linear_extrude(height)
                difference() {
                    translate([eSize, eY + eSize])
                        rounded_square([size.x - eSize, eSize], fillet, center=false);
                    translate([coreXYPosBL.x + separation.x/2 + coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, coreXYPosTR.y + (left ? offset.y : -offset.y)])
                        xyMotorScrewPositions(isNEMAType(motorType) ? motorType : encoderHolePitch(motorType)) {
                            cutout = 6.5;
                            circle(d = cutout);
                            translate([-cutout/2, -cutout])
                                square([cutout, cutout]);
                            translate([cutout/2, motorClearance().y - 14.35])
                                fillet(1);
                            translate([-cutout/2, motorClearance().y - 14.35])
                                rotate(90)
                                    fillet(1);
                        }
                    translate([size.x, eY + 2*eSize])
                        rotate(180)
                            fillet(baseFillet);
                }
            if (sideSupportSizeY)
                translate([0, eY + eSize - sideSupportSizeY, 0])
                    rounded_cube_xy([eSize, sideSupportSizeY, tabHeight + eSize], fillet);
        }
        if (stepdown)
            translate([coreXYPosBL.x + coreXY_drive_pulley_x_alignment(coreXY_type), coreXYPosTR.y, 5])
                cylinder(d=30, h=sideSupportSizeY + 10);
        translate([0, eY + 2*eSize - size.y - partitionExtension - eps, -eps])
            fillet(yFillet, tabHeight + eSize + 2*eps);
        for (x = upperBoltPositions(size.x))
            translate([x + eSize, eY + 3*eSize/2, -eps])
                boltHoleM4HangingCounterboreButtonhead(5 + 2*eps, boreDepth=height - 5, boltHeadTolerance=boltHeadTolerance);
        translate([eSize/2, eY + 5*eSize/2 - size.y, -eps])
            if (M5)
                boltHoleM5HangingCounterboreButtonhead(5 + 2*eps, boreDepth=height + eSize - 5, boltHeadTolerance=boltHeadTolerance);
            else
                boltHoleM4HangingCounterboreButtonhead(5 + 2*eps, boreDepth=height + eSize - 5, boltHeadTolerance=boltHeadTolerance);
    }

    translate([eSize, eY + eSize, 0])
        rotate(-90) {
            fillet = 5;
            translate([-fillet, 0, 0])
                cube([fillet, fillet, height]);
            translate([0, -fillet, 0])
                cube([fillet, fillet, height]);
            fillet(fillet, height);
        }
    if (sideSupportSizeY == 0) {
        translate([0, eY + eSize - bracketThickness, 0])
            difference() {
                rounded_cube_xy([eSize, bracketThickness, tabHeight + eSize], fillet);
                translate([eSize/2, 0, bracketHeight + basePlateThickness - frameBoltOffsetZ])
                    rotate([-90, 0, 0]) {
                        boltHoleM4(bracketThickness, horizontal=true, rotate=180);
                        *hull() {
                            boltHoleM4(bracketThickness, horizontal=true, rotate=180);
                            translate([0, -5, 0])
                                boltHoleM4(bracketThickness, horizontal=true, rotate=180);
                        }
                    }
            }
        translate([eSize, eY + eSize - bracketThickness, 0]) {
            rotate([90, 0, -90])
                rounded_right_triangle(size.y - eSize - bracketThickness, tabHeight + eSize - basePlateThickness, bracketThickness, 0.5, center=false, offset=true);
            translate([-bracketThickness, 0, 0]) {
                cube([bracketThickness, bracketThickness/2, tabHeight + eSize - basePlateThickness]);
                rotate(180)
                    fillet(1, tabHeight + eSize - basePlateThickness - 2);
            }
        }
    }
}

module xyMotorMount(motorType, basePlateThickness, offset=[0, 0], blockHeightExtra=0, stepdown=false, left=true, M5=false) {
    motorWidth = motorWidth(motorType);
    size = xyMotorMountSize(motorWidth, offset, left);
    sideSupportSizeY = size.y - eSize + partitionExtension;
    xyMotorMountBase(motorType, left, [size.x, size.y, basePlateThickness], offset, sideSupportSizeY, stepdown, M5=M5);
    translate_z(basePlateThickness - eps)
        xyMotorMountBlock(motorType, size, basePlateThickness, offset, sideSupportSizeY, blockHeightExtra, stepdown, left, M5=M5);
}

module XY_Motor_Mount_hardware(motorType, basePlateThickness, offset=[0, 0], corkDamperThickness=0, blockHeightExtra=0, stepdown=false, left=true) {
    motorWidth = motorWidth(motorType);
    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(motorWidth);
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();
    sideSupportSizeY = xyMotorMountSize(motorWidth, offset, left).y - eSize + partitionExtension;

    if (isNEMAType(motorType))
        stepper_motor_cable(left ? 500 : 300);
    translate([left ? coreXYPosBL.x + separation.x/2 : coreXYPosTR.x - separation.x/2, coreXYPosTR.y, basePlateThickness]) {
        drivePos = [offset.x + (left ? coreXY_drive_pulley_x_alignment(coreXY_type) : -coreXY_drive_pulley_x_alignment(coreXY_type)), offset.y, 0];
        translate(drivePos) {
            translate_z(-basePlateThickness - corkDamperThickness) {
                explode(-30, true)
                    if (isNEMAType(motorType)) {
                        rotate(left ? -90 : 90)
                            NEMA(motorType, jst_connector = true);
                        explode(15)
                            corkDamper(motorType, corkDamperThickness);
                    } else {
                        vflip()
                            translate_z(2*eps)
                                rotate(left ? 0 : 180)
                                    BLDC(motorType);
                        translate_z(BLDC_shaft_offset(motorType) - BLDC_shaft_length(motorType) - BLDC_prop_shaft_length(motorType))
                            vflip()
                                magnet(MAGRE6x2p5);
                    }
            }
            if (stepdown) {
                drivePulley = GT2x20ob_pulley;
                translate_z(3.25)
                    pulley(drivePulley);
            } else {
                drivePulley = isNEMAType(motorType) ? coreXY_drive_pulley(coreXY_type) : GT2x20ob_pulley;
                vflip()
                    translate_z(-pulley_height(drivePulley) + 0.8 - pulley_flange_thickness(coreXY_toothed_idler(coreXY_type)))
                        pulley(drivePulley);
            }
            boltLength = screw_shorter_than(NEMA_hole_depth + basePlateThickness + corkDamperThickness);
            xyMotorScrewPositions(motorType)
                if (isNEMAType(motorType))
                    boltM3Buttonhead(boltLength);
                else
                    if (motorType[0] == "BLDC4250")
                        boltM3Countersunk(boltLength);
                    else
                        translate_z(-screw_head_height(M2p5_dome_screw))
                            boltM2p5Buttonhead(boltLength);
            if (!isNEMAType(motorType))
                rotate(45)
                    BLDC_screw_positions(encoderHolePitch(motorType))
                        boltM3Buttonhead(10);
        }

        coreXYIdlerBore = coreXYIdlerBore();
        washer = coreXYIdlerBore == 3 ? M3_washer : coreXYIdlerBore == 4 ? M4_washer : M5_washer;
        screw = coreXYIdlerBore == 3 ? (braceCountersunk ? M3_cs_cap_screw : M3_dome_screw) : coreXYIdlerBore == 4 ? (braceCountersunk ? M4_cs_cap_screw : M4_dome_screw) : (braceCountersunk ? M5_cs_cap_screw : M5_dome_screw);
        screwLength = screw_longer_than(pulleyStackHeight + braceThickness + basePlateThickness);
        plainIdlerPos = left ? coreXY_drive_plain_idler_offset(coreXY_type) + (stepdown ? [0, 0, 0] : leftDrivePlainIdlerOffset)
                       : [-coreXY_drive_plain_idler_offset(coreXY_type).x, coreXY_drive_plain_idler_offset(coreXY_type).y, 0]  + (stepdown ? [0, 0, 0] : rightDrivePlainIdlerOffset);
        stepdownPos = [left ? coreXY_drive_pulley_x_alignment(coreXY_type) : -coreXY_drive_pulley_x_alignment(coreXY_type), 0, 0];
        if (stepdown) {
            beltPoints = [ [drivePos.x, drivePos.y, pulley_od(GT2x20ob_pulley)/2],[stepdownPos.x, stepdownPos.y, pulley_od(GT2x40sd_pulley)/2] ];
            //echo(belt_length=belt_length(coreXY_belt(coreXY_type), beltPoints));
            translate_z(13.5)
                belt(coreXY_belt(coreXY_type), beltPoints);
            translate(stepdownPos) {
                translate_z(-5)
                    rod(5, 30, center=false);
                translate_z(20.75)
                    ball_bearing(BB624);
                translate_z(bb_width(BB624)/2 + bearingOffsetZ - basePlateThickness) {
                    ball_bearing(BB624);
                    translate_z(bb_width(BB624)/2)
                        vflip()
                            Stepdown_Pulley_40x20_stl();
                }
                *translate_z(15)
                    vflip()
                        pulley(GT2x20ob_pulley);
            }
        } else if (offset.x != 0) {
            explode(20, true) {
                translate(plainIdlerPos) {
                    translate_z(pulleyStackHeight + braceThickness + eps)
                        if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
                            screw(screw, screwLength);
                    explode(-10, true)
                        washer(washer)
                            explode(5, true)
                                pulley(coreXY_plain_idler(coreXY_type))
                                    explode(5)
                                        washer(washer);
                }
                toothedIdlerPos = coreXY_drive_toothed_idler_offset(coreXY_type);
                translate(toothedIdlerPos) {
                    translate_z(pulleyStackHeight + braceThickness + eps)
                        if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
                            screw(screw, screwLength);
                    explode(-10, true)
                        washer(washer)
                            explode(5, true)
                                pulley(coreXY_toothed_idler(coreXY_type))
                                    explode(5)
                                        washer(washer);
                }
                if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
                    translate([plainIdlerPos.x, toothedIdlerPos.y, pulleyStackHeight + braceThickness + eps])
                        screw(screw, screwLength);
                    translate([toothedIdlerPos.x, plainIdlerPos.y, pulleyStackHeight + braceThickness + eps])
                        screw(screw, screwLength);
                }
            }
        }
    }

    if (left) {
        size = [xyMotorMountSize(motorWidth, offset, left).x, -offset.y + eY + 2*eSize + motorWidth/2 - coreXYPosTR.y, eZ + basePlateThickness - coreXYPosTR.z];
        for (x = upperBoltPositions(size.x))
            translate([x + eSize, eY + 3*eSize/2, basePlateThickness + bracketHeightLeft - eSize - 5 + blockHeightExtra])
                vflip()
                    boltM4ButtonheadHammerNut(_frameBoltLength);
        if (sideSupportSizeY)
            translate([eSize/2, eY + 5*eSize/2 - size.y, basePlateThickness + bracketHeightLeft - 5])
                vflip()
                    boltM4ButtonheadHammerNut(_frameBoltLength);
        else
            translate([eSize/2, eY + eSize - bracketThickness, basePlateThickness + bracketHeightLeft - frameBoltOffsetZ])
                rotate([90, 0, 0])
                    boltM4ButtonheadHammerNut(_frameBoltLength, rotate=90);
    } else {
        size = [xyMotorMountSize(motorWidth, offset, left).x - 2*offset.x, -offset.y + eY + 2*eSize + motorWidth/2 - coreXYPosTR.y, eZ + basePlateThickness - coreXYPosTR.z];
        for (x = upperBoltPositions(size.x))
            translate([eX + eSize - x, eY + 3*eSize/2, basePlateThickness + bracketHeightRight - eSize - 5 + blockHeightExtra])
                vflip()
                    boltM4ButtonheadHammerNut(_frameBoltLength);
        translate([eX + 3*eSize/2, eY + 5*eSize/2 - size.y,  basePlateThickness + bracketHeightRight - 5])
            vflip()
                boltM4ButtonheadHammerNut(_frameBoltLength);
    }
}

module XY_Motor_Mount_Brace_Left_16_stl() {
    stl("XY_Motor_Mount_Brace_Left_16"); // note - need semicolon to ensure explode of xyMotorMountBrace works
    color(pp2_colour)
        translate([coreXYPosBL().x + coreXYSeparation().x/2, coreXYPosTR(motorWidth(motorType(_xyMotorDescriptor))).y, basePlateThickness + pulleyStackHeight + washer_thickness(M3_washer)])
            xyMotorMountBrace(braceThickness, leftDrivePulleyOffset());
}

module XY_Motor_Mount_Brace_Left_25_stl() {
    stl("XY_Motor_Mount_Brace_Left_25"); // note - need semicolon to ensure explode of xyMotorMountBrace works
    color(pp2_colour)
        translate([coreXYPosBL().x + coreXYSeparation().x/2, coreXYPosTR(motorWidth(motorType(_xyMotorDescriptor))).y, basePlateThickness + pulleyStackHeight + washer_thickness(M3_washer)])
            xyMotorMountBrace(braceThickness, leftDrivePulleyOffset());
}

module XY_Motor_Mount_Brace_Right_16_stl() {
    stl("XY_Motor_Mount_Brace_Right_16"); // note - need semicolon to ensure explode of xyMotorMountBrace works
    color(pp2_colour)
        translate([eX + 2*eSize, 0, 0])
            mirror([1, 0, 0])
                translate([coreXYPosBL().x + coreXYSeparation().x/2, coreXYPosTR(motorWidth(motorType(_xyMotorDescriptor))).y, basePlateThickness + pulleyStackHeight + washer_thickness(M3_washer)])
                    xyMotorMountBrace(braceThickness, -rightDrivePulleyOffset());
}

module XY_Motor_Mount_Brace_Right_25_stl() {
    stl("XY_Motor_Mount_Brace_Right_25"); // note - need semicolon to ensure explode of xyMotorMountBrace works
    color(pp2_colour)
        translate([eX + 2*eSize, 0, 0])
            mirror([1, 0, 0])
                translate([coreXYPosBL().x + coreXYSeparation().x/2, coreXYPosTR(motorWidth(motorType(_xyMotorDescriptor))).y, basePlateThickness + pulleyStackHeight + washer_thickness(M3_washer)])
                    xyMotorMountBrace(braceThickness, -rightDrivePulleyOffset());
}

module xyMotorMountLeftStl(M5=false) {
    motorType = motorType(_xyMotorDescriptor);
    offset = leftDrivePulleyOffset();
    color(pp1_colour)
        xyMotorMount(motorType, basePlateThickness, offset, blockHeightExtra, left=true);
}

module XY_Motor_Mount_Left_16_stl() {
    stl("XY_Motor_Mount_Left_16")
        xyMotorMountLeftStl();
}

module XY_Motor_Mount_Left_25_stl() {
    stl("XY_Motor_Mount_Left_25")
        xyMotorMountLeftStl();
}

module XY_Motor_Mount_Left_M5_stl() {
    stl("XY_Motor_Mount_Left_M5")
        xyMotorMountLeftStl(M5=true);
}


//!1. Bolt the idler pulleys and the **XY_Motor_Mount_Brace_Left** to the **XY_Motor_Mount_Left**. Note the brace is not
//!symmetrical - there is an orientation indicator and this should point towards the back of the printer. Tighten the
//!pulley bolts until the pulleys no longer turn freely, and then loosen the bolts by about 1/4 turn until the pulleys
//!turn freely again.
//!2. Bolt the motor and the cork damper to the motor mount. The core damper thermally insulates the motor from the mount
//!and should not be omitted.
//!3. Align the drive pulley with the idler pulleys and bolt it to the motor shaft.
//!4. Add the bolts and t-nuts in preparation for later attachment to the frame.
//
module XY_Motor_Mount_Left_assembly()
assembly("XY_Motor_Mount_Left", ngb=true) {

    motorType = motorType(_xyMotorDescriptor);
    offset = leftDrivePulleyOffset();

    translate_z(eZ - eSize - basePlateThickness - bracketHeightLeft) {
        stl_colour(pp1_colour)
            if (usePulley25())
                XY_Motor_Mount_Left_25_stl();
            else
                XY_Motor_Mount_Left_16_stl();
        XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, is_undef(_corkDamperThickness) ? 0 : _corkDamperThickness, blockHeightExtra, left=true);
        if (offset.x != 0)
            stl_colour(pp2_colour)
                if (usePulley25())
                    XY_Motor_Mount_Brace_Left_25_stl();
                else
                    XY_Motor_Mount_Brace_Left_16_stl();
    }
}

module xyMotorMountRightStl(M5=false) {
    motorType = motorType(_xyMotorDescriptor);
    offset = rightDrivePulleyOffset();

    color(pp1_colour)
        translate([eX + 2*eSize, 0, 0])
            mirror([1, 0, 0])
                xyMotorMount(motorType, basePlateThickness, -offset, blockHeightExtra, left=false);
}

module XY_Motor_Mount_Right_16_stl() {
    stl("XY_Motor_Mount_Right_16")
        xyMotorMountRightStl();
}

module XY_Motor_Mount_Right_25_stl() {
    stl("XY_Motor_Mount_Right_25")
        xyMotorMountRightStl();
}

module XY_Motor_Mount_Right_M5_stl() {
    stl("XY_Motor_Mount_Right_M5")
        xyMotorMountRightStl(M5=true);
}

//!1. Bolt the idler pulleys and the **XY_Motor_Mount_Brace_Right** to the **XY_Motor_Mount_Right**. Note the brace is not
//!symmetrical - there is an orientation indicator and this should point towards the back of the printer. Tighten the
//!pulley bolts until the pulleys no longer turn freely, and then loosen the bolts by about 1/4 turn until the pulleys
//!turn freely again.
//!2. Bolt the motor and the cork damper to the motor mount. The core damper thermally insulates the motor from the mount
//!and should not be omitted.
//!3. Align the drive pulley with the idler pulleys and bolt it to the motor shaft.
//!4. Add the bolts and t-nuts in preparation for later attachment to the frame.
//
module XY_Motor_Mount_Right_assembly()
assembly("XY_Motor_Mount_Right", ngb=true) {

    motorType = motorType(_xyMotorDescriptor);
    offset = rightDrivePulleyOffset();

    translate_z(eZ - eSize - basePlateThickness - bracketHeightRight) {
        stl_colour(pp1_colour)
            if (usePulley25())
                XY_Motor_Mount_Right_25_stl();
            else
                XY_Motor_Mount_Right_16_stl();
        XY_Motor_Mount_hardware(motorType, basePlateThickness, offset, is_undef(_corkDamperThickness) ? 0 : _corkDamperThickness, blockHeightExtra, left=false);
        if (offset.x != 0)
            stl_colour(pp2_colour)
                if (usePulley25())
                    XY_Motor_Mount_Brace_Right_25_stl();
                else
                    XY_Motor_Mount_Brace_Right_16_stl();
    }
}
