use <NopSCADlib/vitamins/pcb.scad>

AS5048_PCB = [
    "AS5048", "AS5048",
    15.5, 16.8, 1.0, // size
    3.5, // corner radius
    2.1, // mounting hole diameter
    0, // pad around mounting hole, pad is actually 3.8, but unplated
    "green", // colour
    false, // true if parts should be separate BOM items
    [ // hole positions
        [-3.5/2, -7.5], [3.5/2, -7.5],
    ],
    [ // components
        [ 15.5/2, -7.5,   0, "chip", 5.2, 4.3, 1.0],
    ],
    [], // accessories
    [], // grid
];
