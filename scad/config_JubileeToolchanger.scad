_variant = "toolchanger";

__extrusionLengths = [350, 350, 400];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20;

_xyMotorDescriptor = "NEMA17_48";
_zMotorDescriptor = "NEMA17_40L280";

_xRailLength = eX - 50;
_yRailLength = eY;
_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";

_beltWidth = 6;

_printBedArmSeparation = 150;

__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
