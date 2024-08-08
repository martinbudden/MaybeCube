include <../config/global_defs.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>
use <../../../BabyCube/scad/printed/Handle.scad>


module Handle_stl() {
    stl("Handle")
        color(pp1_colour)
            handle(size=[15, 100, 40], gripSizeY=15, holeCount=2, extended=true);
}

module Handle_hardware(bolt=true, TNut=true) {
    length = 100;
    size = [15, 15];
    baseHeight = 5;
    for (y = [length/2 + size.x/2, -length/2 - size.x/2, length/2 + size.x/2 + 20, -length/2 - size.x/2 - 20])
        translate([baseHeight, y, 0])
            rotate([90, 0, 90]) {
                explode(20, true)
                    if (bolt)
                        boltM4ButtonheadTNut(12, nutExplode=40);
                if (TNut)
                    boltM4TNut(12);
            }
}
