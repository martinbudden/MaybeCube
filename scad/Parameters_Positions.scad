include <Parameters_main.scad>

// set $t = 2 for mid position
// In animation $t takes values from 0 to 1

$t = 2;

// print size is approx eX-134, eY-115, eZ-219
_xMin = eSize + 60; // limited by printhead fan hitting Y_Carriage, does not hit SK brackets
_xMax = eX + 2*eSize - _xMin + 9;
_yMin = 45;
_yMax = eY - 71; // motor limits this, get and extra 3 with MGN9 X rail
_yMaxCenter = eY - 33; // used for tool changing
_zMin = 97; // limited by z carriage hitting sk bracket// PSU limits this for _variant>250, limited by leadscrew coupling for _variant=250
//zMax = eZ - eSize - 112;
_zMax = eZ - eSize - 82;

// note values of _zRodOffsetY (in Parameters_Main.scad) and heatedBedOffset (in Printbed.scad)

// X-axis
function xPos(t) = t==-1 ? 0 : t==2 ? (_xMin + _xMax)/2 : t==3 ? _xMin : t==4 ? _xMax : t==5 ? _xMax : t==6 ? _xMin : t==7 ? (_xMin + _xMax)/2 : _xMax;
function xPosAnimate(t) = eX/2 + t*100;
__carriagePositionX = $t > 1 ? xPos($t) : xPosAnimate($t);

// Y-axis
function yPos(t) = t==-1 ? 0 : t==2 ? (_yMin + _yMax)/2 : t==3 ? _yMin : t==4 ? _yMin : t==7 ? _yMaxCenter : _yMax;
function yPosAnimate(t) = eY/2 + t*100;
__carriagePositionY = $t > 1  ? yPos($t) : yPosAnimate($t);

function carriagePosition() = [__carriagePositionX, __carriagePositionY];

// Z-axis
function zPos(t) = t==2 ? (_zMin + _zMax)/2 - 15 : t==7 ? _zMin : _zMax;
function zPosAnimate(t) = _zMax - t*10;
function bedHeight() = $t > 1 ? zPos($t) : zPosAnimate($t);
