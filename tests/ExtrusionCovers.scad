//!Display the belt clamps.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/nuts.scad>

use <../scad/printed/extrusionChannels.scad>


//$explode = 1;
//$pose = 1;
module ExtrusionCover_test() {
    translate([0, -1.5, 0])
        E2020Cover(50);
    *translate([0, -1, 0])
        extrusionPiping(10);
    *rotate([90, 0, 0])
        extrusionChannel(50);
    *translate([0, 2.1, 0])
        rotate([0, 90, 90])
            sliding_t_nut(M4_sliding_t_nut);
    translate([0, 10, 0])
        extrusion(E2020, 50);
}

extrusionChannel(50);
*if ($preview)
    ExtrusionCover_test();
