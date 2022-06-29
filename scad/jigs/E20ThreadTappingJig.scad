include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/utils/core/global.scad>
include <NopSCADlib/utils/core/rounded_rectangle.scad>


$fn=192;
eSize = 20;
jigColor = rr_green;

module channelInsert(length=5, channelWidth, channelDepth) {
    offset = 2;
    translate([-channelWidth/2, 0, 0]) {
        cube([channelWidth, offset, length]);
        d = 1;
        translate([d/2, offset, 0])
            cube([channelWidth - d, channelDepth - offset, length]);
        overhang = 1.75 + d/2;
        translate([channelWidth - d/2, offset, 0])
            right_triangle(overhang, channelDepth - offset, length, center=false);
        translate([d/2, offset, 0])
            mirror([1, 0, 0])
                right_triangle(overhang, channelDepth - offset, length, center=false);
    }
}


module jig(boltSize, topLength=22, channelInsertLength1=25, channelInsertLength2=25, boltOffset=0) {
    channelWidth = 6;
    channelDepth = 5.5;

    translate([0, -eSize, 0])
        difference() {
            rounded_cube_xy([eSize, eSize, topLength], 2);
            translate([eSize/2, eSize/2, -eps]) {
                poly_cylinder(h=topLength + 2*eps, r=(boltSize == 5 ? M5_clearance_radius : M6_clearance_radius) + 0.1);
                //boltHoleM6Counterbore(topLength, boreDepth=topLength-5, bridgeThickness=0.5);
            }
    }
    translate_z(topLength) {
        translate([eSize/2, 0, 0])
            rotate(180)
                difference() {
                    channelInsert(channelInsertLength1, channelWidth, channelDepth);
                    if (boltOffset)
                        translate_z(boltOffset)
                            rotate([-90, 0, 0])
                                boltHoleM3Tap(6);
                }
        translate([eSize/2, -eSize, 0])
            difference() {
                channelInsert(channelInsertLength1, channelWidth, channelDepth);
                if (boltOffset)
                    translate_z(boltOffset)
                        rotate([-90, 0, 0])
                            boltHoleM4Tap(6);
            }

        translate([eSize, -eSize/2, 0])
            rotate(90)
                channelInsert(channelInsertLength2, channelWidth, channelDepth);
        translate([0, -eSize/2, 0])
            rotate(-90)
                channelInsert(channelInsertLength2, channelWidth, channelDepth);
    }
}

module E20_Thread_Tapping_Jig_5mm_stl() {
    stl("E20_Thread_Tapping_Jig_5mm")
        color(jigColor)
            jig(5);
}

module E20_Thread_Tapping_Jig_6mm_stl() {
    stl("E20_Thread_Tapping_Jig_6mm")
        color(jigColor)
            jig(6);
}

if ($preview)
    E20_Thread_Tapping_Jig_6mm_stl();
