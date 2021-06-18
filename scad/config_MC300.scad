_variant = "MC300";

__extrusionLengths = [300, 300, 400];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

_xyMotorDescriptor = "NEMA17_40";
_zMotorDescriptor = "NEMA17_40L280";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";

_beltWidth = 6;

_useDualZRods = false;
_printBedSize = 214;
_printBedArmSeparation = 188;
_printBed4PointSupport = !true;

_blowerDescriptor = "BL30x10";

//_useMotorIdler20 = true;

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 50;
