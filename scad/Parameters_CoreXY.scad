include <NopSCADlib/core.scad>
include <NopSCADlib/utils/core_xy.scad>
include <NopSCADlib/vitamins/washers.scad>
include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/rails.scad>

include <Parameters_Main.scad>


GT2x9 = ["GT", 2.0,  9, 1.38, 0.75, 0.254];
GT2x16x11_toothed_idler = ["GT2x16_toothed_idler", "GT2",   16,  9.75, GT2x9, 11.0,  14, 0,   3, 14.0, 1.0, 0, 0,    false,         0];
GT2x16x11_plain_idler =   ["GT2x16x7_plain_idler", "GT2",    0,  9.63, GT2x9, 11.0,  13, 0,   3, 13.0, 1.0, 0, 0,    false,         0];

coreXY_GT2x9_20_16=["coreXY_20_16", GT2x9, GT2x20ob_pulley, GT2x16x11_toothed_idler, GT2x16x11_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];

function coreXY_type() = _beltWidth == 6 ? coreXY_GT2_20_16 : coreXY_GT2x9_20_16;


function yRailSupportThickness() = 3;
function yRailShiftX() = 0; // limit it this to [-0.5, +1.25] avoid problems with yCarriage bolt interference
function yRailOffset() = [coreXYPosBL().x - coreXYSeparation().x + yRailShiftX(), _yRailLength/2 + eSize - (_yRailLength == eY ? eSize : 0), eZ - yRailSupportThickness()];

function yCarriageThickness() = 9;// allows 8mm high tongue to insert into 10mm square carbon fiber tube along X rail
function yCarriageBraceThickness() = 1; // brace to support cantilevered pulleys on yCarriage

// offset to midpoint between the two belts
function beltOffsetZ() = yCarriageThickness() - coreXYSeparation().z - 30.5;
//function beltOffsetZ() = yCarriageThickness() + carriage_height(MGN12H_carriage) + coreXYSeparation().z - 55;

function leftDrivePulleyOffset() = [!is_undef(_useMotorIdler20) && _useMotorIdler20 ? 38 : 34, 0];
function rightDrivePulleyOffset() = [-42.5, 0]; // need to give clearance to extruder motor
//function leftDrivePulleyOffset() = [!is_undef(_useMotorIdler20) && _useMotorIdler20 ? 38 : eX >= 300 ? 34 : 30, 0];
//function lowerDrivePulleyOffset() = [eX >= 300 ? -40 : -31, 0]; // need to give clearance to extruder motor


// use -12.75 for separation.x to make y-carriage idlers coincident vertically
function  coreXYSeparation() = [
    0,
    coreXY_coincident_separation( coreXY_type() ).y, // make Y carriage pulleys coincident in Y
    // Z separation is a pulley with a washer either side and an optional brace for the yCarriage pulleys
    pulley_height(coreXY_toothed_idler( coreXY_type() )) + 2*washer_thickness(M3_washer) + yCarriageBraceThickness()
];


function motorClearance() = [0, 14];


function coreXYPosBL() = [
    1.5*eSize, // this lines of the center of the pulley with the center of the Y rail
    eSize/2,
    // choose Z so the belts align with the Y_Carriage pulleys
    eZ - yCarriageThickness() - yCarriageBraceThickness()/2  - (_beltWidth == 6 ? 42.5 : 42.5 + 4.5)
];

function coreXYPosTR(NEMA_width) = [
    eX + 2*eSize - coreXYPosBL().x,
    eY + 2*eSize - NEMA_width/2 - motorClearance().y,
    coreXYPosBL().z
];
