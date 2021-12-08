//!Displays a handle.

include <../scad/printed/Handle.scad>


//$explode=1;
module Handle_test() {
    Handle_stl();
    Handle_hardware();
}

if ($preview)
    Handle_test();
else
    Handle_stl();
