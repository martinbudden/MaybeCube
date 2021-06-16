include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/springs.scad>
include <NopSCADlib/vitamins/bearing_blocks.scad>
include <NopSCADlib/vitamins/pcb.scad>
include <NopSCADlib/vitamins/sk_brackets.scad>
use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/vitamins/o_ring.scad>

use <printed/Z_Carriage.scad>

use <utils/FrameBolts.scad>

use <vitamins/AntiBacklashNut.scad>
use <vitamins/bolts.scad>
use <vitamins/extrusion.scad>
use <vitamins/extrusionBracket.scad>
use <vitamins/HeatedBedLevelingKnob.scad>
use <vitamins/nuts.scad>

include <Parameters_Main.scad>


function is_true(x) = !is_undef(x) && x == true;

springDiameter = 8;
springLength = 18; // 25 uncompressed
// y value of heatedBedOffset constrained by clearance for heatbed cable connector relative to SK bracket
// and leveling knobs clearance of Z_Carriage
//sk12HoleOffsetFromTop = -0.5;//37.5 - 23; // 14.5
SK_type = _zRodDiameter == 8 ? SK8 : _zRodDiameter == 10 ? SK10 : SK12;
skHoleOffsetFromTop = sk_size(SK_type).y - sk_hole_offset(SK_type);

heatedBedOffset = _printBed4PointSupport
    ? [0, 20, _printBedExtrusionSize/2 + springLength - 8]
    : [0, skHoleOffsetFromTop + 8, _printBedExtrusionSize/2 + 5.5];


_heatedBedSize = _printBedSize == 100 ? [100, 100, 1.6] : // Openbuilds mini heated bed size
                _printBedSize == 120 ? [120, 120, 6] : // Voron 0 size
                _printBedSize == 180 ? [180, 180, 3] :
                _printBedSize == 210 ? [210, 210, 4] :
                _printBedSize == 214 ? [214, 214, 4] :
                _printBedSize == 235 ? [235, 235, 4] : // Ender 3 size
                _printBedSize == 300 ? [300, 300, 4] :
                _printBedSize == 310 ? [310, 310, 3] : // CR-10 size
                undef;

// values marked undef are not currently reliably known
_heatedBedHoleOffset = _printBedSize == 100 ? 4 :
                    _printBedSize == 120 ? 5 :
                    _printBedSize == 180 ? 3 : // !!estimate
                    _printBedSize == 210 ? undef :
                    _printBedSize == 214 ? 3 :
                    _printBedSize == 235 ? 32.5 :
                    _printBedSize == 300 ? 3 : // !!estimate
                    _printBedSize == 310 ? 35 : // hole spacing is 240x240 on CR-10
                    undef;


holeSeparationY = _heatedBedSize.y - 2*_heatedBedHoleOffset;


// how far the print bed is inset from the ends of the extrusion, y direction
//insetY = _variant==200 ? 49.5-1 : 54.5;// !!TODO 200 _variant limited by support, needs new type of support
//heatedBedOffsetY = 2;
//    : [-supportLengthLeft+printBedSupportBoltHoleOffset()-heatedBedHoleOffset, insetY-heatedBedHoleOffset+supportLengthCenter-printBedSupportBoltHoleOffset(), _printBedExtrusionSize];

/*
printBedHoleOffset = printBedSupportBoltHoleOffset();
supportLengthLeft = printBedHoleOffset-heatedBedHoleOffset+(printBedSize().x-_printBedArmSeparation-_printBedExtrusionSize)/2-_printBedOffsetX;
supportLengthRight = supportLengthLeft+2*_printBedOffsetX;
supportLengthCenter = heatedBedOffsetY+insetY-braceY()+printBedHoleOffset+heatedBedHoleOffset;
//yOffset = 22;
//supportLengthCenter = yOffset+insetY-braceY()-extrusionSize+printBedHoleOffset+heatedBedHoleOffset;
*/

// 200 _variant
// OX=135, OY=275
// 214 heatbed
// when _printBedOffsetX==0 support lengths are 22, 22, 13
// when _printBedOffsetX==10 support lengths are 32, 12, 13
// 220 heatbed
// when _printBedOffsetX==0 support lengths are 25, 25, 13
// when _printBedOffsetX==10 support lengths are 35, 15, 13

