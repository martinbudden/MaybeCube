//!Test cube for flow calibration

include <NopSCADlib/utils/core/core.scad>

bedSize = [160, 160];
size = [20, 20, 0.25];
for (x = [0, bedSize.x - size.x], y = [0, bedSize.y - size.y])
    translate([x, y])
        rounded_cube_xy(size, 2);
translate([(bedSize.x - size.x)/2, (bedSize.y - size.y)/2])
    rounded_cube_xy(size, 2);
