//!Display the extrusion covers.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/nuts.scad>

use <../scad/printed/extrusionChannels.scad>

eSize = 20;

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

//extrusionChannel(90, [10, 20, 80], sliding=false);
//extrusionChannel(100, [50], sliding=false, narrow=true);
//extrusionChannel(100, [42.5, 50], sliding=false, channelWidth=4.95);
//extrusionChannel(200, [50, 150], sliding=false, channelWidth=4.95);
//extrusionChannel(100, [10, 50], sliding=false);
//extrusionChannel(100, [50, 150], sliding=false);
//extrusionChannel(200, [eSize, eSize+120], sliding=false);
//extrusionChannel(200, [eSize/2, eSize, eSize+120], sliding=false);
//rotate(90) extrusionChannel(120, [10, 60, 110], sliding=false, channelWidth=3.8, boltDiameter=3);
rotate(90) extrusionChannel(120, [10, 35, 60, 85, 110], sliding=false, channelWidth=4.8, boltDiameter=3);
//rounded_cube_xy([20, 20, 10],1.5);
*if ($preview)
    ExtrusionCover_test();
