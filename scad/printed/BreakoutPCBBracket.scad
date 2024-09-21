include <../config/global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>
include <../config/Parameters_Main.scad>

include <../vitamins/AB_Breakout_PCB.scad>
use <../printed/BaseCover.scad>
use <../printed/WiringGuide.scad>


breakoutPCBBracketSize = [56, 50, 3];
offsetY = baseCoverBackSupportSizeZ();

module breakoutPCBBracketHolePositions(size, z=0) {
    for (x = [23.5, -23.5])
        translate([x, -10, z])
            children();
}

module breakoutPCBBracket(size=breakoutPCBBracketSize) {
    pcbSize = ABBreakoutPCBSize();
    pcbOffset = [-pcbSize.x/2,  - pcbSize.y + offsetY - 2, size.z + 3];
    fillet = 2;

    difference() {
        translate([-size.x/2, -size.y + offsetY, 0])
            union() {
                offset = [size.x - 43, 10 + fillet];
                rounded_cube_xy([size.x, size.y - offset.y, size.z], fillet);
                translate([offset.x/2, 0, 0])
                    rounded_cube_xy([size.x - offset.x, size.y, size.z], fillet);
                translate([offset.x/2, size.y - offset.y, 0])
                    rotate(90)
                        fillet(fillet, size.z);
                translate([size.x - offset.x/2, size.y - offset.y, 0])
                    fillet(fillet, size.z);
                translate([size.x/2, size.y - pcbSize.y/2, 0])
                    pcb_screw_positions(LDO_TOOLHEAD_BREAKOUT_V1_1)
                        translate([0, $i==0 || $i==1 ? -1.05 : -1.6, 0])
                            rounded_cube_xy([7, 8, pcbOffset.z], 1, xy_center=true);
            }
        breakoutPCBBracketHolePositions(size)
            boltHoleM3(size.z);
        translate(pcbOffset)
            breakoutPCBHolePositions()
                vflip()
                    boltHoleM2p5Tap(pcbOffset.z);
                    //boltHole(2.7, pcbOffset.z, cnc=true);
    }
}

module Breakout_PCB_Bracket_hardware(size=breakoutPCBBracketSize) {
    pcbSize = ABBreakoutPCBSize();
    pcbOffset = [-pcbSize.x/2,  - pcbSize.y + offsetY - 2, size.z + 3];

    breakoutPCBBracketHolePositions(size, size.z)
        boltM3CapheadHammerNut(8);
    translate(pcbOffset) {
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
