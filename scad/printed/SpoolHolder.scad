include <../global_defs.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <../../../BabyCube/scad/printed/SpoolHolder.scad>

include <../Parameters_Main.scad>


function spoolOffset() = [3, 0, 7];
spoolHolderBracketSize = [50, 1.5*eSize, 10];

module Spool_Holder_stl() {
    stl("Spool_Holder")
        color(pp2_colour)
            spoolHolder(bracketSize=[5, 2*eSize - 10, 20], offsetX=spoolOffset().x, catchRadius=0, length=90, capOffset=false);
}

module Spool_Holder_36_stl() {
    stl("Spool_Holder_36")
        color(pp2_colour)
            spoolHolder(bracketSize=[5, 2*eSize - 10, 20], offsetX=spoolOffset().x, catchRadius=0, length=90, spoolInternalRadius=36, capOffset=false);
}

module Spool_Holder_Bracket_stl() {
    stl("Spool_Holder_Bracket")
        color(pp1_colour)
            spoolHolderBracket(spoolHolderBracketSize, M3=false);
}

module Spool_Holder_Bracket_hardware(offsetX=0) {
    size = spoolHolderBracketSize;
    holeOffset = (size.x - eSize)/4;

    for (x = [holeOffset, size.x - holeOffset])
        translate([x - size.x/2, eSize/2, size.z - 5])
            vflip()
                boltM4ButtonheadHammerNut(offsetX ? 12 : _frameBoltLength, nutExplode=40);
}
