include <../vitamins/bolts.scad>
include <../vitamins/extrusion.scad>
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
            cylinder(d=4, h=eSize - 2*extrusionChannelDepth() + 2*eps);
    else
        boltHoleM6Counterbore(eSize, extrusionChannelDepth(), 0);
}

module extrusionOXEndBolts(eX) {
    extrusionOX(eX);
    if (_useBlindJoints)
        extrusionOXEndBoltPositions(eX)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOX2040HEndBolts(eX) {
    extrusionOX2040H(eX);
    if (_useBlindJoints)
        extrusionOX2040HEndBoltPositions(eX)
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

module extrusionOYEndBolts(eY) {
    extrusionOY(eY);
    if (_useBlindJoints)
        extrusionOYEndBoltPositions(eY)
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

module extrusionOY2060HEndBolts(eY) {
    extrusionOY2060H(eY);
    if (_useBlindJoints)
        extrusionOY2060HEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOY2060VEndBolts(eY) {
    extrusionOY2060V(eY);
    if (_useBlindJoints)
        extrusionOY2060VEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOY2080HEndBolts(eY) {
    extrusionOY2080H(eY);
    if (_useBlindJoints)
        extrusionOY2080HEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOY2080VEndBolts(eY) {
    extrusionOY2080V(eY);
    if (_useBlindJoints)
        extrusionOY2080VEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOZ2080XEndBolts(eZ) {
    extrusionOZ2080X(eZ);
    if (_useBlindJoints)
        extrusionOZ2080XEndBoltPositions(eY)
            boltM5Buttonhead(_endBoltLength);
}

module extrusionOZ2080YEndBolts(eZ, bothEnds=true) {
    extrusionOZ2080Y(eZ);
    if (_useBlindJoints)
        extrusionOZ2080YEndBoltPositions(eZ, bothEnds=bothEnds)
            boltM5Buttonhead(_endBoltLength);
}
