include <NopSCADlib/utils/core/core.scad>
//include <NopSCADlib/vitamins/psus.scad>

UT_48V3A150WUT = [
    "UT_48V3A150W",
    "UT_48V3A150W",// part name
    129, 97, 30,// length, width, height
    M3_pan_screw, M3_clearance_radius,// screw type and clearance
    false,// true if ATX style
    11,// terminals bay depth
    4.5,// heatsink bay depth
    [// terminals
        7, // count
        11, // y offset
        mw_terminals
    ],
    false,// pcb
    // faces
    [// parameters are: holes, thickness, cutouts, grill, fans, iec, switch, vents, panel cutout
        [// f_bottom, bottom
            [[82.5, -40], [82.5, 40], [-37.5, -40], [-37.5, 40]], // holes
            1.5, // thickness
            [] // cutouts
        ],
        [// f_top, top
            [], // holes
            0.5, // thickness
            [], // cutouts
            true // grill
        ],
        [// f_left, front (terminals) after rotation
            [], // holes
            0.5, // thickness
            [[[-49, -19], [-49, -11.5], [-40, -11.5], [-40, 5], [47.5, 5], [47.5, -19]]] // cutouts
        ],
        [// f_right, back after rotation
            [], // holes
            1.5, // thickness
            [[[-49, -19], [-49, -6], [37.5, -6], [37.5, -12.5], [49, -12.5], [49, -19]]] // cutouts
        ],
        [// f_front, right after rotation
            [[-77.5, 1], [79.5, 9.5], [79.5, -9.5]], // holes
            1.5, // thickness
            [] // cutouts
        ],
        [// f_back, left after rotation
            [], // holes
            0.5, // thickness
            [], // cutouts
            true // grill
        ]
    ],
    [] // accessories for BOM
];


/*
// NIUGUY CB-500W-24V
ng_terminals = [9.525, 1.5, 15, 17.8, 7, 15]; // pitch, divider width, divider height, total depth, height under contacts, depth of contact well

    [id, name, // Name
    s.x, s.y, s.z, // Size
    M3_pan_screw, M3_clearance_radius, // Screw type and clearance hole
    false, // true if ATX
    0, 0, // left and right bays
    //CHANGE TO THIS ONCE NEW PSUs in NopSCADlib: [ways_dc, [5, (s.y - terminal_block_length(terminals, ways_dc))/2], terminals, ways_ac, [5, (s.y - terminal_block_length(terminals, ways_ac))/2], terminals], // terminals, count and offset
    [ways_dc, 5, terminals],
    [ // parameters are: holes, thickness, cutouts, grill, fans, iec, switch, vents, panel cutout
        // bottom
        //CHANGE TO THIS ONCE NEW PSUs in NopSCADlib: [ [[s.x/2 - 4, -s.y/2 + 5, [5, 0]], [-s.x/2 + 4, s.y/2 - 5, [-5, 0] ], ], 1.5, [] ], // two slots cutout for screws
        [ [[s.x/2 - 4, -s.y/2 + 5], [-s.x/2 + 4, s.y/2 - 5], ], 1.5, [] ], // two slots cutout for screws
        // top
        [ [], 0.5,  [
                        [ [-s.x/2+20,-s.y/2], [-s.x/2+20,s.y/2], [-s.x/2,s.y/2], [-s.x/2,-s.y/2] ],
                        [ [ s.x/2-20,-s.y/2], [ s.x/2-20,s.y/2], [ s.x/2,s.y/2], [ s.x/2,-s.y/2] ]
                    ], [5.5, 1.5, 6, [50, 30, 6, 6], []] ], // grill
        // left
        [ [], 2.5,  [
                        [ [s.y/2, s.z/2], [s.y/2, -s.z/2+3], [-s.y/2, -s.z/2+3], [-s.y/2, s.z/2] ], // +3 is for placement of pcb
                        [ [s.y/2, s.z/2], [s.y/2, -s.z/2], [-s.y/2, -s.z/2], [-s.y/2, s.z/2] ],
                    ] ],
        // right
        [ [], 1.5,  [
                        [ [-s.y/2, -s.z/2], [s.y/2, -s.z/2], [s.y/2, s.z/2], [-s.y/2,s.z/2] ],
                    ] ],
        // front
        [ [], 1.5,  [
                        [ [-s.x/2,s.z/2-c], [-s.x/2,s.z/2], [-s.x/2+c,s.z/2] ],
                        [ [ s.x/2,s.z/2-c], [ s.x/2,s.z/2], [ s.x/2-c,s.z/2] ]
                    ], [4.5, 1.5, 6, [15, 15, 4, 8], []] ], // grill
        // back
        [ [], 0.5,  [
                        [ [-s.x/2,-s.z/2+c], [-s.x/2,-s.z/2], [-s.x/2+c,-s.z/2] ],
                        [ [ s.x/2,-s.z/2+c], [ s.x/2,-s.z/2], [ s.x/2-c,-s.z/2] ]
                    ] ],
    ],
    [] // accessories for BOM
];
*/
/*
// Lincoiah, XnBaDa
MN_60W_24V     = NIUGUY_CB_PSU("MN_60W24V",   "MN-60W24V",   [146, 53, 21], ng_terminals);
MN_100W_24V    = NIUGUY_CB_PSU("MN_100W24V",  "MN-100W24V",  [175, 53, 21], ng_terminals);
MN_150W_24V    = NIUGUY_CB_PSU("MN_150W24V",  "MN-150W24V",  [235, 53, 21], ng_terminals);
MN_200W_24V    = NIUGUY_CB_PSU("MN_200W24V",  "MN-200W24V",  [308, 53, 21], ng_terminals);
MN_300W_24V    = NIUGUY_CB_PSU("MN_300W24V",  "MN-300W24V",  [308, 53, 21], ng_terminals);
MN_400W_24V    = NIUGUY_CB_PSU("MN_400W24V",  "MN-400W24V",  [334, 53, 21], ng_terminals);
MN_500W_24V    = NIUGUY_CB_PSU("MN_500W24V",  "MN-500W24V",  [370, 53, 21], ng_terminals);
*/

// NIUGUY
//NG_CB_36W_24V  = NIUGUY_CB_PSU("NG_CB_36W_24V",  "NIUGUY NG-CB-36W-24V",  [117, 35, 22], ng_terminals);
//NG_CB_60W_24V  = NIUGUY_CB_PSU("NG_CB_60W_24V",  "NIUGUY NG-CB-60W-24V",  [142, 35, 22], ng_terminals);
//NG_CB_100W_24V = NIUGUY_CB_PSU("NG_CB_100W_24V", "NIUGUY NG-CB-100W-24V", [138, 50, 22], ng_terminals);
//NG_CB_150W_24V = NIUGUY_CB_PSU("NG_CB_150W_24V", "NIUGUY NG-CB-150W-24V", [138, 50, 22], ng_terminals);
//NG_CB_200W_24V = NIUGUY_CB_PSU("NG_CB_200W_24V", "NIUGUY NG-CB-200W-24V", [178, 50, 22], ng_terminals);
//NG_CB_300W_24V = NIUGUY_CB_PSU("NG_CB_200W_24V", "NIUGUY NG-CB-200W-24V", [205, 50, 22], ng_terminals);
//NG_CB_400W_24V = NIUGUY_CB_PSU("NG_CB_200W_24V", "NIUGUY NG-CB-200W-24V", [238, 50, 22], ng_terminals);
//NG_CB_500W_24V = NIUGUY_CB_PSU("NG_CB_500W_24V", "NIUGUY NG-CB-500W-24V", [238, 50, 22], ng_terminals);
