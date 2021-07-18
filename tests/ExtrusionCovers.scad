//!Display the extrusion covers.

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/nuts.scad>

use <../scad/printed/E20Cover.scad>
use <../scad/printed/extrusionChannels.scad>

eSize = 20;

//$explode = 1;
//$pose = 1;
module ExtrusionCover_test() {
    height = 50;

    translate([0, -1.5, 0])
        E20Cover(height);
    translate([0, 2*eSize + 1, 0])
        rotate(180)
            extrusionPiping(height);
    translate([eSize/2, eSize/2, 0])
        rotate([90, 0, 90])
            extrusionChannel(height);
    translate([eSize/2 - 2.1, 3*eSize/2, 5.5])
        rotate([0, -90, 0])
            sliding_t_nut(M4_sliding_t_nut);
    translate([-eSize/2 - 1.5, eSize/2, 0])
        rotate(-90)
            E20_RibbonCover_50mm_stl();
    translate([0, eSize, 0])
        extrusion(E2040, height, center=false);
}

//extrusionChannel(90, [10, 20, 80], sliding=false);
//extrusionChannel(100, [50], sliding=false, narrow=true);
//extrusionChannel(100, [42.5, 50], sliding=false, channelWidth=4.95);
//extrusionChannel(200, [50, 150], sliding=false, channelWidth=4.95);
//extrusionChannel(100, [10, 50], sliding=false);
//extrusionChannel(100, [50, 150], sliding=false);
//extrusionChannel(200, [eSize, eSize + 120], sliding=false);
//extrusionChannel(200, [eSize/2, eSize, eSize + 120], sliding=false);
//rotate(90) extrusionChannel(120, [10, 60, 110], sliding=false, channelWidth=3.8, boltDiameter=3);
//rotate(90) extrusionChannel(120, [10, 35, 60, 85, 110], sliding=false, channelWidth=4.8, boltDiameter=3);
//rounded_cube_xy([20, 20, 10],1.5);
if ($preview)
    ExtrusionCover_test();
