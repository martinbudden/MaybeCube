include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/utils/tube.scad>
use <NopSCADlib/vitamins/stepper_motor.scad>
use <NopSCADlib/vitamins/fan.scad>
use <RevoNozzle.scad>
include <bolts.scad>

//                                              corner  body    boss    boss          shaft               cap         thread black  end    shaft    shaft
//                                side, length, radius, radius, radius, depth, shaft, length,      holes, heights,    dia,   caps,  conn,  length2, bore
NEMA14_22     = ["NEMA14_22",     35  , 22,     46.4/2, 21,     11,     1,     5,     21,          26,    [9,     7], 3,     true, false, 0,       0];

//          w     d   b   h      s              h     t    o   b  b    a
//          i     e   o   o      c              u     h    u   l  o    p
//          d     p   r   l      r              b     i    t   a  s    p
//          t     t   e   e      e                    c    e   d  s    e
//          h     h              w              d     k    r   e       r
//                        p                     i     n        s  d    t
//                        i                     a     e    d           u
//                        t                           s    i           r
//                        c                           s    a           e
//                        h
fan35x10 = [35,  10, 33, 14.5,   M3_dome_screw, 16,   10, 100, 7, 0,   undef];

biquH2V2SRevoBaseToNozzleTip = 24;
biquH2V2SRevoLowerFixingHoleToBase = 10;
function biquH2V2SRevoLowerFixingHoleToNozzleTipOffsetZ() =  biquH2V2SRevoBaseToNozzleTip + biquH2V2SRevoLowerFixingHoleToBase;
function biquH2V2SRevoAttachmentBoltSpacing() = 15;

biquH2V2SRevoSize = [35, 35, 39];

module reverseBowdenConnector(cap_colour = grey(80)) {
    ir = 4.25 / 2;
    brassColor = "#B5A642";
    body_colour = brassColor;

    color(body_colour) {
        *translate_z(-4.5) {
            tube(or=2.5, ir=ir, h=4.5, center=false);
            //male_metric_thread(6, metric_coarse_pitch(5), length=4.5, center=false, solid=false, colour=body_colour);
        }
        tube(or=7.75/2, ir=ir, h=1, center=false);
        translate_z(1)
            linear_extrude(5)
                difference() {
                    circle(d=9, $fn=6);
                    circle(r=ir);
                }
        translate_z(6)
            tube(or=7.75/2, ir=ir, h=6, center=false);
    }
    color(cap_colour)
        translate_z(12)
            tube(or=4, ir=ir, h=4, center=false);
}

module biquH2V2SCube(size) {
    cut = 2.5;
    linear_extrude(size.z)
        translate([-size.x/2, -size.y/2])
            difference() {
                square([size.x, size.y]);
                right_triangle(cut, cut);
                translate([size.x, 0])
                    rotate(90)
                        right_triangle(cut, cut);
                translate([0, size.y])
                    rotate(-90)
                        right_triangle(cut, cut);
                translate([size.x, size.y])
                    rotate(180)
                        right_triangle(cut, cut);
            }
}

module biquH2V2SCubeAttachment(size) {
    difference() {
        biquH2V2SCube(size);
        for (x = [size.x/2 - 10, 10 - size.x/2])
            translate([x, 0, size.z/2])
                rotate([90, 0, 0])
                    cylinder(h=size.x+2*eps, r=M3_tap_radius, center=true);
        for (y = [size.y/2 - 10, 10 - size.y/2])
            translate([0, y, size.z/2])
                rotate([0, 90, 0])
                    cylinder(h=size.x+2*eps, r=M3_tap_radius, center=true);
    }
}
module biquH2V2SRevo() {
    vitamin(str("biquH2V2SRevo() : BIQU H2V2S Revo"));
    size = biquH2V2SRevoSize;
    motor = NEMA14_22;
    attachmentSize = [size.x, size.y, 5];
    nozzleOffset = [0, 27, 0];
    translate([-attachmentSize.z/2, attachmentSize.y/2, attachmentSize.x/2 + biquH2V2SRevoBaseToNozzleTip])   
        rotate([90, 0, 90]) {
            NEMA(motor, jst_connector=true);
            color(crimson)
                biquH2V2SCubeAttachment(attachmentSize);
            color(grey(25)) {
                translate_z(attachmentSize.z)
                    biquH2V2SCube(size - [0, 0, attachmentSize.z]);
                translate([0, -size.y/2, nozzleOffset.y])
                    rotate([90, 0, 0]) {
                        h = biquH2V2SRevoBaseToNozzleTip - revoNozzleOffsetZ();
                        cylinder(h=h, r1=8.5, r2=6);
                    }
            }
            translate([0, -size.y/2 - biquH2V2SRevoBaseToNozzleTip, nozzleOffset.y])
                rotate([-90, 0, 0])
                    RevoNozzle();
            translate([0, size.y/2, nozzleOffset.y])
                rotate([-90, 0, 0])
                    reverseBowdenConnector();

            fan = fan35x10;
            translate_z(size.z + fan_depth(fan)/2)
                fan(fan);
        }
}
