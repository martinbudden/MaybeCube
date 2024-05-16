//! Display the Cable_Chain_Bracket

use <../scad/printed/CableChainBracket.scad>


//$explode = 1;
//$pose = 1;
module CableChainBracket_test() {
    Cable_Chain_Bracket_stl();
    Cable_Chain_Bracket_hardware();
    Cable_Chain_Bracket_cable_ties();
}

if ($preview)
    CableChainBracket_test();
