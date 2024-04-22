//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>

include <NopSCADlib/vitamins/blowers.scad>

include <../utils/PrintheadOffsets.scad>

include <../utils/X_Rail.scad>
include <../utils/X_Carriage.scad>
include <../vitamins/inserts.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>

include <../Parameters_CoreXY.scad>

halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);
// HC_size = [45.4, 4, 57]
//function xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation) =  [max(carriage_size(xCarriageType).x, 30), 4, halfCarriage ? (36 + beltSeparation - 4.5 + (beltSeparation == 7 ? 1.25 : 0) + carriage_height(xCarriageType) + xCarriageTopThickness() + (!is_undef(beltWidth) && beltWidth == 9 ? 4.5 : 0)) : 58];
function xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation) =  [max(carriage_size(xCarriageType).x, xCarriageSize.x), 4, xCarriageSize.z];
//function accelerometerOffset() = [10, -1, 8];
//function accelerometerOffset() = [6.5, -2, 8];
function accelerometerOffset() = [0, -10.5, 8];
function xCarriageHoleOffsetTop() = halfCarriage ? -1 : 0;//[5.65, -1]; // for alignment with EVA
//function xCarriageHoleOffsetTop() = [4, 0];
//function xCarriageHoleOffsetBottom() = [9.7, 4.5]; // for alignment with EVA
//function xCarriageHoleOffsetBottom() = [9.7, 0];
//function xCarriageHoleOffsetBottom() = [4, 0];
//evaHoleOffsetBottom = 9.7;
//evaHoleSeparationBottom = 26;
evaHoleSeparationTop = 34;
function xCarriageHoleSeparationTopMGN12H() = halfCarriage ? evaHoleSeparationTop : xCarriageBoltSeparation.x; //45.4 - 8
function xCarriageHoleSeparationBottomMGN12H() = halfCarriage ? 38 : xCarriageBoltSeparation.x;

function xCarriageHotendSideSizeM(xCarriageType, beltWidth, beltSeparation) = [xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation).x, halfCarriage ? 5 : xCarriageSize.y, xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation).z];
function xCarriageHotendOffsetY(xCarriageType) = carriage_size(xCarriageType).y/2 + xCarriageHotendSideSizeM(xCarriageType, 0, 0).y + 0.5;

xCarriageBeltTensionerSizeX = 23;
beltClampSize = [25, xCarriageBeltAttachmentSize(beltWidth(), beltSeparation()).x + 1, 4.5];
beltsCenterZOffset = coreXYPosBL().z - xRailCarriagePositionZ();


module xCarriageHotendSideHolePositions(xCarriageType, flipSide=false) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    railCarriageGap = 0.5;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();
    carriageSize = carriage_size(xCarriageType);
    topHoleOffset = xCarriageHoleOffsetTop();

    for (x = xCarriageHolePositions(size.x, holeSeparationTop))
        translate([x - size.x/2, carriageSize.y/2 + railCarriageGap + (flipSide ? size.y : 0), xCarriageTopThickness()/2 + topHoleOffset])
            rotate([-90, 90, 0])
                children();
    for (x = xCarriageHolePositions(size.x, holeSeparationBottom))
        translate([x - size.x/2, carriageSize.y/2 + railCarriageGap + (flipSide ? size.y : 0), -size.z + xCarriageTopThickness() + xCarriageBaseThickness()/2])
            rotate([-90, 90, 0])
                children();
}


module X_Carriage_Beltside_HC_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    stl("X_Carriage_Beltside_HC_16"); // semicolon required for XChange build as this is not on BOM
    color(pp4_colour)
        rotate([90, 0, 0])// orientate for printing
            xCarriageBeltSide(xCarriageType, size, beltsCenterZOffset, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), halfCarriage=true, endCube=true);
}

module X_Carriage_Beltside_RB_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    // orientate for printing
    stl("X_Carriage_Beltside_RB"); // semicolon required for XChange build as this is not on BOM
    color(pp4_colour)
        rotate([90, 0, 0])// orientate for printing
            xCarriageBeltSide(xCarriageType, size, beltsCenterZOffset, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), reversedBelts=true, endCube=true);
}

module X_Carriage_Beltside_RB_MGN9C_stl() {
    xCarriageType = MGN9C_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    // orientate for printing
    stl("X_Carriage_Beltside_RB_MGN9C"); // semicolon required for XChange build as this is not on BOM
    color(pp4_colour)
        rotate([90, 0, 0])// orientate for printing
            xCarriageBeltSide(xCarriageType, size, beltsCenterZOffset, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), reversedBelts=true, endCube=true);
}

module X_Carriage_Beltside_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    // orientate for printing
    stl("X_Carriage_Beltside_16"); // semicolon required for XChange build as this is not on BOM
    color(pp4_colour)
        rotate([90, 0, 0])// orientate for printing
            xCarriageBeltSide(xCarriageType, size, beltsCenterZOffset, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), endCube=true);
}

module X_Carriage_Beltside_25_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 4];

    stl("X_Carriage_Beltside_25"); // semicolon required for XChange build as this is not on BOM
    color(pp4_colour)
        rotate([90, 0, 0])// orientate for printing
            xCarriageBeltSide(xCarriageType, size, beltsCenterZOffset, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), pulley25=true, endCube=true);
}

