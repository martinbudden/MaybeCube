include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>

function extrusionChannelWidth() = 8;
function extrusionChannelDepth() = 6;

// lightSlateGrey
function frameColor() =  is_undef($hide_extrusions) ? [135/255, 145/255, 155/255] : [0, 0, 0, 0];

// OX - oriented to X (canonical form)
// canonical form, in XY plane and aligned with origin
module extrusionOX(length, eSize=20) {
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, eSize/2, eSize/2])
            rotate([0, 90, 0])
                color(frameColor())
                    extrusion(eSize==15 ? E1515 : E2020, length, center=false);
}

module extrusionOX2040H(length) {
    eSize = 20;
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, eSize, eSize/2])
            rotate([0, 90, 0])
                color(frameColor())
                    extrusion(E2040, length, center=false);
}

module extrusionOX2060H(length) {
    eSize = 20;
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, 3*eSize/2, eSize/2])
            rotate([0, 90, 0])
                color(frameColor())
                    extrusion(E2060, length, center=false);
}

module extrusionOX2080H(length) {
    eSize = 20;
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, 2*eSize, eSize/2])
            rotate([0, 90, 0])
                color(frameColor())
                    extrusion(E2080, length, center=false);
}

module extrusionOX2040V(length) {
    eSize = 20;
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90])
                color(frameColor())
                    extrusion(E2040, length, center=false);
}

module extrusionOX2060V(length) {
    eSize = 20;
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, eSize/2, 3*eSize/2])
            rotate([90, 0, 90])
                color(frameColor())
                    extrusion(E2060, length, center=false);
}

module extrusionOX2080V(length) {
    eSize = 20;
    if (is_undef($hide_extrusions) || $hide_extrusions == false)
        translate([0, eSize/2, 2*eSize])
            rotate([90, 0, 90])
                color(frameColor())
                    extrusion(E2080, length, center=false);
}

module extrusionOXEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                translate([0, -eSize/2, -offset - extrusion_tab_thickness(E2040)])
                    vflip()
                        children();
                translate([0, -eSize/2, length + offset + extrusion_tab_thickness(E2040)])
                    children();
            }
}

module extrusionOX2040HEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (x = [0, eSize]) {
                    translate([x, -eSize/2, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                    translate([x, -eSize/2, length + offset + extrusion_tab_thickness(E2040)])
                        children();
                }
            }
}

module extrusionOX2040VEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (y = [-eSize/2, eSize/2]) {
                    translate([0, y, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                    translate([0, y, length + offset + extrusion_tab_thickness(E2040)])
                        children();
                }
            }
}

module extrusionOX2060HEndBoltPositions(length, offset=0, bothEnds=true) {
    eSize = 20;
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (x = [0, eSize, 2*eSize]) {
                    translate([x, -eSize/2, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                    if (bothEnds)
                        translate([x, -eSize/2, length + offset + extrusion_tab_thickness(E2040)])
                            children();
                }
            }
}

module extrusionOX2080HEndBoltPositions(length, offset=0, bothEnds=true) {
    eSize = 20;
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (x = [0, eSize, 2*eSize, 3*eSize]) {
                    translate([x, -eSize/2, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                    if (bothEnds)
                        translate([x, -eSize/2, length + offset + extrusion_tab_thickness(E2040)])
                            children();
                }
            }
}

module extrusionOX2080VEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (y = [-eSize/2, eSize/2, 3*eSize/2, 5*eSize/2]) {
                    translate([0, y, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                    translate([0, y, length + offset + extrusion_tab_thickness(E2040)])
                        children();
                }
            }
}

// OY - oriented to Y
// rotated about Y-axis and re-aligned with origin
// so it points in the Y direction and is "canonical" to the XZ plane
module extrusionOY(length, eSize=20) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX(length, eSize);
}

module extrusionOYEndBoltPositions(length, offset=0) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOXEndBoltPositions(length, offset)
                children();
}

module extrusionOY2040H(length) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2040H(length);
}

module extrusionOY2040HEndBoltPositions(length, offset=0) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2040HEndBoltPositions(length, offset)
                children();
}

module extrusionOY2060H(length) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2060H(length);
}

module extrusionOY2060HEndBoltPositions(length, offset=0) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2060HEndBoltPositions(length, offset)
                children();
}

module extrusionOY2080H(length) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2080H(length);
}

module extrusionOY2080HEndBoltPositions(length, offset=0) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2080HEndBoltPositions(length, offset)
                children();
}

module extrusionOY2040V(length) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2040V(length);
}

module extrusionOY2040VEndBoltPositions(length, offset=0) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX2040VEndBoltPositions(length, offset)
                children();
}

//extrusionOZ(200, 20);
// OZ - oriented to Z form
// rotated about Z-axis and re-aligned with origin
// so it points in the Z direction and is "canonical" to the XY plane
module extrusionOZ(length, eSize=20) {
    translate([eSize, 0, 0])
        rotate([0, -90, 0]) {
            extrusionOX(length, eSize);
            // add a small extension so that joins between extrusion can be better seen
            not_on_bom() no_explode()
                translate([length, 0, 0])
                    extrusionOX(0.25, eSize);
        }
}

module extrusionOZ2040X(length) {
    eSize = 20;
    translate([2*eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2040V(length);
}

module extrusionOZ2060X(length) {
    eSize = 20;
    translate([3*eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2060V(length);
}

module extrusionOZ2080X(length) {
    eSize = 20;
    translate([4*eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2080V(length);
}

module extrusionOZ2080XEndBoltPositions(length, offset=0) {
    translate([0, length, 0])
        rotate([0, -90, 0])
            extrusionOX2080VEndBoltPositions(length, offset)
                children();
}

module extrusionOZ2040Y(length) {
    eSize = 20;
    translate([eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2040H(length);
}

module extrusionOZ2060Y(length) {
    eSize = 20;
    translate([eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2060H(length);
}

module extrusionOZ2080Y(length) {
    eSize = 20;
    translate([eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2080H(length);
}

module extrusionOZ2080YEndBoltPositions(length, offset=0, bothEnds=true) {
    eSize = 20;
    translate([eSize, 0, 0])
        rotate([0, -90, 0])
            extrusionOX2080HEndBoltPositions(length, offset, bothEnds=bothEnds)
                children();
}