// 220 _variant
// OX=135, OY=275
// 214 heatbed
// support lengths 22, 22, 17
// 220 heatbed
// support lengths 25, 25, 17
scs_type = _zRodDiameter == 8 ? SCS8LUU : _zRodDiameter == 10 ? SCS10LUU : SCS12LUU;


function printBedSize() = [
    _heatedBedSize.x,
    is_true(_useDualZRods) ? eY - 3 : eY <= 250 ? 225 : eY <= 300 ? 260 : eY <= 350 ? 275 : 375,
    _printBedExtrusionSize + _heatedBedSize.z
];

extrusion_inner_corner_bracket_hole_offset = 15;


module foamUnderlay(size, holeOffset, foamThickness) {
    dSize = [size.x - 5, holeOffset*2 + 5, foamThickness];
    color(grey(20))
        hull()
            translate([size.x/2, size.y/2, -foamThickness]) {
                rotate(45)
                    translate([-dSize.x/2, -dSize.y/2, 0])
                        rounded_cube_xy(dSize, 1);
                rotate(-45)
                    translate([-dSize.x/2, -dSize.y/2, 0])
                        rounded_cube_xy(dSize, 1);
            }
}

module corkUnderlay(size, boltHoles, underlayThickness) {
    vitamin(str("corkUnderlay(", size, ", ", boltHoles, ", ", underlayThickness, "): Cork underlay ", size.x, "mm x ", size.y, "mm"));

    color("tan")
        difference() {
            rounded_rectangle([size.x, size.y, underlayThickness], 1, center=false, xy_center=false);
            for (i = boltHoles)
                translate(i)
                    boltHole(springDiameter+1, underlayThickness+2*eps);
        }
}

module molex_400(ways) { //! Draw molex header
    pitch = 4.00;
    width = ways * pitch - 0.1;
    depth = 6.35;
    height = 8.15;
    base = 3.18;
    back = 1;
    below = 2.3;
    above = 9;
    color("white")
        union() {
            translate([-depth / 2, -width / 2])
                cube([depth, width, base]);

            w = width - pitch;
            translate([- depth / 2, -w / 2])
                cube([back, w, height]);
         }

    color("silver")
        for (i = [0: ways -1])
            translate([0, i * pitch - width / 2 + pitch / 2, (above + below) / 2 - below])
                cube([1, 1, above + below], center = true);
}


module heatedBed(size=_heatedBedSize, holeOffset=_heatedBedHoleOffset, underlayThickness=0) {
    vitamin(str("heatedBed(", size, ", ", holeOffset, ", ", underlayThickness, "): Heated Bed ", size.x, "mm x ", size.y, "mm"));

