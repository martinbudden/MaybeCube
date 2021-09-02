include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/utils/tube.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
use <X_CarriageAssemblies.scad>

use <../utils/X_Rail.scad>
use <../vitamins/bolts.scad>
use <../Parameters_Positions.scad>


function evaColorGrey() = grey(25);
function evaColorGreen() = "LimeGreen";
function evaAdaptorColor() = "SteelBlue";

function X_CarriageEVATensionerOffsetX() = 1;

beltAlignmentZ = 1;
function evaBeltAlignmentZ() = beltAlignmentZ;

bottomMgn12Size = [8.2, 44.1, 27 + beltAlignmentZ];
bottomMgn12OffsetZ = xCarriageBottomOffsetZ();
evaHoleSeparationTop = 34;
evaHoleSeparationBottom = 26;

module evaPrintheadList() {
    EVA_MC_top_mgn12_stl();
    translate([50, 0, 0])
        EVA_MC_top_lgx_mgn12_a_stl();
    translate([100, 0, 0])
        EVA_MC_top_bmg_mgn12_stl();
    translate([150, 0, 0])
        EVA_MC_top_orbiter_mgn12_stl();
    translate([210, 0, 0])
        EVA_MC_top_titan_mgn12_stl();
    translate([-50, 0, 0])
        EVA_MC_bottom_mgn12_short_duct_stl();
    *translate([-100, 0, 0])
        EVA_MC_dual_5015_bottom_mgn12_wide_stl();
    *translate([-150, 0, 0])
        EVA_MC_7530_fan_mgn12_bottom_wide_stl();
}

module evaHotendTop(top="mgn12", explode=40) {
    translate_z(2*eps)
        explode(explode)
            if (top == "lgx_bmg_mgn12_a")
                EVA_MC_top_lgx_mgn12_a_stl();
            else if (top == "bmg_mgn12")
                EVA_MC_top_bmg_mgn12_stl();
            else if (top == "orbiter_mgn12")
                EVA_MC_top_orbiter_mgn12_stl();
            else if (top == "titan_mgn12")
                EVA_MC_top_titan_mgn12_stl();
            else
                EVA_MC_top_mgn12_stl();
}

module evaHotendBottom() {
    translate([-bottomMgn12Size.y/2, bottomMgn12Size.z/2, -bottomMgn12OffsetZ])
        rotate([90, 90, 0])
            EVA_MC_bottom_mgn12_short_duct_stl();
}

module evaHotendBaseTopHardware(explode=40) {
    carriageType = MGN12H_carriage;

    translate_z(5 - carriage_height(carriageType))
        carriage_hole_positions(MGN12H_carriage)
            translate_z($exploded ? explode-70 : 0)
                explode(70, true)
                    boltM3Caphead(8);
}

module evaHotendBaseBackHardware(explode=40) {
    size = bottomMgn12Size;
    boltLength = 10;

    translate([-size.y/2, 3*bottomMgn12Size.z/2 + 2, -bottomMgn12OffsetZ])
        rotate([90, 90, 0]) {
            explode(-explode, true)
                for (y = [5, size.y - 5])
                    translate([-bottomMgn12Size.y, y, size.z])
                        vflip()
                            boltM3Caphead(boltLength);
            explode(-explode, true)
                for (y = [9, size.y - 9])
                    translate([size.x - 4, y, size.z])
                        vflip()
                            boltM3Caphead(boltLength);
        }
}

module evaHotendBaseFrontHardware(explode=40) {
    size = bottomMgn12Size;
    boltLength = 10;
    translate([-size.y/2, bottomMgn12Size.z/2 - 2, -bottomMgn12OffsetZ])
        rotate([90, 90, 0]) {
            explode(explode, true)
                for (y = [5, size.y - 5])
                    translate([-bottomMgn12Size.y, y, size.z])
                        boltM3Caphead(boltLength);
            explode(explode, true)
                for (y = [9, size.y - 9])
                    translate([size.x - 4, y, size.z])
                        boltM3Caphead(boltLength);
        }
}

