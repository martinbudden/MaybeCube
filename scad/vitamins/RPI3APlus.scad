RPI3APlus =  [
    "RPI3APlus", "Raspberry Pi 3A+",
    65, 56, 1.4, //size
    3, // corner radius
    2.75, // mounting hole diameter
    6, // pad around mounting hole
    "green", //colour
    false, // true if parts should be separate BOM items
    [ // hole positions
        [3.5, 3.5], [-3.5, 3.5], [-3.5, -3.5], [3.5, -3.5]
    ],
    [ // components
        [ 32.5,  -3.5,   0, "2p54header", 20, 2],
        [ 27,   -24.6,   0, "chip",       14, 14, 1],
        [ -6.5,  29,     0, "usb_A"],
        [ 53.5,   6,   -90, "jack"],
        [ 32,     4.4, -90, "hdmi"],
        [ 10.6,   2,   -90, "usb_uA"],
        [  3.6,  28,    90, "flex"],
        [ 45,    11.5, -90, "flex"],
        [  7.75, 28,   180, "-uSD", [12, 11.5, 1.28]],
    ],
    [": Micro SD card"], // accessories
    [32.5 - 9.5 * 2.54, 52.5 - 0.5 * 2.54, 20, 2], // grid
];
