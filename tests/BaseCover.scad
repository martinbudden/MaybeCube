//!Displays the base cover.

include <../scad/config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
use <../scad/printed/WiringGuide.scad>

use <../scad/printed/BaseFrontCover.scad>
use <../scad/printed/BaseCover.scad>
use <../scad/printed/BreakoutPCBBracket.scad>

include <../scad/config/Parameters_Main.scad>
use <../scad/config/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module BaseCover_test() {
    baseCoverTopAssembly(addBolts=false);
    baseCoverLeftSideSupportsAssembly();
    //baseCoverRightSideSupportAssembly();
    baseCoverFrontSupportsAssembly();
    baseCoverBackSupportsAssembly();
    //baseDragChain();
    baseFanMountAssembly();
    breakoutPCBBracketAssembly();
    //printheadWiring(hotendDescriptor="OrbiterV3");

}

if ($preview)
    BaseCover_test();
