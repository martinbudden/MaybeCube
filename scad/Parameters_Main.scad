include <target.scad>

_useBlindJoints = true;
_reducedBOM = false;

module not_on_reduced_bom() {
    let($on_bom = !_reducedBOM)
        children();
}

_boltTogether = true;
_useAsserts = true;


eSize = 20; // for 2020 extrusion
_printBedExtrusionSize = 20;
_basePlateThickness = 3;

// Z
_zRodDiameter = 12;
_zRodLength = eZ - 100;
_zRodOffsetX = _zRodDiameter == 8 ? 20 : _zRodDiameter == 10 ? 20 : 23; // 20 is SK8 and SK10 hole offset, 23 is SK12 hole offset
_zLeadScrewDiameter = 8;
_zLeadScrewOffset = _zRodOffsetX;// ensures clearance of zMotor from frame and alignment with zRods

// sk bracket width = 42, motormount width = 80
__scs_hole_offset = _zRodDiameter == 8 ? 11 : _zRodDiameter == 10 ? 13 : 15;
_zCarriageSCS_sizeZ = 5.5;
__zCarriageYOffset =  __scs_hole_offset + _zCarriageSCS_sizeZ;

//function zRodSeparation() = __zCarriageYOffset*2 + _printBedArmSeparation + 2*_printBedExtrusionSize;
function zRodSeparation() = -__zCarriageYOffset*2 + _printBedArmSeparation;

// set this so the zRod brackets clear the xy motors
__skBracketWidth = 42; // same for SK8, SK10, and SK12
//_zRodOffsetY = eX < 300 ?  eY-zRodSeparation()-__skBracketWidth/2 : eX < 400 ? __skBracketWidth/2+15 : __skBracketWidth/2+40;
//_zRodOffsetY = eX < 300 ? __skBracketWidth/2 : eY - zRodSeparation() - __skBracketWidth/2 - 35;

//_zRodOffsetY = __skBracketWidth/2 + (eX <= 300 ? 0 : eX <= 350 ? 20 : 20);
//_zRodOffsetY = 10 + (eY - zRodSeparation())/2 - __skBracketWidth/2;
// limited by printbed frame hitting XY motors and possibly extruder motor
_zRodOffsetY = eX <= 250 ? __skBracketWidth/2 + 40 : eX <= 300 ? __skBracketWidth/2 + 50 : __skBracketWidth/2 + 60;

// Bolts
_frameBoltLength = 12;
_sideBoltLength = 8;
_endBoltLength = 12;
_endBoltShortLength = 10;
