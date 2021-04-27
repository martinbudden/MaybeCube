include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/extrusion_brackets.scad>

include <../Parameters_Main.scad>

module extrusionInnerCornerBracket(grubCount=2, boltLength=10) {
    if ($preview)
        extrusion_inner_corner_bracket(E20_inner_corner_bracket, grub_screws=false);

    size = [25, 25, 4.5];
    armLength = size.x;

    if ($preview && is_undef($hide_bolts))
        translate([-size.z-0.75, -size.z-0.75, 0])
            rotate([-90, 0, 0]) {
                grubScrewLength = 6;
                if (grubCount > 0)
                    rotate([0, -90, 180])
                        translate([armLength-5, 0, size.z])
                            not_on_bom() no_explode()
                                screw(M3_grub_screw, grubScrewLength);
                if (grubCount == 2)
                    translate([armLength-5, 0, size.z])
                        not_on_bom() no_explode()
                            screw(M3_grub_screw, grubScrewLength);
                if (grubCount == 1)
                    translate([armLength-5, 0, size.z-4.25+boltLength])
                        explode(50) screw(M4_dome_screw, boltLength);
            }
}
