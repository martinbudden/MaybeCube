include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/green_terminals.scad>
include <NopSCADlib/vitamins/pcbs.scad>

BTT_B1_Box_V1_0 = ["BTT_B1_Box_V1_0", "BTT B1 Box V1.0",
    80, 30, 1.6, 0, 3, 4.5, grey(20), false,
    [ [10, 15], [-10, 15] ],
    [
        [ 25, 15,   0, "2p54boxhdr", 7, 2 ],
        [ 45, 10, 180, "jst_xh", 3, false, "green" ],
    ],
    []
];

RepRapLcdPcb = ["RepRapLcdPcb", "RepRap LCD pcb",
    103, 60, 1.6, 0, 3.5, 0, "green", false,
    [ [-3, 3], [-3, -3], [3, -3], [3, 3] ],
    [
        [ 103-(8+8*2.54), -2.54/2, 0, "2p54header", 16, 1 ],
        [ -103/2, 60/2, 0, "-chip", 102, 40, 9, grey(20) ],
        [ -103/2, 60/2, 0, "-chip", 75, 30, 9.1, "#0000cc" ],
    ],
    []
];

RepRapSmartController = ["RepRapSmartController", "RepRap smart controller",
    150, 55, 1.6, 0, 3, 0, "red", false,
    [ [-2.5, 2.5], [-2.5, -2.5], [2.5, -2.5], [2.5, 2.5] ],
    [
        [ 103/2+14, 22, 180, "-pcb", -5.6, RepRapLcdPcb ],
        [ 135,  7,   0, "button_6mm" ],
        [ 135, 45,   0, "buzzer" ],
        [ 135, 27.5, 0, "potentiometer" ],
        [ 25/2,21, 180, "-uSD", [26, 25, 3] ],
        [  55, 28, 180, "-2p54boxhdr", 5, 2 ],
        [  77, 28, 180, "-2p54boxhdr", 5, 2 ],
        [  39, 16,   0, "-chip", 3.5, 10, 1 ],
        [  38, 39,   0, "-chip", 6, 3, 1 ],
    ],
    []
];

ADXL345  = [
    "ADXL345 1", "ADXL345 ",
    20, 15, 1, // size
    0, // corner radius
    3, // mounting hole diameter
    0, // pad around mounting hole
    "#2140BE", // color
    false, // true if parts should be separate BOM items
    [ [2.5, -2.5], [-2.5, -2.5] ], // hole positions
    [ // components
        [ 10,  9,  0, "chip", 6,  4, 1.1,  grey(15) ],
    ],
    [], // accessories
    [(20-2.54*7)/2, 2.54/2, 8, 1], // 8x1 line of holes
];
