include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>

include <NopSCADlib/vitamins/bldc_motors.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../vitamins/bolts.scad>
use <../vitamins/cables.scad>

include <../Parameters_Main.scad>
use <../Parameters_CoreXY.scad>

BLDC_type = BLDC4250;


module cornerCube(size, fillet, cornerFillet) {
    linear_extrude(size.z) {
        difference() {
            rounded_square([size.x, size.y], fillet > 0 ? fillet : 0);
            translate([size.x/2, size.y/2])
                rotate(180)
                    fillet(cornerFillet);
            translate([-size.x/2, -size.y/2])
                fillet(cornerFillet);
        }
        if (fillet < 0) {
            translate([-size.x/2, size.y/2])
                rotate(180)
                    fillet(-fillet);
            translate([size.x/2, -size.y/2])
                rotate(180)
                    fillet(-fillet);
        }
    }
}

module XY_Encoder_Mount_hardware(motorType) {
}

module XY_Encoder_Mount_stl()
stl("XY_Encoder_Mount")
    color(pp2_colour) {
        size = [48, 48, 60];
        cornerSize = [8, 8, size.z];
        /*extra = 2.75;
        size = [BLDC_diameter(BLDC_type) + 2*extra, BLDC_diameter(BLDC_type) + 2*extra, 60];
        echo(size=size);
        cornerSize = [6 + extra, 6 + extra, 60];*/
        //topCornerSize = [9 + extra, 9 + extra, 2];
        fillet = 1;
        cornerFillet = 3;
        difference() {
            union() {
                *for (a = [0, 90, 180, 270])
                    rotate(a)
                        hull() {
                            translate([(size.x - topCornerSize.x)/2, (size.y - topCornerSize.y)/2, -topCornerSize.z])
                                cornerCube(topCornerSize, fillet, cornerFillet);
                            translate([(size.x - cornerSize.x)/2, (size.y - cornerSize.y)/2, -topCornerSize.z - (topCornerSize.x - cornerSize.x)])
                                cornerCube([cornerSize.x, cornerSize.y, eps], fillet, cornerFillet);
                        }
                for (a = [0, 90, 180, 270])
                    rotate(a) {
                        translate([(size.x - cornerSize.x)/2, (size.y - cornerSize.y)/2, -size.z])
                            difference() {
                                cornerCube(cornerSize, fillet, cornerFillet);
                                translate_z(size.z)
                                    vflip()
                                        boltHoleM3Tap(10);
                            }
                        braceThickness = 1.5;
                        translate([(size.x - braceThickness)/2, 0, -size.z/2])
                            hull() {
                                translate([0, (size.y - 2*cornerSize.y + braceThickness + fillet)/2, 0])
                                    cylinder(d=braceThickness, h = size.z, center=true);
                                translate([0, -braceThickness/2])
                                    cylinder(d=braceThickness, h = 2.5, center=true);
                            }
                        translate([0, (size.y - braceThickness)/2, -size.z/2])
                            hull() {
                                translate([(size.x - 2*cornerSize.x + braceThickness + fillet)/2, 0, 0])
                                    cylinder(d=braceThickness, h = size.z, center=true);
                                translate([-braceThickness/2, 0])
                                    cylinder(d=braceThickness, h = 2.5, center=true);
                            }
                    }
            }
            rotate(45)
                BLDC_screw_positions(size.x + 8)
                    vflip()
                        boltHoleM3Tap(8);
        }
        translate_z(-size.z)
            rounded_cube_xy([size.x, size.y, 5], cornerFillet, xy_center=true);
}

module XY_Encoder_Mount_Left_assembly()
assembly("XY_Encoder_Mount_Left", ngb=true) {

    motorWidth = motorWidth(BLDC4250);
    basePlateThickness = 5;

    translate([coreXYPosBL().x + leftDrivePulleyOffset().x + coreXY_drive_pulley_x_alignment(coreXY_type()), coreXYPosTR(motorWidth).y, coreXYPosBL().z - coreXYSeparation().z - basePlateThickness]) {
        stl_colour(pp2_colour)
            XY_Encoder_Mount_stl();
        XY_Encoder_Mount_hardware(BLDC_type);
    }
}

module XY_Encoder_Mount_Right_assembly()
assembly("XY_Encoder_Mount_Right", ngb=true) {

    motorWidth = motorWidth(BLDC4250);
    basePlateThickness = 5;

    translate([coreXYPosTR(motorWidth).x + rightDrivePulleyOffset().x - coreXY_drive_pulley_x_alignment(coreXY_type()), coreXYPosTR(motorWidth).y, coreXYPosBL().z - basePlateThickness]) {
        stl_colour(pp2_colour)
            XY_Encoder_Mount_stl();
        XY_Encoder_Mount_hardware(BLDC_type);
    }
}

module radial_encoder_magnet_6_2p5() {
    vitamin(str(": Radial encoder magnet 6x2.5mm"));
    color(silver)
        cylinder(d=6, h=2.5);
}

module magnetic_encoder_AS5048() {
    vitamin(str(": AS5048 magnetic encoder"));
}
