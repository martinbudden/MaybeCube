include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/psus.scad>
//use <NopSCADlib/printed/psu_shroud.scad>


include <../Parameters_Main.scad>

//PSUtype = [for (i =[0 : len(S_300_12) - 1]) i==1 ? "Switching Power Supply 24V 15A 360W" : S_300_12[i] ];

function PSUtype() = S_300_12;//PSUtype;
function PSUstandoffHeight() = 0;
function psuShroudCableDiameter() = 8;
function psuOffset(PSUtype) = [eSize + 3 + psu_width(PSUtype)/2, eY + 2*eSize, psu_length(PSUtype)/2 + 2*eSize + 15];

module PSUBoltPositions() {//! Position children at the bolt positions on the bottom face
    for (pos = psu_face_holes(psu_faces(PSUtype())[f_bottom]))
        translate([pos.x, pos.y + psu_right_bay(PSUtype()), 0])
            children();
}

module PSUPosition(psuOnBase=false) {
    type = PSUtype();
    psuSize = psu_size(type);
    psuShroudWall = 1.8;
    psuOffsetZ = 2*eSize + psuShroudWall;


    if (psuOnBase) {
        topRightPosition = [eX, eSize + eY - 5, 0];
        translate(topRightPosition)
            translate([-psuSize.x/2, -psuSize.y/2, 0])
                children();
    } else {
        if (eX == 300)
            translate(psuOffset(type))
                rotate([90, 90, 0])
                    children();
        else
            translate([eSize + psuSize.x/2, eY + 2*eSize, psuSize.y/2 + psuOffsetZ])
                rotate([90, 0, 0])
                    children();
    }
}

module PSU() {
    translate_z(PSUstandoffHeight())
        rotate(180)
            if (is_undef($hide_psu) || $hide_psu == false) {
                not_on_reduced_bom()  vitamin(str(": LED Switching Power Supply 24V 15A 360W"));
                not_on_bom() psu(PSUtype());
                thickness = 3.5;
                //mirror([0, 1, 0])
                    //psu_shroud_assembly(PSUtype(), psuShroudCableDiameter(), PSUtype()[0], inserts=false);
            }
}

module psu_shroud_S_300_12_stl() {
    mirror([0, 1, 0])
        psu_shroud(PSUtype(), psuShroudCableDiameter(), PSUtype()[0], inserts=false);
}

module PSU_Cover_stl() {
    psuSize = psu_size(PSUtype());
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
assembly("PSU_Cover") {

    psuSize = psu_size(PSUtype());
    PSUPosition()
        translate([psuSize.x/2 + eSize + 15, 0, psuSize.z])
            hflip()
                stl_colour(pp1_colour)
                    PSU_Cover_stl();
}
