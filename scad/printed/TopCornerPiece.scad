include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>

use <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


topCornerPieceHoles = [ [eSize/2, 3*eSize/2], [eSize/2, 5*eSize/2], [3*eSize/2, eSize/2], [3*eSize/2, 3*eSize/2], [5*eSize/2, eSize/2] ];
topCornerPieceSize = [3*eSize, 3*eSize, 5];

module topCornerPiece() {
    size = topCornerPieceSize;
    fillet = 2;

    translate_z(-size.z)
        difference() {
            union() {
                linear_extrude(size.z)
                    offset(r=fillet)
                        offset(delta=-fillet)
                            hull()
                                polygon([
                                    [eSize, 0], [size.x, 0], [size.x, size.y - 2*eSize], [size.x - 2*eSize, size.y], [0, size.y], [0, eSize]
                                ]);
                guideSize = [5, eSize + 0.5, 5];
                translate([guideSize.y, 0, -guideSize.z])
                    rounded_cube_xy([guideSize.x, guideSize.x + guideSize.y, guideSize.z], 1.5);
                translate([0, guideSize.y, -guideSize.z])
                    rounded_cube_xy([guideSize.x + guideSize.y, guideSize.x, guideSize.z], 1.5);
                translate([guideSize.y, guideSize.y, -guideSize.z])
                    rotate(180)
                        fillet(0.5, guideSize.z);
            }
            for (i = topCornerPieceHoles)
                translate(i)
                    boltPolyholeM4Countersunk(size.z);
        }
}

module Top_Corner_Piece_stl() {
    stl("Top_Corner_Piece")
        color(pp1_colour)
            vflip()
                topCornerPiece();
}

module Top_Corner_Piece_hardware(rotate=0) {
    translate_z(topCornerPieceSize.z)
        vflip()
            for (i = [0 : len(topCornerPieceHoles) - 1])
                translate(topCornerPieceHoles[i])
                    vflip()
                        boltM4CountersunkTNut(10, rotate=(i < 2 ? 90 : i==3 ? (rotate == 0 || rotate==180 ? 90 : 0) : 0));
}

module topCornerPieceAssembly(rotate=0) {
    explode(50, true)
        rotate(rotate) {
            stl_colour(pp1_colour)
                Top_Corner_Piece_stl();
            Top_Corner_Piece_hardware(rotate);
        }
}
