include <global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/WiringGuide.scad>
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

//!1. Bolt the two motor mounts and the **Wiring_Guide** to the rear extrusion.
//!2. Bolt the two idlers to the front extrusion.
//!3. Screw the bolts into the ends of the front and rear extrusions.
//!4. Insert the t-nuts for the **Top_Corner_Piece**s into the extrusions.
//!5. Bolt the front and rear extrusions to the side extrusions, leaving the bolts slightly loose.
//!6. Bolt the **Top_Corner_Piece**s to the extrusions leaving the bolts slightly loose.
//!7. Turn the top face upside down and place on a flat surface. Ensure it is square and tighten the hidden bolts.
//!8. Turn the top face the right way up and tighten the bolts on the **Top_Corner_Piece**s.
//
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
    wiringGuidePosition(offset=0) {
        stl_colour(pp1_colour)
            Wiring_Guide_stl();
        Wiring_Guide_hardware();
    }
    topCornerPieceAssembly(90);
    translate([eX + 2*eSize, 0, 0])
        topCornerPieceAssembly(180);
    translate([0, eY + 2*eSize, 0])
        topCornerPieceAssembly(0);
    translate([eX + 2*eSize, eY + 2*eSize, 0])
        topCornerPieceAssembly(270);
}

//!1. Bolt the MGN rail to the Y_Carriages as shown. Ensure the MGN rail is square to the frame.
//!2. Turn the top face upside down and place on a flat surface. Rack the right side linear rail - move the X-rail
//!to one extreme of the frame and tighten the bolts on that end of the Y-rail. Then move the X-rail to the other
//!extreme and tighten the bolts on that end of the Y-rail. Finally tighten the remaining bolts on the Y-rail.
//!3. Ensure the X-rail moves freely, if it doesn't loosen the bolts you have just tightened and repeat step 2.
//
module Face_Top_Stage_2_assembly()
assembly("Face_Top_Stage_2", big=true, ngb=true) {

    Face_Top_Stage_1_assembly();
    //hidden() Y_Carriage_Left_AL_dxf();
    //hidden() Y_Carriage_Right_AL_dxf();

    translate_z(eZ)
        explode(100, true) {
            xRail();
            xRailBoltPositions()
                explode(20, true)
                    boltM3Caphead(10);
        }
}

//!1. Bolt the **X_Carriage_Belt_Side_MGN12H_assembly** to the MGN carriage.
//!2. Thread the belts as shown and attach them to the **X_Carriage_Belt_Side_MGN12H_assembly**
//! using the **X_Carriage_Belt_Clamp**s
//!3. Leave the belts fairly loose - tensioning of the belts is done after the frame is assembled.
//
module Face_Top_assembly()
assembly("Face_Top", big=true) {

    Face_Top_Stage_2_assembly();

    printheadBeltSide(explode=100);
    if (!exploded())
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
}

//!1. Bolt the MGN linear rail to the extrusion, using the **Rail_Centering_Jig** to align the rail. Fully tighten the
//!bolts - the left rail is the fixed rail and the right rail will be aligned to it.
//!bolts at this stage - they will be fully tightened when the rail is racked at a later stage.
//!2. Bolt the **Y_Carriage_Left_assembly** to the MGN carriage.
//!3. Screw the bolts into ends of the extrusion in preparation for attachment to the rest of the top face.
//
module Left_Side_Upper_Extrusion_assembly() pose(a=[180 + 55, 0, 25 + 90])
assembly("Left_Side_Upper_Extrusion", big=true, ngb=true) {

    yCarriageType = yCarriageType();
    translate([0, eSize, eZ - eSize])
        extrusionOY2040HEndBolts(eY);
    translate([1.5*eSize, eSize + _yRailLength/2, eZ - eSize])
        explode(-40, true)
            rotate([180, 0, 90])
                if (is_undef($hide_rails) || $hide_rails == false) {
                    rail_assembly(yCarriageType, _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
                    railBoltsAndNuts(carriage_rail(yCarriageType), _yRailLength, 5);
                }
    translate_z(eZ - eSize)
        explode(-80, true) {
            Y_Carriage_Left_assembly();
            explode(-20, true)
                Y_Carriage_bolts(yCarriageType, yCarriageThickness(), left=true);
        }
}

//!1. Bolt the MGN linear rail to the extrusion, using the **Rail_Centering_Jig** to align the rail. Do not fully tighten the
//!bolts at this stage - they will be fully tightened when the rail is racked at a later stage.
//!2. Bolt the **Y_Carriage_Right_assembly** to the MGN carriage.
//!3. Screw the bolts into ends of the extrusion in preparation for attachment to the rest of the top face.
//
module Right_Side_Upper_Extrusion_assembly() pose(a=[180 + 55, 0, 25 - 90])
assembly("Right_Side_Upper_Extrusion", big=true, ngb=true) {

    yCarriageType = yCarriageType();
    translate([eX, eSize, eZ - eSize])
        extrusionOY2040HEndBolts(eY);

    translate([eX + eSize/2, eSize + _yRailLength/2, eZ - eSize])
        explode(-40, true)
            rotate([180, 0, 90])
                if (is_undef($hide_rails) || $hide_rails == false) {
                    rail_assembly(yCarriageType(), _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
                    railBoltsAndNuts(carriage_rail(yCarriageType), _yRailLength, 5);
                }
    translate([eX + 2*eSize, 0, eZ - eSize])
        explode(-80, true) {
            Y_Carriage_Right_assembly();
            explode(-20, true)
                Y_Carriage_bolts(yCarriageType, yCarriageThickness(), left=false);
        }
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

module Top_Corner_Piece_hardware(rotate=0) {
    vflip()
        for (i = [0 : len(topCornerPieceHoles) - 1])
            translate(topCornerPieceHoles[i])
                vflip()
                    boltM4CountersunkTNut(10, rotate=(i < 2 ? 90 : i==3 ? (rotate == 0 || rotate==180 ? 90 : 0) : 0));
}

module topCornerPieceAssembly(rotate=0) {
    translate_z(eZ + 5)
        explode(50, true)
            rotate(rotate) {
                stl_colour(pp1_colour)
                    Top_Corner_Piece_stl();
                Top_Corner_Piece_hardware(rotate);
            }
}
