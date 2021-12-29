include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

include <NopSCADlib/vitamins/shaft_couplings.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>
use <NopSCADlib/utils/rounded_triangle.scad>

use <../../../BabyCube/scad/vitamins/CorkDamper.scad>

include <../utils/motorTypes.scad>

include <../vitamins/bolts.scad>
include <../vitamins/extrusionBracket.scad>
include <../vitamins/cables.scad>
use <../vitamins/leadscrew.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


NEMA17_40L230 = ["NEMA17_40L230", 42.3,   40,   53.6/2, 25,     11,     2,     8,     [230, 8, 2], 31,    [8,     8], 3,    false, false, 0,       0];
NEMA17_40L280 = ["NEMA17_40L280", 42.3,   40,   53.6/2, 25,     11,     2,     8,     [280, 8, 2], 31,    [8,     8], 3,    false, false, 0,       0];
NEMA17_40L330 = ["NEMA17_40L330", 42.3,   40,   53.6/2, 25,     11,     2,     8,     [330, 8, 2], 31,    [8,     8], 3,    false, false, 0,       0];

NEMA_motorWidth = !is_undef(_zMotorDescriptor) && _zMotorDescriptor == "NEMA14" ? 36 : 43; // not part of standard, may vary, so give some clearance
zMotorType = motorType(is_undef(_zMotorDescriptor) ? "NEMA17_40" : _zMotorDescriptor);

//wingSizeX = 13; // so overall X size is 79, so Z_Motor_MountGuide_length is an integer
wingSizeX = 7;
motorBracketSizeZ = 5;
motorBracketSizeX = NEMA_motorWidth + 2*motorBracketSizeZ;
counterBoreDepth = 0;//1.5;

function Z_Motor_MountSize(motorLength=NEMA_length(zMotorType), zLeadScrewOffset=_zLeadScrewOffset)
    = [2*wingSizeX + motorBracketSizeX, zLeadScrewOffset + NEMA_motorWidth/2 - 1 + eSize, motorLength + motorBracketSizeZ + 1 + (is_undef(_corkDamperThickness) ? 0 : _corkDamperThickness)];

module NEMA_baseplate(NEMA_type, size, zLeadScrewOffset=_zLeadScrewOffset) {
    assert(isNEMAType(NEMA_type));

    difference() {
        rounded_cube_xy(size, 1);
        translate([size.x/2, zLeadScrewOffset, -eps]) {
            tolerance = 1.0;
            // center circle for the motor boss
            poly_cylinder(r=NEMA_boss_radius(NEMA_type) + tolerance, h=size.z + 2*eps);
            // motor boltholes
            NEMA_screw_positions(NEMA_type)
                hull() {
                    translate([0, -tolerance/2, 0])
                        poly_cylinder(r=M3_clearance_radius, h=size.z + 2*eps, sides=8, twist=0);
                    translate([0, tolerance/2, 0])
                        poly_cylinder(r=M3_clearance_radius, h=size.z + 2*eps, sides=8, twist=0);
                }
        }
    }
    *translate([0, 0, size.z-0.25]) cube([size.x, size.y, 0.25]); // to bridge the holes for printing
}

module zMotorMount(zMotorType, eHeight=40, printbedKinematic=false) {
    assert(isNEMAType(zMotorType));

    zLeadScrewOffset = printbedKinematic ? 30 : _zLeadScrewOffset;
    size = Z_Motor_MountSize(NEMA_length(zMotorType), zLeadScrewOffset);
    motorBracketSizeY = zLeadScrewOffset + NEMA_motorWidth/2;
    blockSizeZ = size.z - eHeight;

