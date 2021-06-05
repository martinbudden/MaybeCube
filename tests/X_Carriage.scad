//! Display the X carriage

include <../scad/global_defs.scad>
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/blowers.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageAssemblies.scad>

use <../scad/utils/carriageTypes.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
module X_Carriage_test() {
    X_Carriage_assembly();
    X_Carriage_Front_assembly();
    //Fan_Duct_stl();
    //Fan_Duct_Right_stl();
    //Belt_Tensioner_stl();
    //Belt_Clamp_stl();
    //Belt_Tidy_stl();
}

if ($preview)
    X_Carriage_test();
