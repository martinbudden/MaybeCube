include <../config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/psus.scad>
//use <NopSCADlib/printed/psu_shroud.scad>

include <../config/Parameters_Main.scad>


//PSUType = [for (i =[0 : len(S_300_12) - 1]) i==1 ? "Switching Power Supply 24V 15A 360W" : S_300_12[i] ];

function PSUType() = S_300_12;
function PSUStandoffHeight() = 0;
function psuShroudCableDiameter() = 8;
function psuOffset(PSUType) = [eSize + 3 + psu_width(PSUType)/2, eY + 2*eSize, psu_length(PSUType)/2 + 2*eSize + 15];

module PSUBoltPositions(PSUType) {//! Position children at the bolt positions on the bottom face
    for (pos = psu_face_holes(psu_faces(PSUType)[f_bottom]))
        translate([-pos.x, pos.y + psu_right_bay(PSUType), 0])
            children();
}

module PSUPosition(psuType, psuVertical=false) {
    psuSize = psu_size(psuType);
    psuShroudWall = 3;
    psuOffsetZ = 2*eSize + psuShroudWall;

    if (psuVertical)
        translate(psuOffset(psuType))
            rotate([90, 90, 0])
                children();
    else
        translate([eSize + psuSize.x/2 + (!is_undef(_printbedKinematic) && _printbedKinematic == true ? 75 : 0), eY + 2*eSize, psuSize.y/2 + psuOffsetZ])
            rotate([90, 0, 0])
                children();
}

module PSU_S_360_24() {
    translate_z(PSUStandoffHeight())
        rotate(180)
            if (is_undef($hide_psu) || $hide_psu == false) {
                vitamin(str(": LED Switching Power Supply 24V 15A 360W"));
                not_on_bom() psu(S_300_12);
                thickness = 3.5;
                //mirror([0, 1, 0])
                    //psu_shroud_assembly(PSUType(), psuShroudCableDiameter(), PSUType()[0], inserts=false);
            }
}

/*
module psu_shroud_S_300_12_stl() {
    mirror([0, 1, 0])
        psu_shroud(PSUType(), psuShroudCableDiameter(), PSUType()[0], inserts=false);
}

module PSU_Cover_stl() {
    psuSize = psu_size(PSUType());
    wallThickness = 3;
    baseSize = [2*eSize + 35, psuSize.y + 2*wallThickness, wallThickness];
    fillet = 1;

    color(pp1_colour)
        stl("PSU_Cover")
            translate([0, -baseSize.y/2, -wallThickness]) {
                rounded_cube_xy(baseSize, fillet);
                rounded_cube_xy([baseSize.x, wallThickness, psuSize.z + wallThickness - eSize], fillet);
                translate([eSize, 0, 0])
                    rounded_cube_xy([baseSize.x - eSize, wallThickness, psuSize.z + wallThickness], fillet);
                rounded_cube_xy([wallThickness, baseSize.y, psuSize.z + wallThickness - eSize], fillet);
                translate([0, baseSize.y - wallThickness, 0]) {
                    rounded_cube_xy([2*eSize, wallThickness, psuSize.z + wallThickness - eSize], fillet);
                    translate([eSize, 0, 0])
                        rounded_cube_xy([baseSize.x - eSize, wallThickness, psuSize.z + wallThickness], fillet);
                }
            }
}

module PSU_Cover_assembly()
assembly("PSU_Cover", ngb=true) {

    psuSize = psu_size(PSUType());
    PSUPosition(PSUType(), psuVertical=true)
        translate([psuSize.x/2 + eSize + 15, 0, psuSize.z])
            hflip()
                stl_colour(pp1_colour)
                    PSU_Cover_stl();
}
*/
