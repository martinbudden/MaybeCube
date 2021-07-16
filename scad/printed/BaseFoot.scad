include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>

use <../vitamins/bolts.scad>

include <../Parameters_Main.scad>


function extrusionFootLShapedBoltOffsetZ() = 3;

module extrusionFootLShaped(footHeight = 10) {
    size = [eSize, eSize + 25, footHeight];
    boltOffset = 10;
    fillet = 2;

    difference() {
        union() {
            rounded_cube_xy(size, fillet);
            translate([size.x, 0, 0])
                rotate(90)
                    rounded_cube_xy(size, fillet);
            translate([0, size.x, 0])
                rotate(90)
                    fillet(fillet, footHeight);
        }
        boreDepth = footHeight - extrusionFootLShapedBoltOffsetZ();
        translate([size.x/2, boltOffset, 0])
            boltHoleM6Counterbore(footHeight, boreDepth);
        translate([size.x/2, size.y - boltOffset, 0])
            boltHoleM4CounterboreButtonhead(footHeight, boreDepth);
        translate([-size.y + eSize + boltOffset, size.x/2, 0])
            boltHoleM4CounterboreButtonhead(footHeight, boreDepth);
    }
}

module Foot_LShaped_12mm_stl() {
    stl("Foot_LShaped_12mm")
        vflip()
            color(pp1_colour)
                extrusionFootLShaped(footHeight=12);
}
