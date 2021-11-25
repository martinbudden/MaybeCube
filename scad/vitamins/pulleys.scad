include <NOPScadlib/vitamins/belts.scad>
GT2x9 = ["GT", 2.0,  9, 1.38, 0.75, 0.254];

//                                                         n       t   o      b         w    h  h    b     f    f  s   s    s              s
//                                                         a       e   d      e         i    u  u    o     l    l  c   c    c              c
//                                                         m       e          l         d    b  b    r     a    a  r   r    r              r
//                                                         e       t          t         t            e     n    n  e   e    e              e
//                                                                 h                    h    d  l          g    g  w   w    w              w
//                                                                                                         e    e                          s
//                                                                                                                 l   z
//                                                                                                         d    t
//
GT2x25x7x3_toothed_idler  = ["GT2x25x7x3_toothed_idler",  "GT2",   25, 15.41, GT2x6,  7.0,  20, 0,   3, 20.0, 2.0, 0, 0,    false,         0];
GT2x25x7x3_plain_idler    = ["GT2x25x7x3_plain_idler",    "GT2",    0, 15.4,  GT2x6,  7.0,  20, 0,   3, 20.0, 2.0, 0, 0,    false,         0];
GT2x25x11x5_toothed_idler = ["GT2x25x11x5_toothed_idler", "GT2",   25, 15.41, GT2x9, 11.0,  20, 0,   5, 20.0, 2.0, 0, 0,    false,         0];
GT2x25x11x5_plain_idler   = ["GT2x25x11x5_plain_idler",   "GT2",    0, 15.4,  GT2x9, 11.0,  20, 0,   5, 20.0, 2.0, 0, 0,    false,         0];
GT2x20x11_pulley          = ["GT2x20x11_pulley",          "GT2",   20, 12.22, GT2x9, 11.0,  15, 7.5, 5, 15.0, 1.5, 6, 3.25, M3_grub_screw, 2]; //Openbuilds
GT2x20x11x5_toothed_idler = ["GT2x20x11x5_toothed_idler", "GT2",   20, 12.22, GT2x9, 11.0,  16, 0,   5, 16.0, 1.5, 0, 0,    false,         0];
GT2x20x11x5_plain_idler   = ["GT2x20x11x5_plain_idler",   "GT2",    0, 12.0,  GT2x9, 11.0,  16, 0,   5, 16.0, 1.5, 0, 0,    false,         0];
GT2x20x3_toothed_idler_sf = ["GT2x20x3_toothed_idler_sf", "GT2",   20, 12.22, GT2x6,  6.5,  18, 0,   3, 13.5, 1.0, 0, 0,    false,         0];
GT2x20x3_plain_idler_sf   = ["GT2x20x3_plain_idler_sf",   "GT2",    0, 12.0,  GT2x6,  6.5,  18, 0,   3, 13.5, 1.0, 0, 0,    false,         0];
