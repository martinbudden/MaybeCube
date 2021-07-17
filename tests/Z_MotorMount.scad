//! Display the Z-axis motor mount

use <../scad/printed/Z_MotorMount.scad>


//$explode = 1;
module Z_Motor_Mount_test() {
    //zMotorMount();
    Z_Motor_Mount_assembly();
    //Z_Motor_Mount_stl();
}

if ($preview) {
    Z_Motor_Mount_test();
}
