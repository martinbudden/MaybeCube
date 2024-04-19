_variant = "MC250";

__extrusionLengths = [250, 250, 350];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_xyMotorDescriptor = "NEMA17_40";
_zMotorDescriptor = "NEMA17_40L200";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRodLength = eZ - 100;

_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";


_coreXYDescriptor = "GT2_20_F623";

_hotendDescriptor = "E3DV6";

_use2060ForTop = false;
_use2060ForTopRear = false;
_useBowdenExtruder = true;
_useDualZRods = false;
_useDualZMotors = false;
_useElectronicsInBase = true;
_useFrontDisplay = false;
_useRB40 = true;
_useReversedBelts = true;
_useSidePanels = true;

_printbedSize = [180, 180, 3];
_printbedArmSeparation = 150;
_printbed4PointSupport = false;

_blowerDescriptor = "BL30x10";

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
_zLeadScrewOffset = 23;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = eZ - 95;
