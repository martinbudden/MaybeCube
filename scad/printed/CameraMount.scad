include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/cameras.scad>
use <NopSCADlib/vitamins/pcb.scad>

include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


cameraType = rpi_camera_v2;
cameraMountBaseSize = [30, 2*eSize, 5];
cameraMountSize = [cameraMountBaseSize.x, 25, 2];
cameraAngle = [40, 0, 0];
cameraOffset = [0, 0, 3];
cameraBoltOffset = 4;

module Camera_Mount_stl() {
    baseSize = cameraMountBaseSize;
    mountSize = cameraMountSize;
    fillet = 1.5;
    pcb = camera_pcb(cameraType);

    stl("Camera_Mount")
        color(pp1_colour)
            translate([-baseSize.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy(baseSize, fillet);
                        translate([0, baseSize.y - mountSize.y, baseSize.z - eps])
                            hull() {
                                rounded_cube_xy([mountSize.x, mountSize.y, eps], fillet);
                                translate_z(mountSize.z)
                                    rotate(cameraAngle)
                                        rounded_cube_xy([mountSize.x, mountSize.y, eps], fillet);
                                translate([0, (1-cos(cameraAngle.x))*mountSize.y, mountSize.z])
                                    #rotate(cameraAngle)
                                        rounded_cube_xy([mountSize.x, mountSize.y, eps], fillet);
                            }
                        translate([baseSize.x/2, baseSize.y - mountSize.y, baseSize.z - eps + mountSize.z])
                            rotate(cameraAngle)
                                translate([0, pcb_size(pcb).y/2 + cameraOffset.y, 0])
                                    pcb_hole_positions(pcb)
                                        cylinder(h=cameraOffset.z, d=4.5);
                    }
                    for (x = [cameraBoltOffset, baseSize.x - cameraBoltOffset])
                        translate([x, eSize/2, 0])
                            boltHoleM3(baseSize.z, twist=4);
                    translate([baseSize.x/2, baseSize.y - mountSize.y, baseSize.z - eps + mountSize.z])
                        rotate(cameraAngle)
                            translate([0, pcb_size(pcb).y/2 + cameraOffset.y, 0])
                                pcb_hole_positions(pcb) {
                                    boltHoleM2Tap(cameraOffset.z, twist=0);
                                    vflip()
                                        boltHoleM2Tap(5, twist=0);
                                }
                }
}

module Camera_Mount_hardware(fov_distance=0) {
    baseSize = cameraMountBaseSize;
    mountSize = cameraMountSize;
    pcb = camera_pcb(cameraType);

    for (x = [cameraBoltOffset - baseSize.x/2, baseSize.x/2 - cameraBoltOffset])
        translate([x, eSize/2, baseSize.z])
            boltM3ButtonheadHammerNut(_frameBoltLength);
    translate([0, baseSize.y - mountSize.y, baseSize.z - eps + mountSize.z])
        rotate(cameraAngle)
            translate([0, pcb_size(pcb).y/2 + cameraOffset.y, cameraOffset.z]) {
                camera(rpi_camera_v2, fov_distance=fov_distance);
                pcb_hole_positions(pcb)
                    translate_z(pcb_size(pcb).z)
                        boltM2Caphead(8);
            }
}

module cameraMountPosition(offset=0) {
    translate([eX/2 + eSize, eY + eSize, eZ - 2*eSize])
        rotate([90, 0, 0])
            translate_z(offset)
                children();
}
