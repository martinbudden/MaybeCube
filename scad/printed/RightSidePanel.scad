include <../global_defs.scad>

use <../printed/extruderBracket.scad> // for spoolHeight(), extruderBracketSize()

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

module Right_Side_Panel_Bracket_stl() {
    stl("Right_Side_Panel_Bracket")
        color(pp3_colour)
            difference() {
                rounded_cube_xy([eSize, eSize, eSize], 2);
                translate([eSize/2, eSize/2, eSize])
                    vflip()
                        boltHoleM4CounterboreButtonhead(eSize, boreDepth=eSize - 3);
                translate([eSize, eSize/2, eSize/2])
                    rotate([90, 0, -90])
                        boltHoleM4(eSize/2, horizontal=true, chamfer_both_ends=false);
            }
}

module Right_Side_Panel_stl() {
    stl("Right_Side_Panel")
        rightSidePanel();
}

module rightSidePanel() {
    toleranceX = 0.5;
    size = [spoolHeight(eX) - iecHousingSize().y - eSize - toleranceX, extruderBracketSize().y, 3];

    color(pp4_colour)
        difference() {
            translate([toleranceX, 0, 0])
                rounded_cube_xy(size, 5);
            for (pos = [ [eSize/2, eSize/2, size.z], [eSize/2, size.y - eSize/2, size.z], [size.x - eSize/2, eSize/2, size.z], [size.x - eSize/2, size.y - eSize/2, size.z]])
                translate(pos)
                    vflip()
                        boltHoleM4(size.z);
        }
}

module rightSidePanelAssembly() {
    explode([-50, -75, 30], true)
        translate([eX + eSize, eY - iecHousingSize().y, 90]) {
            stl_colour(pp3_colour)
                Right_Side_Panel_Bracket_stl();
            if ($preview)
                translate([eSize/2, eSize/2, 3])
                    explode(10, true)
                        boltM4ButtonheadHammerNut(_sideBoltLength);
        }
    translate([eX + 2*eSize, eY + 2*eSize - extruderBracketSize().y, spoolHeight(eX) + eSize])
        rotate([0, 90, 0]) {
            stl_colour(pp4_colour)
                Right_Side_Panel_stl();
            if ($preview) {
                toleranceX = 0.5;
                size = [spoolHeight(eX) - iecHousingSize().y - eSize - toleranceX, extruderBracketSize().y, 3];
                for (pos = [ [eSize/2, eSize/2, size.z], [eSize/2, size.y - eSize/2, size.z], [size.x - eSize/2, size.y - eSize/2, size.z]])
                    translate(pos)
                        boltM4ButtonheadHammerNut(_sideBoltLength);
                translate([size.x - eSize/2, eSize/2, size.z])
                    boltM4Buttonhead(_sideBoltLength);
            }
        }
}