    translate([wingSizeX, eSize, size.z - motorBracketSizeZ]) difference() {
        union() {
            reduce = 1;
            translate([reduce, 0, 0])
                NEMA_baseplate(zMotorType, [motorBracketSizeX-2*reduce, motorBracketSizeY, motorBracketSizeZ], zLeadScrewOffset);
            *translate([0, 5, -size.z + motorBracketSizeZ + 4]) rotate([0, 0, 90]) fillet(2, size.z-4);
            *translate([motorBracketSizeX, 5, -size.z + motorBracketSizeZ + 4]) fillet(2, size.z-4);
            // add the braces
            braceSize = [motorBracketSizeY - motorBracketSizeZ - 1, size.z - motorBracketSizeZ - 7, motorBracketSizeZ - reduce];
            for (x = [motorBracketSizeZ, motorBracketSizeX - reduce])
                translate([x, motorBracketSizeZ, 0])
                    rotate([-90, 0, 90])
                        rounded_right_triangle(braceSize.x, braceSize.y, braceSize.z, 0.75, center=false, offset=true);

            wingSizeZ = size.z - 2*eSize;
            translate_z(motorBracketSizeZ - wingSizeZ) {
                translate([-wingSizeX, 0, 0])
                    cube([wingSizeX + motorBracketSizeZ, motorBracketSizeZ, wingSizeZ]);
                translate([-wingSizeX, 0, -2*eSize])
                    cube([wingSizeX + motorBracketSizeZ, motorBracketSizeZ, 2*eSize]);
                translate([motorBracketSizeX - motorBracketSizeZ, , 0])
                    cube([wingSizeX + motorBracketSizeZ, motorBracketSizeZ, wingSizeZ]);
                translate([motorBracketSizeX - motorBracketSizeZ, 0, -2*eSize])
                    cube([wingSizeX + motorBracketSizeZ, motorBracketSizeZ, 2*eSize]);
            }

            // add the block
            translate([-wingSizeX, -eSize, motorBracketSizeZ - blockSizeZ])
                rotate([90, 0, 90])
                        difference() {
                            fillet = 1;
                            if (printbedKinematic)
                                union() {
                                    rounded_cube_xz([eSize + fillet, blockSizeZ, (size.x - eSize)/2], fillet);
                                    translate([eSize, blockSizeZ - motorBracketSizeZ, (size.x - eSize)/2]) {
                                        rotate([-90, 180, 0])
                                            fillet(0.5, motorBracketSizeZ);
                                        translate([0, 0, eSize])
                                            rotate([-90, 90, 0])
                                                fillet(0.5, motorBracketSizeZ);
                                    }
                                    translate_z((size.x + eSize)/2)
                                        rounded_cube_xz([eSize + fillet, blockSizeZ, (size.x - eSize)/2], fillet);
                                }
                            else
                                rounded_cube_xz([eSize + fillet, blockSizeZ, size.x], fillet);
                            cutSize = eSize;//min(eSize, blockSizeZ);
                            if (eHeight == 20)
                                translate([-eps, blockSizeZ + eps, -eps])
                                    rotate(-90)
                                        linear_extrude(size.x + 2*eps)
                                            right_triangle(cutSize, cutSize);
                        }
        } // end union

        if (printbedKinematic)
            translate([-wingSizeX, -eSize, motorBracketSizeZ - blockSizeZ])
                rotate([90, 0, 90])
                    translate([-eps, -eps, (size.x - eSize)/2]) {
                        fillet = 1;
                        railCutoutSize = [8 + 2*fillet, blockSizeZ + 2*eps, 12.5];
                        translate([eSize, 0, (eSize - railCutoutSize.z)/2]) {
                            translate([-fillet, 0, 0])
                                rounded_cube_xz(railCutoutSize, fillet);
                            rotate([-90, 0, 0])
                                fillet(fillet, blockSizeZ + 2*eps);
                            translate([0, 0, railCutoutSize.z])
                                rotate([-90, -90, 0])
                                    fillet(fillet, blockSizeZ + 2*eps);
                        }
                    }
        // fillet the wings
        translate([-wingSizeX, motorBracketSizeZ, -size.z + motorBracketSizeZ + eps])
            rotate(-90)
                fillet(1, size.z + 2*eps);
        translate([size.x - wingSizeX, motorBracketSizeZ, -size.z + motorBracketSizeZ + eps])
            rotate(180)
                fillet(1, size.z + 2*eps);
        // fillet the base
        translate([0, motorBracketSizeY, -1])
            rotate(-90)
                fillet(1, motorBracketSizeZ + 1);
        translate([motorBracketSizeX, motorBracketSizeY, -1])
            rotate(180)
                fillet(1, motorBracketSizeZ + 1);

        // add the main boltholes
        translate([0, -eSize/2, motorBracketSizeZ]) {
            topHolePitch = printbedKinematic ? eSize + 27 : NEMA_hole_pitch(zMotorType);
            for (x = [topHolePitch/2, -topHolePitch/2])
                translate([motorBracketSizeX/2 + x, 0, 0])
                    vflip()
                        if (eHeight==20)
                            boltHoleM4HangingCounterboreButtonhead(blockSizeZ, boreDepth=blockSizeZ - 5);
                        else
                            boltHoleM4(blockSizeZ);
        }
        // add the boltholes on the wings
        for (x = [wingSizeX/2 + 0.75, size.x - wingSizeX/2 - 0.75])
            translate([x - wingSizeX, 0, -size.z + eSize - motorBracketSizeZ])
                 rotate([-90, 0, 0])
                    boltHoleM4(motorBracketSizeZ, horizontal=true);
    }
}

