include <../config/global_defs.scad>

include <../vitamins/bolts.scad>

use <../utils/extruderBracket.scad> // for spoolHeight()
include <../utils/XY_MotorMount.scad> // for xyMotorMountSize()

include <../vitamins/nuts.scad>

include <../config/Parameters_Main.scad>

function partitionOffsetY() = xyMotorMountSize(motorWidth=motorWidth(motorType(_xyMotorDescriptor)), offset=leftDrivePulleyOffset()).y + 1;

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
                        boltHoleM4(size.z);
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
                        boltM4ButtonheadHammerNut(_sideBoltLength);
        }
}
