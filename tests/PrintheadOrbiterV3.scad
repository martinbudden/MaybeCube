//! Display the OrbiterV3 print head

use <../scad/printed/PrintheadAssemblyOrbiterV3.scad>

//$explode = 1;
//$pose = 1;

module PrintheadOrbiterV3_test() {
    //printheadOrbiterV3Assembly();
    Printhead_OrbiterV3_assembly();
}

if ($preview)
    PrintheadOrbiterV3_test();
