include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>

include <NopSCADlib/vitamins/stepper_motors.scad>
include <NopSCADlib/vitamins/pin_headers.scad>
include <NopSCADlib/vitamins/shaft_couplings.scad>
use <NopSCADlib/utils/rounded_triangle.scad>

use <../../../BabyCube/scad/vitamins/CorkDamper.scad>

use <../vitamins/bolts.scad>
use <../vitamins/cables.scad>
use <../vitamins/leadscrew.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


NEMA17_40L230 = ["NEMA17_40L230", 42.3,   40,   53.6/2, 25,     11,     2,     8,     [230, 8, 2], 31,    [8,     8]];
NEMA17_40L280 = ["NEMA17_40L280", 42.3,   40,   53.6/2, 25,     11,     2,     8,     [280, 8, 2], 31,    [8,     8]];
NEMA17_40L330 = ["NEMA17_40L330", 42.3,   40,   53.6/2, 25,     11,     2,     8,     [330, 8, 2], 31,    [8,     8]];


NEMA_motorWidth = _zNemaType == "14" ? 36 : 43; // not part of standard, may vary, so give some clearance
NEMA_type =
    _zNemaType == "14" ? NEMA14 :
    _zNemaType == "17_40" ? NEMA17M :
    _zNemaType == "17_40L230" ? NEMA17_40L230 :
    _zNemaType == "17_40L280" ? NEMA17_40L280 :
    _zNemaType == "17_40L330" ? NEMA17_40L330 :
    undef;


//wingSizeX = 13; // so overall X size is 79, so Z_Motor_MountGuide_length is an integer
wingSizeX = 7;
motorBracketSizeZ = 5;
motorBracketSizeX = NEMA_motorWidth + 2*motorBracketSizeZ;
motorBracketSizeY = _zLeadScrewOffset + NEMA_motorWidth/2 - 1;
counterBoreDepth = 0;//1.5;

function Z_Motor_MountSize()
    = [2*wingSizeX + motorBracketSizeX, motorBracketSizeY + eSize, NEMA_length(NEMA_type) + motorBracketSizeZ + 2];

/*
module NEMA_MotorWithIntegratedLeadScrew(NEMA_type=NEMA_type) {
    vitamin(str("NEMA_MotorWithIntegratedLeadScrew(", NEMA_type, "): Stepper motor NEMA17 with integrated ", _zLeadScrewLength, "mm lead screw"));

    zLeadScrewLength = _zRodLength;

    not_on_bom() no_explode() {
        NEMA(NEMA_type, jst_connector = true);
        translate_z(zLeadScrewLength/2 - NEMA_length(NEMA_type))
            if (is_undef($hide_bolts))
                not_on_bom() leadscrewX(_zLeadScrewDiameter, zLeadScrewLength);
            else
                color(grey(70))
                    cylinder(h=zLeadScrewLength, d=_zLeadScrewDiameter, center=true);
        }
}
*/

//NEMA_baseplate([motorBracketSizeX, motorBracketSizeY, motorBracketSizeZ]);
module NEMA_baseplate(size) {
    difference() {
        cube(size);
        translate([size.x/2, _zLeadScrewOffset, 0]) {
            // center circle for the motor axle
            translate_z(-eps)
                poly_cylinder(r=NEMA_boss_radius(NEMA_type), h=size.z+2*eps);
            // motor boltholes
            NEMA_screw_positions(NEMA_type)
                boltHoleM3(size.z);
        }
    }
    *translate([0, 0, size.z-0.25]) cube([size.x, size.y, 0.25]); // to bridge the holes for printing
}

/*module Z_Motor_MountWing(wingSizeX) {
    rotate([90, 0, 0])
    difference() {
        size = [wingSizeX, eSize+motorBracketSizeZ, motorBracketSizeZ];
        cube(size);
        // don't fillet the wings, for easier printing
        //filletTopLeft(2, size);
        //filletBottomLeft(2, size);
        translate([wingSizeX/2, motorBracketSizeZ+eSize/2]) boltHoleM4(motorBracketSizeZ);
    }
    translate([wingSizeX/2, motorBracketSizeZ+eSize/2]) boltM4Buttonhead(_frameBoltLength);//!!TNut
}*/

