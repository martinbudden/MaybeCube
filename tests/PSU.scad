//!Displays the PSU.

use <../scad/printed/PSU.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/psus.scad>


//$explode = 1;
module PSU_test() {
    //let($hide_bolts=true)
    *PSU_cover_stl();
    PSU_type = S_300_12;
    psuSize = [psu_length(PSU_type), psu_width(PSU_type), psu_height(PSU_type)];

    *translate([psuSize.y/2, 0, psuSize.x/2+connectorSpace()])
        rotate([-90, -90, 0])
            psu(PSU_type);
    //PSUWithCover();
    PSU();
}

if ($preview)
    PSU_test();
