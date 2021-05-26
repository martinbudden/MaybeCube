include <global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/XY_MotorMount.scad>
use <printed/XY_Idler.scad>
use <printed/Y_CarriageAssemblies.scad>

use <utils/FrameBolts.scad>
use <utils/carriageTypes.scad>
use <utils/RailNutsAndBolts.scad>
use <utils/CoreXYBelts.scad>
use <utils/X_Rail.scad>

use <vitamins/bolts.scad>
use <vitamins/nuts.scad>
use <vitamins/extrusion.scad>

use <Parameters_Positions.scad>
include <Parameters_Main.scad>


module Face_Top_Stage_1_assembly()
assembly("Face_Top_Stage_1", big=true, ngb=true) {
    Left_Side_Upper_Extrusion_assembly();
    Right_Side_Upper_Extrusion_assembly();

    if (is_undef($hide_corexy) || !$hide_corexy) {
        explode(-120)
            XY_Idler_Left_assembly();
        explode(-100)
            XY_Motor_Mount_Left_assembly();
        explode(-120)
            XY_Idler_Right_assembly();
        explode(-100)
            XY_Motor_Mount_Right_assembly();
    }
    faceTopFront();
    faceTopBack();
    explode(50, true) {
        Top_Corner_Piece_assembly();
        translate([eX + 2*eSize, 0, 0])
            rotate(90)
                Top_Corner_Piece_assembly();
        translate([0, eY + 2*eSize, 0])
            rotate(270)
                Top_Corner_Piece_assembly();
        translate([eX + 2*eSize, eY + 2*eSize, 0])
            rotate(180)
                Top_Corner_Piece_assembly();
    }
}

module Face_Top_assembly()
assembly("Face_Top", big=true) {

    Face_Top_Stage_1_assembly();
    //hidden() Y_Carriage_Left_AL_dxf();
    //hidden() Y_Carriage_Right_AL_dxf();

    explode(100, true)
        translate_z(eZ) {
            xRail();
            xRailBoltPositions()
                explode(20, true)
                    boltM3Caphead(10);
        }
    fullPrinthead();
    explode(200, true)
        CoreXYBelts(carriagePosition());
}

module faceTopFront() {
    // add the front top extrusion oriented in the X direction
    translate([eSize, 0, eZ - eSize]) {
        explode([0, -120, 0], true) {
            extrusionOXEndBoltPositions(eX)
                boltM5Buttonhead(_endBoltShortLength);
            color(frameColor())
                render(convexity=4)
                    difference() {
                        extrusionOX(eX);
                        for (x = [eSize/2, eX - eSize/2])
                            translate([x, 0, eSize/2])
                                rotate([-90, 0, 0])
                                    jointBoltHole();
                    }
        }
    }
}

module faceTopBack() {
    // add the back top extrusion oriented in the X direction
    translate([eSize, eY + eSize, eZ - eSize]) {
        use2020 = is_undef(_use2020TopExtrusion) || _use2020TopExtrusion == false ? false : true;

        explode([0, 120, 0], true) {
            extrusionOXEndBoltPositions(eX)
                boltM5Buttonhead(_endBoltShortLength);
            if (!use2020)
                translate_z(-eSize)
                    extrusionOXEndBoltPositions(eX)
                        boltM5Buttonhead(_endBoltLength);
            color(frameColor())
                render(convexity=4)
                    difference() {
                        if (use2020)
                            extrusionOX(eX);
                        else
                            translate_z(-eSize)
                                extrusionOX2040V(eX);
                        for (x = [eSize/2, eX - eSize/2])
                            translate([x, eSize, eSize/2])
                                rotate([90, 0, 0])
                                    jointBoltHole();
                    }

        }
    }
    Wiring_Guide_assembly();
}

wiringDiameter = 7;
sideThickness = 6.5;

module Wiring_Guide_stl() {
    size = [40, eSize, 5];
    fillet = 1.5;

