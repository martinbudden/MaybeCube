_variant = "MC250";

__extrusionLengths = [250, 250, 350];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

_xyNemaType = "17_40";
_zNemaType = "17_40L230";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_xCarriageType = "9H";
_yCarriageType = "12H";

_beltWidth = 6;

_printBedSize = 180;
_printBedArmSeparation = 150;
_printBed4PointSupport = false;

_blower_type = 30;

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
