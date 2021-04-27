include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/screws.scad>

function extrusionChannelWidth() = 8;
function extrusionChannelDepth() = 6;

// lightSlateGrey
function frameColor() =  is_undef($hide_extrusions) ? [135/255, 145/255, 155/255] : [0, 0, 0, 0];

//extrusionOX(300, 20);
// OX - oriented to X form (canonical form)
// canonical form, in XY plane and aligned with origin
module extrusionOX(length, eSize=20) {
    //echo("extrusionLength=", length);
    if (is_undef($hide_extrusions))
        translate([0, eSize/2, eSize/2])
            rotate([0, 90, 0])
                color(frameColor())
                    extrusion(eSize==15 ? E1515 : E2020, length, center=false);
}

module extrusionOX2040H(length) {
    //echo("extrusionLength=", length);
    eSize = 20;
    if (is_undef($hide_extrusions))
        translate([0, eSize, eSize/2])
            rotate([0, 90, 0])
                color(frameColor())
                    extrusion(E2040, length, center=false);
}


module extrusionOX2040V(length) {
    //echo("extrusionLength=", length);
    eSize = 20;
    if (is_undef($hide_extrusions))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90])
                color(frameColor())
                    extrusion(E2040, length, center=false);
}

module extrusionOX2080V(length) {
    //echo("extrusionLength=", length);
    eSize = 20;
    if (is_undef($hide_extrusions))
        translate([0, eSize/2, 2*eSize])
            rotate([90, 0, 90])
                color(frameColor())
                    extrusion(E2080, length, center=false);
}

module extrusionOXEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && is_undef($hide_bolts))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                translate([0, -eSize/2, -offset - extrusion_tab_thickness(E2040)])
                    vflip()
                        children();
                translate([0, -eSize/2, length + offset + extrusion_tab_thickness(E2040)])
                    children();
            }
}

module extrusionOX2040VEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && is_undef($hide_bolts))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (y = [-eSize/2, eSize/2])
                    translate([0, y, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                for (y = [-eSize/2, eSize/2])
                    translate([0, y, length + offset + extrusion_tab_thickness(E2040)])
                        children();
            }
}

module extrusionOX2080VEndBoltPositions(length, offset=0) {
    eSize = 20;
    if ($preview && is_undef($hide_bolts))
        translate([0, eSize/2, eSize])
            rotate([90, 0, 90]) {
                for (y = [-eSize/2, eSize/2, 3*eSize/2, 5*eSize/2])
                    translate([0, y, -offset - extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                for (y = [-eSize/2, eSize/2, 3*eSize/2, 5*eSize/2])
                    translate([0, y, length + offset + extrusion_tab_thickness(E2040)])
                        children();
            }
}
//extrusionOY(300, 20);
// OY - oriented to Y form
// rotated about Y axis and re-aligned with origin
// so it points in the Y direction and is "canonical" to the XZ plane
module extrusionOY(length, eSize=20) {
    translate([0, length, 0])
        rotate([0, 0, -90])
            extrusionOX(length, eSize);
}

module extrusionOY2040H(length) {
    eSize = 20;
    if (is_undef($hide_extrusions))
        translate([eSize, 0, eSize/2])
            rotate([-90, 90, 0])
                color(frameColor())
                    extrusion(E2040, length, center=false);
}

module extrusionOY2040HEndBoltPositions(length, offset) {
    eSize = 20;
    if ($preview && is_undef($hide_bolts))
        translate([eSize, 0, eSize/2])
            rotate([-90, 90, 0]) {
                translate([0, offset, -extrusion_tab_thickness(E2040)])
                    vflip()
                        children();
                translate([0, offset, length + extrusion_tab_thickness(E2040)])
                    children();
            }
}

module extrusionOY2040V(length) {
    eSize = 20;
    if (is_undef($hide_extrusions))
        translate([eSize/2, 0, eSize])
            rotate([-90, 0, 0])
                color(frameColor())
                    extrusion(E2040, length, center=false);
}

module extrusionOY2040VEndBoltPositions(length) {
    eSize = 20;
    if ($preview && is_undef($hide_bolts))
        translate([eSize/2, 0, eSize])
            rotate([-90, 0, 0]) {
                for (y = [-eSize/2, eSize/2])
                    translate([0, y, -extrusion_tab_thickness(E2040)])
                        vflip()
                            children();
                for (y = [-eSize/2, eSize/2])
                    translate([0, y, length + extrusion_tab_thickness(E2040)])
                        children();
            }
}

//extrusionOZ(200, 20);
// OZ - oriented to Z form
// rotated about Z axis and re-aligned with origin
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
