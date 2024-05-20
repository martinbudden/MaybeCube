include <NopSCADlib/vitamins/nuts.scad>

nutHoleTolerance = 0.2;
boltHoleEpsilon = eps;
boltHoleCapHeightTolerance = 0;

METRIC_NUT_AC_WIDTHS = [
    -1, //0 index is not used but reduces computation
    -1,
    -1,
    6.50, // was 6.40, //M3
    8.10, //M4
    9.20, //M5
    11.50, //M6
    12.50, //M7, guess
    14.50, //M8, guess
];
METRIC_NUT_THICKNESS = [
    -1, //0 index is not used but reduces computation
    -1,
    -1,
    2.5, // was 2.40, //M3
    3.3, // was 3.20, //M4
    4.00, //M5
    5.00, //M6
    5.50, //M7
    6.50, //M8
];

module nutHole(diameter, length=0, tolerance=nutHoleTolerance, nutDepth=0) {
    radius = METRIC_NUT_AC_WIDTHS[diameter]/2 + tolerance;
    depth = nutDepth ? nutDepth : METRIC_NUT_THICKNESS[diameter];
    translate([0, 0, -boltHoleEpsilon])
        linear_extrude(depth + boltHoleCapHeightTolerance + 2*boltHoleEpsilon)
            circle(r=radius, $fn=6);
    if (length) {
        boltHole(diameter, length, tolerance);
    }
}

module nutHoleM3(length=0, nutHoleTolerance=nutHoleTolerance, nutDepth=0) {
    radius = METRIC_NUT_AC_WIDTHS[3]/2 + nutHoleTolerance;
    depth = nutDepth ? nutDepth : METRIC_NUT_THICKNESS[3];
    translate([0, 0, -boltHoleEpsilon])
        linear_extrude(depth + boltHoleCapHeightTolerance + 2*boltHoleEpsilon)
            circle(r=radius, $fn=6);
    if (length) {
        boltHoleM3(length);
    }
}

module nutM3(tolerance=nutHoleTolerance, nutDepth=0) {
    if ($preview && is_undef($hide_bolts))
        translate_z(nutDepth-METRIC_NUT_THICKNESS[3])
            nut(M3_nut);
}

module nutM3SlidingT() {
    if ($preview && is_undef($hide_bolts))
        sliding_t_nut(M3_sliding_t_nut);
}

module nutM3Hammer() {
    if ($preview && is_undef($hide_bolts))
        sliding_t_nut(M3_hammer_nut);
}

module nutHoleM3Tap(length=0, tolerance=nutHoleTolerance, nutDepth=0) {
    radius = METRIC_NUT_AC_WIDTHS[3]/2+tolerance;
    depth = nutDepth ? nutDepth : METRIC_NUT_THICKNESS[3];
    translate([0, 0, -boltHoleEpsilon]) linear_extrude(depth+boltHoleCapHeightTolerance + 2*boltHoleEpsilon) circle(r=radius, $fn=6);
    if (length)
        boltHoleM3Tap(length, tolerance);
}

module nutHoleM4(length=0, tolerance=nutHoleTolerance, nutDepth=0) {
    radius = METRIC_NUT_AC_WIDTHS[4]/2+tolerance;
    depth = nutDepth ? nutDepth : METRIC_NUT_THICKNESS[4];
    translate([0, 0, -boltHoleEpsilon])
        linear_extrude(depth+boltHoleCapHeightTolerance+ + 2*boltHoleEpsilon)
            circle(r=radius, $fn=6);
    if (length)
        boltHoleM4(length, tolerance);
}

module nutM4(tolerance=nutHoleTolerance, nutDepth=0) {
    if ($preview && is_undef($hide_bolts))
        translate_z(nutDepth-METRIC_NUT_THICKNESS[3])
            nut(M4_nut);
}

module nutM4SlidingT() {
    M4_sliding_t_nut_short = ["M4_sliding_t_nut", 4,   6,   3.7, 4.7,  false,         0,  10,  10,  6, false];
    if ($preview && is_undef($hide_bolts))
        sliding_t_nut(M4_sliding_t_nut_short);
}
function nutM4SlidingTSize() = [11, 10, 4.5];

module nutM4Hammer() {
    if ($preview && is_undef($hide_bolts))
        sliding_t_nut(M4_hammer_nut);
}


module boltM3CapheadHammerNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM3Caphead(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM3Hammer();
    }
}

module boltM3ShoulderHammerNut(length, nutOffset=2.98 - 6, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM3Shoulder(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM3Hammer();
    }
}

module boltM3ShoulderTNut(length, nutOffset=2.98 - 6, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM3Shoulder(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM3SlidingT();
    }
}

module boltM3ButtonheadHammerNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM3Buttonhead(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM3Hammer();
    }
}

module boltM3CountersunkHammerNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM3Countersunk(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM3Hammer();
    }
}

module boltM4ButtonheadTNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    boltM4Buttonhead(length);
    boltM4TNut(length, nutOffset, rotate, nutExplode);
}

module boltM4TNut(length, nutOffset=2.98, rotate=0, nutExplode=0) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM4SlidingT();
    }
}

module boltM4ShoulderHammerNut(length, nutOffset=2.98 - 8, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM4Shoulder(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM4Hammer();
    }
}

module boltM4ShoulderTNut(length, nutOffset=2.98 - 8, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM4Shoulder(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM4SlidingT();
    }
}

module boltM4ButtonheadHammerNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM4Buttonhead(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM4Hammer();
    }
}

module boltM4CountersunkTNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM4Countersunk(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM4SlidingT();
    }
}

module boltM4CountersunkHammerNut(length, nutOffset=2.98, rotate=0, nutExplode=20) {
    if ($preview && (is_undef($hide_bolts) || $hide_bolts == false)) {
        boltM4Countersunk(length);
        vflip()
            translate_z(length - nutOffset)
                rotate(rotate)
                    explode(nutExplode)
                        nutM4Hammer();
    }
}