    boltHoles = _printBed4PointSupport
        ? [ [holeOffset, holeOffset, 0], [size.x - holeOffset, holeOffset, 0], [size.x - holeOffset, size.y - holeOffset, 0], [holeOffset, size.y - holeOffset, 0] ]
        : [ [holeOffset, size.y/2, 0], [size.x - holeOffset, size.y - holeOffset, 0], [size.x - holeOffset, holeOffset, 0] ];
    translate([-_heatedBedSize.y/2, 0, 0]) {
        if (size.x == 235)
            translate([_heatedBedSize.x - 20, 0, 1])
                rotate([90, 90, 0])
                    molex_400(6);

        translate_z(_printBed4PointSupport ? 0 : underlayThickness)
        color("silver")
            difference() {
                rounded_cube_xy(size, 1);
                for (i = boltHoles)
                    translate(i)
                        if (_printBed4PointSupport)
                            translate_z(size.z + eps)
                                rotate([180, 0, 0]) {
                                    boltHoleM3(size.z, cnc=true);
                                    screw_countersink(M3_cs_cap_screw);
                                }
                        else
                            boltHoleM3(size.z, cnc=true);
                *for (i = [ [holeOffset, holeOffset], [size.x - holeOffset, holeOffset] ])
                    translate(i)
                        boltHoleM3(size.z - underlayThickness);
            }
        // add magnetic layer
        translate_z(size.z + (_printBed4PointSupport ? 0 : underlayThickness))
            if (_printBed4PointSupport) {
                color(grey(20))
                    difference() {
                        magneticBaseSize = [size.x, size.y, 1];
                        rounded_cube_xy(magneticBaseSize, 1);
                        for (i = boltHoles)
                            translate(i)
                                boltHoleM3(magneticBaseSize.z, cnc=true);
                    }
            } else {
                offset = 5;
                printSurfaceSize = [size.x - 2*offset, size.y - 2*offset, 1];
                translate([offset, offset, 0])
                    color("orangeRed")
                        rounded_cube_xy(printSurfaceSize, 1);
            }

        // add underlay
        if (_printBed4PointSupport)
            foamUnderlay(size, holeOffset, 7);
        else
            explode(-40)
                corkUnderlay(size, boltHoles, underlayThickness);

        spring  = ["spring", 8, 0.9, 20, 10, 1, false, 0, "lightblue"];
        supportBoltLength = _printBed4PointSupport ? 45 : 12;
        if (_printBed4PointSupport) for (i=boltHoles) {
            translate(i) {
                explode(0.1, false)
                    translate_z(size.z+eps)
                        if (_printBed4PointSupport)
                            boltM4Countersunk(supportBoltLength);
                        else
                            boltM3Caphead(supportBoltLength);
                if (_printBed4PointSupport) {
                    translate_z(-springLength + underlayThickness)
                        explode(-70)
                            comp_spring(spring, springLength);
                    explode(-200)
                        translate_z(-springLength - eSize/2 - 1)
                            not_on_reduced_bom() HeatedBedLevelingKnob();
                }
            }
        }
    }
}
module heatedBedHardware(size=_heatedBedSize, holeOffset=_heatedBedHoleOffset, underlayThickness=0) {
    boltHoles = _printBed4PointSupport
        ? [ [holeOffset, holeOffset, 0], [size.x - holeOffset, holeOffset, 0], [size.x - holeOffset, size.y - holeOffset, 0], [holeOffset, size.y - holeOffset, 0] ]
        : [ [holeOffset, size.y/2, 0], [size.x - holeOffset, size.y - holeOffset, 0], [size.x - holeOffset, holeOffset, 0] ];

    module oRing() {
        thickness = 2;
        translate_z(thickness/2)
            color("FireBrick")
                O_ring(3, thickness);
        if($children)
            translate_z(thickness)
                children();
    }

    translate([-_heatedBedSize.y/2, 0, underlayThickness + size.z])
        for (i = boltHoles)
            translate(i) {
                translate_z(-washer_thickness(M3_washer))
                    boltM3Caphead(20);
                washer(M3_washer);
                translate_z(-size.z)
                    vflip()
                        washer(M4_penny_washer)
                            oRing()
                                washer(M3_washer)
                                    oRing()
                                        washer(M3_washer)
                                            oRing()
                                                washer(M4_penny_washer)
                                                    translate_z(2)
                                                        rotate(90)
                                                            nutM3SlidingT();

           }
}

module printbedFrameCrossPiece() {
    fSize = _printBedExtrusionSize;
    translate([-_printBedArmSeparation/2, 0, 0]) {
        extrusionOX2040HEndBolts(_printBedArmSeparation);
        if (!_useBlindJoints) {
            translate([0, 2*fSize, fSize/2]) {
                translate([_printBedArmSeparation, 0, 0])
                    explode([40, 0, 0])
                        rotate([0, 0, 90])
                            extrusionInnerCornerBracket();
                explode([-40, 0, 0])
                    rotate([0, 180, -90])
                        extrusionInnerCornerBracket();
            }
            translate([0, 0, fSize/2]) {
                translate([_printBedArmSeparation, 0, 0])
                    rotate([180, 0, -90])
                        extrusionInnerCornerBracket(1);
                rotate([0, 0, -90])
                    extrusionInnerCornerBracket(1);
            }
        }
    }

