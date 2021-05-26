//!Display a side panel sheet
include <NopSCADlib/core.scad>

include <../scad/vitamins/SidePanels.scad>
use <../scad/vitamins/extrusion.scad>
use <../scad/printed/sidePanelJig.scad>

include <../scad/Parameters_Main.scad>

//$explode = 1;
module SidePanel_test() {
    translate([-3, 0, eZ])
        rotate([0, 90, 0])
            Side_Panel_Jig_stl();
    translate([-3, eY + 2*eSize, eZ])
        rotate([-90, 0, -90])
            Side_Panel_Jig_stl();
    Side_Panel_Jig_stl();
    //extrusionOZ(eZ);
    Left_Side_Panel_assembly();
    //Left_Side_Panel_dxf();
    Right_Side_Panel_assembly();
    //Right_Side_Panel_dxf();
}

if ($preview)
    SidePanel_test();
else
    Side_Panel_Jig_stl();
