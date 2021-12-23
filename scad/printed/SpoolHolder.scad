include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

include <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

use <../../../BabyCube/scad/printed/SpoolHolder.scad>

include <../Parameters_Main.scad>


function spoolOffset() = [3, 0, 7];

module Spool_Holder_stl() {
    stl("Spool_Holder")
        color(pp2_colour)
            spoolHolder(bracketSize=[5, 2*eSize-10, 20], offsetX=spoolOffset().x, catchRadius=2);
}

module Spool_Holder_Bracket_stl() {
    size = [3*eSize, 1.5*eSize, 10];
    fillet = 2;
    thickness = 4.75;
    catchRadius = 2;
    catchLength = eSize + 1;

    stl("Spool_Holder_Bracket")
        color(pp1_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy([size.x, size.y, thickness], fillet);
                        sideSize = [eSize - 0.25, size.y, size.z];
                        for (x = [0, size.x - sideSize.x])
                            translate([x, 0, 0])
                                rounded_cube_xy(sideSize, fillet);
                    }
                    for (x = [eSize/2, size.x - eSize/2])
                        translate([x, eSize/2, 0])
                            boltHoleM4HangingCounterboreButtonhead(size.z, boreDepth=size.z - 5);
                    offset = 0.1;
                    translate([size.x/2, size.y - catchRadius - offset, 0])
                        rotate([0, 90, 0])
                             hull() {
                                cylinder(r=catchRadius, h=catchLength, center=true);
                                translate([-catchRadius, 0, -catchLength/2])
                                    cube([catchRadius, catchRadius + offset + eps, catchLength]);
                            }

                }
}

module Spool_Holder_Bracket_hardware(offsetX=0) {
    size = [3*eSize, 1.5*eSize, 10];

    for (x = [eSize/2, size.x - eSize/2])
        translate([x - size.x/2, eSize/2, size.z - 5])
            vflip()
                boltM4ButtonheadHammerNut(offsetX ? 12 : _frameBoltLength, nutExplode=40);
}
