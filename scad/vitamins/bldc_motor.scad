//
//!  Brushless DC electric motor
//
include <NopSCADlib/core.scad>

use <NopSCADlib/vitamins/rod.scad>
use <NopSCADlib/utils/thread.scad>
use <NopSCADlib/utils/tube.scad>


function BLDC_diameter(type)                    = type[1]; //! Diameter
function BLDC_height(type)                      = type[2]; //! Body length
function BLDC_shaft_diameter(type)              = type[3]; //! Shaft diameter
function BLDC_shaft_length(type)                = type[4]; //! Total shaft length
function BLDC_shaft_offset(type)                = type[5]; //! Shaft offset from base
function BLDC_body_colour(type)                 = type[6]; //! Body colour
function BLDC_base_diameter(type)               = type[7]; //! Base diameter
function BLDC_base_height_1(type)               = type[8]; //! Base height 1
function BLDC_base_height_2(type)               = type[9]; //! Base height 2
function BLDC_base_hole_diameter(type)          = type[10]; //! Base hole diameter
function BLDC_base_holes(type)                  = type[11]; //! Base holes
function BLDC_base_open(type)                   = type[12]; //! Base open
function BLDC_wire_diameter(type)               = type[13]; //! Wire diameter
function BLDC_side_colour(type)                 = type[14]; //! Side colour
function BLDC_bell_diameter(type)               = type[15]; //! Bell diameter
function BLDC_bell_height_1(type)               = type[16]; //! Bell height 1
function BLDC_bell_height_2(type)               = type[17]; //! Bell height 2
function BLDC_bell_hole_diameter(type)          = type[18]; //! Bell hole diameter
function BLDC_bell_holes(type)                  = type[19]; //! Bell holes
function BLDC_bell_spokes(type)                 = type[20]; //! Bell spoke count
function BLDC_boss_radius(type)                 = type[21]; //! Boss radius
function BLDC_boss_height(type)                 = type[22]; //! Boss height
function BLDC_propshaft_diameter(type)          = type[23]; //! Propshaft diameter
function BLDC_propshaft_length(type)            = type[24]; //! Propshaft length
function BLDC_propshaft_thread_diameter(type)   = type[25]; //! Propshaft thread diameter
function BLDC_propshaft_thread_length(type)     = type[26]; //! Propshaft thread length

bldc_cap_colour  = grey(50);
bldc_shaft_colour = grey(90);
bldc_bearing_colour = grey(80);

module BLDC(type) { //! Draw specified BLDC motor
    vitamin(str("BLDC(", type[0], "): Brushless DC motor ", type[0]));

    body_colour = BLDC_body_colour(type);
    side_colour = BLDC_side_colour(type);
    body_diameter = BLDC_diameter(type);
    wall_thickness = 1;

    height = BLDC_height(type);

    module feet(base_diameter) {
        holes = BLDC_base_holes(type);
        hole_count = is_list(holes) ? len(holes) : 4;
        for(i = [0 : 1 : hole_count - 1]) {
            spacing = is_list(holes) ? holes[i] : holes;
            radius = base_diameter/2 - spacing/2;
            rotate(i * 360 / hole_count + (hole_count == 4 ? 45 : 0))
                difference() {
                    hull() {
                        circle(r = radius);
                        translate([-spacing / 2, 0])
                            circle(r = radius);
                    }
                    translate([-spacing / 2, 0])
                        circle(d = BLDC_base_hole_diameter(type));
                }
        }
    }

