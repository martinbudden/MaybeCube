//! Display the printbed

use <../scad/PrintBed.scad>


//$explode = 1;
//$pose = 1;
module Printbed_test() {
    Printbed_assembly();
    //heatedBed();
    //Printbed_Frame_with_Z_Carriages_assembly();
    //Printbed_Frame_assembly();
}

if ($preview)
    Printbed_test();
