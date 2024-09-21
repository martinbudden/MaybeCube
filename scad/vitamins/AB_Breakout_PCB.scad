include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/vitamins/pcb.scad>
use <NopSCADlib/vitamins/pin_header.scad>


// Imported from https://github.com/MotorDynamicsLab/LDO-Voron-Hardware/tree/master/Afterburner%20Breakout%20PCB
// See also https://docs.ldomotors.com/en/voron/toolhead_harness

LDO_TOOLHEAD_BREAKOUT_V1_1 = [
    "LDO_TOOLHEAD_BREAKOUT_V1_1", "LDO Toolhead Breakout PCB v1.1",
    39.37, 47.1, 1.0, // size
    0, // corner radius
    2.8, // mounting hole diameter
    0, // pad around mounting hole
    grey(15), // color
    false, // true if parts should be separate BOM items
    [ // hole positions
        [2.15, 2.3], [-2.15, 2.15], [2.3, -2.4], [-2.3, -2.5]
    ],
    [ // components
        [  3,    17.25, 270, "jst_xh", 2, false, grey(90), ],
        [  3,    27.75, 270, "jst_xh", 4, false, grey(90), ],
        [ 11,    17.75, 270, "jst_xh", 2, false, grey(90), ],
        [ 11,    26.75, 270, "jst_xh", 3, false, grey(90), ],
        [ 18.9,  18,    270, "jst_xh", 2, false, grey(90), ],
        [ 18.9,  28,    270, "jst_xh", 2, false, grey(90), ],
        [ 26.6,  5,     270, "jst_xh", 2, false, grey(90), ],
        [ 26.6,  12.75, 270, "jst_xh", 2, false, grey(90), ],
        [ 26.6,  20.5,  270, "jst_xh", 2, false, grey(90), ],
        [ 26.6,  28.25, 270, "jst_xh", 2, false, grey(90), ],
        [ 34,    15.5,  270, "jst_xh", 2, false, grey(90), ],
        [ 34,    25.5,  270, "jst_xh", 4, false, grey(90), ],
    ],
    [], // accessories
    [], // grid
];

//Molex Microfit 3.0, 43045
Microfit3  = ["Microfit3",   3, 11.6, 3.2, 0.66, silver,   grey(30), 7.6, [0,   0,    8.7], 2.4, 0,     0,    0  ];

function ABBreakoutPCBSize() = pcb_size(LDO_TOOLHEAD_BREAKOUT_V1_1);

module breakoutPCBHolePositions(z=0) {
    for (x = [2.3, 37.3], y = [2.4, 44.9])
        translate([x, y, z])
            children();
}

module ABBreakoutPCB() {
    vitamin(str("ABBreakooutPCB3() : Afterburner Breakout PCB"));
    pcbSize = pcb_size(LDO_TOOLHEAD_BREAKOUT_V1_1);
    translate([pcbSize.x/2, pcbSize.y/2, 0]) {
        pcb(LDO_TOOLHEAD_BREAKOUT_V1_1);
        translate([0.8, 13, 1.5])
            rotate(180)
                not_on_bom()
                    pin_socket(Microfit3, 7, 2, right_angle=true);
    }
    /*color([.3,.3,.3])
        translate([0, ABBreakoutPCBSize().y, ABBreakoutPCBSize().z/2])
            rotate(-90)
                import(str("../stlimport/AB Breakout PCB V1.1.dxf"));*/
}
