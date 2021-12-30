include <NopSCADlib/core.scad>

// NIUGUY CB-500W
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

NG_CB_500W = NIUGUY_CB_PSU("NG_CB_500W", "NG-CB-500W", [238, 50, 22], ng_terminals);
