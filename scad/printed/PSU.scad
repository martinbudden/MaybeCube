include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/psus.scad>
use <NopSCADlib/printed/psu_shroud.scad>


include <../Parameters_Main.scad>

PSUtype = [for (i =[0 : len(S_300_12) - 1]) i==1 ? "Switching Power Supply 24V 15A 360W" : S_300_12[i] ];

function PSUtype() = PSUtype;
function PSUstandoffHeight() = 0;
function psuShroudCableDiameter() = 8;
function psuOffset(PSUtype) = [eSize + psu_width(PSUtype)/2, eY + 2*eSize, psu_length(PSUtype)/2 + 2*eSize + 15];

module PSUBoltPositions() {//! Position children at the bolt positions on the bottom face
    rotate(180)
        for (pos = psu_face_holes(psu_faces(PSUtype)[f_bottom]))
            translate([pos.x, pos.y + psu_right_bay(PSUtype), 0])
                children();
}

module PSUPosition(psuOnBase=false) {
    type = PSUtype();
    psuSize = [psu_length(type), psu_width(type), psu_height(type)];
    psuShroudWall = 1.8;
    psuOffsetZ = 2*eSize + psuShroudWall;


    if (psuOnBase) {
        topRightPosition = [eX, eSize + eY - 5, 0];
        translate(topRightPosition)
            translate([-psuSize.x/2, -psuSize.y/2, 0])
                children();
    } else {
        if (eX >= 300)
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
                not_on_reduced_bom() psu(PSUtype());
                thickness = 3.5;
                *mirror([0, 1, 0])
                    psu_shroud_assembly(PSUtype(), psuShroudCableDiameter(), PSUtype()[0], inserts=false);
                    //psu_shroud_fastened_assembly(PSUtype(), psuShroudCableDiameter, thickness, PSUtype()[0], inserts=false);
            }
}

module psu_shroud_S_300_12_stl() {
    mirror([0, 1, 0])
        psu_shroud(PSUtype(), psuShroudCableDiameter(), PSUtype()[0], inserts=false);
}
