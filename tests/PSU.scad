//!Displays the PSU.

use <../scad/utils/PSU.scad>
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/psus.scad>


//$explode = 1;
module PSU_test() {
    //let($hide_bolts=true)
    *PSU_cover_stl();
    //PSU_type = PD_150_12;
    //PSU_type = S_250_48;
    //PSU_type = S_300_12;
    //PSU_type = S_300_12;
    PSU_type = NG_CB_500W_24V;
    psuSize = psu_size(PSU_type);

    *translate([psuSize.y/2, 0, psuSize.x/2])
        rotate([-90, -90, 0])
            psu(PSU_type);
    //PSUWithCover();
    translate([0, 100, 0])
    PSU_S_360_24();
    psu(NG_CB_500W_24V);
}

if ($preview)
    PSU_test();
