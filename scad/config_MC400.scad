_variant = "MC400";

__extrusionLengths = [400, 400, 450];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

_xyNemaType = "17_40";
_zNemaType = "17_40L330";
_corkDamperThickness = 3;

_xRailLength = eX - 50;
_yRailLength = eY;
_xCarriageType = "12H";
_yCarriageType = "12H";

_beltWidth = 6;

_printBedSize = 310;
_printBedArmSeparation = 225;
_printBed4PointSupport = true;

_blower_type = 40;

_useDualZRods = true;

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 70; //!!TODO check this
