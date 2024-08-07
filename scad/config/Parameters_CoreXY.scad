include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/utils/core_xy.scad>

include <../vitamins/pulleys.scad>
include <Parameters_Main.scad>


coreXY_GT2_20_F623 =["coreXY_20_F623", GT2x6, GT2x20ob_pulley,  GT2_F623_plain_idler, GT2_F623_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2_20_F694 =["coreXY_20_F694", GT2x6, GT2x20ob_pulley,  GT2_F694_plain_idler, GT2_F694_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2_20_F695 =["coreXY_20_F695", GT2x6, GT2x20ob_pulley,  GT2_F695_plain_idler, GT2_F695_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2_20_20_sf=["coreXY_20_20sf", GT2x6, GT2x20ob_pulley,  GT2x20x3_toothed_idler_sf, GT2x20x3_plain_idler_sf, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];
coreXY_GT2x9_20_20= ["coreXY_20_20x9", GT2x9, GT2x20x11_pulley, GT2x20x11x3_toothed_idler, GT2x20x11x3_plain_idler, [0, 0, 1], [0, 0, 0.5, 1], [0, 1, 0], [0, 0.5, 0, 1] ];

useXYDirectDrive = !is_undef(_useXYDirectDrive) && _useXYDirectDrive;
function useReversedBelts() = !is_undef(_useReversedBelts) && _useReversedBelts;
function use2060ForTopRear() = !is_undef(_use2060ForTopRear) && _use2060ForTopRear;
largePulleyOffset = _coreXYDescriptor == "GT2_20_F694" ? 0.5 : _coreXYDescriptor == "GT2_20_F695" ? 1.5 : 0;

function coreXY_type(coreXYDescriptor=_coreXYDescriptor) = coreXYDescriptor == "GT2_20_16" ? coreXY_GT2_20_16 :
                         coreXYDescriptor == "GT2_20_20" ? coreXY_GT2_20_20 :
                         coreXYDescriptor == "GT2_20_16_fb" ? coreXY_GT2_20_F623 : // flange bearing
                         coreXYDescriptor == "GT2_20_F623" ? coreXY_GT2_20_F623 :
                         coreXYDescriptor == "GT2_20_F694" ? coreXY_GT2_20_F694 :
                         coreXYDescriptor == "GT2_20_F695" ? coreXY_GT2_20_F695 :
                         coreXYDescriptor == "GT2_20_20_sf" ? coreXY_GT2_20_20_sf :
                         coreXYDescriptor == "GT2_20_20x9" ? coreXY_GT2x9_20_20 :
                         undef;
function coreXYBearing(coreXYDescriptor=_coreXYDescriptor) = coreXYDescriptor == "GT2_20_F623" ? BBF623 :
                         coreXYDescriptor == "GT2_20_F694" ? BBF694 :
                         coreXYDescriptor == "GT2_20_F695" ? BBF695 :
                         undef;

function coreXYIdlerBore(coreXYType=coreXY_type()) = pulley_bore(coreXY_toothed_idler(coreXYType));
function beltWidth(coreXYType=coreXY_type()) = belt_width(coreXY_belt(coreXYType));
function beltSeparation(coreXYType=coreXY_type()) = coreXYSeparation(coreXYType).z - beltWidth(coreXYType);
function coreXYWasher(coreXYType=coreXY_type()) = coreXYIdlerBore(coreXYType) == 3 ? M3_washer : coreXYIdlerBore(coreXYType) == 4 ? M4_shim : M5_shim;

function yRailSupportThickness() = 3;
function yRailShiftX() = 0; // limit it this to [-0.5, +1.25] avoid problems with yCarriage bolt interference
function yRailOffset() = [coreXYPosBL().x - coreXYSeparation().x + yRailShiftX(), _yRailLength/2 + eSize - (_yRailLength == eY ? eSize : 0), eZ - yRailSupportThickness()];

function yCarriageThickness() = 9;// allows 8mm high tongue to insert into 10mm square carbon fiber tube along X rail
function yCarriageBraceThickness() = 1; // brace to support cantilevered pulleys on yCarriage

// offset to midpoint between the two belts
function beltOffsetZ() = yCarriageThickness() - coreXYSeparation().z - 30.5;
//function beltOffsetZ() = yCarriageThickness() + carriage_height(MGN12H_carriage) + coreXYSeparation().z - 55;

function plainIdlerPulleyOffset() = useReversedBelts() ? [0, -19] : largePulleyOffset ? [3, -3] : [0, 0];

// use -12.75 for separation.x to make y-carriage idlers coincident vertically
function  coreXYSeparation(coreXYType=coreXY_type()) = [
    0,
    coreXY_coincident_separation(coreXYType).y, // make Y carriage pulleys coincident in Y
    // Z separation is a pulley with a washer either side and an optional brace for the yCarriage pulleys
    pulley_height(coreXY_plain_idler(coreXYType)) + 2*washer_thickness(coreXYWasher(coreXYType)) + yCarriageBraceThickness()
];
function coreXYOffsetY(coreXYType=coreXY_type()) = 0;

function motorClearance() = [0, 14];


function coreXYPosBL() = [
    useXYDirectDrive ? 2.5*eSize : 1.5*eSize + largePulleyOffset, // this aligns of the center of the pulley with the center of the Y rail
    eSize/2 + largePulleyOffset,
    // choose Z so the belts align with the Y_Carriage pulleys
    eZ - yCarriageThickness() - yCarriageBraceThickness()/2 - (beltWidth() == 6 ? 34 + pulley_height(coreXY_toothed_idler(coreXY_type())) : 35 + pulley_height(coreXY_toothed_idler(coreXY_type())))
];

function coreXYTROffsetY() = useReversedBelts() ? 4 : 0;
function coreXYPosTR(motorWidth) = [
    eX + 2*eSize - coreXYPosBL().x,
    eY + 2*eSize - motorWidth/2 - motorClearance().y + coreXYTROffsetY(),
    coreXYPosBL().z
];
