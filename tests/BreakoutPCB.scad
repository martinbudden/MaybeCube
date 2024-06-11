//! Display the Breakout_PCB_Bracket

use <../scad/vitamins/AB_Breakout_PCB.scad>
use <../scad/printed/BreakoutPCBBracket.scad>


//$explode = 1;
//$pose = 1;
module BreakoutPCB_test() {
    //ABBreakoutPCB();
    breakoutPCBBracket();
    Breakout_PCB_Bracket_hardware();
}

if ($preview)
    BreakoutPCB_test();
