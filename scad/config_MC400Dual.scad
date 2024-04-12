_variant = "MC400Dual";

__extrusionLengths = [400, 400, 500];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_xyMotorDescriptor = "NEMA17_40";
_zMotorDescriptor = "NEMA17_40L380";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRodLength = eZ - 100;

_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";


_coreXYDescriptor = "GT2_20_F694";

_use2060ForTop = true;
_use2060ForTopRear = true;
_useBowdenExtruder = false;
_useDualZRods = true;
_useDualZMotors = true;
_useElectronicsInBase = true;
_useFrontDisplay = true;
_useRB40 = true;
_useReversedBelts = true;
_useSidePanels = true;

_printbedSize = [310, 310, 3]; // CR-10 size
_printbedArmSeparation = 225;
_printbed4PointSupport = true;

_blowerDescriptor = "BL40x10";

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 70; //!!TODO check this
_zLeadScrewOffset = 23;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = eZ - 95;
