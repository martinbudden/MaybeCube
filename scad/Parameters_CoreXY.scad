include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/utils/core_xy.scad>

include <vitamins/pulleys.scad>
include <Parameters_Main.scad>


coreXY_GT2_20_16_fb=["coreXY_20_20fb", GT2x6, GT2x20ob_pulley,  GT2x16x6p5x3_plain_idler_fb, GT2x16x6p5x3_plain_idler_fb, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2_20_20_sf=["coreXY_20_20sf", GT2x6, GT2x20ob_pulley,  GT2x20x3_toothed_idler_sf, GT2x20x3_plain_idler_sf, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2_20_25   =["coreXY_20_25",   GT2x6, GT2x20ob_pulley,  GT2x25x7x3_toothed_idler, GT2x25x7x3_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2x9_20_20= ["coreXY_20_20x9", GT2x9, GT2x20x11_pulley, GT2x20x11x3_toothed_idler, GT2x20x11x3_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2x9_20_25= ["coreXY_20_25x9", GT2x9, GT2x20x11_pulley, GT2x25x11x3_toothed_idler, GT2x25x11x3_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];

useXYDirectDrive = !is_undef(_useXYDirectDrive) && _useXYDirectDrive;
function useReversedBelts() = !is_undef(_useReversedBelts) && _useReversedBelts;
function use2060ForTopRear() = !is_undef(_use2060ForTopRear) && _use2060ForTopRear;
function usePulley25() = _coreXYDescriptor == "GT2_20_25" || _coreXYDescriptor == "GT2_20_25x9";
pulley25Offset = usePulley25() ? 2.6 : 0;
largePulleyOffset = usePulley25() ? 3 : 0;
largePulleyOffsetTop = usePulley25() ? 5.5 : 0;

function coreXY_type(coreXYDescriptor=_coreXYDescriptor) = coreXYDescriptor == "GT2_20_16" ? coreXY_GT2_20_16 :
                         coreXYDescriptor == "GT2_20_20" ? coreXY_GT2_20_20 :
                         coreXYDescriptor == "GT2_20_16_fb" ? coreXY_GT2_20_16_fb :
                         coreXYDescriptor == "GT2_20_20_sf" ? coreXY_GT2_20_20_sf :
                         coreXYDescriptor == "GT2_20_25" ? coreXY_GT2_20_25 :
                         coreXYDescriptor == "GT2_20_20x9" ? coreXY_GT2x9_20_20 :
                         coreXY_GT2x9_20_25;

function coreXYIdlerBore(coreXYType=coreXY_type()) = pulley_bore(coreXY_toothed_idler(coreXYType));
function beltWidth(coreXYType=coreXY_type()) = belt_width(coreXY_belt(coreXYType));
function beltSeparation(coreXYType=coreXY_type()) = coreXYSeparation(coreXYType).z - beltWidth(coreXYType);
function coreXYWasher(coreXYType=coreXY_type()) = coreXYIdlerBore(coreXYType) == 3 ? M3_washer : coreXYIdlerBore(coreXYType) == 4 ? M4_washer : M5_washer;

function yRailSupportThickness() = 3;
function yRailShiftX() = 0; // limit it this to [-0.5, +1.25] avoid problems with yCarriage bolt interference
function yRailOffset() = [coreXYPosBL().x - coreXYSeparation().x + yRailShiftX(), _yRailLength/2 + eSize - (_yRailLength == eY ? eSize : 0), eZ - yRailSupportThickness()];

function yCarriageThickness() = 9;// allows 8mm high tongue to insert into 10mm square carbon fiber tube along X rail
function yCarriageBraceThickness() = 1; // brace to support cantilevered pulleys on yCarriage

// offset to midpoint between the two belts
function beltOffsetZ() = yCarriageThickness() - coreXYSeparation().z - 30.5;
//function beltOffsetZ() = yCarriageThickness() + carriage_height(MGN12H_carriage) + coreXYSeparation().z - 55;

function leftDrivePulleyOffset() = useReversedBelts() ? [30, use2060ForTopRear()? -10 : -6] : [useXYDirectDrive ? 0 : 38 + 3*largePulleyOffset, -largePulleyOffsetTop];
function rightDrivePulleyOffset() = [useXYDirectDrive ? 0 : -42.5 - 3*largePulleyOffset, useReversedBelts() ? (use2060ForTopRear()? -10 : -6) : -largePulleyOffsetTop]; // need to give clearance to extruder motor
function plainIdlerPulleyOffset() = useReversedBelts() ? [0, -20] : largePulleyOffset ? [3, -3] : [0, 0];

// use -12.75 for separation.x to make y-carriage idlers coincident vertically
function  coreXYSeparation(coreXYType=coreXY_type()) = [
    0,
    coreXY_coincident_separation(coreXYType).y, // make Y carriage pulleys coincident in Y
    // Z separation is a pulley with a washer either side and an optional brace for the yCarriage pulleys
    pulley_height(coreXY_plain_idler(coreXYType)) + 2*washer_thickness(coreXYWasher(coreXYType)) + yCarriageBraceThickness()
];


function motorClearance() = [0, 14];


function coreXYPosBL() = [
    useXYDirectDrive ? 2.5*eSize : 1.5*eSize + largePulleyOffset, // this aligns of the center of the pulley with the center of the Y rail
    eSize/2 + largePulleyOffset,
    // choose Z so the belts align with the Y_Carriage pulleys
    eZ - yCarriageThickness() - yCarriageBraceThickness()/2 - (beltWidth() == 6 ? 34 + pulley_height(coreXY_toothed_idler(coreXY_type())) : 35 + pulley_height(coreXY_toothed_idler(coreXY_type())))
];

function coreXYPosTR(motorWidth) = [
    eX + 2*eSize - coreXYPosBL().x,
    eY + 2*eSize - motorWidth/2 - motorClearance().y + largePulleyOffsetTop + (useReversedBelts() ? 6 : 0),
    coreXYPosBL().z
];
