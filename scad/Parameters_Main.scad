include <target.scad>

_useBlindJoints = true;
_reducedBOM = false;

_boltTogether = true;
_useAsserts = true;


_printBedExtrusionSize = 20;
_basePlateThickness = 3;

// Z
_zRodDiameter = 12;
_zRodLength = eZ - 100;
_zRodOffsetX = _zRodDiameter == 8 ? 20 : _zRodDiameter == 10 ? 20 : 23; // 20 is SK8 and SK10 hole offset, 23 is SK12 hole offset
_zLeadScrewDiameter = 8;
_zLeadScrewOffset = _zRodOffsetX;// ensures clearance of zMotor from frame and alignment with zRods
_upperZRodMountsExtrusionOffsetZ = _zRodLength + 5;

__scs_hole_offset = _zRodDiameter == 8 ? 11 : _zRodDiameter == 10 ? 13 : 15;
_zCarriageSCS_sizeZ = 5.5;
__zCarriageYOffset =  __scs_hole_offset + _zCarriageSCS_sizeZ;

function zRodSeparation() = -__zCarriageYOffset*2 + (is_undef(_printBedArmSeparation) ? 150 : _printBedArmSeparation);

// Bolts
_frameBoltLength = 10;
_sideBoltLength = 8;
_endBoltLength = 12;
_endBoltShortLength = 10;
