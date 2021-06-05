//!Display the x axis linear rail.

include <../scad/global_defs.scad>

use <../scad/utils/X_Rail.scad>

include <../scad/Parameters_Main.scad>


//$explode = 1;
module xRail_test() {
    translate([-eX/2, -eY/2, 0])
        xRail();
}

if ($preview)
    xRail_test();
