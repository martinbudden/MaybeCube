//!Display the BIQU B1 print head.

include <../scad/global_defs.scad>

include <../scad/vitamins/bolts.scad>
use <../scad/vitamins/PrintheadBIQU_B1.scad>


//$explode = 1;
module PrintheadBIQU_B1_test() {
    no_explode()
        PrintheadBIQU_B1();
    PrintheadBIQU_B1_boltPositions()
        explode(70)
            boltM3Caphead(10);
}

if ($preview)
    PrintheadBIQU_B1_test();
