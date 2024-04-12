//! Display an exploded view of the MaybeCube

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/PrintheadAssemblies.scad>
include <../scad/utils/Z_Rods.scad>

use <../scad/BackFace.scad>
use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
use <../scad/FaceTop.scad>
use <../scad/Printbed.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


$explode = 1;
module Exploded_View_test() {
    explode = 200;

    no_explode()
        Base_Plate_assembly();

    *explode([0, explode, 0])
        Back_Panel_assembly();

    explode([-explode, 0, 0]) {
        Left_Side_assembly();
        zRods();
        zMotor();
        translate_z(bedHeight())
            if ($target[0]=="M")
                Printbed_assembly();
    }

    explode([explode, 0, 0])
        Right_Side_assembly();

    explode([0, 0, 1.25*explode]) {
        Face_Top_assembly();
        //fullPrinthead();
        printheadBeltSide();
        printheadE3DV6();
    }
}

if ($preview)
    rotate($vpr.z == 25 ? 0 : -90 + 30)
        translate([-eX/2 - eSize, -eY/2 - eSize, 0])
            Exploded_View_test();