//Z_Motor_MountBrace([motorBracketSizeY-motorBracketSizeZ, Z_Motor_MountSize().z-motorBracketSizeZ, motorBracketSizeZ]);
module Z_Motor_MountBrace(size) {
    rotate([90, 0, 90]) {
        //filletedInsetRightTriangle3d(size, 0.75, 3);
        rounded_right_triangle(size.x, size.y, size.z, 0.75, center=false, offset=true);
    }
    *difference() {
        rotate([90, 0, 90]) rightTriangle3d(size);
        angle = atan2(size.x, size.y);
        filletLength = sqrt(size.x*size.x+size.y*size.y);
        translate([0, size.x, 0]) rotate([0, angle, -90]) fillet(1, filletLength);
        translate([size.z, size.x, 0]) rotate([-angle, 0, 180]) fillet(1, filletLength);
    }
}

module zMotorMount(eHeight=40) {
    size = Z_Motor_MountSize();

    blockSizeZ = size.z - eHeight;
    offset = (motorBracketSizeX - NEMA_hole_pitch(NEMA_type))/2;

    color(pp1_colour)
    translate([wingSizeX, eSize, size.z - motorBracketSizeZ]) difference() {
        union() {
            reduce = 1;
            translate([reduce, 0, 0])
                NEMA_baseplate([motorBracketSizeX-2*reduce, motorBracketSizeY, motorBracketSizeZ]);
            epsilon = 1/128;
            *translate([0, 5, -size.z+motorBracketSizeZ+4]) rotate([0, 0, 90]) fillet(2, size.z-4);
            *translate([motorBracketSizeX, 5, -size.z+motorBracketSizeZ+4]) fillet(2, size.z-4);
            // add the braces
            braceSize = [motorBracketSizeY - motorBracketSizeZ, size.z - motorBracketSizeZ-7, motorBracketSizeZ - reduce];
            translate([braceSize.z+reduce, motorBracketSizeZ, 0]) rotate([0, 180, 0]) Z_Motor_MountBrace(braceSize);
            translate([motorBracketSizeX-reduce, motorBracketSizeZ, 0]) rotate([0, 180, 0]) Z_Motor_MountBrace(braceSize);

            wingSizeZ = size.z-2*eSize;
            translate_z(motorBracketSizeZ - wingSizeZ) {
                translate([-wingSizeX, 0, 0])
                    cube([wingSizeX + motorBracketSizeZ, motorBracketSizeZ, wingSizeZ]);
                translate([-wingSizeX, 0, -2*eSize])
                    cube([wingSizeX + motorBracketSizeZ, motorBracketSizeZ, 2*eSize]);
                translate([motorBracketSizeX - motorBracketSizeZ, , 0])
                    cube([wingSizeX+motorBracketSizeZ, motorBracketSizeZ, wingSizeZ]);
                translate([motorBracketSizeX - motorBracketSizeZ, 0, -2*eSize])
                    cube([wingSizeX+motorBracketSizeZ, motorBracketSizeZ, 2*eSize]);
            }

            // add the block
            translate([-wingSizeX, -eSize, motorBracketSizeZ - blockSizeZ])
                rotate([90, 0, 90]) {
                        difference() {
                            fillet = 1;
                            rounded_cube_xz([eSize + fillet, blockSizeZ, size.x], fillet);
                            cutSize = eSize;//min(eSize, blockSizeZ);
                            if (eHeight == 20)
                                translate([-eps, blockSizeZ + eps, -eps])
                                    rotate(-90)
                                        linear_extrude(size.x + 2*eps)
                                            right_triangle(cutSize, cutSize);
                        }
                    }
        }

        // fillet the wings
        translate([-wingSizeX, motorBracketSizeZ, -size.z+motorBracketSizeZ]) rotate([0, 0, -90]) fillet(1, size.z);
        translate([size.x-wingSizeX, motorBracketSizeZ, -size.z+motorBracketSizeZ]) rotate([0, 0, 180]) fillet(1, size.z);
        // fillet the base
        translate([0, motorBracketSizeY, -1]) rotate([0, 0, -90]) fillet(1, motorBracketSizeZ+1);
        translate([motorBracketSizeX, motorBracketSizeY, -1]) rotate([0, 0, 180]) fillet(1, motorBracketSizeZ+1);

        // add the main boltholes
        if (eHeight==20) {
            translate([0, -eSize/2, motorBracketSizeZ]) {
                translate([offset, 0, 0]) vflip() boltHoleM4Counterbore(blockSizeZ, boreDepth=blockSizeZ-5, bridgeThickness=0.5);
                translate([motorBracketSizeX-offset, 0, 0]) vflip() boltHoleM4Counterbore(blockSizeZ, boreDepth=blockSizeZ-5, bridgeThickness=0.5);
            }
        } else {
            translate([0, -eSize/2, motorBracketSizeZ]) {
                translate([offset, 0, 0]) vflip() boltHoleM4(blockSizeZ);
                translate([motorBracketSizeX-offset, 0, 0]) vflip() boltHoleM4(blockSizeZ);
            }
        }
        // add the boltholes on the wings
    for (x = [wingSizeX/2 + 0.75, size.x - wingSizeX/2 - 0.75])
            translate([x - wingSizeX, 0, -size.z + eSize - motorBracketSizeZ]) {
                 rotate([-90, 0, 0])
                    boltHoleM4(motorBracketSizeZ, horizontal=true);

            }
    }
    // add the main bolts
    for (x = [offset, motorBracketSizeX-offset])
        translate([x+wingSizeX, eSize/2, size.z])
            boltM4ButtonheadTNut(eHeight==40 ? 12 : _frameBoltLength);

