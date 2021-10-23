//!# Kinematic
//!
//!This is proof of concept showing the MaybeCube with the Jubilee Kinematic Bed.
//
include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/JubileeKinematicBed.scad>
use <printed/Z_MotorMount.scad>
include <vitamins/bolts.scad>

use <FaceLeft.scad>
use <FaceRight.scad>
use <FaceTop.scad>

include <Parameters_Main.scad>

//$explode = 1;
//$pose = 1;

module JubileeKinematicBed_assembly()
assembly("JubileeKinematicBed", big=true) {
    //front_left_bed_coupling_lift_stl();
    //front_right_bed_coupling_lift_stl();
    //back_bed_coupling_lift_stl();
    Left_Side_assembly();
    Right_Side_assembly();
    //Face_Top_Stage_1_assembly();
    //jubilee_build_plate();

}


if ($preview)
    JubileeKinematicBed_assembly();
