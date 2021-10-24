_variant = "MC400KB";

__extrusionLengths = [400, 400, 450];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20;

_xyMotorDescriptor = "NEMA17_48";
_zMotorDescriptor = "NEMA17_40L330";
_corkDamperThickness = 2;

_use2060ForTop = true;
_xRailLength = eX - 50;
_yRailLength = eY;
_zRailLength = eZ - 100;
_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";
_zCarriageDescriptor = "MGN12C";

_beltWidth = 6;

_printBedSize = 300;
_printBedArmSeparation = 332;
_printBedKinematic = true;

_zRodOffsetY = 44;
_zLeadScrewOffset = 30;// ensures clearance of zMotor from frame and zRail
_upperZRodMountsExtrusionOffsetZ = eZ - 90;