    module base() {
        base_diameter = BLDC_base_diameter(type);
        h1 = BLDC_base_height_1(type);
        h2 = BLDC_base_height_2(type);
        color(body_colour)
            if (BLDC_base_open(type)) {
                difference() {
                    linear_extrude(h1)
                        feet(base_diameter);
                        circle(d = 2*BLDC_shaft_diameter(type));
                }
                translate_z(h1)
                    cylinder(d = 2 * BLDC_shaft_diameter(type), h = h2);
            } else {
                difference() {
                    union() {
                        render(convexity = 8)
                            linear_extrude(h1)
                                difference() {
                                    circle(d = base_diameter);
                                    circle(d = 2*BLDC_shaft_diameter(type));
                                    BLDC_base_screw_positions(type)
                                        circle(d=BLDC_base_hole_diameter(type));
                                }
                        rotate_extrude()
                            polygon([ [base_diameter/2, 0], [body_diameter/2, h1], [body_diameter/2, h1+h2], [body_diameter/2 - wall_thickness, h1+h2], [body_diameter/2 - wall_thickness, h1], [base_diameter/2, h1] ]);
                    }
                r =  body_diameter > 40 ? 2.5 : body_diameter * PI / (8 * 3);
                for (a = [0, 90, 180, 270])
                    rotate(a)
                        hull() {
                            translate([base_diameter/2, 0,  -eps])
                                cylinder(r=r, h=h1 + 2*eps);
                            translate([body_diameter/2, -r, -eps])
                                cube([eps, 2*r, h1 + 2*eps]);
                        }
                if (body_diameter > 40) {
                    hull() {
                        r = 6;
                        translate([base_diameter/2, 0,  -eps])
                            cylinder(r=r, h=h1 + 2*eps);
                        translate([body_diameter/2, -r, -eps])
                            cube([eps, 2*r, h1 + 2*eps]);
                    }
                    for (a = [90, 180, 270])
                        for (b = [-90/4, 90/4])
                            rotate(a + b)
                                hull() {
                                    translate([base_diameter/2 - r, 0, -eps])
                                        cylinder(r=r, h=h1 + 2*eps);
                                    translate([body_diameter/2, -r, -eps])
                                        cube([eps, 2*r, h1 + 2*eps]);
                                }
                }
            }
        }
        color(bldc_bearing_colour)
            translate_z(0.25)
                tube(or = BLDC_shaft_diameter(type), ir = BLDC_shaft_diameter(type)/2, h = h1, center=false);

        if (show_threads)
            BLDC_base_screw_positions(type)
                female_metric_thread(BLDC_base_hole_diameter(type), metric_coarse_pitch(BLDC_base_hole_diameter(type)), h1, center = false, colour = body_colour);

        wire_diameter = BLDC_wire_diameter(type);
        for(i = [0 : 2])
            color(wire_diameter > 3 ? ["red", "blue", "yellow"][i] : grey(20))
                translate([body_diameter / 5, (i - 1) * wire_diameter, wire_diameter / 2 + 0.25])
                    rotate([0, 90, 0])
                        cylinder(r = wire_diameter / 2, h = body_diameter / 2, center = false);

    } // end module base

    module bell() {
        bell_diameter = BLDC_bell_diameter(type);
        h1 = BLDC_bell_height_1(type);
        h2 = BLDC_bell_height_2(type);
        gap = BLDC_base_open(type) ? - 0.25 : height > 20 ? 0.5 : 0.25;
        side_length = height - h1 -h2 - gap - BLDC_base_height_1(type) - BLDC_base_height_2(type);

