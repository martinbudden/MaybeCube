include <NopSCADlib/vitamins/inserts.scad>

// tolerance for brassKnurl when printed vertically, ie against the print grain
brassKnurlToleranceVertical = 0.0;
brassKnurlTolerance = 0.2;
brassKnurl5x5Length = 5.2;

module brassKnurl5x5Hole(tolerance=brassKnurlTolerance, nutDepth=0) {
    depth = nutDepth == 0 ? brassKnurl5x5Length : nutDepth;
    translate([0, 0, -boltHoleEpsilon]) cylinder(d=4.6 + tolerance, h=depth + 2*boltHoleEpsilon);
}

module threadedHoleM3(length=0, tolerance=brassKnurlTolerance, useBrass5x5Knurl=true) {
    if (useBrass5x5Knurl) {
        brassKnurl5x5Hole(tolerance);
        boltHoleM3(length);
    } else {
        nutHoleM3(length, tolerance);
    }
}

module brassKnurlHoleM3(length=0, tolerance=brassKnurlTolerance, nutDepth=0, bridgeThickness=0) {
    brassKnurl5x5Hole(tolerance, nutDepth);
    translate_z(bridgeThickness)
        boltHoleM3(length, tolerance);
}

module brassKnurlHoleM3Bridged(length=0, tolerance=brassKnurlTolerance, nutDepth=0) {
    depth = nutDepth ? nutDepth : brassKnurl5x5Length;
    brassKnurl5x5Hole(tolerance, nutDepth=depth);
    translate([0, 0, depth + 0.25]) boltHoleM3(length-depth-0.25, tolerance);
    *boltHoleM3(length, tolerance);
}

module threadedInsertM3() {
    boltColorBrass = "#B5A642";
    if ($preview && is_undef($hide_bolts)) color(boltColorBrass) insert(F1BM3);
}

module insertHoleM3(length, horizontal=false, rotate=0) {
    boltHole(2*insert_hole_radius(F1BM3) + 0.2, 5, horizontal=horizontal, rotate=rotate);
    boltHoleM3(length, horizontal=horizontal, rotate=rotate, twist=4);
}
