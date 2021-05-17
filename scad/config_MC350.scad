_variant = "MC350";

__extrusionLengths = [350, 350, 400];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

_xyNemaType = "17_48";
_zNemaType = "17_40L280";
_corkDamperThickness = 3;

_xRailLength = eX - 50;
_yRailLength = eY;
_xCarriageType = "12H";
_yCarriageType = "12H";

_beltWidth = 6;

_printBedSize = 235;
_printBedArmSeparation = 150;
_printBed4PointSupport = true;

_blower_type = 30;

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 105;
