//!Display the Kinematic Bed
//!
//!This is proof of concept showing the MaybeCube with the Jubilee Kinematic Bed.
//
include <../scad/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/JubileeKinematicBed.scad>
use <../scad/BasePlate.scad>
use <../scad/FaceLeft.scad>
use <../scad/FaceRight.scad>
//use <../scad/printed/PrintheadAssemblies.scad>

//$explode = 1;
//$pose = 1;

module KinematicBed_test() {
    bedHeight = 100;//_zMax;//_zMin-20;
    //translate([-(25.35+24)/2,-35,-(51.5+33.9)/2])
    //translate([-24.675,-35,-42.7])
    //front_left_bed_coupling_lift_assembly();
    //front_right_bed_coupling_lift_assembly();
    //back_bed_coupling_lift_assembly();
    //back_bed_coupling_lift_stl();
    Left_Side_assembly(bedHeight=bedHeight, printbedKinematic=true);
    Right_Side_assembly(bedHeight=bedHeight, printbedKinematic=true, sideAssemblies=false);
    basePlateAssembly(rightExtrusion=true);
    translate_z(bedHeight) jubilee_build_plate();
    //printheadHotendSide(t=3);
    //let($hide_bolts=true)
    //let($hide_rails=true)
    //let($hide_extrusions=true)
    //zRails(left=false);
}


if ($preview)
    KinematicBed_test();
