//!Displays a camera mount with camera.

include <../scad/printed/CameraMount.scad>


//$explode=1;
module Camera_Mount_test() {
    Camera_Mount_stl();
    Camera_Mount_hardware();
}

if ($preview)
    Camera_Mount_test();
else
    Camera_Mount_stl();
