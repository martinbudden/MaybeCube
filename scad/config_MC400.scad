_variant = "MC400";

__extrusionLengths = [400, 400, 450];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20; // for 2020, 2040  etc extrusion

_xyMotorDescriptor = "NEMA17_40";
_zMotorDescriptor = "NEMA17_40L330";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRodLength = eZ - 100;

_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";


_beltWidth = 6;

_use2060ForTop = true;
_useDualZRods = true;
_useDualZMotors = true;
_useSidePanels = false;

_printBedSize = [310, 310, 3] : // CR-10 size
_printBedArmSeparation = 225;
_printBed4PointSupport = true;

_blowerDescriptor = "BL40x10";

// set this so the zRod brackets clear the xy motors
// limited by printbed frame hitting XY motors and possibly extruder motor
__skBracketWidth = 42; // same for SK8, SK10, and SK12
_zRodOffsetY = __skBracketWidth/2 + 70; //!!TODO check this
_zLeadScrewOffset = 23;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = eZ - 95;
