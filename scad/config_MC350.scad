_variant = "MC350";

__extrusionLengths = [350, 350, 450];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_xyMotorDescriptor = "NEMA17_48";
_zMotorDescriptor = "NEMA17_40L330";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRodLength = eZ - 100;

_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";


_coreXYDescriptor = "GT2_20_16_fb";

_use2060ForTop = true;
_use2060ForTopRear = false;
_useDualZRods = false;
_useDualZMotors = false;
_useElectronicsInBase = true;
_useFrontDisplay = true;
_useRB40 = true;
_useReversedBelts = true;
_useSidePanels = true;

_printbedSize = [235, 235, 4]; // Ender 3 size
_printbedArmSeparation = 150;
_printbed4PointSupport = true;

_blowerDescriptor = "BL30x10";

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
_zLeadScrewOffset = 23;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = eZ - 95;
