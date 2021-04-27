include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/tube.scad>
include <NopSCADlib/vitamins/pin_headers.scad>


function filament_sensor_size() = [40, 27, 12];

filamentOffset = 6;

module filament_sensor_hole_positions(z=0) {
    for (x = [-10, 10])
        translate([x, -filamentOffset, z])
            children();
}

module filament_sensor() {
    vitamin(str("filament_sensor() : filament sensor"));
    size = filament_sensor_size();

    color = grey(20);
    color(color) {
        difference() {
            translate([0, -filamentOffset, 0])
                cube(size, center=true);
            rotate([0, 90, 0])
                cylinder(h=size.x + 1, r=1.5, center=true);
            filament_sensor_hole_positions()
                cylinder(h=size.z + 2*eps, r=M3_clearance_radius, center=true);
        }
        translate([-size.x/2, 0, 0])
            rotate([0, 90, 0])
                tube(or=2.5, ir=1.5, h=5);
    }
    translate([10, -size.y/2 - 3, 0])
        jst_xh_header(jst_ph_header, 3, right_angle=true);
}
