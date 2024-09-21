include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/vitamins/pcb.scad>

BTT_KRAKEN_V1_0 = [
    "BTT_KRAKEN_V1_0", "BigTreeTech Kraken v1.0",
    200.03, 113, 1.0, // size
    3, // corner radius
    3.5, // mounting hole diameter
    5, // pad around mounting hole
    grey(30), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
        [5, -5], [-4.03, -5], [5, 5], [-4, 5]
    ],
    [ // components
    ],
    [], // accessories
    [], // grid
];

