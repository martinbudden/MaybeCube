//!Display a side panel sheet
include <NopSCADlib/utils/core/core.scad>

include <../scad/vitamins/Panels.scad>
include <../scad/vitamins/extrusion.scad>
use <../scad/jigs/PanelJig.scad>
include <../scad/FaceRightExtras.scad>

include <../scad/Parameters_Main.scad>

//$explode = 1;
module SidePanel_Jig_test() {
    translate([-3, 0, eZ])
        rotate([0, 90, 0])
            Panel_Jig_stl();
    translate([-3, eY + 2*eSize, eZ])
        rotate([-90, 0, -90])
            Panel_Jig_stl();
    rotate([0, -90, 0])
        Panel_Jig_stl();
    translate([eX + 2*eSize, 0, eZ])
        rotate([-90, 0, 90])
            Panel_Jig_stl();
    //extrusionOZ(eZ);
    translate([3, 0, 0])
        faceRightSpoolHolderBracket();
    Left_Side_Panel_assembly();
    //Left_Side_Panel_dxf();
    Right_Side_Panel_assembly();
    //Right_Side_Panel_dxf();
}

module SidePanel_test() {
    Left_Side_Channel_Spacers();
    Left_Side_Panel_assembly(hammerNut=false);
    //Right_Side_Channel_Spacers();
    //Right_Side_Panel_assembly(hammerNut=false);
    //Extruder_Bracket_assembly();
}

if ($preview)
    SidePanel_test();
else
    Panel_Jig_stl();
    // left side
    //Channel_Spacer_44p5_stl();
    //Channel_Spacer_89p5_stl();
    // right side
    //Channel_Spacer_14p5_stl();
    //Channel_Spacer_84p5_stl();
