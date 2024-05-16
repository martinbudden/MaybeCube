include <../global_defs.scad>

include <../utils/FrameBolts.scad>

use <NopSCADlib/utils/fillet.scad>

include <../printed/CameraMount.scad>
use <../printed/Handle.scad>
use <../printed/PrintheadAssemblies.scad>
use <../printed/TopCornerPiece.scad>
use <../printed/WiringGuide.scad>
use <../printed/XY_MotorMount.scad>
use <../printed/XY_Idler.scad>
use <../printed/Y_CarriageAssemblies.scad>

include <../utils/bezierTube.scad>
include <../utils/X_Rail.scad>
include <../utils/CoreXYBelts.scad>
include <../utils/RailNutsAndBolts.scad>
include <../utils/printheadOffsets.scad>

use <../Parameters_Positions.scad>

function use2060ForTop() = !is_undef(_use2060ForTop) && _use2060ForTop;
useCamera = false;


//!1. Bolt the **Wiring_Guide** to the rear extrusion.
//!2. Screw the bolts into the ends of the front and rear extrusions.
//!3. Insert the t-nuts for the **Handle** into the extrusions.
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

    faceTopFront(useRB40());
    faceTopBack(use2060ForTopRear() ? 60 : 40);
    if (is_undef($hide_extras) || !$hide_extras) {
        for (x = [3*eSize/2, eX + eSize/2])
            translate([x, eY/2 + eSize, eZ])
                rotate([0, -90, 0])
                    Handle_hardware(bolt=false, TNut=true);
        translate_z(eZ)
            topCornerPieceAssembly(0);
        translate([eX + 2*eSize, 0, eZ])
            topCornerPieceAssembly(90);
        translate([eX + 2*eSize, eY + 2*eSize, eZ])
            topCornerPieceAssembly(180);
        translate([0, eY + 2*eSize, eZ])
            topCornerPieceAssembly(270);
    }
}

//!1. Turn the top face upside down and place on a flat surface.
//!2. Bolt the **X_Rail_assmebly** to MGN Y carriages.
//!3. Rack the right side linear rail - Kove the X-rail to one extreme of the frame and tighten the bolts
//!on that end of the Y-rail. Then move the X-rail to the other extreme and tighten the bolts on that end
//!of the Y-rail. Finally tighten the remaining bolts on the Y-rail.
//!4. Ensure the X-rail moves freely, if it doesn't loosen the bolts you have just tightened and repeat step 3.
//
module Face_Top_Stage_2_assembly()
assembly("Face_Top_Stage_2", big=true, ngb=true) {

    translate([0, eY + 2*eSize, 2*(eZ - eSize)])
        vflip() {
            explode(100, show_line=false)
                Face_Top_Stage_1_assembly();
            //hidden() Y_Carriage_Left_AL_dxf();
            //hidden() Y_Carriage_Right_AL_dxf();

            X_Rail_assembly();

            yCarriageType = carriageType(_yCarriageDescriptor);
            translate_z(eZ - eSize)
                explode(-100, show_line=false)
                    Y_Carriage_bolts(yCarriageType, yCarriageThickness(), left=true);
            translate([eX + 2*eSize, 0, eZ - eSize])
                explode(-100, show_line=false)
                    Y_Carriage_bolts(yCarriageType, yCarriageThickness(), left=false);
        }
}

//!1. Bolt the XY_Idlers to the frame.
//!2. Bolt the XY_Motor mounts to the frame.
//
module Face_Top_Stage_3_assembly()
assembly("Face_Top_Stage_3", big=true, ngb=true) {

    Face_Top_Stage_2_assembly();

    translate([0, eY + 2*eSize, 2*(eZ - eSize)])
        vflip()
            if (is_undef($hide_corexy) || !$hide_corexy) {
                explode(-120, show_line=false) {
                    XY_Idler_Left_assembly();
                    XY_Idler_Right_assembly();
                }
                explode(-100, show_line=false) {
                    XY_Motor_Mount_Left_assembly();
                    XY_Motor_Mount_Right_assembly();
                }
            }
}

//!1. Bolt the **X_Carriage_Beltside_assembly** to the MGN carriage.
//!2. Thread the belts as shown and attach them to the **X_Carriage_Beltside_assembly**
//! using the **X_Carriage_Belt_Clamp**.
//!3. Leave the belts fairly loose - tensioning of the belts is done after the frame is assembled.
//
module Face_Top_Stage_4_assembly()
assembly("Face_Top_Stage_4", big=true, ngb=true) {

    Face_Top_Stage_3_assembly();

    translate([0, eY + 2*eSize, 2*(eZ - eSize)])
        vflip() {
            printheadBeltSide(explode=-100);

            explode(-350, show_line=false)
                CoreXYBelts(carriagePosition());
    }
}

