include <NopSCADlib/utils/core/core.scad>

// NIUGUY CB-500W-24V
ng_terminals = [9.525, 1.5, 15, 17.8, 7, 15]; // pitch, divider width, divider height, total depth, height under contacts, depth of contact well

function NIUGUY_CB_PSU(id, name, s /*size*/, terminals, ways_dc=4, ways_ac=3, c=10/*corner*/) =
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
NG_CB_500W_24V = NIUGUY_CB_PSU("NG_CB_500W_24V", "NIUGUY NG-CB-500W-24V", [238, 50, 22], ng_terminals);
