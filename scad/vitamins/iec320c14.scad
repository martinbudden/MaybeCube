include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/iecs.scad>
include <NopSCADlib/vitamins/rockers.scad>


module iec320c14FusedSwitched() {
    if ($preview) {
        difference() {
            iec(IEC_320_C14_switched_fused_inlet);
            rh = 5.1 + 16.5 + eps;
            *translate([0, -12, 5.1 - rh/2 - eps])
                rotate(90)
                    rocker_hole(small_rocker, h=rh);
        }
        not_on_bom() no_explode()
            translate([0, -12, 2 + eps])
                rotate(90)
                    rocker(small_rocker, "red");
    }
}

function iec320c14FusedSwitchedType() = IEC_320_C14_switched_fused_inlet;