module evaBeltClampPosition() {
    xCarriageBeltClampPosition(MGN12H_carriage, bottomMgn12Size)
        children();
}

module evaBeltClamp() {
    evaBeltClampPosition()
        translate_z(4.5)
            X_Carriage_Belt_Clamp_stl();
}

module evaBeltClampHardware() {
    evaBeltClampPosition()
        translate_z(4.5)
            vflip()
                X_Carriage_Belt_Clamp_hardware(countersunk=true);
}

module evaBeltTensionerPositions(explode=0) {
    translate([-18 - X_CarriageEVATensionerOffsetX(), 2.95, -31])
        explode([explode, 0, 0])
            children();
    translate([18 + X_CarriageEVATensionerOffsetX(), 2.95, -33])
        rotate([0, -180, 0])
            explode([explode, 0, 0])
                children();
}

module evaBeltTensioners() {
    evaBeltTensionerPositions(explode=-40)
        X_Carriage_Belt_Tensioner_stl();
}
module evaBeltTensionersHardware() {
    evaBeltTensionerPositions(explode=70)
        X_Carriage_Belt_Tensioner_hardware(40, 18.5);
}

module EVA_MC_BottomMgn12(ductSizeY=undef, airflowSplit=false) {
    size = bottomMgn12Size;
    tabSize = [22, is_undef(ductSizeY) ? size.y - 20 : ductSizeY, 3 + beltAlignmentZ];
    fillet = 0;
    offsetY = 4.5;
    carriageType = MGN12H_carriage;

    translate_z(-beltAlignmentZ/2) {
        difference() {
            union() {
                rounded_cube_xy(size, fillet);
                translate([size.x + 10, size.y/2, 0])
                    rounded_cube_xy([8, tabSize.y + 14, tabSize.z], 4 - eps, xy_center=true);
                translate([0, (size.y - tabSize.y)/2, 0]) {
                    cube(tabSize);
                    translate([size.x, 0, 0])
                        rotate(270)
                            fillet(2, tabSize.z);
                    translate([size.x + 6, 0, 0])
                        rotate(180)
                            fillet(2, tabSize.z);
                    translate([size.x, tabSize.y, 0])
                        fillet(2, tabSize.z);
                    translate([size.x + 6, tabSize.y, 0])
                        rotate(90)
                            fillet(2, tabSize.z);
                }
            }
            cutoutSize = [size.x + 2*eps, 12, 2 + 2*eps];
            hull()
                translate([-eps, (size.y - cutoutSize.y)/2, size.z + eps]) {
                    translate([0, cutoutSize.y, 0])
                        rotate([0, 90, 0])
                            right_triangle(cutoutSize.z, cutoutSize.z, cutoutSize.x, center=false);
                    rotate([-90, 0, -90])
                        right_triangle(cutoutSize.z, cutoutSize.z, cutoutSize.x, center=false);
            }
            for (y = [0, size.y], z = [6, size.z - 6])
                translate([size.x, y, z])
                    //scale([1, 1.2, 1])
                        tube(7, 4, 4);
            translate([3, size.y/2, size.z - cutoutSize.z])
                vflip()
                    boltHoleM3(5, twist=4);
            translate([15.4, size.y/2, -eps])
                rounded_cube_xy([10.6, tabSize.y - 4, tabSize.z + 2*eps], 1.5, xy_center=true);
            translate([size.x + eps, -eps, -eps])
                rotate(90)
                    right_triangle(2, 2, size.z + 2*eps, center=false);
            translate([size.x + eps, size.y + eps, -eps])
                rotate(180)
                    right_triangle(2, 2, size.z + 2*eps, center=false);
            for (y = [(size.y - evaHoleSeparationBottom)/2, (size.y + evaHoleSeparationBottom)/2])
                translate([size.x - 4, y, 0])
                    boltHoleM3Tap(size.z, twist=4);
            for (y = [(size.y + tabSize.y)/2 + 3, (size.y - tabSize.y)/2 - 3])
                translate([size.x + 10, y, 0])
                    boltHoleM3(tabSize.z, twist=4);
        }
        if (airflowSplit)
            translate([0, (size.y - 1.5)/2, 0])
                cube([tabSize.x, 1.5, tabSize.z]);

        extraZ = 0.5;
        translate_z(extraZ)
            xCarriageBeltAttachment(size.y);
        translate([-xCarriageBeltAttachmentSize().x, 0, 0])
            cube([xCarriageBeltAttachmentSize().x, size.y, extraZ]);
    }
}

