_variant = "MC400";

__extrusionLengths = [400, 400, 450];
eX = __extrusionLengths.x;
eY = __extrusionLengths.y;
eZ = __extrusionLengths.z;

eSize = 20;

_xyMotorDescriptor = "NEMA17_48";
_zMotorDescriptor = "NEMA17_40L330";
_corkDamperThickness = 2;

_xRailLength = eX - 50;
_yRailLength = eY;
_zRailLength = eZ - 100;

_xCarriageDescriptor = "MGN12H";
_xCarriageCountersunk = true;
_yCarriageDescriptor = "MGN12H";
_zCarriageDescriptor = "MGN12C";

_coreXYDescriptor = "GT2_20_16_fb";

_use2060ForTop = true;
_useDualZRods = false;
_useDualZMotors = false;
_useElectronicsInBase = true;
_useFrontDisplay = true;
_useRB40 = true;
_useReversedBelts = true;
_useSidePanels = true;

_printbedSize = [305, 300, 6.35];
_printbedHoleOffset = [8, 30];
_printbedArmSeparation = 50 + _printbedSize.y - 2*_printbedHoleOffset.y;
_printbedKinematic = true;

_zRodOffsetY = 65;
_zLeadScrewOffset = 30;// ensures clearance of zMotor from frame and zRail
_upperZRodMountsExtrusionOffsetZ = eZ - 90;
