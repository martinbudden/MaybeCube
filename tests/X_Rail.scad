//!Display the x axis linear rail.

use <../scad/utils/X_Rail.scad>
include <../scad/global_defs.scad>
include <../scad/Parameters_Main.scad>

//$explode = 1;
module xRail_test() {
    translate([-eX/2, -eY/2, 0])
        xRail();
        //X_Rail_with_X_Carriage_assembly();
}

if ($preview)
    xRail_test();
