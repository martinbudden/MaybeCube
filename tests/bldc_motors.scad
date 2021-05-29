include <NopSCADlib/core.scad>
include <../scad/vitamins/bldc_motors.scad>

use <NopSCADlib/utils/layout.scad>


module bldc_motors()
    layout([for(b = bldc_motors) BLDC_diameter(b)])
        rotate(-90)
            BLDC(bldc_motors[$i]);

if($preview)
    let($show_threads = 1)
        bldc_motors();
