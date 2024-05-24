//! Display the E3DV6 print head

use <../scad/printed/PrintheadAssemblyE3DV6.scad>

//$explode = 1;
//$pose = 1;

module PrintheadE3DV6_test() {
    //printheadE3DV6Assembly();
    Printhead_E3DV6_assembly();
}

if ($preview)
    PrintheadE3DV6_test();
