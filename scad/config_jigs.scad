_variant = "jigs";

__extrusionLengths = [350, 350, 400];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_useDualZRods = false;
_useDualZMotors = false;

_printbedSize = [214, 214, 4];
_printbedArmSeparation = 188;
_printbed4PointSupport = !true;

__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 40;
