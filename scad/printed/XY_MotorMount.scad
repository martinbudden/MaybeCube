include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/utils/rounded_triangle.scad>

include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../../../BabyCube/scad/vitamins/CorkDamper.scad>

use <../vitamins/bolts.scad>
use <../vitamins/cables.scad>
use <../vitamins/extrusionBracket.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>
use <../Parameters_CoreXY.scad>


NEMA17_60  = ["NEMA17_60",   42.3, 60,     53.6/2, 25,     11,     2,     5,     24,          31,    [11.5,  9]];

NEMA_type =
    _xyNemaType == "14" ? NEMA14 :
    _xyNemaType == "17_40" ? NEMA17M :
    _xyNemaType == "17_48" ? NEMA17 :
    _xyNemaType == "17_60" ? NEMA17_60 :
    undef;

NEMA_width = NEMA_width(NEMA_type);
NEMA_hole_depth = 5;

useMotorIdler20 = !is_undef(_useMotorIdler20) && _useMotorIdler20;

bracketThickness = 5;
basePlateThickness = useMotorIdler20 ? 7 : 6.5;
bracketHeightRight = eZ - eSize - (coreXYPosBL().z + washer_thickness(M3_washer));
bracketHeightLeft = bracketHeightRight + coreXYSeparation().z;

function upperBoltPositions(sizeX) = [eSize/2 + 3, sizeX - 3*eSize/2 - 3];

//leftDrivePlainIdlerOffset = [0, useMotorIdler20 ? 0 : eX >=300 ? 2 : 5, 0];
//rightDrivePlainIdlerOffset = [0, eX >=300 ? 0 : 5, 0];
leftDrivePlainIdlerOffset = [0, useMotorIdler20 ? 0 : 2, 0];
rightDrivePlainIdlerOffset = [0, 0, 0];
frameBoltOffsetZ = 12.5; // this allows an inner corner bracket to be used
blockHeightExtra = is_undef(_use2020TopExtrusion) || _use2020TopExtrusion == false ? 0 : eSize;
boltHeadTolerance = 0.1;
sideSupportSizeY = 30;

module xyMotorMountBaseCutouts(left, size, offset, sideSupportSizeY = 0, cnc=false) {
    assert(!is_undef(left));
    fillet = 1.5;
    yFillet = 5;
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();

    translate([0, eY + eSize])
        square([eSize, eSize]);
    translate([0, eY + 2*eSize - size.y])
        fillet(yFillet);
    translate([eSize, eY + 2*eSize])
        rotate(270)
            fillet(fillet);
    translate([0, eY + eSize])
        rotate(270)
            fillet(fillet);

    for (x = upperBoltPositions(size.x))
        translate([x + eSize, eY + 3*eSize/2])
            poly_circle(r = screw_head_radius(M4_dome_screw) + boltHeadTolerance);
    if (sideSupportSizeY!=0)
        translate([eSize/2, eY + 3*eSize/2 - (sideSupportSizeY < 0 ? size.y - eSize : sideSupportSizeY)])
            poly_circle(r = screw_head_radius(M4_dome_screw) + boltHeadTolerance);

    translate([coreXYPosBL().x + separation.x/2, coreXYPosTR(NEMA_width).y + offset.y]) {
        translate([coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0]) {
            poly_circle(r = NEMA_boss_radius(NEMA_type));
            if (cnc)
                NEMA_screw_positions(NEMA_type)
                    poly_circle(r = M3_clearance_radius);
        }
        if (cnc) {
            translate(coreXY_drive_plain_idler_offset(coreXY_type) + (left ? leftDrivePlainIdlerOffset : rightDrivePlainIdlerOffset))
                poly_circle(r = M3_tap_radius);
            translate(coreXY_drive_toothed_idler_offset(coreXY_type))
                poly_circle(r = M3_tap_radius);
        }
    }
}

module xyMotorMountBase(left, size, offset, sideSupportSizeY, cnc=false) {
    baseFillet = 3;
    separation = coreXYSeparation();
    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(NEMA_width);
    coreXY_type = coreXY_type();
    pP = coreXY_drive_plain_idler_offset(coreXY_type) + (left ? leftDrivePlainIdlerOffset : rightDrivePlainIdlerOffset);
    pT = coreXY_drive_toothed_idler_offset(coreXY_type);

