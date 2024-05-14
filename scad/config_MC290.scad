_variant = "MC290";

__extrusionLengths = [290, 340, 320];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_xyMotorDescriptor = "NEMA17_40";
_zMotorDescriptor = "NEMA17_40L230";
_corkDamperThickness = 2;

_xRailLength = 250;
_yRailLength = 300;
_zRodLength = 240;

_xCarriageDescriptor = "MGN9H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";


_coreXYDescriptor = "GT2_20_16";

_hotendDescriptor = "E3DV6";

_useBackMounts = true;
_useBowdenExtruder = true;
_useDualZRods = false;
_useDualZMotors = false;
_useFrontDisplay = false;
_useSidePanels = false;

_printbedSize = [214, 214, 4];
_printbedArmSeparation = 188;
_printbed4PointSupport = false;

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
_zLeadScrewOffset = 23;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = eZ - 95;
