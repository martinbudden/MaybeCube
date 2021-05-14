//!Display the Z carriages.

use <../scad/printed/Z_Carriage.scad>


//$explode = 1;
module Z_Carriage_test() {
    translate([-50, 0, 0])
        Z_Carriage_Left_assembly();
    translate([50, 00, 0])
        Z_Carriage_Right_assembly();
    *Z_Carriage_Left_stl();
    *translate([0, 100, 0])
        Z_Carriage_Right_stl();
    Z_Carriage_Center_assembly();
    //Z_Carriage_Center_stl();
    //Z_Carriage_Center_hardware();
}

if ($preview) {
    Z_Carriage_test();
    *intersection() {
        translate([5, 15, 0])
            cube([40, 30, 50]);
        let($hide_bolts=true)
        Z_Carriage_test();
    }
}
