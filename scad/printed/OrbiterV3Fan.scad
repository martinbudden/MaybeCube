include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/blowers.scad>

include <../vitamins/bolts.scad>


module Smart_Orbiter_V3_Duct_stl() {
    stl("Smart_Orbiter_V3_Duct")
        color(pp1_colour)
            import(str("../stlimport/Smart_Orbiter_V3_Duct_v1.3.3mf"));
}

module Smart_Orbiter_V3_Fan_Bracket_stl() {
    blowerType = RB5015;
    color(pp2_colour)
        difference() {
            union() {
                stl("Smart_Orbiter_V3_Fan_Bracket")
                    rotate([90, 0, 0])
                        import(str("../stlimport/Smart_Orbiter_V3_Fan_Bracket_v1.1.3mf"));
                translate([-49, -74.31, -9.496])
                    blower_hole_positions(blowerType)
                        cylinder(r=5  , h=3.9995);
            }
            translate([-49, -74.31, -9.496])
                blower_hole_positions(blowerType)
                    boltHoleM3Tap(4);
        }
    //translate([-17.6, -26.35, -6.4]) boltM3Countersunk(10);
}

