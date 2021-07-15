//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../utils/carriageTypes.scad>
use <../utils/PrintheadOffsets.scad>

use <../vitamins/bolts.scad>

use <X_CarriageBeltAttachment.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltClamps.scad>
include <../../../BabyCube/scad/printed/X_CarriageFanDuct.scad>

use <../Parameters_CoreXY.scad>
include <../Parameters_Main.scad>


function hotendOffset(xCarriageType, hotend_type=0) = printHeadHotendOffset(hotend_type) + [-xCarriageBackSize(xCarriageType).x/2, xCarriageBackOffsetY(xCarriageType), 0];
function grooveMountSize(blower_type, hotend_type=0) = [printHeadHotendOffset(hotend_type).x, blower_size(blower_type).x + 6.25, 12];
function blower_type() = is_undef(_blowerDescriptor) || _blowerDescriptor == "BL30x10" ? BL30x10 : BL40x10;
//function accelerometerOffset() = [10, -1, 8];
function accelerometerOffset() = [7, -1, 8];

module X_Carriage_Belt_Side_MGN12H_stl() {
    xCarriageType = MGN12H_carriage;

    // orientate for printing
    stl("X_Carriage_Belt_Side_MGN12H")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageFrontBeltAttachment(xCarriageType, _beltWidth, beltOffsetZ(), coreXYSeparation().z, accelerometerOffset());
}

module X_Carriage_Belt_Side_MGN12H_assembly()
assembly("X_Carriage_Belt_Side_MGN12H", big=true) {
    rotate([-90, 0, 0])
        stl_colour(pp4_colour)
            X_Carriage_Belt_Side_MGN12H_stl();
    translate([19, -2.5, -31]) {
        rotate([0, 0, 180]) {
            X_Carriage_Belt_Tensioner_stl();
            X_Carriage_Belt_Tensioner_hardware();
        }
        translate([-19*2, 0, -2])
            rotate([180, 0, 0]) {
                X_Carriage_Belt_Tensioner_stl();
                X_Carriage_Belt_Tensioner_hardware();
            }
    }
}

module X_Carriage_Belt_Side_MGN12C_stl() {
    xCarriageType = MGN12C_carriage;

    // orientate for printing
    stl("X_Carriage_Belt_Side_MGN12C")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageFrontBeltAttachment(xCarriageType, _beltWidth, beltOffsetZ(), coreXYSeparation().z, accelerometerOffset());
}

module X_Carriage_Belt_Side_MGN12C_assembly()
assembly("X_Carriage_Belt_Side_MGN12C", big=true) {
    rotate([-90, 0, 0])
        stl_colour(pp4_colour)
            X_Carriage_Belt_Side_MGN12C_stl();
}

module X_Carriage_Belt_Side_MGN9C_stl() {
    xCarriageType = MGN9C_carriage;

    // orientate for printing
    stl("X_Carriage_Belt_Side_MGN9C")
        color(pp4_colour)
            rotate([90, 0, 0])
                xCarriageFrontBeltAttachment(xCarriageType, _beltWidth, beltOffsetZ(), coreXYSeparation().z, accelerometerOffset());
}

module X_Carriage_Belt_Side_MGN9C_assembly()
assembly("X_Carriage_Belt_Side_MGN9C", big=true) {
    rotate([-90, 0, 0])
        stl_colour(pp4_colour)
            X_Carriage_Belt_Side_MGN9C_stl();
}

module X_Carriage_Front_MGN12H_stl() {
    xCarriageType = MGN12H_carriage;

    // orientate for printing
    stl("X_Carriage_Front_MGN12H")
        color(pp4_colour)
            rotate([0, -90, 0])
                xCarriageFront(xCarriageType, _beltWidth, beltOffsetZ(), coreXYSeparation().z);
}

//!1. Bolt the Belt_Clamps to the X_Carriage_Front, leaving them loose for later insertion of the belts.
//!2. Insert the Belt_tensioners into the X_Carriage_Front, and use the 20mm bolts to secure them in place.
module X_Carriage_Front_MGN12H_assembly()
assembly("X_Carriage_Front_MGN12H", big=true) {

    xCarriageType = MGN12H_carriage;
    size = xCarriageFrontSize(xCarriageType, _beltWidth);
    beltOffsetZ = beltOffsetZ();

    rotate([0, 90, 0])
        stl_colour(pp4_colour)
            X_Carriage_Front_MGN12H_stl();

    translate([-size.x/2, -xCarriageFrontOffsetY(xCarriageType), 0]) {
        for (i= [
                    [beltClampOffsetX(), -1.5, beltOffsetZ - coreXYSeparation().z/2],
                    [size.x - beltClampOffsetX(), -1.5, beltOffsetZ + coreXYSeparation().z/2]
                ])
            translate(i)
                rotate([0, -90, 90])
                    explode(20, true) {
                        stl_colour(pp2_colour)
                            Belt_Clamp_stl();
                        Belt_Clamp_hardware(_beltWidth);
                    }
        translate([size.x/2, -1.5, beltOffsetZ])
            rotate([0, -90, 90])
                explode(20, true) {
                    stl_colour(pp2_colour)
                        Belt_Tidy_stl();
                    Belt_Tidy_hardware(_beltWidth);
                }

        translate([12, (size.y + beltInsetFront(undef))/2, beltOffsetZ - coreXYSeparation().z/2]) {
            explode([0, -10, 0])
                stl_colour(pp3_colour)
                    Belt_Tensioner_stl();
            Belt_Tensioner_hardware(_beltWidth);
        }

        translate([size.x - 12, (size.y + beltInsetFront(undef))/2, beltOffsetZ + coreXYSeparation().z/2])
            rotate(180) {
                explode([0, 10, 0])
                    stl_colour(pp3_colour)
                        Belt_Tensioner_stl();
                Belt_Tensioner_hardware(_beltWidth);
            }
    }
}

