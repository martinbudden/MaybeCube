//!Display a side panel sheet

include <../scad/vitamins/SidePanels.scad>


//$explode = 1;
module SidePanel_test() {
    Left_Side_Panel_assembly();
    //Left_Side_Panel_dxf();
    Right_Side_Panel_assembly();
    //Right_Side_Panel_dxf();
}

if ($preview)
    SidePanel_test();
