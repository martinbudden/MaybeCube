include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/vitamins/pcb.scad>

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

module BTT_MANTA_8MP_V2_Base_stl() {
    pcbType = BTT_MANTA_8MP_V2_0;
    pcbSize = pcb_size(pcbType);
    size = [pcbSize.x + 2, pcbSize.y + 2, 2];
    standoffHeight = 5;

    stl("BTT_MANTA_8MP_V2_Base")
        translate_z(-size.z)
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
    size = [20, pcbSize.y + 2, 5];

    stl("BTT_MANTA_8MP_V2_Spacer")
        difference() {
            rounded_cube_xy(size, 3, xy_center=true);
            for (i = [ 0, 3])
                translate([0, pcb_coord(pcbType, pcb_holes(pcbType)[i]).y, 0])
                    boltHoleM3(size.z);
        }
}
