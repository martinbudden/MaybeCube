//! Display the Bambu_Fan_Bracket

use <../scad/printed/BambuFanBracket.scad>



//$explode = 1;
//$pose = 1;
module BambuFanBracket_test() {
    //Bambu_Fan_Bracket_155_stl();
    //Bambu_Fan_Bracket_hardware([165, 155, 3]);
    bambuFanBracketAssembly();
}

if ($preview)
    BambuFanBracket_test();
