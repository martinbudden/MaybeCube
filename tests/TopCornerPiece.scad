//!Displays a top corner piece.

use <../scad/printed/TopCornerPiece.scad>

module TopCornerPiece_test() {
    Top_Corner_Piece_stl();
    Top_Corner_Piece_hardware();
}

if ($preview)
    TopCornerPiece_test();
