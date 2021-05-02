//!Display the belt clamps.

include <NopSCADlib/core.scad>
use <../scad/printed/X_CarriageAssemblies.scad>


//$explode = 1;
//$pose = 1;
module BeltClamp_test() {
    Belt_Tidy_stl();
    //Fan_Duct_stl();
}

if ($preview)
    BeltClamp_test();