    difference() {
        linear_extrude(size.z, convexity=2) {
            difference() {
                translate([0, eY + 2*eSize - size.y, 0])
                    rounded_square([size.x, size.y], baseFillet, center=false);
                xyMotorMountBaseCutouts(left, size=size, offset=offset, sideSupportSizeY=sideSupportSizeY, cnc=cnc);
            }
        }
        if (!cnc)
            translate([coreXYPosBL.x + separation.x/2, coreXYPosTR.y + offset.y]) {
                translate([coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0])
                    NEMA_screw_positions(NEMA_type)
                        boltHoleM3(basePlateThickness, twist=5);
                translate(pP)
                    boltHoleM3Tap(basePlateThickness);
                translate(pT)
                    boltHoleM3Tap(basePlateThickness);
                translate([pP.x, pT.y])
                    boltHoleM3Tap(basePlateThickness);
                translate([pT.x, pP.y])
                    boltHoleM3Tap(basePlateThickness);
            }
    }
    if (!cnc)
        translate([coreXYPosBL.x + separation.x/2, coreXYPosTR.y + offset.y]) {
            pulleyStackHeight = 2*washer_thickness(M3_washer) + pulley_height(GT2x16_plain_idler);
            translate([pP.x, pT.y, size.z])
                difference() {
                    if (left)
                        translate([0, leftDrivePlainIdlerOffset.y/2 - 1, 0])
                            rounded_cube_xy([9, 8.5 - leftDrivePlainIdlerOffset.y, pulleyStackHeight], 1, xy_center=true);
                    else
                        translate([0, rightDrivePlainIdlerOffset.y/2 - 1, 0])
                            rounded_cube_xy([9, 8.5 - rightDrivePlainIdlerOffset.y, pulleyStackHeight], 1, xy_center=true);
                    boltHoleM3Tap(pulleyStackHeight);
                }
            translate([pT.x, pP.y, size.z])
                difference() {
                    if (left)
                        translate([1, -leftDrivePlainIdlerOffset.y, 0])
                            rounded_cube_xy([8.5, 9, pulleyStackHeight], 1, xy_center=true);
                    else
                        translate([1, 0, 0])
                            rounded_cube_xy([8.5, 9, pulleyStackHeight], 1, xy_center=true);
                    boltHoleM3Tap(pulleyStackHeight);
                }
        }
}

module xyMotorMountBlock(size, bracketHeight, basePlateThickness, offset=[0, 0], sideSupportSizeY, blockHeightExtra=0) {
    fillet = 1.5;
    yFillet = 5;
    baseFillet = 3;

    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(NEMA_width);
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();


    tabHeight = bracketHeight - eSize;
    height = tabHeight + blockHeightExtra;

