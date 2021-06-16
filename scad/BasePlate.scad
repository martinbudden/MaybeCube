include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/displays.scad>
use <NopSCADlib/vitamins/sheet.scad>

use <printed/BaseFoot.scad>
use <printed/BaseFrontCover.scad>
use <printed/DisplayHousingAssemblies.scad>

use <utils/FrameBolts.scad>

use <vitamins/bolts.scad>
use <vitamins/extrusion.scad>
use <vitamins/nuts.scad>

include <Parameters_Main.scad>


AL3 = ["AL3", "Aluminium sheet", 3, [0.9, 0.9, 0.9, 1], false];

basePlateSize = [eX + 2*eSize, eY + 2*eSize, _basePlateThickness];
function pcbType() = BTT_SKR_V1_4_TURBO;
//function pcbType() = BTT_SKR_E3_TURBO;
//function pcbType() = BTT_SKR_MINI_E3_V2_0;

psuOnBase = false; //eX >= 350;
pcbOnBase = false;

module BaseAL_dxf() {
    size = basePlateSize;

    dxf("BaseAL")
        color(silver)
            difference() {
                sheet_2D(AL3, size.x, size.y, corners=2);
                translate([-size.x/2, -size.y/2])
                    baseCutouts(cncSides=0);
            }
}

module BaseAL() {
    size = basePlateSize;

    translate([size.x/2, size.y/2, -size.z/2])
        render_2D_sheet(AL3, w=size.x, d=size.y)
            BaseAL_dxf();
}

module Base_Plate_stl() {
    size = basePlateSize;

    stl("Base_Plate")
        color(pp1_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        rounded_square([size.x, size.y], 1.5, center = false);
                        baseCutouts();
                    }
}

module Base_Plate_template_stl() {
    size = basePlateSize;

    stl("Base_Plate_template")
        color(pp1_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        rounded_square([size.x, size.y], 1.5, center = false);
                        baseCutouts(radius=1);
                    }
}

module baseplateM6BoltPositions(size) {
    size = basePlateSize;

    for (x = [eSize/2, size.x - eSize/2], y = [eSize/2, size.x - eSize/2])
        translate([x, y, 0])
            children();
}

module baseCutouts(cncSides = undef, radius = undef) {
// set radius=1 to make drill template

    size = basePlateSize;

    baseplateM4BoltPositions(size)
        poly_circle(is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
    baseplateM4CornerBoltPositions(size)
        poly_circle(is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
    baseplateM6BoltPositions(size)
        poly_circle(is_undef(radius) ? M6_clearance_radius : radius, sides=cncSides);
    if (psuOnBase)
        PSUPosition(psuOnBase)
            PSUBoltPositions()
                poly_circle(is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
    if (pcbOnBase)
        pcbPosition(pcbType())
            pcb_screw_positions(pcbType())
                poly_circle(is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);

}

module baseplateM4BoltPositions(size) {
    inset = eSize + 15;

    for (x = [eSize/2, size.x - eSize/2], y = [inset + (size.y - 2*inset)/3, size.y - inset - (size.y - 2*inset)/3])
        translate([x, y, 0])
            rotate(0)
                children();
    for (y = [eSize/2, size.y - eSize/2], x = [inset + (size.x - 2*inset)/3, size.x - inset - (size.x - 2*inset)/3])
        translate([x, y, 0])
            rotate(90)
                children();
}

module baseplateM4CornerBoltPositions(size) {
    inset = eSize + 15;

    for (x = [eSize/2, size.x - eSize/2], y = [inset, size.y - inset])
        translate([x, y, 0])
            rotate(0)
                children();
    for (y = [eSize/2, size.y - eSize/2], x = [inset, size.x-inset])
        translate([x, y, 0])
            rotate(90)
                children();
}

function basePlateHeight() = _basePlateThickness + 12;


module Base_Plate_assembly()
assembly("Base_Plate", big=true, ngb=true) {
    size = basePlateSize;

    BaseAL();
    //hidden() Base_stl();
    //hidden() Base_template_stl();

    //controlPanelPosition()
    //    controlPanel();
    Display_Housing_TFT35_E3_assembly();
    // front extrusion
    explode(50, true)
        translate([eSize, 0, 0]) {
            extrusionOX2080VEndBolts(eX);
            translate_z(4*eSize + 2*eps)
                explode(25, true) {
                    stl_colour(pp1_colour)
                        Front_Cover_stl();
                    Front_Cover_hardware();
                }
            translate([eX/2, 2*eps, 4*eSize + 2*eps])
                explode(25, true)
                    vflip() {
                        stl_colour(pp2_colour)
                            Front_Display_Wiring_Cover_stl();
                        Front_Display_Wiring_Cover_hardware();
                    }
        }

    // rear extrusion
    translate([eSize, eY + eSize, 0])
        explode(50, true)
            extrusionOX2040VEndBolts(eX);
    translate_z(-size.z)
        baseplateM4BoltPositions(size) {
            vflip()
                explode(30)
                    boltM4Buttonhead(_sideBoltLength);
            translate_z(_sideBoltLength-3)
                explode(20)
                    nutM4Hammer();
        }
    translate_z(-size.z - extrusionFootLShapedBoltOffsetZ())
        baseplateM4CornerBoltPositions(size) {
            vflip()
                explode(30)
                    boltM4Buttonhead(_frameBoltLength);
            translate_z(_frameBoltLength-3)
                explode(20)
                    nutM4Hammer();
        }

    footHeight = 12;
    translate([0, eSize, -size.z - footHeight])
        rotate([180, 0, -90])
            stl_colour(pp1_colour)
                Foot_LShaped_12mm_stl();
    translate([eX + eSize, 0, -size.z - footHeight])
        rotate([180, 0, 0])
            stl_colour(pp1_colour)
                Foot_LShaped_12mm_stl();
    translate([eX + 2*eSize, eY + eSize, -size.z - footHeight])
        rotate([180, 0, 90])
            stl_colour(pp1_colour)
                Foot_LShaped_12mm_stl();
    translate([eSize, eY + 2*eSize, -size.z - footHeight])
        rotate([180, 0, 180])
            stl_colour(pp1_colour)
                Foot_LShaped_12mm_stl();

}

/*
module Standoff_6mm_stl() {
    stl("Standoff_6mm");

    h = PSUStandoffHeight();
    color(pp1_colour)
        tube(or=6/2, ir = M3_clearance_radius, h=h, center = false);
}
*/
