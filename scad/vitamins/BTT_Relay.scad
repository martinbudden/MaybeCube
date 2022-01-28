use <NopSCADlib/vitamins/pcb.scad>
use <NopSCADlib/vitamins/psu.scad>

/*
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
        //[ -14.5,  18.15,   0, "block", 16,  30,    17.0, grey(25) ],
        //[ -14.5,  18.15,   0, "block", 15,  25.5,  17.1, "PaleGoldenrod" ],
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

btt_relay_v1_2_terminals = [10, 1.33, 13.2, 16, 7, 13];

module btt_relay_v1_2_pcb() {
    pcb(BTT_RELAY_V1_2);

    pcbSize = pcb_size(BTT_RELAY_V1_2);
    terminalType = btt_relay_v1_2_terminals;
    ways = 3;
    translate([pcbSize.x/2 - 6.5, -terminal_block_length(terminalType, ways)/2, pcbSize.z])
        rotate(180)
            terminal_block(terminalType, ways);
}
*/

module BTT_Relay_Base_stl() {
    pcbSize = pcb_size(BTT_RELAY_V1_2);
    size = [pcbSize.x + 2, pcbSize.y + 2, 3];

    stl("BTT_Relay_Base")
        translate_z(-size.z)
            difference() {
                rounded_cube_xy(size, 1, xy_center=true);
                pcb_hole_positions(BTT_RELAY_V1_2)
                    boltHoleM3(size.z);
            }
}