module Z_Motor_Mount_stl() {
    // invert Z_Motor_Mount so it can be printed without support
    stl("Z_Motor_Mount")
        color(pp1_colour)
            translate([0, -Z_Motor_MountSize(NEMA_length(zMotorType)).x/2, 0])
                rotate([180, 0, 90])
                    zMotorMount(zMotorType);
}

module Z_Motor_Mount_KB_stl() {
    // invert Z_Motor_Mount so it can be printed without support
    stl("Z_Motor_Mount_KB")
        color(pp3_colour)
            translate([0, -Z_Motor_MountSize(NEMA_length(zMotorType)).x/2, 0])
                rotate([180, 0, 90])
                    zMotorMount(zMotorType, printbedKinematic=true);
}

module zMotorLeadscrew(zMotorType, zLeadScrewLength) {
    zLeadScrewLength = _zRodLength - 50;
    translate([eSize+_zLeadScrewOffset, 0, Z_Motor_MountSize(NEMA_length(zMotorType)).z - motorBracketSizeZ + zLeadScrewLength/2 + NEMA_shaft_length(NEMA_type) + 2])
        leadscrewX(_zLeadScrewDiameter, zLeadScrewLength);
}

module Z_Motor_Mount_Motor_hardware(explode=50, zLeadScrewOffset=_zLeadScrewOffset) {
    corkDamperThickness = is_undef(_corkDamperThickness) ? 0 : _corkDamperThickness;

    stepper_motor_cable(eX + eY + 150);// z motor

    size = Z_Motor_MountSize(NEMA_length(zMotorType));
    translate([eSize + zLeadScrewOffset, 0, size.z - motorBracketSizeZ - corkDamperThickness]) {
        if (corkDamperThickness)
            explode(-explode + 10)
                corkDamper(zMotorType, corkDamperThickness);
        explode(-explode, true)  {
            shaft_length = NEMA_shaft_length(zMotorType);
            if (is_list(shaft_length)) {
                if (bom_mode()) {
                    rotate(-90)
                        not_on_bom() NEMA(zMotorType, jst_connector = true);
                    vitamin(str("NEMA(", zMotorType[0], "): Stepper motor NEMA", round(NEMA_width(zMotorType) / 2.54), " x ", NEMA_length(zMotorType), "mm, ", shaft_length[0], "mm integrated leadscrew"));
                } else {
                    // integrated lead screw, so set shaft length to zero and use leadscrewX rather than NopSCADlib leadscrew
                    NEMA_no_shaft = [ for (i = [0 : len(zMotorType) - 1]) i==8 ? [1, shaft_length[1], shaft_length[2]] : zMotorType[i] ];
                    no_explode() {
                        rotate(-90)
                            NEMA(NEMA_no_shaft, jst_connector = true);
                        translate_z(eps)
                            leadscrewX(shaft_length[1], shaft_length[0], shaft_length[2], center=false);
                    }
                }
            } else {
                // no integrated lead screw, so add lead screw and coupling
                rotate(-90)
                    NEMA(zMotorType, jst_connector = true);
                translate_z(NEMA_shaft_length(motorType)) {
                    explode(80)
                        shaft_coupling(SC_5x8_rigid, colour = grey(30));
                    zLeadScrewLength = _zRodLength - 50;
                    leadscrewX(_zLeadScrewDiameter, zLeadScrewLength, center=false);
                }
            }
        }
    }
    NEMA_screw_positions(zMotorType)
        translate([eSize + zLeadScrewOffset, 0, size.z - counterBoreDepth])
            boltM3Buttonhead(screw_shorter_than(5 + motorBracketSizeZ - counterBoreDepth + corkDamperThickness));
}

