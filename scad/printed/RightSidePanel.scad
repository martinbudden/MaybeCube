include <../global_defs.scad>

use <../printed/extruderBracket.scad> // for spoolHeight(), extruderBracketSize()

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


module Right_Side_Panel_stl() {
    stl("Right_Side_Panel")
        rightSidePanel();
}

module rightSidePanel() {
    toleranceX = 0.5;
    size = [spoolHeight(eX) - iecHousingSize().y - toleranceX, extruderBracketSize().y, 3];

    color(pp4_colour)
        difference() {
            translate([toleranceX, 0, 0])
                rounded_cube_xy(size, 5);
            for (pos = [ [eSize/2, eSize/2, size.z], [eSize/2, size.y - eSize/2, size.z], [size.x - eSize/2, eSize/2, size.z], [size.x - eSize/2, size.y - eSize/2, size.z]])
                translate(pos)
                    vflip()
                        boltHoleM4Countersunk(size.z);
        }
}

module rightSidePanelAssembly() {
    translate([eX + 2*eSize, eY + 2*eSize - extruderBracketSize().y, spoolHeight(eX) + eSize])
        rotate([0, 90, 0]) {
            stl_colour(pp4_colour)
                Right_Side_Panel_stl();
            if ($preview) {
                toleranceX = 0.5;
                size = [spoolHeight(eX) - iecHousingSize().y - toleranceX, extruderBracketSize().y, 3];
                for (pos = [ [eSize/2, eSize/2, size.z], [eSize/2, size.y - eSize/2, size.z], [size.x - eSize/2, eSize/2, size.z], [size.x - eSize/2, size.y - eSize/2, size.z]])
                    translate(pos)
                        boltM4CountersunkHammerNut(_sideBoltLength);
            }
        }
}
