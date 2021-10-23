_variant = "JubileeKinematicBed";

__extrusionLengths = [400, 400, 400];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20;

_xyMotorDescriptor = "NEMA17_48";
_zMotorDescriptor = "NEMA17_40L280";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRailLength = eZ - 100;
_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";
_zCarriageDescriptor = "MGN12H";

_beltWidth = 6;

_printBedSize = 300;
_printBedArmSeparation = 330;
_printBedKinematic = true;

__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
