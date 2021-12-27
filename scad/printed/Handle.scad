include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>



module handleCrossSection(size, fillet, angle) {
    module teardrop(r, angle) {
        hull() {
            circle4n(r);
            if (angle > 0) {
                square_size = [2*r*(sin(angle) - (1 - cos(angle))/tan(angle)), r];
                translate([0, square_size.y / 2])
                    square(square_size, center = true);
            }
        }
    }

    hull() {
        for (x = [fillet, size.x - fillet]) {
            translate([x, fillet])
                rotate(180)
                    teardrop(fillet, angle);
            translate([x, size.y - fillet])
                teardrop(fillet, angle);
        }
    }
}

module Handle_stl() {
    length = 100;
    height = 40;
    internalRadius = 10;
    size = [15, 15];
    fillet = 4;
    filletAngle = 55;
    baseHeight = 5;

    module top() {
        translate_z(size.x + internalRadius)
            linear_extrude(length - 2*internalRadius)
                handleCrossSection(size, fillet, filletAngle);
    }

    module topCorner(angle=90) {
        translate([-internalRadius, size.y/2, size.x + internalRadius])
            rotate([-90, angle==90 ? 0 : angle, 0])
                rotate_extrude(angle=angle == 90 ? 90 : eps, convexity=2, $fn = r2sides4n(internalRadius))
                    translate([internalRadius, -size.y/2])
                        handleCrossSection(size, fillet, filletAngle);
    }

    module side(length) {
        translate([-height + size.x, 0, 0])
            rotate([0, 90, 0])
                linear_extrude(length)
                    handleCrossSection(size, fillet, filletAngle);
    }

    module corner() {
        difference() {
            union() {
                topCorner();
                hull() {
                    translate_z(size.x)
                        side(height - size.x - internalRadius);
                    side(eps);
                }
                hull() {
                    topCorner(angle=45);
                    translate_z(-size.x/2)
                        side(baseHeight);
                    side(eps);
                }
            }
            translate([size.x, size.y/2, size.x/2])
                rotate([0, -90, 0])
                    boltHoleM4CounterboreButtonhead(height, boreDepth=height - baseHeight, horizontal=true);
            h = 20;
            translate([size.x - height + h, size.y/2, size.x/2 - 20])
                rotate([0, -90, 0])
                    boltHoleM4CounterboreButtonhead(h, boreDepth=height - h - baseHeight, horizontal=true);
        }
    }

    stl("Handle")
        color(pp1_colour)
            translate([height - size.x, size.x + length/2, -size.y/2])
                rotate([90, 0, 0]) {
                    top();
                    corner();
                    translate_z(length + 2*size.x)
                        mirror([0, 0, 1])
                            corner();
                }
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
