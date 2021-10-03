include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/displays.scad>
include <NopSCADlib/vitamins/potentiometers.scad>

BTT_TFT35_E3_V3_0_Potentiometer_PCB = ["","",
    31, 18, 1.6,
    0, 0, 0,
    grey(20),
    false,
    [], // hole positions
    [ // components
        [ 15.5, 10, 0, "-potentiometer", BTT_encoder ],
    ],
    [] // accessories
];

BTT_TFT35_E3_V3_0_PCB = [
    "", "",
    93.35, 87, 1.6, // size
    0, // corner radius
    3, // mounting hole diameter
    1, // pad around mounting hole
    grey(30), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
         [2.725, -2.725], [-2.725, -2.725], [2.725, -2.725 - 64.90], [-2.725, -2.725 - 64.90]
    ],
    [ // components
        [ -18,    9,    0,            "buzzer", 5, 9 ],
        [ -77.73, 9,    0,            "pcb", 6, BTT_TFT35_E3_V3_0_Potentiometer_PCB ],
        [ -45.18, 9.5,  0,            "-button_6mm" ],
        [   8,   -(18.34 + 44.84)/2, 180, "uSD", [26.5, 16, 3] ],
        [   8,   -(50.13 + 62.13)/2, 180, "usb_A" ],
        [  12,   -7,    0,            "2p54socket", 2, 4 ], // ESP-01 socket
        //[   2.4, -7,  180,            "pcb", 10, ESP_01 ],

        // EXP1-3
        [ -16.5,  -4.3,   0, "2p54boxhdr", 5, 2 ],
        [ -36.5,  -4.3,   0, "2p54boxhdr", 5, 2 ],
        [ -56.5,  -4.3,   0, "2p54boxhdr", 5, 2 ],
        // JST headers
        [  -5,    32,    90, "jst_xh", 2 ],
        [ -13,    20,     0, "jst_xh", 3 ],
        [ -27,    20,     0, "jst_xh", 3 ],
        [ -45,    20,     0, "jst_xh", 3 ],
        [ -59,    20,     0, "jst_xh", 3 ],
        [  81.5, -14,   180, "jst_xh", 5 ],
        [  81.5, -23,   180, "jst_xh", 5 ],
        [  66.5, -39,     0, "chip", 18, 18, 1, grey(20) ],
    ],
    [] // accessories
];

function BTT_TFT35_E3_V3_0(size=[84.5, 54.5, 8.5], pcbSize=[93.35, 87, 1.6]) = [
    "BTT_TFT35_E3_V3_0", "BigTreeTech TFT35 E3 v3.0",
    size.x, size.y, size.z,                                                         // size
    BTT_TFT35_E3_V3_0_PCB,                                                          // pcb
    [5.435, 7.5, 0] - [(pcbSize.x - size.x)/2, (pcbSize.y - size.y)/2, 0],          // pcb offset from center, calculated from offset from edges
    [ [-size.x/2 + 7, -size.y/2 + 2.5], [size.x/2 - 3.5, size.y/2 - 2.5, 0.5] ],    // aperture
    [ [-size.x/2 + 8, -size.y/2 + 3.5], [size.x/2 - 4.5, size.y/2 - 3.5, 0.25] ],   // touch screen position and size
    0,                                                                              // length that studs protrude from the PCB holes
    [ [-size.x/2 - 1, -size.y/2], [-size.x/2, size.y/2, 0.5] ],                     // keep out region for ribbon cable, 1mm wide at right side of screen
];

/*BigTreeTech_TFT35_E3_V3_0 = ["BigTreeTech_TFT35_E3_V3_0", "BigTreeTech TFT35 E3 v3.0",
    84.5, 54.5, 4,                      // size, screen is 84.5 wide
    BigTreeTech_TFT35_E3_V3_0_PCB,      // pcb
    [ 5.435 - (93.35 - 84.5)/2, 7.5 - (87 - 54.5)/2, 0], // pcb offset from center
    [ [-(84.5/2 - 7), -(54.5/2 - 2.5)], [84.5/2 - 3.5, 54.5/2 - 2.5, 0.5] ],  // aperture
    [],                                 // touch screen position and size
    0,                                  // length that studs protrude from the PCB holes
    [],                                 // keep out region for ribbon cable
];*/

/*
BigTreeTech_TFT35_E3_V3_0 = ["BigTreeTech_TFT35_E3_V3_0", "BigTreeTech TFT35 E3 v3.0",
    85.65, 54.5, 4,                     // size
    BigTreeTech_TFT35_E3_V3_0_PCB,      // pcb
    [ 7.65 - 1.15 -(93.35 - 85.65)/2, 9.5 - (87-54.5)/2, 0], // pcb offset from center
    [[-85.65/2 + 4.5, -26.5], [85.65/2 - 1.15, 26.5, 0.5]],  // aperture
    [],                                 // touch screen position and size
    0,                                  // length that studs protrude from the PCB holes
    [],                                 // keep out region for ribbon cable
];
*/

/*
BTT_TFT35_V3_0 = ["BTT_TFT35_V3_0", "BigTreeTech TFT35 v3.0",
    85.5, 54.5, 4,                  // size, screen is 84.5 wide, extra 1mm added to allow clearance of ribbon cable at side
    BigTreeTech_TFT35v3_0_PCB,      // pcb
    [6.5 - (110 - 85.5)/2, 0, 0],   // pcb offset from center
//    [ [-85.5/2 + 7, -25.5], [85.5/2 - 3.5, 25.5, 0.5] ],  // aperture
    [ [-85.5/2 + 7, -25], [85.5/2 - 3.5, 25, 0.5] ],    // aperture
    [ [-85.5/2 + 7, -25], [85.5/2 - 3.5, 25, 0.25] ],   // touch screen position and size
    0,                                                  // length that studs protrude from the PCB holes
    [ [-85.5/2 -1, -54.5/2], [-85.5/2, 54.5/2, 0.5] ],  // keep out region for ribbon cable
];
*/
