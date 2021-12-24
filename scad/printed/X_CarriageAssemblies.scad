//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/blowers.scad>

use <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>

include <../vitamins/bolts.scad>
include <../vitamins/inserts.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
include <../../../BabyCube/scad/printed/X_CarriageFanDuct.scad>

include <../Parameters_CoreXY.scad>

halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);

function xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation) =  [max(carriage_size(xCarriageType).x, 30), 4, 36 + beltSeparation - 4.5 + (beltSeparation == 7 ? 1.25 : 0) +carriage_height(xCarriageType) + xCarriageTopThickness() + (!is_undef(beltWidth) && beltWidth == 9 ? 4.5 : 0)];
function xCarriageHotendSideSizeM(xCarriageType, beltWidth, beltSeparation) = [xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation).x, halfCarriage ? 5 : 6, xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation).z];
function xCarriageHotendOffsetY(xCarriageType) = carriage_size(xCarriageType).y/2 + xCarriageHotendSideSizeM(xCarriageType, 0, 0).y + 0.5;

function hotendOffset(xCarriageType, hotendDescriptor="E3DV6") = printheadHotendOffset(hotendDescriptor) + [-xCarriageHotendSideSizeM(xCarriageType, 0, 0).x/2, xCarriageHotendOffsetY(xCarriageType), 0];
function grooveMountSize(blower_type, hotendDescriptor="E3DV6") = [printheadHotendOffset(hotendDescriptor).x, blower_size(blower_type).x + 6.25, 12];
function blower_type() = is_undef(_blowerDescriptor) || _blowerDescriptor == "BL30x10" ? BL30x10 : BL40x10;
//function accelerometerOffset() = [10, -1, 8];
function accelerometerOffset() = [6.5, -2, 8];
function xCarriageHoleOffsetTop() = halfCarriage ? -1 : 0;//[5.65, -1]; // for alignment with EVA
//function xCarriageHoleOffsetTop() = [4, 0];
//function xCarriageHoleOffsetBottom() = [9.7, 4.5]; // for alignment with EVA
//function xCarriageHoleOffsetBottom() = [9.7, 0];
//function xCarriageHoleOffsetBottom() = [4, 0];
//evaHoleOffsetBottom = 9.7;
//evaHoleSeparationBottom = 26;
evaHoleSeparationTop = 34;
function xCarriageHoleSeparationTopMGN12H() = halfCarriage ? evaHoleSeparationTop : 35; //45.4 - 8
function xCarriageHoleSeparationBottomMGN12H() = halfCarriage ? 38 : 35;

xCarriageBeltTensionerSizeX = 23;
beltClampSize = [25, xCarriageBeltAttachmentSize(beltWidth(), beltSeparation()).x - 0.5, 4.5];


module X_Carriage_Belt_Side_HC_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    stl("X_Carriage_Belt_Side_HC_16")
        color(pp4_colour)
            rotate([90, 0, 180])// orientate for printing
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), endCube=true, halfCarriage=true);
}

module X_Carriage_Belt_Side_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    // orientate for printing
    stl("X_Carriage_Belt_Side_16")
        color(pp4_colour)
            rotate([90, 0, 180])// orientate for printing
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), halfCarriage=false);
}

module X_Carriage_Belt_Side_25_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 4];

    stl("X_Carriage_Belt_Side_25")
        color(pp4_colour)
            rotate([90, 0, 180])// orientate for printing
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), endCube=true, pulley25=true, halfCarriage=false);
}

//!Insert the belts into the **X_Carriage_Belt_Tensioner**s and then bolt the tensioners into the
//!**X_Carriage_Belt_Side** part as shown. Note the belts are not shown in this diagram.
//
module X_Carriage_Belt_Side_assembly()
assembly("X_Carriage_Belt_Side") {

    //echo(dTooth=pulley_pr(GT2x25x7x3_toothed_idler)-pulley_pr(GT2x16_toothed_idler));
    //echo(dPlain=pulley_pr(GT2x25x7x3_plain_idler)-pulley_pr(GT2x16_plain_idler));

    rotate([-90, 180, 0])
        stl_colour(pp4_colour)
            if (usePulley25())
                translate([0, 0, -pulley25Offset])
                    X_Carriage_Belt_Side_25_stl();
            else
                if (halfCarriage)
                    X_Carriage_Belt_Side_HC_16_stl();
                else
                    X_Carriage_Belt_Side_16_stl();

    size = xCarriageBeltSideSizeM(MGN12H_carriage, beltWidth(), beltSeparation());// + [1, 0, 4];
    beltTensionerSize = xCarriageBeltTensionerSize(beltWidth());
    boltLength = 40;
    gap = 0.1; // small gap so can see clearance when viewing model
    offset = [ 22.5,
               beltTensionerSize.y - beltAttachmentOffsetY() + xCarriageBeltAttachmentCutoutOffset() + gap - pulley25Offset,
               -size.z + xCarriageTopThickness() + xCarriageBaseThickness() + 0.75];
    translate(offset) {
        translate([0, 0, beltWidth() + beltSeparation() - (beltTensionerSize.z - beltWidth())])
            rotate([0, 0, 180]) {
                explode([-40, 0, 0])
                    stl_colour(pp2_colour)
                        X_Carriage_Belt_Tensioner_stl();
                X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, offset.x);
            }
        translate([-2*offset.x, 0, beltTensionerSize.z])
            rotate([180, 0, 0]) {
                explode([-40, 0, 0])
                    stl_colour(pp2_colour)
                        X_Carriage_Belt_Tensioner_stl();
                X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, offset.x);
            }
    }
}

