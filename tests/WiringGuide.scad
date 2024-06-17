//! Display the Wiring Guide

use <../scad/printed/WiringGuide.scad>


//$explode = 1;
//$pose = 1;
module WiringGuide_test() {
    rotate([180, 0, 0]) {
        Wiring_Guide_stl();
            translate([0, 0, wiringGuideTabHeight()]) {
                    Wiring_Guide_Clamp_stl();
                Wiring_Guide_Clamp_hardware();
            }
    }
    Wiring_Guide_Socket_stl();
    Wiring_Guide_Socket_hardware();
}

if ($preview)
    WiringGuide_test();