    // add the bolts on the wings
    for (x = [wingSizeX/2 + 0.75, size.x - wingSizeX/2 - 0.75])
        translate([x, eSize + motorBracketSizeZ, eSize - 2*motorBracketSizeZ])
            rotate([90, 0, 180])
                boltM4ButtonheadTNut(_frameBoltLength);
}

module Z_Motor_Mount_stl() {
    // invert Z_Motor_Mount so it can be printed without support
    stl("Z_Motor_Mount")
        translate([0, -Z_Motor_MountSize().x/2, 0])
            rotate([180, 0, 90])
                zMotorMount();
}

module Z_Motor_Mount_Right_stl() {
    // invert Z_Motor_Mount so it can be printed without support
    stl("Z_Motor_Mount_Right")
        translate([0, -Z_Motor_MountSize().x/2, 0])
            rotate([180, 0, 90])
                zMotorMount(eHeight=20);
}

module zMotorLeadscrew(zLeadScrewLength) {
    zLeadScrewLength = _zRodLength - 50;
    translate([eSize+_zLeadScrewOffset, 0, Z_Motor_MountSize().z - motorBracketSizeZ + zLeadScrewLength/2 + NEMA_shaft_length(NEMA_type) + 2])
        leadscrewX(_zLeadScrewDiameter, zLeadScrewLength);
}

module zMotorMountAssembly(corkDamperThickness) {
    stepper_motor_cable(eX + eY + 150);// z motor
    if ($preview) {
        size = Z_Motor_MountSize();
        translate([eSize + _zLeadScrewOffset, 0, size.z - motorBracketSizeZ - corkDamperThickness]) {
            if (corkDamperThickness)
                explode(-40)
                    corkDamper(NEMA_type, corkDamperThickness);
            explode(-50, true)  {
                shaft_length = NEMA_shaft_length(NEMA_type);
                if (is_list(shaft_length)) {
                    // integrated lead screw, so set shaft length to zero and use leadscrewX rather than NopSCADlib leadscrew
                    NEMA_no_shaft = [ for (i = [0 : len(NEMA_type) - 1]) i==8 ? [1, shaft_length[1], shaft_length[2]] : NEMA_type[i] ];
                    no_explode() {
                        rotate(-90) NEMA(NEMA_no_shaft, jst_connector = true);
                        translate_z(eps)
                            leadscrewX(shaft_length[1], shaft_length[0], shaft_length[2], center=false);
                    }
                } else {
                    // no integrated lead screw, so add lead screw and coupling
                    not_on_reduced_bom()
                        rotate(-90)
                            NEMA(NEMA_type, jst_connector = true);
                    translate_z(NEMA_shaft_length(NEMA_type)) {
                        explode(80)
                            not_on_reduced_bom()
                                shaft_coupling(SC_5x8_rigid, colour = grey(30));
                        zLeadScrewLength = _zRodLength - 50;
                        leadscrewX(_zLeadScrewDiameter, zLeadScrewLength, center=false);
                    }
                }
            }
        }
        NEMA_screw_positions(NEMA_type)
            translate([eSize + _zLeadScrewOffset, 0, size.z - counterBoreDepth])
                boltM3Buttonhead(screw_shorter_than(5 + motorBracketSizeZ - counterBoreDepth + corkDamperThickness));
    }
}

module Z_Motor_Mount_assembly() pose(a=[55, 0, 25+90])
assembly("Z_Motor_Mount", big = true, ngb=true) {
    vflip()
        Z_Motor_Mount_stl();
    zMotorMountAssembly(corkDamperThickness=_corkDamperThickness);
}

module Z_Motor_Mount_Right_assembly() pose(a=[55, 0, 25+90])
assembly("Z_Motor_Mount_Right", big = true, ngb=true) {
    vflip()
        Z_Motor_Mount_Right_stl();
    zMotorMountAssembly(corkDamperThickness=_corkDamperThickness);
}