//!1. Turn the top face the correct way up.
//!2. Bolt the handles to the previously inserted t-nuts.
//
module Face_Top_assembly()
assembly("Face_Top", big=true) {

    translate([0, eY + 2*eSize, 2*(eZ - eSize)])
        vflip()
            Face_Top_Stage_4_assembly();

    for (x = [3*eSize/2, eX + eSize/2])
        translate([x, eY/2 + eSize, eZ])
            explode(20, true)
                rotate([0, -90, 0]) {
                    stl_colour(pp1_colour)
                        Handle_stl();
                    Handle_hardware(bolt=true, TNut=false);
                }
}

module faceTopFront(use2040=true) {
    // add the front top extrusion oriented in the X direction
    translate([eSize, 0, eZ - eSize]) {
        explode([0, -120, 0], true) {
            extrusionOXEndBoltPositions(eX)
                boltM5Buttonhead(_endBoltShortLength);
            // second bolt also needs to be _endBoltShortLength, to give room to XY_Idler pulley bolt
            if (use2040)
                translate_z(-eSize)
                    extrusionOXEndBoltPositions(eX)
                        boltM5Buttonhead(_endBoltShortLength);
            difference() {
                if (use2040)
                    translate_z(-eSize)
                        extrusionOX2040V(eX);
                else
                    extrusionOX(eX);
                for (x = use2060ForTop() ? [eSize/2, 3*eSize/2, eX - eSize/2, eX - 3*eSize/2] : [eSize/2, eX - eSize/2])
                    translate([x, 0, eSize/2])
                        rotate([-90, 0, 0])
                            jointBoltHole();
                // boltHole for attachment in 2020 case, for XY_Idler in 2040 case
                for (x = [eSize/2, eX - eSize/2])
                    translate([x, eSize/2, use2040 ? -eSize : 0])
                        jointBoltHole();
            }
        }
    }
}

module faceTopBack(height=40, fov_distance=0) {
    // add the back top extrusion oriented in the X direction
    explode([0, 120, 0], true, show_line=false) {
        translate([eSize, eY + eSize, eZ - eSize]) {
            extrusionOXEndBoltPositions(eX)
                boltM5Buttonhead(_endBoltShortLength);
            if (height >= 40)
                translate_z(-eSize)
                    extrusionOXEndBoltPositions(eX)
                        boltM5Buttonhead(_endBoltLength);
            if (height >= 60)
                translate_z(-2*eSize)
                    extrusionOXEndBoltPositions(eX)
                        boltM5Buttonhead(_endBoltLength);
            difference() {
                if (height==20)
                    extrusionOX(eX);
                else if (height==40)
                    translate_z(-eSize)
                        extrusionOX2040V(eX);
                else if (height==60)
                    translate_z(-2*eSize)
                        extrusionOX2060V(eX);
                for (x = use2060ForTop() ? [eSize/2, 3*eSize/2, eX - eSize/2, eX - 3*eSize/2] : [eSize/2, eX - eSize/2])
                    translate([x, eSize, eSize/2])
                        rotate([90, 0, 0])
                            jointBoltHole();
            }
        }
        if (_variant != "JubileeToolChanger" && (is_undef($hide_extras) || !$hide_extras)) {
            explode([0, -40, 0], true, show_line=false)
                wiringGuidePosition(offsetX = useCamera ? cameraMountBaseSize.x/2 : 0)
                    vflip() {
                        stl_colour(pp3_colour)
                            Wiring_Guide_Socket_stl();
                        Wiring_Guide_Socket_hardware();
                    }
            if (useCamera)
                cameraMountPosition() {
                    stl_colour(pp1_colour)
                        Camera_Mount_stl();
                    Camera_Mount_hardware(fov_distance);
                }
        }
    }
}

module printheadWiring(hotendDescriptor="E3DV6", showCable=true) {
    // don't show the incomplete cable if there are no extrusions to obscure it
    wireRadius = 2.5;
    bezierPos = wiringGuidePosition(useCamera ? cameraMountBaseSize.x/2 : 0, wiringGuideCableOffsetY(), eSize);
    if (showCable && is_undef($hide_extrusions))
        color(grey(20)) {
            bezierTube(bezierPos, [carriagePosition().x, carriagePosition().y, eZ] + printheadWiringOffset(hotendDescriptor), tubeRadius=wireRadius);
            translate(bezierPos)
                vflip()
                    cylinder(h=bezierPos.z - 20, r=wireRadius, center=false);
        }

