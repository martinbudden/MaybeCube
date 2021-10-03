include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/rails.scad>


jigColor = rr_green;

module Rail_Centering_Jig_stl() {
    rail_type = MGN12;
    eSize = 20;
    size = [2*eSize + 20, eSize + 15, 10];

    stl("Rail_Centering_Jig")
        color(jigColor)
            translate([0, -eSize, 0])
                linear_extrude(size.z)
                    offset(1.5) offset(-1.5) difference() {
                        translate([-(size.x-2*eSize)/2, 0])
                            square([size.x, size.y]);
                        translate([(-rail_width(rail_type) + eSize)/2, eSize])
                            square([rail_width(rail_type), rail_height(rail_type)], center=false);
                        square([2*eSize, eSize], center=false);
                    }
}

if ($preview)
    Rail_Centering_Jig_stl();
