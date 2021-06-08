include <../global_defs.scad>

include <NopSCADlib/core.scad>

use <../vitamins/extrusion.scad>
use <../vitamins/bolts.scad>
include <../Parameters_Main.scad>


module jointBolt() {
    if (_useBlindJoints)
        ;// do nothing
    else
        translate_z(-extrusionChannelDepth())
            boltM6Caphead(25);
}

module jointBoltHole() {
    if (_useBlindJoints)
        translate_z(extrusionChannelDepth() - eps)
            cylinder(d = 4, h = eSize - 2*extrusionChannelDepth() + 2*eps);
    else
        boltHoleM6Counterbore(eSize, extrusionChannelDepth(), 0);
}

module extrusionOXEndBolts(eX) {
    extrusionOX(eX);
    if (_useBlindJoints)
        extrusionOXEndBoltPositions(eX)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOX2040VEndBolts(eX) {
    extrusionOX2040V(eX);
    if (_useBlindJoints)
        extrusionOX2040VEndBoltPositions(eX)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOX2080VEndBolts(eX) {
    extrusionOX2080V(eX);
    if (_useBlindJoints)
        extrusionOX2080VEndBoltPositions(eX)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOY2040HEndBolts(eY) {
    extrusionOY2040H(eY);
    if (_useBlindJoints)
        extrusionOY2040HEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOY2040VEndBolts(eY) {
    extrusionOY2040V(eY);
    if (_useBlindJoints)
        extrusionOY2040VEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}
