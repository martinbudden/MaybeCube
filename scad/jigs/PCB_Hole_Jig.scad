include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

use <../utils/PSU.scad>
use <../BackFace.scad>

eSize = 20;
jigColor = rr_green;

module PCB_Hole_Jig_stl() {
    size = [110, 20, 1];
    fillet = 3;
    offsetY = 155;

    stl("PCB_Hole_Jig")
        color(jigColor)
            translate_z(-size.z) {
                difference() {
                    linear_extrude(size.z)
                        difference() {
                            translate([eX + 2*eSize - size.x, offsetY - size.y/2])
                                union() {
                                    translate([size.x - eSize, -offsetY + size.y/2])
                                        rounded_square([eSize, 200], fillet, center=false);
                                    translate([0, 50 - 25])
                                        rounded_square([size.x, size.y + 25], fillet, center=false);
                                    translate([-15, -50])
                                        rounded_square([size.x + 15, size.y + 35], fillet, center=false);
                                }
                                *for (y = [6, size.y/2, size.y - 6])
                                    translate([eX + 3*eSize/2, y + offsetY -size.y/2])
                                        poly_circle(r=M4_clearance_radius);
                                translate([backPanelSize().x/2, backPanelSize().y/2]) {
                                    backPanelCutouts(PSUType(), BTT_SKR_V1_4_TURBO, radius=1);
                                    backPanelCutouts(PSUType(), BTT_SKR_E3_TURBO, radius=1);
                                }
                        }
                }
            }
}

module PCB_Hole_Jig_assembly()
assembly("PCB_Hole_Jig") {

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0]) {
            stl_colour(jigColor)
                PCB_Hole_Jig_stl();
        }
}

if ($preview)
    PCB_Hole_Jig_stl();
