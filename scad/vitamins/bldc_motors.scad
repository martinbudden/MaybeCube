//
//  Brushless hDC electric motors
//
crimson = [220/255,20/255,60/255];
//                                     shaft  shaft  shaft      body   base             holes               base           side  bell             holes               boss  pshaft        thread
//                      diameter height diam length  offset   colour   diam   h1   h2   diam position       open  wire    colour diam   h1   h2   d  position spokes r  h  length diam   length  diam
BLDC0603  = ["BLDC0603",    9.0,  7.5,    1,  17.5,    0.5, crimson,    13,    1,    1, 1.6,[10,10,10],    true,  1.0, grey(20),   8,    1,    1, 0,  0,          3, 0, 0,   0,     0,     0,     0];
BLDC0802  = ["BLDC0802",   14.0,  9.5,    1,    12,    0.5, grey(20),   14,    1,    1, 2,  [10,10,10],    true,  1.0, grey(20),  14,    1,    1, 0,  0,          3, 0, 0,   0,     0,     0,     0];
BLDC1105  = ["BLDC1105",   14.0, 11.75, 1.5,    11,      0, grey(90),   12,    1,    1, 2,   9,            true,  1.0, grey(90),  12,    1,    1, 2, [5,5],       4, 0, 0,   0,     0,     0,     0];
BLDC1306  = ["BLDC1306",  17.75, 13,      2,    14,      0, crimson,    16,    1,    1, 2,  12,           false,  2.0, grey(20),  12,    1,    1, 0,  0,          6, 4, 1,   5,     6,     5,     6];
BLDC1804  = ["BLDC1804",   23.0, 12,      2,    11,      0, grey(20),   20,  2.5,    1, 2,  12,           false,  2.0, grey(20),  20,  2.5,    1, 0,  0,          6, 2, 1,   5,     6,     5,     6];
BLDC2205  = ["BLDC2205",   28.0, 18,      3,    17,      0, crimson,    26,    1,    3, 3,  [19,16,19,16],false,  3.0, grey(20),22.5, 3.75,    1, 0,  0,          6, 2, 1,   5,     5,     5,     5];
BLDC2212  = ["BLDC2212",   28.0, 28,      3,    27,      0, grey(20),   23,    4,    2, 3,  [19,16,19,16],false,  3.0, grey(20),  23,    4,    2, 0,  0,          6, 2, 1,   6,     7,     5,     7];
BLDC4250  = ["BLDC4250",   42.5, 48,      5,    70,     20, crimson,    30,    4,    6, 3,  25,           false,  4.0, grey(20),  30,    4,    6, 3, 17,          8, 6, 2,   0,     0,     0,     0];

bldc_motors = [BLDC0603, BLDC0802, BLDC1105, BLDC1306, BLDC1804, BLDC2205, BLDC2212, BLDC4250];
//bldc_motors = [BLDC0603, BLDC1105,BLDC1804,BLDC4250];
//bldc_motors = [BLDC2205];
use <bldc_motor.scad>