    stl("Wiring_Guide")
        color(pp1_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy([size.x, size.y, 3], fillet);
                        rounded_cube_xy([(size.x - wiringDiameter)/2, size.y, size.z], fillet);
                        translate([(size.x + wiringDiameter)/2, 0, 0]) {
                            rounded_cube_xy([(size.x - wiringDiameter)/2, size.y, size.z], fillet);
                            rounded_cube_xy([sideThickness, size.y, wiringDiameter + 2], fillet);
                        }
                        translate([(size.x - wiringDiameter)/2 - sideThickness, 0, 0])
                            rounded_cube_xy([sideThickness, size.y, wiringDiameter + 2], fillet);
                    }
                    for (x = [5, size.x - 5])
                        translate([x, size.y/2, 0])
                            boltHoleM3(size.z, twist=3);
                    for (x = [(size.x - wiringDiameter - sideThickness)/2, (size.x + wiringDiameter + sideThickness)/2])
                        translate([x, size.y/2, 0])
                            boltHoleM3Tap(size.z + wiringDiameter);
                }
}

module Wiring_Guide_Clamp_stl() {
    size = [wiringDiameter + 2*sideThickness, eSize, 2.5];
    fillet = 1.5;

    stl("Wiring_Guide_Clamp")
        color(pp2_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    rounded_cube_xy(size, fillet);
                    for (x = [sideThickness/2, size.x - sideThickness/2])
                        translate([x, size.y/2, 0])
                            boltHoleM3(size.z, twist=3);
                }
 }

module Wiring_Guide_assembly()
assembly("Wiring_Guide") {
    translate([eX/2 + eSize, eY + eSize, eZ - 2*eSize])
        rotate([90, 0, 0]) {
            stl_colour(pp1_colour)
                Wiring_Guide_stl();
            stl_colour(pp2_colour)
                translate_z(wiringDiameter + 2)
                    Wiring_Guide_Clamp_stl();
        }
}

module Left_Side_Upper_Extrusion_assembly() pose(a = [180 + 55, 0, 25 + 90])
assembly("Left_Side_Upper_Extrusion", big=true, ngb=true) {
    translate([0, eSize, eZ - eSize])
        extrusionOY2040HEndBolts(eY);
    explode(-40, true)
        translate([1.5*eSize, eSize + _yRailLength/2, eZ - eSize])
            rotate([180, 0, 90])
                if (is_undef($hide_rails) || $hide_rails == false) {
                    rail_assembly(yCarriageType(), _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
                    railBoltsAndNuts(yRailType(), _yRailLength, 5);
                }
    explode(-10, true)
        Y_Carriage_Left_assembly();
}

module Right_Side_Upper_Extrusion_assembly() pose(a = [180+55, 0, 25-90])
assembly("Right_Side_Upper_Extrusion", big=true, ngb=true) {

    translate([eX, eSize, eZ - eSize])
        extrusionOY2040HEndBolts(eY);

    translate([eX + eSize/2, eSize + _yRailLength/2, eZ - eSize])
        explode(-40, true)
            rotate([180, 0, 90])
                if (is_undef($hide_rails) || $hide_rails == false) {
                    rail_assembly(yCarriageType(), _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
                    railBoltsAndNuts(yRailType(), _yRailLength, 5);
                }
    explode(-10, true)
        Y_Carriage_Right_assembly();
}

topCornerPieceHoles = [ [eSize/2, 3*eSize/2], [eSize/2, 5*eSize/2], [3*eSize/2, eSize/2], [3*eSize/2, 3*eSize/2], [5*eSize/2, eSize/2] ];

module topCornerPiece() {
    size = [3*eSize, 3*eSize, 5];
    fillet = 2;

    difference() {
        linear_extrude(size.z)
            offset(r=fillet)
                offset(delta=-fillet)
                    hull()
                        polygon([
                            [eSize, 0], [size.x, 0], [size.x, size.y - 2*eSize], [size.x - 2*eSize, size.y], [0, size.y], [0, eSize]
                        ]);
        for (i = topCornerPieceHoles)
            translate(i)
                boltPolyholeM4Countersunk(size.z);
    }
}

module Top_Corner_Piece_stl() {
    stl("Top_Corner_Piece")
        color(pp1_colour)
            vflip()
                topCornerPiece();
}

module Top_Corner_Piece_hardware() {
    vflip()
        for (i = topCornerPieceHoles)
            translate(i)
                vflip()
                    boltM4CountersunkTNut(10);
}

module Top_Corner_Piece_assembly()
assembly("Top_Corner_Piece", ngb=true) {

    translate_z(eZ + 5)
        rotate(90) {
            stl_colour(pp1_colour)
                Top_Corner_Piece_stl();
            Top_Corner_Piece_hardware();
        }
}
