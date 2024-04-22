include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/vitamins/pcb.scad>

BTT_MANTA_5MP_V1_0 = [
    "BTT_MANTA_5MP_V1_0", "BigTreeTech Manta 5MP v1.0",
    137.39, 95, 1.0, // size
    3, // corner radius
    3.5, // mounting hole diameter
    5, // pad around mounting hole
    grey(30), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
        [4.5, -26], [-4.5, -4], [4.5, 4.5], [-4.5, 4.5]
    ],
    [ // components
    ],
    [], // accessories
    [], // grid
];

module BTT_MANTA_5MP_V1_Base_stl() {
    pcbType = BTT_MANTA_5MP_V1_0;
    pcbSize = pcb_size(pcbType);
    size = [pcbSize.x + 2, pcbSize.y + 2, 2];
    standoffHeight = 5;

    stl("BTT_MANTA_5MP_V1_Base")
        translate_z(-size.z)
            difference() {
                union() {
                    width = size.x;
                    translate([(size.x - width)/2, 0, 0])
                        rounded_cube_xy([width, size.y, size.z], 3, xy_center=true);
                    pcb_hole_positions(pcbType)
                        if ($i == 1 || $i ==3)
                            cylinder(r=3, h=size.z + standoffHeight);
                }
                pcb_hole_positions(pcbType)
                    if ($i == 1)
                        boltHoleM3Tap(size.z + standoffHeight);
                    else if ($i == 3)
                        boltHoleM3(size.z + standoffHeight);
            translate([pcb_coord(pcbType, pcb_holes(pcbType)[3]).x, pcb_coord(pcbType, pcb_holes(pcbType)[1]).y, 0])
                boltHoleM3(size.z);
            }
}

