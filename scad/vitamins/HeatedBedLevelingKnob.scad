include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/inserts.scad>

include <../vitamins/bolts.scad>


module HeatedBedLevelingKnob(color = grey(20)) {
    vitamin(str("HeatedBedLevelingKnob(): Heated bed leveling knob"));

    knob_r = 25;
    knob_thickness = 7;
    knob_stem_r = 5;
    knob_stem_h = 3;
    knob_wave = 1.5;
    knob_waves = knob_r;
    knob_height = knob_stem_h + knob_thickness;
    knob_spokes = 8;
    knob_spoke_length = knob_r - 8;

    function wave(a) = knob_r + (sin(a * knob_waves) - 1) * knob_wave;

    translate_z(-knob_height) {
        color(color) {
            linear_extrude(knob_thickness, convexity = 1)
                difference() {
                    polygon(points = [ for (a = [0 : 359]) [wave(a) * sin(a), wave(a) * cos(a)] ]);
                    circle(r = knob_spoke_length);
                }
            difference() {
                union() {
                    cylinder(h = knob_height, r = knob_stem_r);
                    spoke_size = [knob_spoke_length, 1.5, 2];
                    for (a = [0 : knob_spokes - 1])
                        rotate(a * 360 / knob_spokes) {
                            translate([spoke_size.x, 0, spoke_size.z])
                                rotate([90, 0, 180])
                                    right_triangle(spoke_size.x, knob_thickness - spoke_size.z - 2, spoke_size.y);
                            translate([0, -spoke_size.y / 2, 0]) {
                                cube(spoke_size);
                            }
                        }
                }
                insert_hole(F1BM3, knob_height);
            }
        }
        if ($preview)
            rotate([180, 0, 0])
                not_on_bom() insert(F1BM3);
    }
}
