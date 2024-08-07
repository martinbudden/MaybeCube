include <../config/global_defs.scad>

include <../vitamins/bolts.scad>
use <../vitamins/OrbiterV3.scad>
include <NopSCADlib/vitamins/blowers.scad>


module Smart_Orbiter_V3_Duct_stl() {
    stl("Smart_Orbiter_V3_Duct")
        color(pp1_colour)
            import(str("../stlimport/Smart_Orbiter_V3_Duct_v1.3.3mf"));
}

module Smart_Orbiter_V3_Fan_Bracket_stl() {
    blowerType = RB5015;
    translate([-49, -74.31, -9.496])
    color(pp2_colour)
        difference() {
            union() {
                translate([49, 74.31, 9.496])
                    stl("Smart_Orbiter_V3_Fan_Bracket")
                        rotate([90, 0, 0])
                            import(str("../stlimport/Smart_Orbiter_V3_Fan_Bracket_v1.1.3mf"));
                blower_hole_positions(blowerType)
                    cylinder(r=5, h=3.9995);
            }
            blower_hole_positions(blowerType)
                boltHoleM3Tap(4);
        }
    //translate([-17.6, -26.35, -6.4]) boltM3Countersunk(10);
}

module Smart_Orbiter_V3_Fan_Bracket_5015_stl() {
    blowerType = RB5015;
    blowerHoles = blower_screw_holes(blowerType);
    orbiterHolesOffset = [48.42, 21.72];
    orbiterHoles = [ orbiterHolesOffset + [0, 0], orbiterHolesOffset + [-smartOrbiterV3FanBoltSpacing().x, smartOrbiterV3FanBoltSpacing().y] ];
    thickness = 3.5;

    stl("Smart_Orbiter_V3_Fan_Bracket_5015")
    translate([-49, 74.31, 9.496])
    vflip()
        color(pp2_colour)
            difference() {
                union() {
                    linear_extrude(thickness) {
                        difference() {
                            union() {
                                hull() {
                                    translate(blowerHoles[0])
                                        circle(r=4);
                                    translate(blowerHoles[1])
                                        circle(r=4);
                                    translate(orbiterHoles[0])
                                        circle(r=5);
                                    translate(orbiterHoles[1])
                                        circle(r=5);
                                    translate([38, 50.7])
                                        circle(r=1);
                                    translate([51, 46])
                                        circle(r=1);
                                }
                                hull() {
                                    translate([38, 50.7])
                                        circle(r=1);
                                    translate([51, 46])
                                        circle(r=1);
                                    translate([47, 50.7])
                                        circle(r=1);
                                }
                            }

                            hull() {
                                translate([38, 19.5])
                                    circle(r=1);
                                translate([30.5, 26.5])
                                    circle(r=1);
                                translate([30.5, 42.5])
                                    circle(r=1);
                                translate([39.5, 42.5])
                                    circle(r=1);
                                translate([43.3, 37.5])
                                    circle(r=1);
                                translate([43.3, 19.5])
                                    circle(r=1);
                            }
                            hull() {
                                translate([15, 40])
                                    circle(r=1);
                                translate([23, 42.5])
                                    circle(r=1);
                                translate([23, 32.5])
                                    circle(r=1);
                            }
                        }
                    }
                    *translate_z(-0.5)
                        linear_extrude(thickness) {
                                translate(orbiterHoles[0])
                                    circle(r=thickness);
                                translate(orbiterHoles[1])
                                    circle(r=thickness);
                        }
                    translate([36.8, 50])
                        rounded_cube_xy([2.5, 6.5, thickness], 0.5);
                    translate([44.2, 50])
                        rounded_cube_xy([2.5, 6.5, thickness], 0.5);
                }// end union

                // cutout for motor clearance
                translate([12, 25, -eps])
                    cube([7.5, 40, 1]);

                blower_hole_positions(blowerType)
                    boltHoleM3Tap(4);

                translate_z(thickness - 0.5)
                    for (i = orbiterHoles)
                        translate(i)
                            vflip()
                                boltPolyholeM3Countersunk(thickness + 1);
                translate([36.8, 54, thickness/2])
                    rotate([-90, 0, -90])
                        boltHoleM2p5Tap(10, horizontal=true, chamfer=0);
            }
}