module xCarriageBeltClamps(xCarriageType) {
    assert(is_list(xCarriageType));

    size = xCarriageBackSize(xCarriageType, _beltWidth);

    translate([-size.x/2 - 1, 0, -coreXYSeparation().z/2])
        rotate([0, 90, 180])
            explode(10, true) {
                stl_colour(pp2_colour)
                    Belt_Clamp_stl();
                Belt_Clamp_hardware(_beltWidth);
            }
    translate([size.x/2 + 1, 0, coreXYSeparation().z/2])
        rotate([0, 90, 0])
            explode(10, true) {
                stl_colour(pp2_colour)
                    Belt_Clamp_stl();
                Belt_Clamp_hardware(_beltWidth);
            }
}

module X_Carriage_Groovemount_MGN12H_stl() {
    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotend_type = 0;
    grooveMountSize = grooveMountSize(blower_type, hotend_type);
    hotendOffset = hotendOffset(xCarriageType, hotend_type);

    stl("X_Carriage_Groovemount_MGN12H")
        color(pp1_colour)
            rotate([0, 90, 0]) {
                xCarriageBack(xCarriageType, _beltWidth, beltOffsetZ(), coreXYSeparation().z, clamps=false, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), offsetB=xCarriageHoleOffsetBottom(), accelerometerOffset=accelerometerOffset());
                hotEndHolder(xCarriageType, grooveMountSize, hotendOffset, hotend_type, blower_type, baffle=false, left=false);
            }
}

//!1. Bolt the belt clamps to the sides of the X_Carriage. Leave the clamps loose to allow later insertion of the belts.
//!2. Bolt the fan onto the side of the X_Carriage, secure the fan wire with a ziptie.
//!3. Ensure a good fit between the fan and the fan duct and bolt the fan duct to the X_Carriage.
module X_Carriage_Groovemount_MGN12H_assembly()
assembly("X_Carriage_Groovemount_MGN12H", big=true, ngb=true) {

    xCarriageType = MGN12H_carriage;
    blower_type = blower_type();
    hotend_type = 0;
    hotendOffset = hotendOffset(xCarriageType, hotend_type);

    rotate([0, -90, 0])
        stl_colour(pp1_colour)
            X_Carriage_Groovemount_MGN12H_stl();

    *translate([0, carriage_size(xCarriageType).y/2 + xCarriageBackSize(xCarriageType).y - beltInsetBack(undef), beltOffsetZ()])
        xCarriageBeltClamps(xCarriageType);

    grooveMountSize = grooveMountSize(blower_type, hotend_type);

    explode([40, 0, 0], true)
        hotEndPartCoolingFan(xCarriageType, grooveMountSize, hotendOffset, blower_type, left=false);
    explode([40, 0, -10], true)
        hotEndHolderAlign(hotendOffset, left=false)
            blowerTranslate(xCarriageType, grooveMountSize, hotendOffset, blower_type)
                rotate([-90, 0, 0]) {
                    stl_colour(pp2_colour)
                        Fan_Duct_stl();
                    Fan_Duct_hardware(xCarriageType, hotend_type);
                }
}

module Belt_Tidy_stl() {
    stl("Belt_Tidy")
        color(pp2_colour)
            beltTidy(_beltWidth);
}

module Belt_Clamp_stl() {
    stl("Belt_Clamp")
        color(pp2_colour)
            beltClamp(_beltWidth);
}

module Belt_Tensioner_stl() {
    stl("Belt_Tensioner")
        color(pp3_colour)
            beltTensioner(_beltWidth);
}

module Fan_Duct_stl() {
    stl("Fan_Duct")
        color(pp2_colour)
            translate([26, 0, 0])
                mirror([1, 0, 0])
                    fanDuct(printHeadHotendOffset().x, jetOffset=-0.5, chimneySizeZ=17);
}
