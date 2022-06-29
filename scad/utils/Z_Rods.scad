include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/pillow_blocks.scad>
include <NopSCADlib/vitamins/rod.scad>
include <NopSCADlib/vitamins/sk_brackets.scad>

use <../printed/E20Cover.scad>
use <../printed/JubileeKinematicBed.scad>
use <../printed/Z_MotorMount.scad>

include <../vitamins/extrusion.scad>
include <../vitamins/nuts.scad>


function useDualZRods() = !is_undef(_useDualZRods) && _useDualZRods;
function useDualZMotors() = !is_undef(_useDualZMotors) && _useDualZMotors;


module sk_bracket_with_bolts(type) {
    sk_bracket(type);
    screw_separation = sk_screw_separation(type);

    for (i = [-screw_separation / 2, screw_separation / 2])
        translate([i, sk_base_height(type) - sk_hole_offset(type), 0])
            rotate([90, 0, 180])
                translate_z(0.5)
                    boltM4CountersunkTNut(_frameBoltLength);
}

module KP_PillowBlockSpacer_stl() {
    stl("KP_PillowBlockSpacer")
        kp_pillow_block_spacer(KP08_18);
}

module kp_pillow_block_spacer(type) {
    size =[eSize, kp_size(type).x + 1, _zRodOffsetX - kp_hole_offset(type)];
    translate([0, -kp_hole_offset(type), 0])
        rotate([90, 90, 0])
            difference() {
                rounded_cube_xy(size, 2, xy_center=true);
                for (i = [-kp_screw_separation(type)/2, kp_screw_separation(type)/2])
                    translate([0, i, 0])
                        boltHoleM4(size.z);
            }
}

module kp_pillow_block_with_bolts(type) {
    kp_pillow_block(type);
    explode([0, -10, 0])
        KP_PillowBlockSpacer_stl();

    for (i = [-kp_screw_separation(type)/2, kp_screw_separation(type)/2])
        translate([i, kp_base_height(type) - kp_hole_offset(type), 0])
            rotate([90, 0, 0])
                explode(1, true)
                    boltM4ButtonheadTNut(16);
}

module zMounts() {
    SK_type = _zRodDiameter == 8 ? SK8 : _zRodDiameter == 10 ? SK10 : SK12;
    translate([eSize, 0, eSize/2]) {
        explode([30, -100, 0])
            rotate([0, 90, 0])
                zRodMountGuide(_zRodOffsetY - sk_size(SK_type).x/2);
        translate([_zRodOffsetX, _zRodOffsetY, 0])
            rotate([0, 180, -90]) {
                explode([-70, 30, 0], true)
                    sk_bracket_with_bolts(SK_type);
                explode([70, 30, 0], true)
                    translate([zRodSeparation(), 0, 0])
                        hflip()
                            sk_bracket_with_bolts(SK_type);
            }
    }
}

module zMountsUpper() {
    zMounts();

    *translate([eSize + _zRodOffsetX, _zRodOffsetY, eSize])
        rotate([0, 180, -90])
            explode([0, 40, 0], true)
                translate([zRodSeparation()/2, 0, 0])
                    zLeadScrewBearingHolder_stl();

    *translate([eSize + _zRodOffsetX, _zRodOffsetY, eSize/2])
        rotate([0, 180, -90])
            explode([0, 40, 0], true)
                translate([zRodSeparation()/2, 0, 0])
                    kp_pillow_block_with_bolts(KP08_18);
}

module zMountsLower(zMotorLength, includeMotor=false) {
    translate_z(_upperZRodMountsExtrusionOffsetZ - _zRodLength + eSize - 5)
        zMounts();

    if (zMotorLength)
        translate([0, _zRodOffsetY, 0]) {
            // add the motor mount
            explode([30, 0, 20], true)
                translate([0, zRodSeparation()/2, 0]) {
                    stl_colour(pp1_colour)
                        vflip()
                            Z_Motor_Mount_stl();
                    Z_Motor_Mount_hardware();
                    if (includeMotor)
                        Z_Motor_Mount_Motor_hardware();
                }

            SK_type = _zRodDiameter == 8 ? SK8 : _zRodDiameter == 10 ? SK10 : SK12;
            explode([20, -20, 0])
                translate([eSize, sk_size(SK_type).x/2, 3*eSize/2])
                    rotate([0, 90, 0])
                        zMotorMountGuide((zRodSeparation() - Z_Motor_MountSize(zMotorLength).x - sk_size(SK_type).x)/2);
        }
}

