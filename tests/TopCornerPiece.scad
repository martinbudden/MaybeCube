//!Displays a top corner piece.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/psus.scad>

use <../scad/printed/TopCornerPiece.scad>

module TopCornerPiece_test() {
    Top_Corner_Piece_stl();
    Top_Corner_Piece_hardware();
}

if ($preview)
    TopCornerPiece_test();
