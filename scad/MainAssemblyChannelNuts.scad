//!# Channel nuts


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <vitamins/Panels.scad>

include <target.scad>


module nuts_assembly()
assembly("nuts") {

    //Right_Side_Channel_Nuts();
    //Left_Side_Channel_Nuts();
    translate([0, -eY - 2*eSize]) {
        Left_Side_Channel_Spacers();
        //leftSidePanelPC();
        //Right_Side_Channel_Spacers();
        //rightSidePanelPC();
        Left_Base_Channel_Spacers();
        //Back_Panel_Channel_Spacers();
    }
    //Channel_Nut_70_RL_stl();
    //Channel_Nut_230_R_stl();
}

if ($preview)
    nuts_assembly();
