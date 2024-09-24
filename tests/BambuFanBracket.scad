//! Display the Bambu_Fan_Bracket

include <../scad/printed/BambuFanBracket.scad>



//$explode = 1;
//$pose = 1;
module BambuFanBracket_test() {
    if (eZ == 400)
        Bambu_Fan_Bracket_150_stl();
    else
        Bambu_Fan_Bracket_200_stl();
    Bambu_Fan_Bracket_hardware(eZ == 400 ? bambuFanBracketSize400 : bambuFanBracketSize450);
    //bambuFanBracketAssembly();
}

if ($preview)
    BambuFanBracket_test();
