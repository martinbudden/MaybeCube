//! Display a foot

use <../scad/printed/BaseFoot.scad>


//$explode = 1;
//$pose = 1;
module BaseFoot_test() {
    Foot_LShaped_12mm_stl();
}

if ($preview)
    BaseFoot_test();
