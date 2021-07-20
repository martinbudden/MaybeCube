include <Parameters_main.scad>

// set $t = 2 for mid position
// In animation $t takes values from 0 to 1

$t = 2;

// print size is approx eX-134, eY-115, eZ-219
_xMin = eSize + 59; // limited by Y_Carriage tongue with X_Carriage belt attachment, was limited by E3D V6 hotend cartridge wiring hitting SK brackets, will differ for other hotends
_xMax = eX + 2*eSize - 82; // limited by printhead fan hitting Y_Carriage or belt hitting Y_Carriage brace post
_yMin = 44.5;
_yMax = eY - 71; // motor limits this, get an extra 3 with MGN9 X rail
_yMaxCenter = eY - 33; // used for tool changing
_zMin = 97; // limited by z carriage hitting sk bracket, limited by leadscrew coupling for _variant=250
_zMax = eZ - eSize - (eX >= 350 ? 105 : 85 + 3);

// note values of _zRodOffsetY (in Parameters_Main.scad) and heatedBedOffset (in Printbed.scad)

// X-axis
function xPos(t) = t==-1 ? 0 : t==2 ? (_xMin + _xMax)/2 : t==3 ? _xMin : t==4 ? _xMax : t==5 ? _xMax : t==6 ? _xMin : t==7 ? (_xMin + _xMax)/2 : _xMax;
function xPosAnimate(t) = eX/2 + t*100;

// Y-axis
function yPos(t) = t==-1 ? 0 : t==2 ? (_yMin + _yMax)/2 : t==3 ? _yMin : t==4 ? _yMin : t==7 ? _yMaxCenter : _yMax;
function yPosAnimate(t) = eY/2 + t*100;

function carriagePosition(t=undef) = [is_undef(t) ? ($t > 1  ? xPos($t) : xPosAnimate($t)) : xPos(t), is_undef(t) ? ($t > 1  ? yPos($t) : yPosAnimate($t)) : yPos(t)];

// Z-axis
function zPos(t) = t==2 ? (_zMin + _zMax)/2 - 15 : t==7 ? _zMin : _zMax;
function zPosAnimate(t) = _zMax - t*10;
function bedHeight(t=undef) = is_undef(t) ? ($t > 1 ? zPos($t) : zPosAnimate($t)) : zPos(t);
