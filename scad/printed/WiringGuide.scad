include <../config/global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../utils/bezierTube.scad>
include <../utils/PrintheadOffsets.scad>

include <../utils/extruderBracket.scad>

use <ReverseBowdenBracket.scad>

use <../config/Parameters_Positions.scad>


wiringDiameter = 7;
sideThickness = 6.5;
wiringGuideSize = [30, 20, 5];
wiringGuideClampSize = [wiringDiameter + 2*sideThickness, wiringGuideSize.y, 3];

function wiringGuideCableOffsetY() = 10;
wiringClearance = 0.5;
function wiringGuideTabHeight() = wiringGuideCableOffsetY() + wiringDiameter - 2 + wiringClearance;

function wiringGuidePosition(offsetX=10, offsetY=0, offsetZ=0) = [eX/2 + eSize + 10 - (wiringGuideSize.x + eSize)/2 - offsetX, eY + eSize - offsetY, eZ - eSize - offsetZ];
function useCamera() = false;

module Wiring_Guide_stl() {
    stl("Wiring_Guide")
        color(pp1_colour)
            wiringGuide(wiringGuideSize, wiringGuideTabHeight());
}

module wiringGuide(size, tabHeight) {
    fillet = 1.5;
    translate([-size.x/2, eSize - size.y, 0])
        difference() {
            union() {
                rounded_cube_xy([size.x, size.y, 3], fillet);
                translate([(wiringGuideSize.x - wiringDiameter - 2*sideThickness)/2, 0, 0])
                    rounded_cube_xy([wiringDiameter + 2*sideThickness, size.y, wiringGuideCableOffsetY() + wiringClearance], fillet);
                for (x = [0, (size.x + wiringDiameter)/2])
                    translate([x, 0, 0])
                        rounded_cube_xy([(size.x - wiringDiameter)/2, size.y, size.z], fillet);
                for (x = [(size.x + wiringDiameter)/2, (size.x - wiringDiameter)/2 - sideThickness])
                    translate([x, 0, 0])
                        rounded_cube_xy([sideThickness, size.y, tabHeight], fillet);
            }
            for (x = [(size.x - wiringDiameter - sideThickness)/2, (size.x + wiringDiameter + sideThickness)/2])
                translate([x, size.y/2, 1])
                    boltHoleM3Tap(tabHeight - 1);
        }
}

module Wiring_Guide_Clamp_stl() {
    stl("Wiring_Guide_Clamp")
        color(pp2_colour)
            wiringGuideClamp(wiringGuideClampSize);
}

module wiringGuideClamp(size) {
    fillet = 1.5;
    translate([-size.x/2, eSize - size.y, 0])
        difference() {
            rounded_cube_xy(size, fillet);
            for (x = [sideThickness/2, size.x - sideThickness/2])
                translate([x, size.y/2, 0])
                    boltHoleM3(size.z, twist=3);
        }
}

module Wiring_Guide_Clamp_hardware() {
    size = wiringGuideClampSize;

    for (x = [-size.x/2 + sideThickness/2, size.x/2 - sideThickness/2])
        translate([x, eSize - size.y/2, size.z])
            boltM3Buttonhead(10);
}

module Wiring_Guide_Socket_stl() {
    size = [wiringGuideSize.x + 24, wiringGuideSize.y + 20, wiringGuideCableOffsetY()];
    fillet = 1.5;
    toleranceX = 0.4;
    toleranceZ = 0.5;

    stl("Wiring_Guide_Socket")
        color(pp2_colour)
            vflip()
                translate([-size.x/2, eSize - size.y, 0])
                    difference() {
                        union() {
                            translate([0, 0, 0])
                                rounded_cube_xy([size.x, size.y - wiringGuideSize.y, size.z], fillet);
                            /*size1 = [(size.x - wiringGuideSize.x)/2 + 5, 5, size.z];
                            *for (x = [0, size.x - size1.x])
                                translate([x, 0, 0])
                                    rounded_cube_xy(size1, fillet);*/
                            size2 = [(size.x - wiringGuideSize.x - toleranceX)/2, size.y, size.z];
                            for (x = [0, (size.x + wiringGuideSize.x + toleranceX)/2])
                                translate([x, 0, 0])
                                    rounded_cube_xy(size2, fillet);
                            size3 = [(size.x - wiringGuideSize.x - toleranceX)/2 + 5, size.y, size.z - wiringGuideSize.z - toleranceZ];
                            for (x = [0, size.x - size3.x])
                                translate([x, 0, size.z - size3.z])
                                    rounded_cube_xy(size3, fillet);
                        }
                        for (x = [size.x/2 - 21, size.x/2 + 21])
                            translate([x, size.y - eSize/2, size.z])
                                vflip()
                                    boltHoleM3HangingCounterbore(size.z - 5, boreDepth=size.z - 5);
                    }
}

module Wiring_Guide_Socket_hardware() {
    size = [wiringGuideSize.x, eSize, 10];
    vflip()
        for (x = [size.x/2 - 21, size.x/2 + 21])
            translate([x - size.x/2, size.y/2, size.z/2])
                boltM3CapheadHammerNut(_frameBoltLength);
}

module wiringGuidePosition(offsetX=10, offsetY=0) {
    translate(wiringGuidePosition(offsetX, offsetY))
        rotate([90, 0, 0])
            children();
}

module printheadWiring(hotendDescriptor="E3DV6", showCable=true) {
    // don't show the incomplete cable if there are no extrusions to obscure it
    wireRadius = 2.5;
    bezierPos = wiringGuidePosition(offsetY=wiringGuideCableOffsetY(), offsetZ=eSize) - [useCamera() ? cameraMountBaseSize.x/2 : 0, 0, 0];
    if (showCable && is_undef($hide_extrusions))
        color(grey(20)) {
            bezierTube(bezierPos, [carriagePosition().x, carriagePosition().y, eZ] + printheadWiringOffset(hotendDescriptor), tubeRadius=wireRadius);
            translate(bezierPos)
                vflip()
                    cylinder(h=bezierPos.z - 3*eSize, r=wireRadius, center=false);
        }

    /*translate([carriagePosition().x, carriagePosition().y, eZ] + printheadWiringOffset(hotendDescriptor))
        for (z = [11, 21])
            translate([0, -3.5, z])
                rotate([0, 90, 90])
                    cable_tie(cable_r=3, thickness=4.5);*/

    translate([useCamera() ? cameraMountBaseSize.x/2 : 0, 0, 0])
        wiringGuidePosition() {
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

module reverseBowdenTube(hotendDescriptor="OrbiterV3") {
    color("white")
        bezierTube(reverseBowdenBracketOffset(),
            [carriagePosition().x, carriagePosition().y, eZ] + printheadBowdenOffset(hotendDescriptor),
            tubeRadius=2,
            bowdenTube=false,
            length = eX + eY - 100);
}

module BowdenTube(hotendDescriptor="E3DV6") {
    color("white")
        bezierTube(extruderPosition() + Extruder_Bracket_assembly_bowdenOffset(),
            [carriagePosition().x, carriagePosition().y, eZ] + printheadBowdenOffset(hotendDescriptor),
            tubeRadius=2,
            bowdenTube=true,
            length = eX + eY - 100);
}


