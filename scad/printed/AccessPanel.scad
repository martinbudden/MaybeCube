include <../global_defs.scad>

include <NopSCADlib/core.scad>

use <../printed/extruderBracket.scad> // for spoolHeight
use <../printed/IEC_Housing.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


module Access_Panel_300_stl() {
    stl("Access_Panel_300")
        accessPanel();
}

module Access_Panel_stl() {
    stl("Access_Panel")
        accessPanel();
}

module accessPanel() {
    toleranceX = 0.5;
    size = [spoolHeight(eX) - iecHousingSize().y - eSize - toleranceX, partitionOffsetY() - 2, 3];

    color(pp4_colour)
        difference() {
            translate([toleranceX, 0, 0])
                rounded_cube_xy(size, 5);
            for (pos = [ [eSize/2, eSize/2, size.z], [eSize/2, size.y - eSize/2, size.z], [size.x - eSize/2, size.y - eSize/2, size.z]])
                translate(pos)
                    vflip()
                        boltHoleM4Countersunk(size.z);
        }
}

module accessPanelAssembly() {
    translate([eX + 2*eSize, eY + 2*eSize - partitionOffsetY() + 2, spoolHeight(eX) + eSize])
        rotate([0, 90, 0]) {
            stl_colour(pp4_colour)
                if (eX == 300)
                    Access_Panel_300_stl();
                else
                    Access_Panel_stl();
            size = [spoolHeight(eX) - iecHousingSize().y - eSize, partitionOffsetY() - 2, 3];
            if ($preview)
                for (pos = [ [eSize/2, eSize/2, size.z], [eSize/2, size.y - eSize/2, size.z], [size.x - eSize/2, size.y - eSize/2, size.z]])
                    translate(pos)
                        boltM4CountersunkHammerNut(_sideBoltLength);
        }
}
