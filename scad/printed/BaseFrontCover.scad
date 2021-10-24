include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/fillet.scad>

use <../vitamins/displays.scad>
include <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

use <../../../BabyCube/scad/printed/DisplayHousing.scad>
use <DisplayHousingAssemblies.scad>

include <../Parameters_Main.scad>


fillet = 2;
countersunk = false;
lip = 0;
height = 8;

module Front_Cover_300_stl() {

    stl("Front_Cover_300")
        color(pp1_colour)
            frontCover(300/2);
}

module Front_Cover_350_stl() {

    stl("Front_Cover_350")
        color(pp1_colour)
            frontCover(350/2);
}

module Front_Cover_400_stl() {

    stl("Front_Cover_400")
        color(pp1_colour)
            frontCover(400/2);
}

module frontCover(sizeX) {
    size = [sizeX, eSize + lip, height];
    difference() {
        translate([0, eSize - size.y, 0])
            rounded_cube_xy(size, fillet);
        for (x = [20, size.x - 20])
            translate([x, eSize/2, size.z])
                if (countersunk)
                    boltPolyholeM3Countersunk(size.z, sink=0.25);
                else
                    vflip()
                        boltHoleM3(size.z);
    }
}

module Front_Cover_hardware() {
    size = [eX/2, eSize + lip, height];

    for (x = [20, size.x - 20])
        translate([x, eSize/2, size.z])
            if (countersunk)
                boltM3CountersunkHammerNut(12);
            else
                boltM3ButtonheadHammerNut(12);
}

module Front_Display_Wiring_Cover_300_stl() {
    stl("Front_Display_Wiring_Cover_300")
        color(pp2_colour)
            frontDisplayWiringCover(300/2);
}

module Front_Display_Wiring_Cover_350_stl() {
    stl("Front_Display_Wiring_Cover_350")
        color(pp2_colour)
            frontDisplayWiringCover(350/2);
}

module Front_Display_Wiring_Cover_400_stl() {
    stl("Front_Display_Wiring_Cover_400")
        color(pp2_colour)
            frontDisplayWiringCover(400/2);
}

module frontDisplayWiringCover(sizeX) {
    display_type = BTT_TFT35_E3_V3_0();
    size1 = [displayHousingSize(display_type).x, eSize + 5, height];
    size2 = [displayHousingSize(display_type).x, size1.y - eSize, eSize + size1.z];
    size3 = [sizeX - size1.x, eSize + lip, size1.z];
    channelWidth = 20;
    channelDepth = size1.z - 1;


            vflip()
                difference() {
                    union() {
                        translate_z(channelDepth)
                            rounded_cube_xy([size1.x, size1.y, size1.z - channelDepth], fillet);
                        for (x = [0, (size1.x + channelWidth)/2])
                            translate([x, 0, 0])
                                rounded_cube_xy([(size1.x - channelWidth)/2, size1.y, size1.z], fillet);
                        for (x = [0, (size1.x + channelWidth)/2])
                            translate([x, eSize, size1.z - size2.z])
                                rounded_cube_xy([(size2.x - channelWidth)/2, size2.y, size2.z], fillet);
                        // cover the gap
                        translate([(size1.x - channelWidth)/2 - 2*fillet, eSize + 5, size1.z - size2.z]) {
                            depth = 2;
                            translate([0, -depth, 0])
                                cube([channelWidth + 4*fillet, depth, size2.z]);
                            for (x =  [0, channelWidth + 2*fillet])
                                translate([x, -fillet, 0])
                                    cube([2*fillet, fillet, size2.z]);
                            translate([2*fillet, -depth, 0])
                                rotate(-90)
                                    fillet(1, size2.z);
                            translate([channelWidth + 2*fillet, -depth, 0])
                                rotate(180)
                                    fillet(1, size2.z);
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
                        translate([x, eSize/2, size1.z])
                            if (countersunk)
                                boltPolyholeM3Countersunk(size1.z, sink=0.25);
                            else
                                vflip()
                                    boltHoleM3(size1.z);
                }
}

module Front_Display_Wiring_Cover_hardware() {

    for (x = [20, eX/2 - 20])
        translate([x, -eSize/2, -height])
            vflip()
                if (countersunk)
                    boltM3CountersunkHammerNut(12);
                else
                    boltM3ButtonheadHammerNut(12);
}