module zMotor(explode=_zRodLength + 40) {
    translate([0, eSize + _zRodOffsetY + zRodSeparation()/2, 0])
        Z_Motor_Mount_Motor_hardware(explode);
}

module zRods(left=true) {
    explode(-_zRodLength + 100)
        translate([left ? eSize + _zRodOffsetX : eX + eSize -_zRodOffsetX, eSize + _zRodOffsetY, _upperZRodMountsExtrusionOffsetZ + eSize - _zRodLength/2 - 2.5]) {
            rod(d=_zRodDiameter, l=_zRodLength);
            translate([0, zRodSeparation(), 0])
                rod(d=_zRodDiameter, l=_zRodLength);
        }
}

module zRails(bedHeight=100, left=true, useElectronicsInBase=false) {
    railZPos = bedHeight - 34;
    carriageHeight = carriage_height(is_undef(_zCarriageDescriptor) ? MGN12C_carriage : carriageType(_zCarriageDescriptor));
    if (left) {
        for (y = [0, _printbedArmSeparation])
            translate([0, y + _zRodOffsetY, 0]) {
                translate_z(2*eSize)
                    extrusionOZ(eZ - 150);
                translate([eSize/2, eSize, eZ - 150 + 2*eSize])
                    rotate([-90, 0, 90])
                        extrusionInnerCornerBracket();
                translate([eSize/2, 0, eZ - 150 + 2*eSize])
                    rotate([-90, 0, -90])
                        extrusionInnerCornerBracket();
                translate_z(3*eSize/2)
                    zRail(railZPos, left=true);
                translate([0, 10, 0])
                    Z_Motor_Mount_KB_assembly();
            }
        translate([eSize + carriageHeight, _zRodOffsetY + eSize/2, railZPos + 12.5]) {
            //rotate([90, 0, 90]) Z_Carriage_Left_Front_stl();
            Z_Carriage_Left_Front_assembly();
            translate([0, _printbedArmSeparation, 0])
                //rotate([90, 0, 90]) Z_Carriage_Left_Back_stl();
                Z_Carriage_Left_Back_assembly();
        }
    } else {
        translate([eX + eSize, _zRodOffsetY + _printbedArmSeparation/2, 0]) {
            translate_z(useElectronicsInBase ? eSize : 2*eSize)
                extrusionOZ(eZ - (useElectronicsInBase ? 130 : 150));
            translate([eSize/2, eSize, eZ - 150 + 2*eSize])
                rotate([-90, 0, 90])
                    extrusionInnerCornerBracket();
            translate([eSize/2, 0, eZ - 150 + 2*eSize])
                rotate([-90, 0, -90])
                    extrusionInnerCornerBracket();
            translate_z(3*eSize/2)
                zRail(railZPos, left=false);
            translate([eSize, 10, 0])
                rotate(180)
                    Z_Motor_Mount_Right_KB_assembly();
            translate([-carriageHeight + 15, eSize/2, railZPos + 12.5])
                //rotate([90, 0, -90]) Z_Carriage_Right_Center_stl();
                Z_Carriage_Right_Center_assembly();
        }
    }
}

module zRail(carriagePosition, zCarriageType=undef, left=true) {
    zCarriageType = is_undef(zCarriageType) ? (is_undef(_zCarriageDescriptor) ? MGN12C_carriage : carriageType(_zCarriageDescriptor)) : zCarriageType;
    zRailLength = is_undef(_zRailLength) ? eZ - 100 : _zRailLength;
    translate([left ? eSize : 0, eSize/2, zRailLength/2])
        rotate([0, 90, left ? 0 : 180])
            if (is_undef($hide_rails) || $hide_rails == false)
                rail_assembly(zCarriageType, zRailLength, -carriagePosition + zRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
}
