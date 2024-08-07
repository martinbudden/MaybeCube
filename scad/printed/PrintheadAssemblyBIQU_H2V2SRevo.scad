include <../config/global_defs.scad>

use <NopSCADlib/vitamins/wire.scad>

include <../vitamins/bolts.scad>

include <../utils/X_Rail.scad>
use <../vitamins/BIQU_H2V2SRevo.scad>

use <X_CarriageBIQU_H2V2SRevo.scad>
use <X_CarriageAssemblies.scad>


module printheadBiquH2V2SRevoAssembly() {
    biquH2V2SRevo();
}

module Printhead_BIQU_H2V2SRevo_assembly() pose(a=[55, 0, 25 + 90])
assembly("Printhead_BIQU_H2V2SRevo", big=true) {

    xCarriageType = MGN12H_carriage;
    pcb = true;
    explode([0, -40, 0], true)
        xCarriageBIQU_H2V2SRevoAssembly(inserts=true, pcb=pcb);
    translate([biquH2V2SRevoOffsetX(), 21 + railCarriageGap() - 0.5, -biquH2V2SRevoNozzleOffsetFromMGNCarriageZ()])
        printheadBiquH2V2SRevoAssembly();
    explode([0, -60, 0], true)
        xCarriageBiquH2V2SRevoHolePositions(xCarriageType)
            boltM3Countersunk(10);
    xCarriageBiquH2V2SRevoCableTiePositions(xCarriageType, pcb=pcb)
        translate([1, railCarriageGap() + 5.4, 0])
            rotate([0, 90, -90])
                cable_tie(cable_r = 3.5, thickness = 5.5);
}