module X_Carriage_Belt_Tensioner_stl() {
    stl("X_Carriage_Belt_Tensioner")
        color(pp2_colour)
            xCarriageBeltTensioner(xCarriageBeltTensionerSize(beltWidth(), xCarriageBeltTensionerSizeX));
}

module X_Carriage_Belt_Clamp_16_stl() {
    stl("X_Carriage_Belt_Clamp_16")
        color(pp2_colour)
            xCarriageBeltClamp(beltClampSize, offset=-1.75, countersunk=true);
}

module X_Carriage_Belt_Clamp_Buttonhead_16_stl() {
    stl("X_Carriage_Belt_Clamp_Buttonhead_16")
        color(pp2_colour)
            xCarriageBeltClamp(beltClampSize, offset=-1.75);
}

module X_Carriage_Belt_Clamp_25_stl() {
    stl("X_Carriage_Belt_Clamp_25")
        color(pp2_colour)
            xCarriageBeltClamp(beltClampSize, offset=-1.75, countersunk=true);
}

module X_Carriage_Belt_Clamp_Buttonhead_25_stl() {
    stl("X_Carriage_Belt_Clamp_Buttonhead_25")
        color(pp2_colour)
            xCarriageBeltClamp(beltClampSize, offset=-1.75);
}

module xCarriageBeltClampAssembly(xCarriageType, countersunk=true) {
    assert(is_list(xCarriageType));

    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());

    translate([0, 5 + pulley25Offset, -size.z + xCarriageTopThickness() + xCarriageBaseThickness() + 0.5])
        rotate([-90, 180, 0]) {
            stl_colour(pp2_colour)
                if (countersunk)
                    if (_coreXYDescriptor == "GT2_20_25")
                        X_Carriage_Belt_Clamp_25_stl();
                    else
                        X_Carriage_Belt_Clamp_16_stl();
                else
                    if (_coreXYDescriptor == "GT2_20_25")
                        X_Carriage_Belt_Clamp_Buttonhead_25_stl();
                    else
                        X_Carriage_Belt_Clamp_Buttonhead_16_stl();
            X_Carriage_Belt_Clamp_hardware(beltClampSize, offset=-1.75, countersunk=countersunk);
        }
}

module X_Carriage_Groovemount_HC_16_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    stl("X_Carriage_Groovemount_HC_16")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
                difference() {
                    union() {
                        xCarriageBack(xCarriageType, size, 0, xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), halfCarriage=true, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0), grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
                    // bolt holes for Z probe mount
                    for (z = [0, -8])
                        translate([size.x/2, 18, z - 26])
                            rotate([0, -90, 0])
                                boltHoleM3Tap(9);
                }
            }
}

module xCarriageHotendSideHolePositions() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    railCarriageGap = 0.5;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();
    carriageSize = carriage_size(xCarriageType);
    topHoleOffset = xCarriageHoleOffsetTop();

    for (x = xCarriageHolePositions(size.x, holeSeparationTop))
        translate([x - size.x/2, carriageSize.y/2 + railCarriageGap, xCarriageTopThickness()/2 + topHoleOffset])
            rotate([-90, 90, 0])
                children();
    for (x = xCarriageHolePositions(size.x, holeSeparationBottom))
        translate([x - size.x/2, carriageSize.y/2 + railCarriageGap, -size.z + xCarriageTopThickness() + xCarriageBaseThickness()/2])
            rotate([-90, 90, 0])
                children();
}

module X_Carriage_Groovemount_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();
    railCarriageGap = 0.5;

    stl("X_Carriage_Groovemount")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
                difference() {
                    union() {
                        xCarriageBack(xCarriageType, size, 0, holeSeparationTop, holeSeparationBottom, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0), grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
                    xCarriageHotendSideHolePositions()
                        insertHoleM3(size.y, horizontal=true);
                    // bolt holes for Z probe mount
                    for (z = [0, -8])
                        translate([size.x/2, 18, z - 26])
                            rotate([0, -90, 0])
                                boltHoleM3Tap(9);
                }
            }
}

module xCarriageGroovemountAssembly() {

    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);
    if (halfCarriage) {
        stl_colour(pp1_colour)
            rotate([0, -90, 0])
                X_Carriage_Groovemount_HC_16_stl();
    } else {
        stl_colour(pp1_colour)
            rotate([0, -90, 0])
                X_Carriage_Groovemount_stl();
        xCarriageHotendSideHolePositions()
            vflip()
                _threadedInsertM3();
    }

    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);

    explode([40, 0, 0], true)
        hotEndPartCoolingFan(xCarriageType, grooveMountSize, hotendOffset, blower_type, left=false);
    explode([40, 0, -10], true)
        hotEndHolderAlign(hotendOffset, left=false)
            blowerTranslate(xCarriageType, grooveMountSize, hotendOffset, blower_type)
                rotate([-90, 0, 0]) {
                    stl_colour(pp2_colour)
                        Fan_Duct_stl();
                    Fan_Duct_hardware(xCarriageType, hotendDescriptor);
                }
}

module Fan_Duct_stl() {
    stl("Fan_Duct")
        color(pp2_colour)
            translate([26, 0, 0])
                mirror([1, 0, 0])
                    fanDuct(printheadHotendOffset().x, jetOffset=-0.5, chimneySizeZ=17);
}
