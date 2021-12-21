//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/blowers.scad>

use <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>

include <../vitamins/bolts.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
include <../../../BabyCube/scad/printed/X_CarriageFanDuct.scad>

include <../Parameters_CoreXY.scad>

useMotorIdlerLarge = pulley_hub_dia(coreXY_toothed_idler(coreXY_type())) > 15;

xCarriageFrontSize = [30, 4, 40.5];
function xCarriageFrontSizeM(xCarriageType, beltWidth, beltSeparation) =  [max(carriage_size(xCarriageType).x, xCarriageFrontSize.x), xCarriageFrontSize.y, 36 + beltSeparation - 4.5 + (beltSeparation ==7 ? 2 : 0) +carriage_height(xCarriageType) + xCarriageTopThickness() + (!is_undef(beltWidth) && beltWidth == 9 ? 4.5 : 0)]; //has the belt tensioners
function xCarriageBackSizeM(xCarriageType, beltWidth, beltSeparation) = [xCarriageFrontSizeM(xCarriageType, beltWidth, beltSeparation).x, 5, xCarriageFrontSizeM(xCarriageType, beltWidth, beltSeparation).z];
function xCarriageBackOffsetY(xCarriageType) = carriage_size(xCarriageType).y/2 + xCarriageBackSizeM(xCarriageType, 0, 0).y;

function hotendOffset(xCarriageType, hotendDescriptor="E3DV6") = printHeadHotendOffset(hotendDescriptor) + [-xCarriageBackSizeM(xCarriageType, 0, 0).x/2, xCarriageBackOffsetY(xCarriageType), 0];
function grooveMountSize(blower_type, hotendDescriptor="E3DV6") = [printHeadHotendOffset(hotendDescriptor).x, blower_size(blower_type).x + 6.25, 12];
function blower_type() = is_undef(_blowerDescriptor) || _blowerDescriptor == "BL30x10" ? BL30x10 : BL40x10;
//function accelerometerOffset() = [10, -1, 8];
function accelerometerOffset() = [6.5, -2, 8];
function xCarriageHoleOffsetTop() = -1;//[5.65, -1]; // for alignment with EVA
//function xCarriageHoleOffsetTop() = [4, 0];
//function xCarriageHoleOffsetBottom() = [9.7, 4.5]; // for alignment with EVA
//function xCarriageHoleOffsetBottom() = [9.7, 0];
//function xCarriageHoleOffsetBottom() = [4, 0];
//evaHoleOffsetBottom = 9.7;
//evaHoleSeparationBottom = 26;
evaHoleSeparationTop = 34;
function xCarriageHoleSeparationTopMGN12H() = evaHoleSeparationTop; //45.4 - 8
function xCarriageHoleSeparationBottomMGN12H() = 38;//34;//37.4; //45.4 - 8

xCarriageBeltTensionerSizeX = 23;


module X_Carriage_Belt_Side_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageFrontSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();
    offsetT = xCarriageHoleOffsetTop();

    // orientate for printing
    stl("X_Carriage_Belt_Side_16")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), holeSeparationTop, holeSeparationBottom, extraOverlap=1, accelerometerOffset=accelerometerOffset(), offsetT=offsetT);
}

module X_Carriage_Belt_Side_25_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageFrontSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 4];
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();
    offsetT = xCarriageHoleOffsetTop();

    // orientate for printing
    stl("X_Carriage_Belt_Side_25")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), holeSeparationTop, holeSeparationBottom, extraOverlap=1, accelerometerOffset=accelerometerOffset(), offsetT=offsetT);
}