    *translate_z(fSize/2) {
        explode([0, -25, 0])
            vflip()
                antiBacklashNut();
        translate([antiBacklashNutBoltSeparation()/2, 0, 0]) {
            explode([_printBedArmSeparation/2+10, 0, 0])
                rotate([-90, 0, 0])
                    nutM4SlidingT();
            rotate([90, 0, 0])
                explode(60)
                    boltM4Buttonhead(12);
        }
        translate([-antiBacklashNutBoltSeparation()/2, 0, 0]) {
            explode([-_printBedArmSeparation/2-10, 0, 0])
                rotate([-90, 0, 0])
                    nutM4SlidingT();
            rotate([90, 0, 0])
                explode(60)
                    boltM4Buttonhead(12);
        }
    }
}

module Printbed_Frame_assembly()
assembly("Printbed_Frame", big=true, ngb=true) {
    size = printBedSize();
    fSize = _printBedExtrusionSize;
    yOffset = scs_size(scs_type).x/2; // 42/2

    translate([-_printBedArmSeparation/2, 0, -fSize/2]) {
        for (x = [-fSize/2, _printBedArmSeparation + fSize/2])
            explode([0, 150, 0])
                color(frameColor()) render(convexity=2) difference() {
                    translate([x - fSize/2, -yOffset, 0])
                        extrusionOY(size.y, fSize);
                    // access hole for Z_Carriage bolt
                    *translate([x + fSize/2, -yOffset + (scs_size(scs_type).x - scs_screw_separation_x(scs_type))/2, fSize/2])
                        rotate([0, -90, 0])
                            jointBoltHole();
                    // access holes for crosspiece
                    for (y = [fSize/2, 3*fSize/2])
                        translate([x + fSize/2, y + printBedFrameCrossPieceOffset(), fSize/2])
                            rotate([0, -90, 0])
                                jointBoltHole();
                    if (_printBed4PointSupport) {
                        for (y = [_heatedBedHoleOffset, _heatedBedSize.y - _heatedBedHoleOffset])
                            translate([x, y + heatedBedOffset.y, 0]) {
                                // hole for bolt
                                cylinder(h=eSize, r=M4_clearance_radius);
                                //cutout for spring
                                translate_z(eSize - 3)
                                    cylinder(h=4, r=5);
                                *translate_z(-1)
                                    cylinder(h=4, r=5);
                            }
                    } else {
                        for (y = x == -fSize/2 ? [_heatedBedSize.y/2] : [_heatedBedHoleOffset, _heatedBedSize.y - _heatedBedHoleOffset])
                            translate([x, y + heatedBedOffset.y, 0])
                                cylinder(h=eSize, r=M4_clearance_radius);
                    }
            }

        translate([_printBedArmSeparation/2, 0]) {
            translate([0, printBedFrameCrossPieceOffset()])
                printbedFrameCrossPiece();
            if (is_true(_useDualZRods))
                //translate([0, eY - 2*eSize - 6 - printBedFrameCrossPieceOffset(), 0])
                //translate([0, eY + 2*eSize - _zRodOffsetX - 3*printBedFrameCrossPieceOffset(), 0])
                translate([0, eY - 2*_zRodOffsetX - printBedFrameCrossPieceOffset(), 0])
                    rotate(180)
                        printbedFrameCrossPiece();
        }
    *if (!_printBed4PointSupport) {
        translate([-fSize/2, heatedBedOffset.y + _heatedBedSize.y/2, 27])
            boltM3Caphead(20);
        translate([fSize/2 + _printBedArmSeparation, - yOffset, 27]) {
            //boltM3Caphead(20);
            translate([0, yOffset + heatedBedOffset.y + _heatedBedHoleOffset, 0])
                boltM3Caphead(20);
            translate([0, yOffset + heatedBedOffset.y + _heatedBedSize.y - _heatedBedHoleOffset, 0])
                boltM3Caphead(20);
            //echo(eOffset = yOffset + heatedBedOffset.y + _heatedBedHoleOffset-1.5);
        }
    }
    /*
    translate([_printBedArmSeparation, 0, fSize])
        explode([50, -40, 0], true)
            rotate([-90, 90, 90])
                Printbed_Corner_Bracket_stl();
    explode([-50, -40, 0], true)
        rotate([-90, -90, -90])
            Printbed_Corner_Bracket_stl();

    if (is_true(_useDualZRods))
        translate([0, eY-2*eSize - 18, fSize]) {
            explode([50, -40, 0], true)
                rotate([-90, 90, -90])
                    Printbed_Corner_Bracket_stl();
        translate([_printBedArmSeparation, 0, -fSize])
            explode([-50, -40, 0], true)
                rotate([-90, -90, 90])
                    Printbed_Corner_Bracket_stl();
        }
    */
    }
    explode([150, 0, 0])
        Z_Carriage_Center_assembly();
    if (is_true(_useDualZRods))
        translate([0, yRight, 0])
            rotate(180)
                explode([150, 0, 0])
                    Z_Carriage_Center_assembly();
}


