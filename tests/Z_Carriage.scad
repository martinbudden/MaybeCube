//!Display the Z carriages.

use <../scad/printed/Z_Carriage.scad>


//$explode = 1;
module Z_Carriage_test() {
    Z_Carriage_Left_assembly();
    translate([0, 100, 0])
        Z_Carriage_Right_assembly();
    *Z_Carriage_Left_stl();
    *translate([0, 100, 0])
        Z_Carriage_Right_stl();
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