module EVA_MC_TopMgn12(counterBore=true) {
    size = [bottomMgn12Size.y, bottomMgn12Size.z, 8];
    carriageType = MGN12H_carriage;

    translate([0, beltAlignmentZ/2, 0])
        difference() {
            rounded_cube_xy(size, 1, xy_center=true);
            translate_z(size.z - carriage_height(carriageType))
                carriage_hole_positions(carriageType)
                    vflip()
                        if (counterBore)
                            boltHoleM3Counterbore(8, twist=4);
                        else
                            boltHoleM3(8, twist=4);
            for (x = [-evaHoleSeparationTop/2, evaHoleSeparationTop/2])
                translate([x, size.y/2, 3])
                        rotate([90, 0, 0])
                            boltHoleM3Tap(size.y, horizontal=true);
            fillet = 1 + eps;
            translate([-size.x/2 - eps, 0, size.z + eps])
                rotate([90, 90, 0])
                    right_triangle(fillet, fillet, size.y + 2*eps, center=true);
            translate([size.x/2 + eps, 0, size.z + eps])
                rotate([90, 180, 0])
                    right_triangle(fillet, fillet, size.y + 2*eps, center=true);
        }
}

module evaImportStl(file) {
    import(str("../stlimport/eva/", file, ".stl"));
}

module EvaTopConvert(stlFile, zOffset=5, horizontal=true) {
    module boltCutout(offset, height) {
        vflip() {
            *hull()
                for (x = [-offset, offset])
                    translate([x, 0, -zOffset - height - eps])
                        cylinder(r=screw_head_radius(M3_cap_screw), h=screw_head_height(M3_cap_screw));
            hull()
                for (x = [-offset, offset])
                    translate([x, 0, -zOffset - height])
                        cylinder(r=screw_clearance_radius(M3_cap_screw), h=8 + eps);
        }
    }

    translate_z(-zOffset)
        //render(convexity=2)
            difference() {
                height = 8;
                union() {
                    evaImportStl(stlFile);
                    size1 = [40 + 2*eps, 27, height - screw_head_height(M3_cap_screw) - 0.2];
                    size2 = [bottomMgn12Size.y, 12, 1];
                    size3 = [30, 12, height - screw_head_height(M3_cap_screw) - 0.2];
                    for (size = [size1, size2, size3])
                        translate([-size.x/2, -size.y/2, zOffset])
                            cube(size);
                    size4 = [bottomMgn12Size.y, beltAlignmentZ, height - 1];
                    size5 = [bottomMgn12Size.y - 2, beltAlignmentZ, height];
                    translate([-size4.x/2, 13.5, zOffset])
                        hull() {
                            cube(size4);
                            translate([1, 0, 0])
                                cube(size5);
                        }
                    if (stlFile == "top_orbiter_mgn12") {
                        size1 = [7.07, beltAlignmentZ, height + 1.5];
                        size2 = [10.1, beltAlignmentZ, height];
                        translate([-6.55, 13.5, zOffset])
                            hull() {
                                translate([-size1.x/2, 0, 0])
                                    cube(size1);
                                translate([-size2.x/2, 0, 0])
                                    cube(size2);
                            }
                    }
                }
                for (x = [-evaHoleSeparationTop/2, evaHoleSeparationTop/2])
                    translate([x, size.y/2 + beltAlignmentZ, zOffset + 3])
                        rotate([90, 0, 0])
                            boltHoleM3Tap(size.y + beltAlignmentZ, horizontal=horizontal, twist=4);
                boltCutout(7, height - 3);
                size = [bottomMgn12Size.y + 2*eps, 27 + 2*eps, zOffset + eps];
                translate([-size.x/2, -size.y/2, -eps])
                    cube(size);
                translate_z(-zOffset - height) {
                    offset = 1.25;
                    carriageType = MGN12H_carriage;
                    x_pitch = carriage_pitch_x(carriageType)/2 - offset;
                    y_pitch = carriage_pitch_y(carriageType)/2;

                    for(x = [-x_pitch, x_pitch], y = [-y_pitch, y_pitch])
                        translate([x, y, carriage_height(carriageType)])
                            boltCutout(offset, height - 3);
                }
            }
}