//!Insert the belts into the **X_Carriage_Belt_Tensioner**s and then bolt the tensioners into the
//!**X_Carriage_Belt_Side** part as shown. Note the belts are not shown in this diagram.
//
module X_Carriage_Belt_Side_assembly()
assembly("X_Carriage_Belt_Side") {

    rotate([-90, 0, 0])
        stl_colour(pp4_colour)
            if (_coreXYDescriptor == "GT2_20_25")
                X_Carriage_Belt_Side_25_stl();
            else
                X_Carriage_Belt_Side_16_stl();

    beltTensionerSize = xCarriageBeltTensionerSize(beltWidth());
    boltLength = 40;
    gap = 0.1; // small gap so can see clearance when viewing model
    offset = [ 22.5,
               xCarriageBeltTensionerSize(beltWidth()).y - beltAttachmentOffsetY() + xCarriageBeltAttachmentCutoutOffset() + gap,
               -31 ];
    translate(offset) {
        rotate([0, 0, 180]) {
            explode([-40, 0, 0])
                stl_colour(pp2_colour)
                    X_Carriage_Belt_Tensioner_stl();
            X_Carriage_Belt_Tensioner_hardware(beltTensionerSize, boltLength, offset.x);
        }
        translate([-2*offset.x, 0, -2])
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

module X_Carriage_Belt_Clamp_Buttonhead_16_stl() {
    size = [xCarriageBeltAttachmentSize().x - 0.5, 25, 4.5];

    stl("X_Carriage_Belt_Clamp_Buttonhead_16")
        color(pp2_colour)
            xCarriageBeltClamp(size);
            /*translate([0, -size.y/2, 0])
                difference() {
                    fillet = 1;
                    rounded_cube_xy(size, fillet);
                    *for (x = [0, xCarriageBeltClampHoleSeparation()])
                        translate([x + 3.2, size.y/2, 0])
                            boltHoleM3(size.z, twist=4);
                    for (y = [-xCarriageBeltClampHoleSeparation()/2, xCarriageBeltClampHoleSeparation()/2])
                        translate([size.x/2 + 1.25, y + size.y/2, 0])
                            boltHoleM3(size.z, twist=4);
                }*/
}

module X_Carriage_Belt_Clamp_16_stl() {
    size = [xCarriageBeltAttachmentSize(beltWidth(), beltSeparation()).x - 0.5, 25, 4.5];

    stl("X_Carriage_Belt_Clamp_16")
        color(pp2_colour)
            vflip()
                xCarriageBeltClamp(size, countersunk=true);
}

module X_Carriage_Belt_Clamp_25_stl() {
    size = [xCarriageBeltAttachmentSize(beltWidth(), beltSeparation()).x - 0.5, 25, 4.5];

    stl("X_Carriage_Belt_Clamp_25")
        color(pp2_colour)
            vflip()
                xCarriageBeltClamp(size, countersunk=true);
}

module xCarriageBeltClampAssembly(xCarriageType, countersunk=true) {
    assert(is_list(xCarriageType));

    size = xCarriageFrontSizeM(xCarriageType, beltWidth(), beltSeparation());

    xCarriageBeltClampPosition(xCarriageType, size, beltWidth(), beltSeparation()) {
        stl_colour(pp2_colour)
            if (countersunk)
                vflip()
                    if (_coreXYDescriptor == "GT2_20_25")
                        X_Carriage_Belt_Clamp_25_stl();
                    else
                        X_Carriage_Belt_Clamp_16_stl();
            else
                if (_coreXYDescriptor == "GT2_20_25")
                    X_Carriage_Belt_Clamp_Buttonhead_25_stl();
                else
                    X_Carriage_Belt_Clamp_Buttonhead_16_stl();
        X_Carriage_Belt_Clamp_hardware(beltWidth(), beltSeparation(), countersunk=countersunk);
    }
}

module X_Carriage_Groovemount_16_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    stl("X_Carriage_Groovemount_16")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                size = xCarriageBackSizeM(xCarriageType, beltWidth(), beltSeparation());
                difference() {
                    union() {
                        xCarriageBack(xCarriageType, size, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageBackSizeM(xCarriageType, 0, 0).x, grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
                    // bolt holes for Z probe mount
                    for (z = [0, -8])
                        translate([size.x/2, 18, z - 26])
                            rotate([0, -90, 0])
                                boltHoleM3Tap(9);
                }
            }
}

module X_Carriage_Groovemount_25_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    stl("X_Carriage_Groovemount_25")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                size = xCarriageBackSizeM(xCarriageType, beltWidth(), beltSeparation());
                difference() {
                    union() {
                        xCarriageBack(xCarriageType, size, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageBackSizeM(xCarriageType, 0, 0).x, grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
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

    rotate([0, -90, 0])
        stl_colour(pp1_colour)
            if (_coreXYDescriptor == "GT2_20_25")
                X_Carriage_Groovemount_25_stl();
            else
                X_Carriage_Groovemount_16_stl();

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
                    fanDuct(printHeadHotendOffset().x, jetOffset=-0.5, chimneySizeZ=17);
}
