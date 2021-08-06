_variant = "EVA";

__extrusionLengths = [250, 250, 400];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20;

_xyMotorDescriptor = "NEMA17_48";

_xRailLength = eX - 50;
_yRailLength = eY;
_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";

_beltWidth = 6;

__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
