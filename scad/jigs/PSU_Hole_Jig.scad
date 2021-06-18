include <NopSCADlib/core.scad>

use <../printed/PSU.scad>
use <../BackFace.scad>


jigColor = rr_green;

module PSU_Hole_Jig_stl() {
    size = [115, 20, 1];
    fillet = 3;
    offsetY = psuOffset(PSUType()).z;
    counterSunk = true;

    stl("PSU_Hole_Jig")
        color(rr_green)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        union() {
                            translate([0, 80]) {
                                rounded_square([size.x, size.y], fillet, center=false);
                                rounded_square([20, 160], fillet, center=false);
                            }
                            translate([0, offsetY + 75 - size.y/2])
                                rounded_square([size.x, size.y], fillet, center=false);
                        }
                        translate([backPanelSize().x/2, backPanelSize().y/2])
                            backPanelCutouts(PSUType(), pcbType(), radius=1);
                    }
}

module PSU_Hole_Jig_assembly()
assembly("PSU_Hole_Jig", ngb=true) {

    translate([0, eY + 2*eSize, 0])
        rotate([90, 0, 0]) {
            stl_colour(pp2_colour)
                PSU_Hole_Jig_stl();
        }
}

if ($preview)
    PSU_Hole_Jig_stl();