//!Insert the belts into the **X_Carriage_Belt_Tensioner**s and then bolt the tensioners into the
//!**X_Carriage_Beltside** part as shown. Note the belts are not shown in this diagram.
//
module X_Carriage_Beltside_assembly()
assembly("X_Carriage_Beltside", big=true) {

    //echo(dTooth=pulley_pr(GT2x25x7x3_toothed_idler)-pulley_pr(GT2x16_toothed_idler));
    //echo(dPlain=pulley_pr(GT2x25x7x3_plain_idler)-pulley_pr(GT2x16_plain_idler));

    useReversedBelts = useReversedBelts();
    rotate([-90, 0, 0])
        stl_colour(pp4_colour)
            if (useReversedBelts) {
                if (_xCarriageDescriptor == "MGN9C")
                    X_Carriage_Beltside_RB_MGN9C_stl();
                else
                    X_Carriage_Beltside_RB_stl();
            } else if (usePulley25())
                translate([0, 0, -pulley25Offset])
                    X_Carriage_Beltside_25_stl();
            else
                if (halfCarriage)
                    X_Carriage_Beltside_HC_16_stl();
                else
                    X_Carriage_Beltside_16_stl();

    size = xCarriageBeltSideSizeM(MGN12H_carriage, beltWidth(), beltSeparation());
    beltTensionerSize = xCarriageBeltTensionerSize(beltWidth());
    boltLength = 40;
    gap = 0.1; // small gap so can see clearance when viewing model
    offset = [ size.x/2 - 2,
               beltTensionerSize.y - beltAttachmentOffsetY() + gap - pulley25Offset,
               coreXYPosBL().z - xRailCarriagePositionZ()];
    translate(offset) {
        if (useReversedBelts) {
            translate([0, 0, -(beltSeparation() + beltWidth())/2]) // -1.0 to -1.2
                rotate([0, 180, 0]) {
                    explode([-40, 0, 0])
                        stl_colour(pp2_colour)
                            X_Carriage_Belt_Tensioner_RB_stl();
                    mirror([0, 1, 0])
                        X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, size.x/2 + offset.x);
                }
            translate([-2*offset.x, 0, (beltSeparation() + beltWidth())/2]) // 1.0 to 1.2
                rotate([0, 0, 0]) {
                    explode([-40, 0, 0])
                        stl_colour(pp2_colour)
                            X_Carriage_Belt_Tensioner_RB_stl();
                    mirror([0, 1, 0])
                        X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, size.x/2 + offset.x);
                }
        } else {
            translate([0, 0, (beltSeparation() + beltWidth())/2]) // 0.75 to 0.95
                rotate([0, 0, 180]) {
                    explode([-40, 0, 0])
                        stl_colour(pp2_colour)
                            X_Carriage_Belt_Tensioner_stl();
                    X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, size.x/2 + offset.x);
                }
            translate([-2*offset.x, 0, -(beltSeparation() + beltWidth())/2]) // -0.75 to -0.95
                rotate([180, 0, 0]) {
                    explode([-40, 0, 0])
                        stl_colour(pp2_colour)
                            X_Carriage_Belt_Tensioner_stl();
                    X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, size.x/2 + offset.x);
                }
        }
    }
}

module X_Carriage_Belt_Tensioner_stl() {
    stl("X_Carriage_Belt_Tensioner"); // semicolon required for XChange build as this is not on BOM
    color(pp2_colour)
        xCarriageBeltTensioner(xCarriageBeltTensionerSize(beltWidth(), xCarriageBeltTensionerSizeX));
}

module X_Carriage_Belt_Tensioner_RB_stl() {
    stl("X_Carriage_Belt_Tensioner_RB"); // semicolon required for XChange build as this is not on BOM
    color(pp2_colour)
        mirror([0, 1, 0])
            xCarriageBeltTensioner(xCarriageBeltTensionerSize(beltWidth(), xCarriageBeltTensionerSizeX));
}

module X_Carriage_Belt_Clamp_stl() {
    stl("X_Carriage_Belt_Clamp"); // semicolon required for XChange build as this is not on BOM
    offset = (beltClampSize.y - xCarriageBeltAttachmentSize(beltWidth(), beltSeparation()).x)/2 - 1;
    color(pp2_colour)
        xCarriageBeltClamp(beltClampSize, offset=offset, countersunk=true);
}

module X_Carriage_Belt_Clamp_Buttonhead_stl() {
    stl("X_Carriage_Belt_Clamp_Buttonhead"); // semicolon required for XChange build as this is not on BOM
    offset = (beltClampSize.y - xCarriageBeltAttachmentSize(beltWidth(), beltSeparation()).x)/2 - 1;
    color(pp2_colour)
        xCarriageBeltClamp(beltClampSize, offset=offset);
}

module X_Carriage_Belt_Clamp_25_stl() {
    stl("X_Carriage_Belt_Clamp_25"); // semicolon required for XChange build as this is not on BOM
    color(pp2_colour)
        xCarriageBeltClamp(beltClampSize, offset=-1.25, countersunk=true);
}

module X_Carriage_Belt_Clamp_Buttonhead_25_stl() {
    stl("X_Carriage_Belt_Clamp_Buttonhead_25"); // semicolon required for XChange build as this is not on BOM
    color(pp2_colour)
        xCarriageBeltClamp(beltClampSize, offset=-1.25);
}

module xCarriageBeltClampAssembly(xCarriageType, countersunk=true) {
    assert(is_list(xCarriageType));

    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());

    translate([0, 5 + pulley25Offset, beltsCenterZOffset])
        rotate([-90, 180, 0]) {
            stl_colour(pp2_colour)
                if (countersunk)
                    if (usePulley25())
                        X_Carriage_Belt_Clamp_25_stl();
                    else
                        X_Carriage_Belt_Clamp_stl();
                else
                    if (usePulley25())
                        X_Carriage_Belt_Clamp_Buttonhead_25_stl();
                    else
                        X_Carriage_Belt_Clamp_Buttonhead_stl();
            X_Carriage_Belt_Clamp_hardware(beltClampSize, countersunk=countersunk);
        }
}

