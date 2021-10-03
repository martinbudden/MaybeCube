//!Display a side panel sheet
include <NopSCADlib/utils/core/core.scad>

include <../scad/vitamins/Panels.scad>
use <../scad/vitamins/extrusion.scad>
use <../scad/jigs/PanelJig.scad>

include <../scad/Parameters_Main.scad>

//$explode = 1;
module SidePanel_test() {
    translate([-3, 0, eZ])
        rotate([0, 90, 0])
            Panel_Jig_stl();
    translate([-3, eY + 2*eSize, eZ])
        rotate([-90, 0, -90])
            Panel_Jig_stl();
    Panel_Jig_stl();
    //extrusionOZ(eZ);
    Left_Side_Panel_assembly();
    //Left_Side_Panel_dxf();
    Right_Side_Panel_assembly();
    //Right_Side_Panel_dxf();
}

if ($preview)
    SidePanel_test();
else
    Panel_Jig_stl();
