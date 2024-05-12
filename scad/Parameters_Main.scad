include <target.scad>

_useBlindJoints = true;

_boltTogether = true;
_useAsserts = true;


_printbedExtrusionSize = 20;
_basePlateThickness = 3;

// Z
_zRodDiameter = 12;
_zRodOffsetX = _zRodDiameter == 8 ? 20 : _zRodDiameter == 10 ? 20 : 23; // 20 is SK8 and SK10 hole offset, 23 is SK12 hole offset
_zLeadScrewDiameter = 8;

__scs_hole_offset = _zRodDiameter == 8 ? 11 : _zRodDiameter == 10 ? 13 : 15;
_zCarriageSCS_sizeZ = 0;
__zCarriageYOffset =  __scs_hole_offset + _zCarriageSCS_sizeZ;

_invertedZRods = !is_undef(_printbedArmSeparation) && _printbedArmSeparation == 150 && eY > 250;
function zRodSeparation() =  _printbedArmSeparation + (_invertedZRods ? __zCarriageYOffset*2 + 2*_printbedExtrusionSize : - __zCarriageYOffset*2);

// Bolts
_frameBoltLength = 10;
_sideBoltLength = 8;
_endBoltLength = 12;
_endBoltShortLength = 10;
