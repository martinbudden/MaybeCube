include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/utils/fillet.scad>

use <../vitamins/bolts.scad>
use <../vitamins/displays.scad>
use <../../../BabyCube/scad/printed/DisplayHousing.scad>

use <DisplayHousingAssemblies.scad>

include <../Parameters_Main.scad>

module Front_Cover_stl() {
    lip = 3;
    size = [eX/2, eSize + lip, 8];
    fillet = 2;

    stl("Front_Cover")
        color(pp1_colour)
            difference() {
                translate([0, eSize - size.y, 0])
                    rounded_cube_xy(size, fillet);
                for (x = [20, size.x - 20])
                    translate([x, eSize/2, 0])
                        boltHoleM3(size.z);
            }
}

module Front_Display_Wiring_Cover_stl() {
    display_type = BTT_TFT35_E3_V3_0();
    lip = 3;
    size1 = [displayHousingSize(display_type).x, eSize + 5, 8];
    size2 = [displayHousingSize(display_type).x, size1.y - eSize, eSize + size1.z];
    size3 = [eX/2 - size1.x, eSize + lip, size1.z];
    fillet = 2;
    channelWidth = 20;
    channelDepth = size1.z - 1;


    stl("Front_Display_Wiring_Cover_stl")
        color(pp1_colour)
            vflip()
                difference() {
                    union() {
                        difference() {
                            rounded_cube_xy(size1, fillet);
                            translate([(size1.x - channelWidth)/2, -eps, -eps])
                                cube([channelWidth, size1.y + 2*eps, channelDepth + eps]);
                        }
                        difference() {
                            translate([0, eSize, size1.z - size2.z])
                                rounded_cube_xy(size2, fillet);
                            translate([(size1.x - channelWidth)/2, eSize - eps, size1.z - size2.z - eps])
                                cube([channelWidth, channelDepth + eps, size1.z + size2.z - channelDepth]);
                        }
                        translate([size1.x, eSize - size3.y, 0])
                            rounded_cube_xy(size3, fillet);
                        translate([size1.x, eSize, 0])
                            fillet(fillet, size1.z);
                        // cover the undesired fillets
                        translate([size1.x - 2*fillet, 0, 0])
                            cube([4*fillet, eSize, size1.z]);
                    }
                    for (x = [20, size1.x + size3.x - 20])
                        translate([x, eSize/2, 0])
                            boltHoleM3(size1.z);
                }
}
