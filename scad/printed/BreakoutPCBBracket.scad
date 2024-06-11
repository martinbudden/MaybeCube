include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>
include <../Parameters_Main.scad>

include <../vitamins/AB_Breakout_PCB.scad>
use <../printed/BaseCover.scad>
use <../printed/WiringGuide.scad>


breakoutPCBBracketSize = [58, 50, 3];
offsetY = baseCoverBackSupportSizeZ();

module breakoutPCBBracketHolePositions(size, z=0) {
    for (x = [5, size.x - 5])
        translate([x - size.x/2, -10, z])
            children();
}

module breakoutPCBBracket(size=breakoutPCBBracketSize) {
    pcbSize = ABBreakoutPCBSize();
    holeOffset = [(size.x - pcbSize.x)/2, size.y - pcbSize.y, 0];
    fillet = 2;
//            translate([(pcbSize.x - size.x)/2, pcbSize.y - size.y, 0])
    translate([-size.x/2, -size.y + offsetY, 0])
        difference() {
            union() {
                rounded_cube_xy(size, fillet);
                translate([size.x/2, size.y - pcbSize.y/2,0])
                    pcb_screw_positions(LDO_TOOLHEAD_BREAKOUT_V1_1)
                    //breakoutPCBHolePositions()
                    if ($i==0 || $i==1)
                        rounded_cube_xy([5, 7, size.z + 2.5], 1, xy_center=true);
                    else
                        translate([0, -1.1, 0])
                            rounded_cube_xy([5, 7, size.z + 2.5], 1, xy_center=true);
            }
        translate([size.x/2, size.y - offsetY, 0])
            breakoutPCBBracketHolePositions(size)
                boltHoleM4(size.z);
            translate(holeOffset)
                breakoutPCBHolePositions()
                    //boltHoleM2p5Tap(size.z + 2.5);
                    boltHole(2.7, size.z + 2.5, cnc=true);
        }
}

module Breakout_PCB_Bracket_hardware(size=breakoutPCBBracketSize) {
    pcbSize = ABBreakoutPCBSize();
    holeOffset = [(size.x - pcbSize.x)/2, size.y - pcbSize.y, 0];

    breakoutPCBBracketHolePositions(size, size.z)
        boltM4ButtonheadHammerNut(8);
    translate([-pcbSize.x/2, -pcbSize.y + offsetY, size.z + 2.5]) {
        ABBreakoutPCB();
        breakoutPCBHolePositions(pcbSize.z)
            boltM2p5Caphead(6);
    }
}

module Breakout_PCB_Bracket_stl() {
    stl("Breakout_PCB_Bracket")
        color(pp3_colour)
            breakoutPCBBracket();
}

module breakoutPCBBracketAssembly() {
    translate([wiringGuidePosition().x, eY + eSize, 3*eSize])
        rotate([90, 0, 0]) {
            stl_colour(pp3_colour)
                Breakout_PCB_Bracket_stl();
            Breakout_PCB_Bracket_hardware();
        }
}
