//! Display the IEC housing

use <../scad/FaceRightExtras.scad>
use <../scad/printed/IEC_Housing.scad>


//$explode = 1;
//$pose = 1;
module IEC_Housing_test() {
    //IEC_Housing_stl();
    //IEC_Housing_Mount_stl();
    IEC_housing();
    IEC_Housing_Mount_assembly();
}

if ($preview)
    IEC_Housing_test();
