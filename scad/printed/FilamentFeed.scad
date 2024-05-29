include <../global_defs.scad>

use <NopSCADlib/vitamins/e3d.scad>
use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>

filamentFeedSize = [2* eSize, eSize, 5];
filamentFeedBowdenOffset = [(eSize + filamentFeedSize.x)/2, filamentFeedSize.y/2, filamentFeedSize.z];

function filamentFeedOffset() = [eX + eSize, eY - 2*eSize, eZ] + filamentFeedBowdenOffset;;


module filamentFeed() {
    size = filamentFeedSize;
    sizeY = 30;
    fillet = 2;

    difference() {
        union() {
            rounded_cube_xy(size, fillet);
            translate([0, size.y - sizeY, 0])
                rounded_cube_xy([eSize, sizeY, size.z], fillet);
            translate([eSize, 0, 0])
                rotate(-90)
                    fillet(fillet, size.z);
        }
        translate([(eSize + size.x)/2, size.y/2, 0])
            boltHoleM6Tap(size.z);
        for (y = [size.y - 7, size.y - sizeY + 7])
            translate([eSize/2, y, 0])
                boltHoleM4(size.z);
    }
}

module Filament_Feed_stl() {
    stl("Filament_Feed")
        color(pp2_colour)
            vflip() // better orientation for printing
                filamentFeed();
}

module Filament_Feed_hardware() {
    size = filamentFeedSize;
    sizeY = 30;

    translate(filamentFeedBowdenOffset)
        bowden_connector();
    for (y = [size.y - 7, size.y - sizeY + 7])
        translate([eSize/2, y, size.z])
            boltM4ButtonheadHammerNut(10);
}

module Filament_Feed_assembly()
assembly("Filament_Feed") {
    translate(filamentFeedOffset() - filamentFeedBowdenOffset) {
        color(pp2_colour)
            vflip()
                Filament_Feed_stl();
        Filament_Feed_hardware();
    }
}

