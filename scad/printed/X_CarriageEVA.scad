include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/utils/tube.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../printed/X_CarriageEVA.scad>
use <../printed/X_CarriageBeltAttachment.scad>

use <../vitamins/bolts.scad>


function evaColorGrey() = grey(25);
function evaColorGreen() = "LimeGreen";
function X_CarriageEVATensionerOffsetX() = 1;

bottomMgn12Size = [8.2, 44.1, 27];


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
    translate([-100, 0, 0])
        EVA_MC_dual_5015_bottom_mgn12_wide_stl();
    translate([-150, 0, 0])
        EVA_MC_7530_fan_mgn12_bottom_wide_stl();
}

module evaHotendBase(top="mgn12", explode=40) {
    translate_z(2*eps)
        explode(explode)
            if (top == "bmg_mgn12")
                EVA_MC_top_bmg_mgn12_stl();
            else
                EVA_MC_top_mgn12_stl();
    translate([-22.1, 13.5, -40.8])
        rotate([90, 90, 0]) {
            EVA_MC_bottom_mgn12_short_duct_stl();
            sizeZ = 44.1;
            explode(20, true)
                for (y = [3*sizeZ/10, 7*sizeZ/10])
                    translate([-xCarriageBeltAttachmentSizeX(), y, 18.5])
                        X_Carriage_Belt_Clamp_stl();
        }
    evaTensioners();
}

module evaHotendBaseHardware(explode=40) {
    carriageType = MGN12H_carriage;
    translate_z(5 - carriage_height(carriageType))
        carriage_hole_positions(MGN12H_carriage)
            explode(explode, true)
                boltM3Caphead(8);
    translate([-22.1, 13.5, -40.8])
        rotate([90, 90, 0]) {
            sizeZ = 44.1;
            explode(20, true)
                for (y = [3*sizeZ/10, 7*sizeZ/10])
                    translate([-xCarriageBeltAttachmentSizeX(), y, 18.5])
                        X_Carriage_Belt_Clamp_hardware();
            size = bottomMgn12Size;
            explode([-explode, 0, 0], true)
                for (y = [5, size.y - 5])
                    translate([-44, y, size.z]) {
                        boltM3Caphead(40);
                        translate_z(-33)
                            rotate(30)
                                explode(-20)
                                    nut(M3_nut);
                    }
            for (y = [9, size.y - 9])
                translate([size.x - 4, y, size.z]) {
                    boltM3Caphead(40);
                    translate_z(-33)
                        rotate(30)
                            explode(-40)
                                nut(M3_nut);
                }
        }
    evaTensionersHardware();
}

module evaTensioners() {
    translate([-18 - X_CarriageEVATensionerOffsetX(), 2.95, -31])
        explode([-50, 0, 0])
            X_Carriage_Belt_Tensioner_stl();
    translate([18 + X_CarriageEVATensionerOffsetX(), 2.95, -33])
        rotate([0, -180, 0])
            explode([-50, 0, 0])
                X_Carriage_Belt_Tensioner_stl();
}

module evaTensionersHardware() {
    translate([-18 - X_CarriageEVATensionerOffsetX(), 2.95, -31])
        X_Carriage_Belt_Tensioner_hardware();
    translate([18 + X_CarriageEVATensionerOffsetX(), 2.95, -33])
        rotate([0, -180, 0])
            X_Carriage_Belt_Tensioner_hardware();
}

module EVA_MC_BottomMgn12(ductSizeY=undef, split=false) {
    size = bottomMgn12Size;
    tabSize = [22, is_undef(ductSizeY) ? size.y - 20 : ductSizeY, 3];
    fillet = 0;
    offsetY = 4.5;
    carriageType = MGN12H_carriage;

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
        cutoutSize = [size.x+2*eps, 12, 2+2*eps];
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
        for (y = [9, size.y - 9])
            translate([size.x - 4, y, 0])
                boltHoleM3(size.z, twist=4);
        for (y = [(size.y + tabSize.y)/2 + 3, (size.y - tabSize.y)/2 - 3])
            translate([size.x + 10, y, 0])
                boltHoleM3(tabSize.z, twist=4);
    }
    if (split)
        translate([0, (size.y - 1.5)/2, 0])
            cube([tabSize.x, 1.5, tabSize.z]);
    xCarriageBeltAttachment(size.y);
}

