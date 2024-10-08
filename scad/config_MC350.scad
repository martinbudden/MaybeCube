_variant = "MC350";

__extrusionLengths = [350, 350, 450];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_xyMotorDescriptor = "NEMA17_48";
_zMotorDescriptor = "NEMA17_40L300";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRodLength = eZ - 100;

_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";


_coreXYDescriptor = "GT2_20_F694";

_hotendDescriptor = "OrbiterV3";

_use2060ForTop = false;
_use2060ForTopRear = true;
_useDualZRods = false;
_useDualZMotors = false;
_useElectronicsInBase = true;
_useFrontDisplay = false;
_useRB40 = true;
_useReversedBelts = true;
_useSidePanels = true;

//_printbedSize = [235, 235, 4]; // Ender 3 size
//_printbedArmSeparation = 150;
//_printbed4PointSupport = true;
_printbedSize = [254, 254, 8]; // Voron Trident 250x250 size
_printbedArmSeparation = 185;
_printbed4PointSupport = false;

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
//_zRodOffsetY = __skBracketWidth/2 + 40; // for Ender 3 size print bed
_zRodOffsetY = __skBracketWidth/2 + 100; // for Voron Trident 250x250 size print bed
_zLeadScrewOffset = 23;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = eZ - 95;