//!1. Slide the Z carriages onto the frame as shown.
//!
//!2. Ensure the Z carriages are square and aligned with the end of the frame and then tighten the bolts.
//
module Printbed_Frame_with_Z_Carriages_assembly()
assembly("Printbed_Frame_with_Z_Carriages", big=true, ngb=true) {

    Printbed_Frame_assembly();
    yRight = eY - 2*_zRodOffsetX;

    translate([-zRodSeparation()/2, 0, 0]) {
        explode([0, -100, 0])
            Z_Carriage_Left_assembly();
        if (is_true(_useDualZRods))
            translate([0, yRight, 0])
                rotate(180)
                    Z_Carriage_Right_assembly();
    }
    translate([zRodSeparation()/2, 0, 0]) {
        explode([0, -100, 0])
            Z_Carriage_Right_assembly();
        if (is_true(_useDualZRods))
            translate([0, yRight, 0])
                rotate(180)
                    Z_Carriage_Left_assembly();
    }
    *Printbed_Strain_Relief_assembly(); //!!TODO position this correctly
}

module Printbed_assembly()  pose(a=[210, 0, 320])
assembly("Printbed", big=true) {

    translate([eSize + _zRodOffsetX, eSize + zRodSeparation()/2 + _zRodOffsetY, 0])
        rotate(-90) {
            Printbed_Frame_with_Z_Carriages_assembly();
            // add the heated bed
            explode(120, true)
                translate(heatedBedOffset) {
                    not_on_reduced_bom() heatedBed(_heatedBedSize, _heatedBedHoleOffset, 3);
                    if (!_printBed4PointSupport)
                        heatedBedHardware(_heatedBedSize, _heatedBedHoleOffset, 3);
                }
        }
}

wiringDiameter = 6.5;
sideThickness = 6.5;

module Printbed_Strain_Relief_stl() {
    size = [40, eSize, 5];
    fillet = 1.5;

    stl("Printbed_Strain_Relief")
        color(pp1_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy(size, fillet);
                        for (y = [0, size.y - sideThickness])
                            translate([(size.x - eSize)/2, y, 0])
                                rounded_cube_xy([eSize, sideThickness, wiringDiameter + 2], fillet);
                    }
                    for (x = [5, size.x - 5])
                        translate([x, size.y/2, size.z])
                            vflip()
                                boltPolyholeM3Countersunk(size.z, sink=0.25);
                    for (y = [sideThickness/2, size.y - sideThickness/2])
                        translate([size.x/2, y, 0])
                            boltHoleM3Tap(size.z + wiringDiameter);
                }
}

module Printbed_Strain_Relief_Clamp_stl() {
    size = [eSize, eSize, 2.5];
    fillet = 1.5;

    stl("Printbed_Strain_Relief_Clamp")
        color(pp2_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    rounded_cube_xy(size, fillet);
                    for (y = [sideThickness/2, size.y - sideThickness/2])
                        translate([size.x/2, y, 0])
                            boltHoleM3(size.z, twist=5);
                }
 }

module Printbed_Strain_Relief_assembly()
assembly("Printbed_Strain_Relief") {
    translate([eSize + _zRodOffsetX + 150, 2*eSize + zRodSeparation() + _zRodOffsetY, -eSize/2])
        rotate([90, 0, 0]) {
            stl_colour(pp1_colour)
                Printbed_Strain_Relief_stl();
            stl_colour(pp2_colour)
                translate_z(wiringDiameter + 2)
                    Printbed_Strain_Relief_Clamp_stl();
        }
}
