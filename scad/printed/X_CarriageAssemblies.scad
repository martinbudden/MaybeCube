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
function xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation) =  [max(carriage_size(xCarriageType).x, xCarriageFrontSize.x), xCarriageFrontSize.y, 36 + beltSeparation - 4.5 + (beltSeparation == 7 ? 1.25 : 0) +carriage_height(xCarriageType) + xCarriageTopThickness() + (!is_undef(beltWidth) && beltWidth == 9 ? 4.5 : 0)];
function xCarriageHotendSideSizeM(xCarriageType, beltWidth, beltSeparation) = [xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation).x, 5.5, xCarriageBeltSideSizeM(xCarriageType, beltWidth, beltSeparation).z];
function xCarriageHotendOffsetY(xCarriageType) = carriage_size(xCarriageType).y/2 + xCarriageHotendSideSizeM(xCarriageType, 0, 0).y;

function hotendOffset(xCarriageType, hotendDescriptor="E3DV6") = printheadHotendOffset(hotendDescriptor) + [-xCarriageHotendSideSizeM(xCarriageType, 0, 0).x/2, xCarriageHotendOffsetY(xCarriageType), 0];
function grooveMountSize(blower_type, hotendDescriptor="E3DV6") = [printheadHotendOffset(hotendDescriptor).x, blower_size(blower_type).x + 6.25, 12];
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


module X_Carriage_Belt_Side_HC_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    // orientate for printing
    stl("X_Carriage_Belt_Side_HC_16")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), endCube=true, HC=true);
}

module X_Carriage_Belt_Side_16_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 1];

    // orientate for printing
    stl("X_Carriage_Belt_Side_16")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), HC=false);
}

module X_Carriage_Belt_Side_25_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());// + [1, 0, 4];
    echo(size=size);

    // orientate for printing
    stl("X_Carriage_Belt_Side_25")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageBeltSide(xCarriageType, size, beltWidth(), beltSeparation(), xCarriageHoleSeparationTopMGN12H(), xCarriageHoleSeparationBottomMGN12H(), accelerometerOffset=accelerometerOffset(), offsetT=xCarriageHoleOffsetTop(), endCube=true, pulley25=true);
}

//!Insert the belts into the **X_Carriage_Belt_Tensioner**s and then bolt the tensioners into the
//!**X_Carriage_Belt_Side** part as shown. Note the belts are not shown in this diagram.
//
module X_Carriage_Belt_Side_assembly(HC=true)
assembly("X_Carriage_Belt_Side") {

    isPulley25 = (_coreXYDescriptor == "GT2_20_25");
    offsetY25 = 2.6;
    //echo(dTooth=pulley_pr(GT2x25x7x3_toothed_idler)-pulley_pr(GT2x16_toothed_idler));
    //echo(dPlain=pulley_pr(GT2x25x7x3_plain_idler)-pulley_pr(GT2x16_plain_idler));

    rotate([-90, 0, 0])
        stl_colour(pp4_colour)
            if (isPulley25)
                translate([0, 0, -offsetY25])
                    X_Carriage_Belt_Side_25_stl();
            else
                if (HC)
                    X_Carriage_Belt_Side_HC_16_stl();
                else
                    X_Carriage_Belt_Side_16_stl();

    size = xCarriageBeltSideSizeM(MGN12H_carriage, beltWidth(), beltSeparation());// + [1, 0, 4];
    beltTensionerSize = xCarriageBeltTensionerSize(beltWidth());
    boltLength = 40;
    gap = 0.1; // small gap so can see clearance when viewing model
    offset = [ 22.5,
               beltTensionerSize.y - beltAttachmentOffsetY() + xCarriageBeltAttachmentCutoutOffset() + gap - (isPulley25 ? offsetY25 : 0),
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

    size = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());

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
                        xCarriageBack(xCarriageType, size, HC=true, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0).x, grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
                    // bolt holes for Z probe mount
                    for (z = [0, -8])
                        translate([size.x/2, 18, z - 26])
                            rotate([0, -90, 0])
                                boltHoleM3Tap(9);
                }
            }
}

module X_Carriage_Groovemount_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    stl("X_Carriage_Groovemount")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
                difference() {
                    union() {
                        xCarriageBack(xCarriageType, size, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0).x, grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
                    // bolt holes for Z probe mount
                    for (z = [0, -8])
                        translate([size.x/2, 18, z - 26])
                            rotate([0, -90, 0])
                                boltHoleM3Tap(9);
                }
            }
}

/*module X_Carriage_Groovemount_25_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blower_type, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    stl("X_Carriage_Groovemount_25")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
                difference() {
                    union() {
                        xCarriageBack(xCarriageType, size, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                        hotEndHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0).x, grooveMountSize, hotendOffset, hotendDescriptor, blower_type, baffle=false, left=false);
                    }
                    // bolt holes for Z probe mount
                    for (z = [0, -8])
                        translate([size.x/2, 18, z - 26])
                            rotate([0, -90, 0])
                                boltHoleM3Tap(9);
                }
            }
}
*/

module xCarriageGroovemountAssembly(HC=false) {

    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotendDescriptor = "E3DV6";
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    rotate([0, -90, 0])
        stl_colour(pp1_colour)
            if (_coreXYDescriptor == "GT2_20_25")
                X_Carriage_Groovemount_stl();
            else
                if (HC)
                    X_Carriage_Groovemount_HC_16_stl();
                else
                    X_Carriage_Groovemount_stl();

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
