use <NopSCADlib/vitamins/pcb.scad>


BTT_RELAY_V1_2 = [
    "BTT_RELAY_V1_2", "BigTreeTech Relay Module v1.2",
    80.4, 36.3, 1.5, // size
    1, // corner radius
    3, // mounting hole diameter
    5, // pad around mounting hole
    grey(15), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
        [3, 3.5], [-3, 3.5], [3, -3.5], [-3, -3.5]
    ],
    [ // components
        [  44.5,  10.0,    0, "block", 25,  20,    15.8, grey(25) ],
        [  47.5,  -7.6,    0, "block", 19,  15.25, 15.8, "SkyBlue" ],
        [ -14.5,  18.15,   0, "block", 16,  30,    17.0, grey(25) ],
        [ -14.5,  18.15,   0, "block", 15,  25.5,  17.1, "PaleGoldenrod" ],
        [   2.5,  10.65, 270, "jst_xh", 2, false, grey(20), ],
        [   2.5,  18.15, 270, "jst_xh", 2, false, grey(20), ],
        [   2.5,  25.65, 270, "jst_xh", 2, false, grey(20), ],
        [  11.0,   2.0,    0, "2p54header", 2, 1 ],
        [  23.0,   2.0,    0, "2p54header", 4, 1 ],
        [   7.9,  -3.3,   90, "2p54header", 2, 1 ],
    ],
    [], // accessories
    [], // grid
];
