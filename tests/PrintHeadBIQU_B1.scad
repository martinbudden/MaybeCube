//!Display the BIQU B1 print head.

include <../scad/global_defs.scad>
include <NopSCADlib/core.scad>

use <../scad/vitamins/bolts.scad>
use <../scad/vitamins/PrintHeadBIQU_B1.scad>


//$explode = 1;
module PrintHeadBIQU_B1_test() {
    no_explode()
        PrintHeadBIQU_B1();
    PrintHeadBIQU_B1_boltPositions()
        explode(70)
            boltM3Caphead(10);
}

if ($preview)
    PrintHeadBIQU_B1_test();