    difference() {
        union() {
            linear_extrude(height)
                difference() {
                    translate([eSize, eY + eSize])
                        rounded_square([size.x - eSize, eSize], fillet, center=false);
                    translate([coreXYPosBL.x + separation.x/2 + coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, coreXYPosTR.y + offset.y])
                        NEMA_screw_positions(NEMA_type) {
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
                translate([0, eY + eSize - (sideSupportSizeY < 0 ? size.y - eSize : sideSupportSizeY), 0])
                    rounded_cube_xy([eSize, (sideSupportSizeY < 0 ? size.y - eSize : sideSupportSizeY), tabHeight + eSize], fillet);
        }
        translate([0, eY + 2*eSize - size.y - eps, -eps])
            fillet(yFillet, tabHeight + eSize + 2*eps);
        for (x = upperBoltPositions(size.x))
            translate([x + eSize, eY + 3*eSize/2, -eps])
                boltHoleM4HangingCounterboreButtonhead(5 + 2*eps, boreDepth=height - 5, boltHeadTolerance=boltHeadTolerance);
        translate([eSize/2, eY + 3*eSize/2 - (sideSupportSizeY < 0 ? size.y - eSize : sideSupportSizeY), -eps])
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
    if (sideSupportSizeY == 0)
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
    if (sideSupportSizeY == 0)
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

module xyMotorMount(left, bracketHeight, basePlateThickness, offset=[0, 0], sideSupportSizeY, blockHeightExtra=0) {
    size = [offset.x + eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + NEMA_width/2, -offset.y + eY + 2*eSize + NEMA_width/2, eZ + basePlateThickness] - coreXYPosTR(NEMA_width);

    xyMotorMountBase(left, [size.x, size.y, basePlateThickness], offset, sideSupportSizeY);
    translate_z(basePlateThickness - eps)
        xyMotorMountBlock(size, bracketHeight, basePlateThickness, offset, sideSupportSizeY, blockHeightExtra);
}

/*
module xyMotorMountRight(bracketHeight, basePlateThickness, offset=[0, 0], blockHeightExtra=0) {
    fillet = 1.5;
    yFillet = 5;
    baseFillet = 3;
    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(NEMA_width);
    size = [-offset.x + eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + NEMA_width/2, -offset.y + eY + 2*eSize + NEMA_width/2, eZ + basePlateThickness]  - coreXYPosTR;

    separation = coreXYSeparation();
    coreXY_type = coreXY_type();

    difference() {
        linear_extrude(basePlateThickness, convexity=2) {
            difference() {
                translate([eX + 2*eSize - size.x, eY + 2*eSize - size.y, 0])
                    rounded_square([size.x, size.y], baseFillet, center=false);
                //xyMotorMountBaseCutouts(left=false, size, offset);
                translate([eX + eSize, eY + eSize])
                    square([eSize, eSize]);
                translate([eX + 2*eSize, eY + 2*eSize - size.y])
                    rotate(90)
                        fillet(yFillet);
                translate([eX + eSize, eY + 2*eSize])
                    rotate(180)
                        fillet(fillet);
                translate([eX + 2*eSize, eY + eSize])
                    rotate(180)
                        fillet(fillet);
                translate([coreXYPosTR.x - separation.x/2, coreXYPosTR.y + offset.y]) {
                    translate([-coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0]) {
                        poly_circle(r = NEMA_boss_radius(NEMA_type));
                        *NEMA_screw_positions(NEMA_type)
                            poly_circle(r = M3_clearance_radius);
                    }
                    *translate([-coreXY_drive_plain_idler_offset(coreXY_type).x, coreXY_drive_plain_idler_offset(coreXY_type).y])
                        poly_circle(r = M3_tap_radius);
                    *translate(coreXY_drive_toothed_idler_offset(coreXY_type))
                        poly_circle(r = M3_tap_radius);
                }
            }
        }
        translate([coreXYPosTR.x - separation.x/2, coreXYPosTR.y + offset.y]) {
            translate([-coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0])
                NEMA_screw_positions(NEMA_type)
                    boltHoleM3(basePlateThickness, twist=5);
            translate([-coreXY_drive_plain_idler_offset(coreXY_type).x, coreXY_drive_plain_idler_offset(coreXY_type).y + rightDrivePlainIdlerOffset.y])
                boltHoleM3Tap(basePlateThickness);
            translate(coreXY_drive_toothed_idler_offset(coreXY_type))
                boltHoleM3Tap(basePlateThickness);
        }
        for (x = upperBoltPositions(size.x))
            translate([x + eX + 2*eSize - size.x, eY + 3*eSize/2, -eps])
                boltHoleM4HangingCounterboreButtonhead(5 + 2*eps, boreDepth=height - 5, boltHeadTolerance=boltHeadTolerance);
    }

    tabHeight = bracketHeightRight - eSize + basePlateThickness;
    height = tabHeight + blockHeightExtra;

    difference() {
        translate([eX + 2*eSize - size.x, eY + eSize, 0])
            rounded_cube_xy([size.x-eSize, eSize, height], fillet);
        translate([coreXYPosTR.x - separation.x/2, coreXYPosTR.y + offset.y])
            translate([-coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0])
                NEMA_screw_positions(NEMA_type) {
                    cutout = 6.5;
                    cylinder(d = cutout, h = height + eps);
                    translate([-cutout/2, -cutout, 0])
                        cube([cutout, cutout, height + eps]);
                    translate([cutout/2, motorClearance().y - 14.35, 0])
                        fillet(1, height + eps);
                    translate([-cutout/2, motorClearance().y - 14.35, 0])
                        rotate(90)
                            fillet(1, height + eps);
                }
        for (x = upperBoltPositions(size.x))
            translate([x + eX + 2*eSize - size.x, eY + 3*eSize/2, -eps])
                boltHoleM4HangingCounterboreButtonhead(5 + 2*eps, boreDepth=height - 5, boltHeadTolerance=boltHeadTolerance);
    }

    translate([eX + eSize, eY + eSize - bracketThickness, 0]) {
        translate([0, bracketThickness, 0])
            rotate(180) {
                fillet = 5;
                translate([-fillet, 0, 0])
                    cube([fillet, fillet, height]);
                translate([0, -fillet, 0])
                    cube([fillet, fillet, height]);
                fillet(fillet, height);
            }
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
        translate([bracketThickness, 0, basePlateThickness]) {
            rotate([90, 0, -90])
                rounded_right_triangle(size.y-eSize-bracketThickness, tabHeight + eSize - basePlateThickness, bracketThickness, 0.5, center=false, offset=true);
            translate([-bracketThickness, 0, 0])
                cube([bracketThickness, bracketThickness/2, tabHeight + eSize - basePlateThickness]);
            rotate(270)
                fillet(1, tabHeight + eSize - basePlateThickness - 2);
        }
    }
}
*/

module XY_Motor_Mount_hardware(sideSupportSizeY=0, corkDamperThickness=0, blockHeightExtra=0, left=true) {

    offset = left ? leftDrivePulleyOffset() : rightDrivePulleyOffset();
    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(NEMA_width);
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();

    stepper_motor_cable(eZ - 100 + eX + eY/2 + 300);
    translate([coreXYPosBL.x + separation.x/2, coreXYPosTR.y + offset.y, eZ - eSize - (left ? bracketHeightLeft : bracketHeightRight)]) {
        translate([coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0, 0]) {
            translate_z(-basePlateThickness - corkDamperThickness) {
                rotate(-90)
                    NEMA(NEMA_type, jst_connector = true);
                corkDamper(NEMA_type, corkDamperThickness);
            }
            vflip()
                translate_z(-pulley_height(coreXY_drive_pulley(coreXY_type)))
                    pulley(coreXY_drive_pulley(coreXY_type()));
            boltLength = screw_shorter_than(NEMA_hole_depth + basePlateThickness + corkDamperThickness);
            NEMA_screw_positions(NEMA_type)
                boltM3Buttonhead(boltLength);
        }

        translate(coreXY_drive_plain_idler_offset(coreXY_type) + (left ? leftDrivePlainIdlerOffset : rightDrivePlainIdlerOffset)) {
            translate_z(pulley_height(coreXY_toothed_idler(coreXY_type)))
                screw(M3_cap_screw, 16);
                washer(M3_washer)
                    pulley(useMotorIdler20 ? GT2x20_plain_idler : coreXY_plain_idler(coreXY_type));
        }
        translate(coreXY_drive_toothed_idler_offset(coreXY_type)) {
            translate_z(pulley_height(coreXY_toothed_idler(coreXY_type)))
                screw(M3_cap_screw, 16);
            washer(M3_washer)
                pulley(coreXY_toothed_idler(coreXY_type));
        }
    }

    size = [offset.x + eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + NEMA_width/2, -offset.y + eY + 2*eSize + NEMA_width/2, eZ + basePlateThickness] - coreXYPosTR;
    for (x = upperBoltPositions(size.x))
        translate([x + eSize, eY + 3*eSize/2, eZ - 2*eSize - 5 + blockHeightExtra])
            vflip()
                boltM4ButtonheadHammerNut(_frameBoltLength);
    if (sideSupportSizeY)
        translate([eSize/2, eY + 3*eSize/2 - (sideSupportSizeY < 0 ? size.y - eSize : sideSupportSizeY),  eZ - eSize - 5])
            vflip()
                boltM4ButtonheadHammerNut(_frameBoltLength);
    else
        translate([eSize/2, eY + eSize - bracketThickness, eZ - eSize - frameBoltOffsetZ])
            rotate([90, 0, 0])
                boltM4ButtonheadHammerNut(_frameBoltLength, rotate=90);
}

module XY_Motor_Mount_Right_hardware(corkDamperThickness=0, blockHeightExtra=0) {

    offset = rightDrivePulleyOffset();
    coreXYPosBL = coreXYPosBL();
    coreXYPosTR = coreXYPosTR(NEMA_width);
    separation = coreXYSeparation();
    coreXY_type = coreXY_type();

    stepper_motor_cable(eZ - 100 + eY/2 + 200);
    translate([coreXYPosTR.x - separation.x/2, coreXYPosTR.y + offset.y, eZ - eSize - bracketHeightRight]) {
        translate([-coreXY_drive_pulley_x_alignment(coreXY_type) + offset.x, 0, 0]) {
            translate_z(-basePlateThickness - corkDamperThickness) {
                rotate(90)
                    NEMA(NEMA_type, jst_connector = true);
                corkDamper(NEMA_type, corkDamperThickness);
            }
            vflip()
                translate_z(-pulley_height(coreXY_drive_pulley(coreXY_type)))
                    pulley(coreXY_drive_pulley(coreXY_type()));
            boltLength = screw_shorter_than(NEMA_hole_depth + basePlateThickness);
            NEMA_screw_positions(NEMA_type)
                boltM3Buttonhead(boltLength);
        }
        translate([-coreXY_drive_plain_idler_offset(coreXY_type).x, coreXY_drive_plain_idler_offset(coreXY_type).y + rightDrivePlainIdlerOffset.y, 0] ) {
            translate_z(pulley_height(coreXY_toothed_idler(coreXY_type)))
                screw(M3_cap_screw, 16);
            washer(M3_washer)
                pulley(useMotorIdler20 ? GT2x20_plain_idler : coreXY_plain_idler(coreXY_type));
        }
        translate(coreXY_drive_toothed_idler_offset(coreXY_type)) {
            translate_z(pulley_height(coreXY_toothed_idler(coreXY_type)))
                screw(M3_cap_screw, 16);
            washer(M3_washer)
                pulley(coreXY_toothed_idler(coreXY_type));
        }
    }
    *translate([eX + 3*eSize/2, eY + eSize - bracketThickness, eZ - eSize - frameBoltOffsetZ])
        rotate([90, 0, 0])
            boltM4ButtonheadHammerNut(_frameBoltLength, rotate=90);

    size = [-offset.x + eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + NEMA_width/2, -offset.y + eY + 2*eSize + NEMA_width/2, eZ + basePlateThickness]  - coreXYPosTR;
    for (x = upperBoltPositions(size.x))
        translate([x + eX + 2*eSize - size.x, eY + 3*eSize/2, eZ - 2*eSize - 5 + blockHeightExtra])
            vflip()
                boltM4ButtonheadHammerNut(_frameBoltLength);
    translate([eX + 3*eSize/2, eY + 3*eSize/2 - (sideSupportSizeY < 0 ? size.y - eSize : sideSupportSizeY),  eZ - eSize - 5])
        vflip()
            boltM4ButtonheadHammerNut(_frameBoltLength);
}

module XY_Motor_Mount_Left_stl() {
    offset = leftDrivePulleyOffset();
    //coreXYPosBL = coreXYPosBL();
    //separation = coreXYSeparation();

    stl("XY_Motor_Mount_Left")
        color(pp1_colour)
            translate_z(eZ - eSize - basePlateThickness - bracketHeightLeft)
            //translate_z(coreXYPosBL.z - basePlateThickness - washer_thickness(M3_washer))
                xyMotorMount(true, bracketHeightLeft, basePlateThickness, offset, sideSupportSizeY, blockHeightExtra=blockHeightExtra);
}

module XY_Motor_Mount_Left_assembly()
assembly("XY_Motor_Mount_Left", ngb=true) {

    stl_colour(pp1_colour)
        XY_Motor_Mount_Left_stl();
    XY_Motor_Mount_hardware(sideSupportSizeY=sideSupportSizeY, corkDamperThickness=_corkDamperThickness, blockHeightExtra=blockHeightExtra);
}

module XY_Motor_Mount_Right_stl() {
    offset = rightDrivePulleyOffset();
    //coreXYPosBL = coreXYPosBL();
    //separation = coreXYSeparation();

    stl("XY_Motor_Mount_Right")
        color(pp1_colour)
            translate_z(eZ - eSize - basePlateThickness - bracketHeightRight) {
            //translate_z(coreXYPosBL.z - separation.z - basePlateThickness - washer_thickness(M3_washer))
                *xyMotorMountRight(bracketHeightRight, basePlateThickness, offset=offset, blockHeightExtra=blockHeightExtra);
                translate([eX + 4*eSize/2, 0, 0])
                    mirror([1, 0, 0])
                        xyMotorMount(false, bracketHeightRight, basePlateThickness, -offset, sideSupportSizeY, blockHeightExtra=blockHeightExtra);
            }
}

module XY_Motor_Mount_Right_assembly()
assembly("XY_Motor_Mount_Right", ngb=true) {

    stl_colour(pp1_colour)
        XY_Motor_Mount_Right_stl();
    XY_Motor_Mount_Right_hardware(corkDamperThickness=_corkDamperThickness, blockHeightExtra=blockHeightExtra);
}
