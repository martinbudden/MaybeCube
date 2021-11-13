include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/utils/core_xy.scad>

include <Parameters_Main.scad>


GT2x9 = ["GT", 2.0,  9, 1.38, 0.75, 0.254];
GT2x20x11_pulley        = ["GT2x20x11_pulley",        "GT2",   20, 12.22, GT2x9, 11.0,  15, 7.5, 5, 15.0, 1.5, 6, 3.25, M3_grub_screw, 2]; //Openbuilds
GT2x20x11_toothed_idler = ["GT2x20x11_toothed_idler", "GT2",   20, 12.22, GT2x9, 11.0,  16, 0,   5, 16.0, 1.5, 0, 0,    false,         0];
GT2x20x11_plain_idler   = ["GT2x20x11_plain_idler",   "GT2",    0, 12.0,  GT2x9, 11.0,  16, 0,   5, 16.0, 1.5, 0, 0,    false,         0];
GT2x20_toothed_idler_sf = ["GT2x20_toothed_idler_sf", "GT2",   20, 12.22, GT2x6,  6.5,  18, 0,   3, 13.5, 1.0, 0, 0,    false,         0];
GT2x20_plain_idler_sf   = ["GT2x20_plain_idler_sf",   "GT2",    0, 12.0,  GT2x6,  6.5,  18, 0,   3, 13.5, 1.0, 0, 0,    false,         0];

coreXY_GT2_20_20_sf=["coreXY_20_20sf", GT2x6, GT2x20ob_pulley, GT2x20_toothed_idler_sf, GT2x20_plain_idler_sf, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2x9_20_20= ["coreXY_20_20x9", GT2x9, GT2x20x11_pulley, GT2x20x11_toothed_idler, GT2x20x11_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
useXYDirectDrive = !is_undef(_useXYDirectDrive) && _useXYDirectDrive;

function coreXY_type() = _coreXYDescriptor == "GT2_20_16" ? coreXY_GT2_20_16 : _coreXYDescriptor == "GT2_20_20" ? coreXY_GT2_20_20 :  _coreXYDescriptor == "GT2_20_20_sf" ? coreXY_GT2_20_20_sf : coreXY_GT2x9_20_20;
function coreXYIdlerBore() = pulley_bore(coreXY_toothed_idler(coreXY_type()));
function beltWidth() = _coreXYDescriptor == "coreXY_GT2x9_20_20" ? 9 : 6;

function yRailSupportThickness() = 3;
function yRailShiftX() = 0; // limit it this to [-0.5, +1.25] avoid problems with yCarriage bolt interference
function yRailOffset() = [coreXYPosBL().x - coreXYSeparation().x + yRailShiftX(), _yRailLength/2 + eSize - (_yRailLength == eY ? eSize : 0), eZ - yRailSupportThickness()];

function yCarriageThickness() = 9;// allows 8mm high tongue to insert into 10mm square carbon fiber tube along X rail
function yCarriageBraceThickness() = 1; // brace to support cantilevered pulleys on yCarriage

// offset to midpoint between the two belts
function beltOffsetZ() = yCarriageThickness() - coreXYSeparation().z - 30.5;
//function beltOffsetZ() = yCarriageThickness() + carriage_height(MGN12H_carriage) + coreXYSeparation().z - 55;

function leftDrivePulleyOffset() = [useXYDirectDrive ? 0 : 38, 0];
function rightDrivePulleyOffset() = [useXYDirectDrive ? 0 : (eX >= 350 ? -38 : -42.5), 0]; // need to give clearance to extruder motor


// use -12.75 for separation.x to make y-carriage idlers coincident vertically
function  coreXYSeparation() = [
    0,
    coreXY_coincident_separation( coreXY_type() ).y, // make Y carriage pulleys coincident in Y
    // Z separation is a pulley with a washer either side and an optional brace for the yCarriage pulleys
    pulley_height(coreXY_toothed_idler( coreXY_type() )) + 2*washer_thickness(coreXYIdlerBore() == 3 ? M3_washer : coreXYIdlerBore() == 4 ? M4_washer : M5_washer) + yCarriageBraceThickness()
];


function motorClearance() = [0, 14];


function coreXYPosBL() = [
    useXYDirectDrive ? 2.5*eSize : 1.5*eSize, // this aligns of the center of the pulley with the center of the Y rail
    eSize/2,
    // choose Z so the belts align with the Y_Carriage pulleys
    eZ - yCarriageThickness() - yCarriageBraceThickness()/2  - (beltWidth() == 6 ? 42.5 : 42.5 + pulley_height(coreXY_toothed_idler(coreXY_type())) - 7.5)
];

function coreXYPosTR(motorWidth) = [
    eX + 2*eSize - coreXYPosBL().x,
    eY + 2*eSize - motorWidth/2 - motorClearance().y,
    coreXYPosBL().z
];