module EVA_MC_TopMgn12(counterBore=true) {
    size = [44.1, 27, 8];
    carriageType = MGN12H_carriage;

    difference() {
        rounded_cube_xy(size, 1, xy_center=true);
        translate_z(size.z - carriage_height(carriageType))
            carriage_hole_positions(carriageType)
                vflip()
                    if (counterBore)
                        boltHoleM3Counterbore(8, twist=4);
                    else
                        boltHoleM3(8, twist=4);
        for (x = [-size.x/2 + 5, size.x/2 -5])
            translate([x, size.y/2, 3])
                    rotate([90, 0, 0])
                        boltHoleM3(size.y, horizontal=true);
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

module EvaTopConvert(stlFile, zOffset = 5) {
    module boltCutout(offset, height) {
        vflip() {
            *hull()
                for (x = [-offset, offset])
                    translate([x, 0, -zOffset - height - eps])
                        cylinder(r=screw_head_radius(M3_cap_screw), h=screw_head_height(M3_cap_screw));
            hull()
                for (x = [-offset, offset])
                    translate([x, 0, -zOffset - height])
                        cylinder(r=screw_clearance_radius(M3_cap_screw), h=8+eps);
        }
    }

    translate_z(-zOffset)
        //render(convexity=2)
            difference() {
                height = 8;
                union() {
                    evaImportStl(stlFile);
                    size1 = [30 + 2*eps, 27, height - screw_head_height(M3_cap_screw) - 0.2];
                    size2 = [44.1, 12, 1];
                    size3 = [30, 12, height - screw_head_height(M3_cap_screw) - 0.2];
                    for (size = [size1, size2, size3])
                        translate([-size.x/2, -size.y/2, zOffset])
                            cube(size);
                }
                boltCutout(7, height - 3);
                size = [44.1 + 2*eps, 27 + 2*eps, zOffset + eps];
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
        color(evaColorGrey())
            EVA_MC_BottomMgn12();
}

module EVA_MC_dual_5015_bottom_mgn12_wide_stl() {
    stl("EVA_MC_dual_5015_bottom_mgn12_wide")
        color(evaColorGrey())
            EVA_MC_BottomMgn12(34, split=true);
}

module EVA_MC_7530_fan_mgn12_bottom_wide_stl() {
    stl("EVA_MC_7530_fan_mgn12_bottom_wide")
        color(evaColorGrey())
            EVA_MC_BottomMgn12(34);
}

module EVA_MC_top_mgn12_stl() {
    stl("EVA_MC_top_mgn12")
        color(evaColorGrey())
            EVA_MC_TopMgn12(counterBore=true);
}

module EVA_MC_top_lgx_mgn12_a_stl() {
    stl("EVA_MC_top_lgx_mgn12_a")
        color(evaColorGrey())
            EVA_MC_TopMgn12(counterBore=false);
}

module EVA_MC_top_bmg_mgn12_stl() {
    stl("EVA_MC_top_bmg_mgn12")
        color(evaColorGrey())
            EvaTopConvert("top_bmg_mgn12");
}

module EVA_MC_top_orbiter_mgn12_stl() {
    stl("EVA_MC_top_orbiter_mgn12")
        color(evaColorGrey())
            EvaTopConvert("top_orbiter_mgn12");
}

module EVA_MC_top_titan_mgn12_stl() {
    stl("EVA_MC_top_titan_mgn12")
        color(evaColorGrey())
            EvaTopConvert("top_titan_mgn12");
}