module Z_Motor_Mount_hardware(printbedKinematic=false) {
    size = Z_Motor_MountSize(NEMA_length(zMotorType));
    eHeight = 40;

    // add the main bolts
    topHolePitch = printbedKinematic ? eSize + 20 : NEMA_hole_pitch(zMotorType);
    if (printbedKinematic) {
        *for (y = [topHolePitch/2, -topHolePitch/2])
            translate([eSize/2, y, size.z])
                boltM4Buttonhead(_frameBoltLength);
        translate([eSize/2, eSize/2, size.z - 8])
            rotate([90, 0, 90])
                extrusionInnerCornerBracket(grubCount=1, boltLength=12, boltOffset=1);
        translate([eSize/2, -eSize/2, size.z - 8])
            rotate([90, 0, -90])
                extrusionInnerCornerBracket(grubCount=1, boltLength=12, boltOffset=1);
    } else {
        for (y = [topHolePitch/2, -topHolePitch/2])
            translate([eSize/2, y, size.z])
                boltM4ButtonheadTNut(eHeight==40 ? 12 : _frameBoltLength, rotate=90);
    }
    // add the bolts on the wings
    for (y = [size.x/2 - wingSizeX/2 - 0.75, -size.x/2 + wingSizeX/2 + 0.75])
        translate([eSize + motorBracketSizeZ, y, eSize - 2*motorBracketSizeZ])
            rotate([90, 0, 90])
                boltM4ButtonheadTNut(_frameBoltLength);
}

//!1. Bolt the motor and the cork damper to the **Z_Motor_Mount**. Note that the cork damper thermally insulates the motor
//!from the motor mount and should not be omitted.
//!2. Attach the other bolts and t-nuts loosely to the motor mount, for later attachment to the frame.
//
module Z_Motor_Mount_assembly() pose(a=[55, 0, 25 + 90])
assembly("Z_Motor_Mount", big=true, ngb=true) {

    vflip()
        stl_colour(pp1_colour)
            Z_Motor_Mount_stl();
    Z_Motor_Mount_hardware();
    Z_Motor_Mount_Motor_hardware();
}

module Z_Motor_Mount_KB_assembly() pose(a=[55, 0, 25 + 90])
assembly("Z_Motor_Mount_KB", big=true, ngb=true) {

    vflip()
        stl_colour(pp3_colour)
            Z_Motor_Mount_KB_stl();
    Z_Motor_Mount_hardware(printbedKinematic=true);
    Z_Motor_Mount_Motor_hardware(zLeadScrewOffset=30);
}

//!1. Bolt the motor and the cork damper to the **Z_Motor_Mount**. Note that the cork damper thermally insulates the motor
//!from the motor mount and should not be omitted.
//!2. Attach the other bolts and t-nuts loosely to the motor mount, for later attachment to the frame.
//
module Z_Motor_Mount_Right_assembly() pose(a=[55, 0, 25 + 90])
assembly("Z_Motor_Mount_Right", big=true, ngb=true) {

    vflip()
        stl_colour(pp1_colour)
            Z_Motor_Mount_Right_stl();
    Z_Motor_Mount_hardware();
    Z_Motor_Mount_Motor_hardware();
}
