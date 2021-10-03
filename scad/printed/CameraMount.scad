include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/cameras.scad>

include <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


cameraMountSize = [40, eSize, 5];
cameraAngle = [30, 15, 0];

module Camera_Mount_stl() {
    size = cameraMountSize;
    fillet = 1.5;

    stl("Camera_Mount")
        color(pp1_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy([size.x, size.y, 3], fillet);
                    }
                    for (x = [5, size.x - 5])
                        translate([x, size.y/2, 0])
                            boltHoleM3(size.z, twist=3);
                }
}

module Camera_Mount_hardware() {
    size = cameraMountSize;
    for (x = [5 - size.x/2, size.x/2 - 5])
        translate([x, size.y/2, size.z])
            boltM3ButtonheadHammerNut(_frameBoltLength);
    translate([0, 10, size.z + 3])
        rotate(cameraAngle)
            camera(rpi_camera_v2, fov_distance=eY);
}

module cameraMountPosition(offset=0) {
    translate([eX/2 - 3*eSize/2, eY + eSize, eZ - 2*eSize])
        rotate([90, 0, 0])
            translate_z(offset)
                children();
}
