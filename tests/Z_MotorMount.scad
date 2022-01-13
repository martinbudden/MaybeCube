//! Display the Z-axis motor mount

use <../scad/printed/Z_MotorMount.scad>


//$explode = 1;
module Z_Motor_Mount_test() {
    //zMotorMount();
    //Z_Motor_Mount_stl();
    Z_Motor_Mount_assembly();
    //Z_Motor_Mount_KB_assembly();
    //Z_Motor_Mount_Right_KB_assembly();
}

if ($preview) {
    Z_Motor_Mount_test();
}
