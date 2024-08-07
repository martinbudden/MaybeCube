include <../config/global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>


eSize = 20;
topCornerPieceHoles = [ [eSize/2, 3*eSize/2], [eSize/2, 5*eSize/2], [3*eSize/2, eSize/2], [3*eSize/2, 3*eSize/2], [5*eSize/2, eSize/2] ];
topCornerPieceSize = [3*eSize, 3*eSize, 5];

module topCornerPiece(guide=true) {
    size = topCornerPieceSize;
    fillet = 2;

    difference() {
        union() {
            // offset so that the front panel does catch when inserted, even if it flexes a bit.
            // on second thoughts, probably not a good idea as makes alignment more difficult
            offset = 0;
            *linear_extrude(size.z)
                offset(r=fillet)
                    offset(delta=-fillet)
                        hull()
                            polygon([
                                [eSize, 0], [size.x, 0], [size.x, size.y - 2*eSize], [size.x - 2*eSize, size.y], [0, size.y], [0, eSize]
                            ]);
            hull() {
                translate([eSize, offset, 0])
                    rounded_cube_xy([size.x - eSize, eSize - offset, size.z], fillet);
                translate([offset, eSize, 0])
                    rounded_cube_xy([eSize - offset, size.y - eSize, size.z], fillet);
            }
            if (guide) {
                // guide for top cover and placing Face_Top_assembly upside down on top of frame
                guideSize = [5, 7.5, 5 + size.z];
                translate([eSize + 0.5, eSize + 0.5 - guideSize.y, 0])
                    rounded_cube_xy([guideSize.x, guideSize.x + guideSize.y - offset, guideSize.z], 1.5);
                translate([eSize + 0.5 - guideSize.y, eSize + 0.5, 0])
                    rounded_cube_xy([guideSize.x + guideSize.y - offset, guideSize.x, guideSize.z], 1.5);
                translate([eSize + 0.5, eSize + 0.5, 0])
                    rotate(180)
                        fillet(0.5, guideSize.z);
            }
        }
        for (i = topCornerPieceHoles)
            translate(i)
                translate_z(size.z)
                    boltPolyholeM4Countersunk(size.z);
        cutDepth = 2;
        translate_z(size.z - cutDepth + eps)
            difference() {
                cube([eSize + 0.5, eSize + 0.5, cutDepth]);
                translate([eSize + 0.5, eSize + 0.5, 0])
                    rotate(180)
                        fillet(0.5, cutDepth);
            }
    }
}

module Top_Corner_Piece_stl() {
    stl("Top_Corner_Piece");
    color(pp2_colour)
        topCornerPiece(guide=false);
}

module Top_Corner_Piece_Flat_stl() {
    stl("Top_Corner_Piece_Flat");
    color(pp2_colour)
        topCornerPiece(guide=false);
}

module Top_Corner_Piece_hardware(rotate=0) {
    translate_z(topCornerPieceSize.z)
        for (i = [0 : len(topCornerPieceHoles) - 1])
            translate(topCornerPieceHoles[i])
                    boltM4CountersunkTNut(10, rotate=(i < 2 ? 90 : i==3 ? (rotate == 0 || rotate==180 ? 90 : 0) : 0));
}

module topCornerPieceAssembly(rotate=0) {
    explode(50, true)
        rotate(rotate) {
            stl_colour(pp2_colour)
                if (is_undef(_useBackMounts) || _useBackMounts == false)
                    Top_Corner_Piece_stl();
                else
                    Top_Corner_Piece_Flat_stl();
            Top_Corner_Piece_hardware(rotate);
        }
}
