include <NopSCADlib/vitamins/rails.scad>


jigColor = rr_green;
eSize = 20;

module Rail_Centering_Jig_MGN12_2020_stl() {
    stl("Rail_Centering_Jig_MGN12_2020")
        color(jigColor)
            railCenteringJig([eSize + 20, eSize + 15, 10], MGN12);
}

module Rail_Centering_Jig_MGN12_2040_stl() {
    stl("Rail_Centering_Jig_MGN12_2040")
        color(jigColor)
            railCenteringJig([2*eSize + 20, eSize + 15, 10], MGN12);
}

module Rail_Centering_Jig_MGN12_2060_stl() {
    stl("Rail_Centering_Jig_MGN12_2060")
        color(jigColor)
            railCenteringJig([3*eSize + 20, eSize + 15, 10], MGN12);
}

module railCenteringJig(size, rail_type) {
    translate([0, -eSize, 0])
        linear_extrude(size.z)
            offset(1.5) offset(-1.5) difference() {
                translate([-eSize/2, 0])
                    square([size.x, size.y]);
                offset = size.x == 80 ? 20 : 0;
                translate([offset + (eSize - rail_width(rail_type))/2, eSize])
                    square([rail_width(rail_type), rail_height(rail_type)], center=false);
                square([size.x - eSize, eSize], center=false);
            }
}

if ($preview)
    Rail_Centering_Jig_stl();
