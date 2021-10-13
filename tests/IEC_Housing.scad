//! Display the IEC housing

include <NopSCADlib/utils/core/core.scad>
use <../scad/FaceRightExtras.scad>
use <../scad/printed/IEC_Housing.scad>
use <../scad/vitamins/Panels.scad>


//$explode = 1;
//$pose = 1;
module IEC_Housing_test() {
    //IEC_Housing_stl();
    //IEC_Housing_Mount_stl();
    *intersection() {
        translate([0, -180, -2])
            rounded_cube_xy([36, 40, 30], 2);
        IEC_Housing_Mount_300_stl();
    }
    IEC_Housing_assembly();
    //Partition_assembly();
}

if ($preview)
    IEC_Housing_test();
