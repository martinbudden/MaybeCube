use <NopSCADlib/vitamins/pcb.scad>


BTT_RELAY_V1_0 = [
    "BTT_RELAY_V1_0", "BigTreeTech Relay Module v1.0",
    79.25, 33.78, 1.6, // size
    1, // corner radius
    3, // mounting hole diameter
    3.5, // pad around mounting hole
    grey(30), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
        [2.54, 2.285], [-2.54, 2.285], [2.54, -2.285], [-2.54, -2.285]
    ],
    [ // components
    ],
    [], // accessories
    [], // grid
];
