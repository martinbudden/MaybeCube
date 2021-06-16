include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/tube.scad>
include <NopSCADlib/vitamins/pin_headers.scad>


function filament_sensor_size() = [28, 30.85, 12.65];

function filament_sensor_offset() = [filament_sensor_size().x - 3, 0, 4.5];

module filament_sensor_hole_positions(z=0) {
    size = filament_sensor_size();
    holeOffsetX = filament_sensor_size().x - 15;
    tubeLength = 6;

    for (y = [-10, 10])
        translate([holeOffsetX - filament_sensor_offset().x, y -size.y/2 - tubeLength, z])
            children();
}

module filament_sensor() {
    vitamin(str("filament_sensor() : Filament sensor"));
    size = filament_sensor_size();
    filamentOffset = filament_sensor_offset();
    tubeLength = 6;
    color = grey(20);

    color(color) {
        difference() {
            translate([-filamentOffset.x, -size.y - tubeLength, 0])
                rounded_cube_xy(size, 1);
            translate([0, -size.y - tubeLength, filamentOffset.z])
                rotate([-90, 0, 0])
                    cylinder(h=size.y + 2*eps, r=1.5);
            filament_sensor_hole_positions()
                cylinder(h=size.z + 2*eps, r=M3_clearance_radius);
        }
        translate([0, -tubeLength, filamentOffset.z])
            rotate([-90, 0, 0])
                    tube(or=2.5, ir=1.5, h=tubeLength, center=false);
    }
    translate([5 - filamentOffset.x, -size.y/2 - tubeLength, 7])
        rotate([0, 180, -90])
            jst_xh_header(jst_xh_header, 3, right_angle=true);
}
