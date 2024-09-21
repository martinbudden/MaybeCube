include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/vitamins/pcb.scad>
use <NopSCADlib/utils/fillet.scad>

include <bolts.scad>

BTT_MANTA_8MP_V2_0 = [
    "BTT_MANTA_8MP_V2_0", "BigTreeTech Manta 8MP v2.0",
    169.93, 102.74, 1.0, // size
    3, // corner radius
    3.5, // mounting hole diameter
    5, // pad around mounting hole
    grey(30), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
        [5, -4.74], [-14.93, -4.74], [5, 8], [-4.43, 5]
    ],
    [ // components
    ],
    [], // accessories
    [], // grid
];


BTT_MANTA_8MP_V2_Base_height = 4.5;

module BTT_MANTA_8MP_V2_Base_stl() {
    pcbType = BTT_MANTA_8MP_V2_0;
    pcbSize = pcb_size(pcbType);
    size = [pcbSize.x + 2, pcbSize.y + 2, 1.5];
    standoffHeight = BTT_MANTA_8MP_V2_Base_height - size.z;

    stl("BTT_MANTA_8MP_V2_Base")
        color(pp4_colour)
            difference() {
                union() {
                    width = size.x;
                    translate([(size.x - width)/2, 0, 0])
                        rounded_cube_xy([width, size.y, size.z], 3, xy_center=true);
                    pcb_hole_positions(pcbType)
                        if ($i == 1 || $i == 3 || width == size.x)
                            cylinder(r=3, h=size.z + standoffHeight);
                }
                pcb_hole_positions(pcbType)
                    if ($i == 1)
                        boltHoleM3Tap(size.z + standoffHeight);
                    else
                        boltHoleM3(size.z + standoffHeight);
            translate([pcb_coord(pcbType, pcb_holes(pcbType)[3]).x, pcb_coord(pcbType, pcb_holes(pcbType)[1]).y, 0])
                boltHoleM3(size.z);
            }
}

module BTT_MANTA_8MP_V2_Spacer_stl() {
    pcbType = BTT_MANTA_8MP_V2_0;
    pcbSize = pcb_size(pcbType);
    size = [20, pcbSize.y + 2, 10];

    stl("BTT_MANTA_8MP_V2_Spacer")
        color(pp2_colour)
            difference() {
                rounded_cube_xy(size, 3, xy_center=true);
                cutoutFillet = 1;
                cutoutSize = [2, 10, 6];
                translate([-size.x/2, size.y/2 - cutoutSize.y, size.z -  cutoutSize.z + eps]) {
                    translate([-2*cutoutFillet, 0, 0])
                        rounded_cube_xy([cutoutSize.x + 2*cutoutFillet, cutoutSize.y + 2*cutoutFillet, cutoutSize.z], cutoutFillet);
                    rotate(-90)
                        fillet(cutoutFillet, cutoutSize.z);
                    translate([cutoutSize.x, cutoutSize.y, 0])
                        rotate(-90)
                            fillet(cutoutFillet, cutoutSize.z);
                }
                translate([0, pcb_coord(pcbType, pcb_holes(pcbType)[0]).y, size.z])
                    vflip()
                        boltHoleM3Counterbore(size.z);
                translate([0, pcb_coord(pcbType, pcb_holes(pcbType)[3]).y, 0])
                    boltHoleM3(size.z);
            }
}
