//!Display the belt clamps.

include <NopSCADlib/core.scad>
use <../scad/printed/extrusionChannels.scad>


//$explode = 1;
//$pose = 1;
module ExtrusionCover_test() {
    E2020Cover(50);
}

if ($preview)
    ExtrusionCover_test();