    /*translate([carriagePosition().x, carriagePosition().y, eZ] + printheadWiringOffset(hotendDescriptor))
        for (z = [11, 21])
            translate([0, -3.5, z])
                rotate([0, 90, 90])
                    cable_tie(cable_r=3, thickness=4.5);*/

    wiringGuidePosition(offsetX = useCamera ? cameraMountBaseSize.x/2 : 0) {
        stl_colour(pp1_colour)
            Wiring_Guide_stl();
        explode(20, true)
            translate_z(wiringGuideTabHeight()) {
                stl_colour(pp2_colour)
                    Wiring_Guide_Clamp_stl();
                Wiring_Guide_Clamp_hardware();
            }
    }
}


//!1. Bolt the MGN linear rail to the extrusion, using the **Rail_Centering_Jig** to align the rail. Fully tighten the
//!bolts - the left rail is the fixed rail and the right rail will be aligned to it.
//!2. Bolt the **Y_Carriage_Left_assembly** to the MGN carriage.
//!3. Screw the bolts into ends of the extrusion in preparation for attachment to the rest of the top face.
//
module Left_Side_Upper_Extrusion_assembly() pose(a=[180 + 55, 0, 25 + 90])
assembly("Left_Side_Upper_Extrusion", big=true, ngb=true) {

    yCarriageType = carriageType(_yCarriageDescriptor);
    translate([0, eSize, eZ - eSize])
        if (use2060ForTop())
            extrusionOY2060HEndBolts(eY);
        else
            extrusionOY2040HEndBolts(eY);
    translate([coreXYPosBL().x, xyIdlerRailOffset() + _yRailLength/2, eZ - eSize])
        explode(-40, true)
            rotate([180, 0, 90])
                if (is_undef($hide_rails) || $hide_rails == false) {
                    rail_assembly(yCarriageType, _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
                    railBoltsAndNuts(carriage_rail(yCarriageType), _yRailLength, 4);
                }
}

//!1. Bolt the MGN linear rail to the extrusion, using the **Rail_Centering_Jig** to align the rail. Do not fully tighten the
//!bolts at this stage - they will be fully tightened when the rail is racked at a later stage.
//!2. Bolt the **Y_Carriage_Right_assembly** to the MGN carriage.
//!3. Screw the bolts into ends of the extrusion in preparation for attachment to the rest of the top face.
//!4. Note that the last two holes of the rail are not used - the Y_Carriage cannot travel here since the motors are in the way.
//!Not using these holes shortens the constrained length of rail and so reduces the flex of the Y axes caused by bimetalic expansion
//!when the frame heats up during printing.
//
module Right_Side_Upper_Extrusion_assembly() pose(a=[180 + 55, 0, 25 - 90])
assembly("Right_Side_Upper_Extrusion", big=true, ngb=true) {

    yCarriageType = carriageType(_yCarriageDescriptor);
    translate([eX, eSize, eZ - eSize])
        if (use2060ForTop())
            translate([-eSize, 0, 0])
                extrusionOY2060HEndBolts(eY);
        else
            extrusionOY2040HEndBolts(eY);

    translate([eX + 2*eSize - coreXYPosBL().x, xyIdlerRailOffset() + _yRailLength/2, eZ - eSize])
        explode(-40, true)
            rotate([180, 0, 90])
                if (is_undef($hide_rails) || $hide_rails == false) {
                    rail_assembly(yCarriageType, _yRailLength, carriagePosition().y - eSize - _yRailLength/2, carriage_end_colour="green", carriage_wiper_colour="red");
                    railBoltsAndNuts(carriage_rail(yCarriageType), _yRailLength, 4);
                }
}

//! Bolt the Y_Carriages to the ends of the linear rail.
//
module X_Rail_assembly() pose(a=[180 + 55, 0, 25 - 90])
assembly("X_Rail", big=true, ngb=true) {

    yCarriageType = carriageType(_yCarriageDescriptor);

    translate_z(eZ) {
        xRail(carriagePosition());
        xRailBoltPositions(carriagePosition())
            explode(20, true)
                boltM3Caphead(10);
    }
    translate_z(eZ - eSize)
        explode(-80, show_line=false)
            Y_Carriage_Left_assembly();
    translate([eX + 2*eSize, 0, eZ - eSize])
        explode(-80, show_line=false)
            Y_Carriage_Right_assembly();
}