        color(body_colour) {
            translate_z(height - h1) {
                difference() {
                    union() {
                        top_thickness = min(h1, 2);
                        render(convexity = 8)
                            translate_z(h1 - top_thickness)
                                linear_extrude(top_thickness)
                                    difference() {
                                        circle(d = bell_diameter);
                                        if (BLDC_shaft_length(type) > height)
                                            circle(d = BLDC_shaft_diameter(type));
                                        BLDC_bell_screw_positions(type)
                                            circle(d = BLDC_bell_hole_diameter(type));
                                    }
                        rotate_extrude()
                            polygon([ [bell_diameter/2, h1], [body_diameter/2, 0], [body_diameter/2, -h2], [body_diameter/2 - wall_thickness, -h2], [body_diameter/2 - wall_thickness, 0], [bell_diameter/2, h1 - top_thickness] ]);
                    }
                    spoke_count = BLDC_bell_spokes(type);
                    if (spoke_count % 4 == 0) {
                        r = body_diameter > 40 ? body_diameter / 15 : 2.5;
                        for (a = [0, 90, 180, 270])
                            rotate(a) {
                                hull() {
                                    translate([bell_diameter/2 + r, 0, -eps])
                                        cylinder(r=r, h=h1 + 2*eps);
                                    translate([body_diameter/2, -r, -eps])
                                        cube([eps, 2*r, h1 + 2*eps]);
                                }
                                rotate(45)
                                    hull() {
                                        translate([bell_diameter/2, 0, -eps])
                                            cylinder(r=r, h=h1 + 2*eps);
                                        translate([body_diameter/2, -r, -eps])
                                            cube([eps, 2*r, h1 + 2*eps]);
                                    }
                            }
                    } else {
                        r1 =  bell_diameter * PI / (spoke_count * 3);
                        r2 =  body_diameter * PI / (spoke_count * 3);
                        for (i = [0 : 1 : spoke_count - 1])
                            rotate(i * 360 / spoke_count)
                                hull() {
                                    translate([bell_diameter/2, 0, -eps])
                                        cylinder(r=r1, h=h1 + 2*eps);
                                    translate([body_diameter/2, 0, -eps])
                                        cylinder(r=r2, h=h1 + 2*eps);
                                }
                    }
                } // end difference
                if (BLDC_boss_height(type))
                    translate_z(h1)
                        tube(or = BLDC_boss_radius(type), ir = BLDC_shaft_diameter(type)/2, h = BLDC_boss_height(type));

            } // end translate
            if (BLDC_propshaft_diameter(type))
                translate_z(height) {
                    cylinder(d=BLDC_propshaft_diameter(type), h=BLDC_propshaft_length(type));
                    thread_diameter = BLDC_propshaft_thread_diameter(type);
                    translate_z(BLDC_propshaft_length(type))
                        if (show_threads)
                            male_metric_thread(thread_diameter, metric_coarse_pitch(thread_diameter), BLDC_propshaft_thread_length(type), center=false);
                        else
                            cylinder(d=thread_diameter, h=BLDC_propshaft_thread_length(type));
                }
        } // end colour

        color(side_colour)
            translate_z(height - h1 - h2  -side_length)
                tube(body_diameter/2, body_diameter/2 - wall_thickness, side_length, center=false);

        if (show_threads)
            translate_z(height)
                BLDC_bell_screw_positions(type)
                    vflip()
                        female_metric_thread(BLDC_bell_hole_diameter(type), metric_coarse_pitch(BLDC_bell_hole_diameter(type)), h1, center = false, colour = body_colour);
    } // end module bell

    base();
    bell();

    color(bldc_shaft_colour)
        translate_z(-BLDC_shaft_offset(type) - eps)
            not_on_bom()
                rod(d=BLDC_shaft_diameter(type), l=BLDC_shaft_length(type), center=false);

}

module BLDC_screw_positions(holes, n = 4) {
    hole_count = is_list(holes) ? len(holes) : 4;
    for($i = [0 : 1 : min(n - 1, hole_count - 1)]) {
        spacing = is_list(holes) ? holes[$i] : holes;
        rotate($i * 360 / hole_count)
            translate([spacing / 2, 0])
                rotate(-$i * 90)
                    children();
    }
}

module BLDC_base_screw_positions(type, n = 4) { //! Positions children at the base screw holes
    if (BLDC_base_holes(type))
        rotate(is_list(BLDC_base_holes(type)) && len(BLDC_base_holes(type)) == 3 ? 180 : 45)
            BLDC_screw_positions(BLDC_base_holes(type), n)
                children();
}

module BLDC_bell_screw_positions(type, n = 4) { //! Positions children at the top screw holes
    if (BLDC_bell_holes(type))
        BLDC_screw_positions(BLDC_bell_holes(type), n)
            children();
}
