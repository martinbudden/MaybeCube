//!Display a side panel sheet

include <../scad/vitamins/SidePanels.scad>
use <../scad/vitamins/extrusion.scad>

include <../scad/Parameters_Main.scad>

//$explode = 1;
module SidePanel_test() {
    extrusionOZ(eZ);
    Left_Side_Panel_assembly();
    //Left_Side_Panel_dxf();
    Right_Side_Panel_assembly();
    //Right_Side_Panel_dxf();
}

if ($preview)
    SidePanel_test();