module EVA_MC_bottom_mgn12_short_duct_stl() {
    stl("EVA_MC_bottom_mgn12_short_duct")
        color(evaAdaptorColor())
            EVA_MC_BottomMgn12();
}

module EVA_MC_dual_5015_bottom_mgn12_wide_stl() {
    stl("EVA_MC_dual_5015_bottom_mgn12_wide")
        color(evaAdaptorColor())
            EVA_MC_BottomMgn12(34, airflowSplit=true);
}

module EVA_MC_7530_fan_mgn12_bottom_wide_stl() {
    stl("EVA_MC_7530_fan_mgn12_bottom_wide")
        color(evaAdaptorColor())
            EVA_MC_BottomMgn12(34);
}

module EVA_MC_top_mgn12_stl() {
    stl("EVA_MC_top_mgn12")
        color(evaAdaptorColor())
            EVA_MC_TopMgn12(counterBore=true);
}

module EVA_MC_top_lgx_mgn12_a_stl() {
    stl("EVA_MC_top_lgx_mgn12_a")
        color(evaAdaptorColor())
            EVA_MC_TopMgn12(counterBore=false);
}

module EVA_MC_top_bmg_mgn12_stl() {
    stl("EVA_MC_top_bmg_mgn12")
        color(evaAdaptorColor())
            EvaTopConvert("top_bmg_mgn12");
}

module EVA_MC_top_orbiter_mgn12_stl() {
    stl("EVA_MC_top_orbiter_mgn12")
        color(evaAdaptorColor())
            EvaTopConvert("top_orbiter_mgn12", horizontal=false);
}

module EVA_MC_top_titan_mgn12_stl() {
    stl("EVA_MC_top_titan_mgn12")
        color(evaAdaptorColor())
            EvaTopConvert("top_titan_mgn12");
}

module back_corexy_stl() {
    stl("back_corexy")
        stl_colour(evaColorGreen())
            evaImportStl("back_corexy");
}

module universal_face_stl() {
    stl("universal_face")
        stl_colour(evaColorGreen())
            evaImportStl("universal_face");
}

module printheadEVA(rotate=180, explode=0, t=undef) {
    xRailCarriagePosition(carriagePosition(t), rotate)
        explode(explode, true) {
            color(pp4_colour)
                //evaHotendTop(top="mgn12");
                //evaHotendTop(top="lgx_bmg_mgn12_a");
                //evaHotendTop(top="bmg_mgn12");
                evaHotendTop(top="orbiter_mgn12");
                //evaHotendTop(top="titan_mgn12");
            color(pp4_colour)
                evaHotendBottom();
            zOffset = 5;
            translate([0, 19.5, -15.5 - zOffset])
                color(pp2_colour)
                    evaImportStl("back_corexy");
        }
}
