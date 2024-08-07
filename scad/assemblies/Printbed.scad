include <../config/global_defs.scad>

include <../utils/FrameBolts.scad>

include <NopSCADlib/vitamins/springs.scad>
include <NopSCADlib/vitamins/bearing_blocks.scad>
include <NopSCADlib/vitamins/pcb.scad>
include <NopSCADlib/vitamins/sk_brackets.scad>
include <NopSCADlib/printed/drag_chain.scad>
use <NopSCADlib/vitamins/o_ring.scad>

use <../printed/Z_Carriage.scad>
use <../printed/CableChainBracket.scad>
use <../printed/BaseCover.scad>

use <../vitamins/HeatedBedLevelingKnob.scad>
include <../vitamins/nuts.scad>


function is_true(x) = !is_undef(x) && x == true;

springDiameter = 8;
springLength = 18; // 25 uncompressed
// y value of heatedBedOffset constrained by clearance for heatbed cable connector relative to SK bracket
// and leveling knobs clearance of Z_Carriage
//sk12HoleOffsetFromTop = -0.5;//37.5 - 23; // 14.5
SK_type = _zRodDiameter == 8 ? SK8 : _zRodDiameter == 10 ? SK10 : SK12;
skHoleOffsetFromTop = sk_size(SK_type).y - sk_hole_offset(SK_type);

heatedBedOffset = !is_undef(_printbed4PointSupport) && _printbed4PointSupport
    ? [0, 40, _printbedExtrusionSize/2 + springLength - 8]
    : [_printbedSize.x == 254 ? 17.5 : 0, skHoleOffsetFromTop + (_printbedSize.x == 254 ? 2 : 8), _printbedExtrusionSize/2 + (_printbedSize.x == 254 ? 15 : 7.5)];

_heatedBedSize = _printbedSize;
/*_heatedBedSize = is_undef(_printbedSize) || _printbedSize == 100 ? [100, 100, 1.6] : // Openbuilds mini heated bed size
                _printbedSize == 120 ? [120, 120, 6] : // Voron 0 size
                _printbedSize == 180 ? [180, 180, 3] :
                _printbedSize == 210 ? [210, 210, 4] :
                _printbedSize == 214 ? [214, 214, 4] :
                _printbedSize == 235 ? [235, 235, 4] : // Ender 3 size
                _printbedSize == 300 ? [300, 300, 4] :
                _printbedSize == 310 ? [310, 310, 3] : // CR-10 size
                undef;*/

// values marked undef are not currently reliably known
_heatedBedHoleOffset = is_undef(_heatedBedSize) || _heatedBedSize.x == 100 ? 4 :
                    _heatedBedSize.x == 120 ? 5 :
                    _heatedBedSize.x == 180 ? 3 : // !!estimate
                    _heatedBedSize.x == 210 ? undef :
                    _heatedBedSize.x == 214 ? 3 :
                    _heatedBedSize.x == 235 ? 32.5 : // Ender 3
                    _heatedBedSize.x == 254 ? 7 : // Voron Trident
                    _heatedBedSize.x == 300 ? 3 : // !!estimate
                    _heatedBedSize.x == 305 ? 3 : // kinematic bed
                    _heatedBedSize.x == 310 ? 35 : // hole spacing is 240x240 on CR-10
                    undef;
function boltHoles(size, holeOffset, printbed4PointSupport) = printbed4PointSupport
    ? [ [holeOffset, holeOffset, 0], [size.x - holeOffset, holeOffset, 0], [size.x - holeOffset, size.y - holeOffset, 0], [holeOffset, size.y - holeOffset, 0] ]
    : size.x == 254 ? [ [holeOffset, size.y/2, 0], [size.x - 42, size.y - holeOffset, 0], [size.x - 42, holeOffset, 0] ]
    : [ [size.x - holeOffset, size.y/2, 0], [holeOffset, size.y - holeOffset, 0], [holeOffset, holeOffset, 0] ];

scs_type = _zRodDiameter == 8 ? SCS8LUU : _zRodDiameter == 10 ? SCS10LUU : SCS12LUU;
dualCrossPieces = true;
printbedFrameCrossPiece2Offset = eX < 350 ? -2*_zRodOffsetX - printbedFrameCrossPieceOffset() : -scs_size(scs_type).x/2 - 50;


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

module corkUnderlay(size, boltHoles, underlayThickness=3) {
    vitamin(str("corkUnderlay(", size, "): Cork underlay ", size.x, "mm x ", size.y, "mm"));

    color("tan")
        difference() {
            rounded_cube_xy([size.x, size.y, underlayThickness], 1);
            for (i = boltHoles)
                translate(i)
                    rounded_cube_xy([15, 15, underlayThickness + 2*eps], 1, xy_center=true);
        }
}

module magneticBase(size, boltHoles) {
    vitamin(str("magneticBase(", size, "): Magnetic base ", size.x, "mm x ", size.y, "mm"));
    vitamin(": PEI coated spring steel build plate 250mm x 250mm");

    color(grey(20))
        explode(15)
            difference() {
                magneticBaseSize = [size.x, size.y, 1];
                    rounded_cube_xy(magneticBaseSize, 1);
                for (i = boltHoles)
                    translate(i)
                        boltHole(7, magneticBaseSize.z, cnc=true);
                if (size.x == 254)
                    for (y = [37.5, -37.5])
                        translate([7, size.x/2 + y, 0])
                            boltHole(6, magneticBaseSize.z, cnc=true);
            }
}

module siliconeHeater(size) {
    heaterSize = [200, 200, 2];
    vitamin(str("siliconeHeater(", size, "): Silicone Heater with thermistor - ", heaterSize.x, "mm x ", heaterSize.y, "mm"));
    translate([(size.x - heaterSize.x)/2, (size.y - heaterSize.y)/2, -size.z - heaterSize.z])
        color("OrangeRed")
            explode(-20)
                rounded_cube_xy(heaterSize, 1);
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
        for (i = [0: ways - 1])
            translate([0, i * pitch - width / 2 + pitch / 2, (above + below) / 2 - below])
                cube([1, 1, above + below], center=true);
}


module heatedBed(size=_heatedBedSize, boltHoles=[], underlayThickness=0) {
    if (size.x == 254)
        vitamin(": Voron Trident Build Plate - 250x250");
    else
        vitamin(str("heatedBed(", size, "): Heated Bed ", size.x, "mm x ", size.y, "mm"));
    translate([-_heatedBedSize.y/2, 0, 0]) {
        if (size.x == 235)
            translate([_heatedBedSize.x - 20, 0, 1])
                rotate([90, 90, 0])
                    molex_400(6);

        translate_z(_printbed4PointSupport ? 0 : underlayThickness)
        color("silver")
            difference() {
                rounded_cube_xy(size, 1);
                for (i = boltHoles)
                    translate(i)
                        if (_printbed4PointSupport)
                            translate_z(size.z + eps)
                                rotate([180, 0, 0]) {
                                    boltHoleM3(size.z, cnc=true);
                                    screw_countersink(M3_cs_cap_screw);
                                }
                        else
                            if (size.x == 254)
                                translate_z(size.z)
                                    vflip()
                                        boltHoleM3Counterbore(size.z, boltHeadTolerance=1, cnc=true);
                            else
                                boltHoleM3(size.z, cnc=true);
                *for (i = [ [holeOffset, holeOffset], [size.x - holeOffset, holeOffset] ])
                    translate(i)
                        boltHoleM3(size.z - underlayThickness);
                if (size.x == 254)
                    for (y = [37.5, -37.5])
                        translate([7, size.x/2 + y, 0])
                            boltHoleM3Tap(size.z, cnc=true);

            }
        // add magnetic layer
        translate_z(size.z + (_printbed4PointSupport ? 0 : underlayThickness))
            if (_printbed4PointSupport) {
                magneticBase(size, boltHoles);
            } else if (size.x == 254) {
                //magneticBase(size, boltHoles);
                siliconeHeater(size);
            } else {
                offset = 5;
                printSurfaceSize = [size.x - 2*offset, size.y - 2*offset, 1];
                translate([offset, offset, 0])
                    color("OrangeRed")
                        explode(10)
                            rounded_cube_xy(printSurfaceSize, 1);
            }

        // add underlay
        *if (_printbed4PointSupport)
            foamUnderlay(size, holeOffset, 7);
        //else
            //explode(-40)
              //  corkUnderlay(size, boltHoles, underlayThickness);

        spring  = ["spring", 8, 0.9, 20, 10, 1, false, 0, "lightblue"];
        supportBoltLength = _printbed4PointSupport ? 45 : 12;
        if (_printbed4PointSupport && (is_undef($hide_bolts) || $hide_bolts == false)) for (i=boltHoles) {
            translate(i) {
                explode(0.1, false)
                    translate_z(size.z + eps)
                        if (_printbed4PointSupport)
                            boltM4Countersunk(supportBoltLength);
                        else
                            boltM3Caphead(supportBoltLength);
                if (_printbed4PointSupport) {
                    translate_z(-springLength + underlayThickness)
                        explode(-70)
                            comp_spring(spring, springLength);
                    explode(-200)
                        translate_z(-springLength - eSize/2 - 1)
                            HeatedBedLevelingKnob();
                }
            }
        }
    }
}

module siliconeSpacer() {
    vitamin(str("Silicone Spacer(", 18, ", ", 16, "): Silicone Spacer ", 18, "mm x ", 16, "mm"));
    color("FireBrick")
        tube(8, 2, 18);
    if($children)
        translate_z(18)
            explode(10, true)
                children();
}
module heatedBedHardware(size=_heatedBedSize, boltHoles, underlayThickness=0) {

    module oRing() {
        thickness = 2;
        explode(5, true)
            translate_z(thickness/2)
                color("FireBrick")
                    O_ring(4, thickness);
        if($children)
            translate_z(thickness)
                explode(10, true)
                    children();
    }
    if (size.x == 254)
        for (y = [37.5, -37.5])
            translate([-size.y/2 + 7, size.x/2 + y, underlayThickness + size.z])
                boltM3Caphead(8);

    translate([-size.y/2, 0, underlayThickness + size.z])
    //explode(-10, true)
        for (i = boltHoles)
            translate(i)
                if (size.x == 254) {
                    translate_z(-4)
                        boltM3Caphead(25);
                    translate_z(-size.z)
                        vflip()
                            explode(5,true)
                                translate_z(size.z + 1)
                                    siliconeSpacer()
                                        translate_z(-7)
                                            rotate(90)
                                                explode(5)
                                                    nutM3SlidingT();
                } else {
                    boltM3Caphead(20);
                    translate_z(-size.z)
                        vflip()
                            explode(5,true)
                                washer(M3_washer)
                                    oRing()
                                        washer(M3_washer)
                                            oRing()
                                                washer(M3_washer)
                                                    oRing()
                                                        washer(M3_washer)
                                                            oRing()
                                                                washer(M4_penny_washer)
                                                                    translate_z(2)
                                                                        rotate(90)
                                                                            explode(5)
                                                                                nutM3Hammer();
                }
}

module printbedFrameCrossPiece() {
    fSize = _printbedExtrusionSize;
    translate([-_printbedArmSeparation/2, 0, 0]) {
        extrusionOX2040HEndBolts(_printbedArmSeparation);
        if (!_useBlindJoints) {
            translate([0, 2*fSize, fSize/2]) {
                translate([_printbedArmSeparation, 0, 0])
                    explode([40, 0, 0])
                        rotate([0, 0, 90])
                            extrusionInnerCornerBracket();
                explode([-40, 0, 0])
                    rotate([0, 180, -90])
                        extrusionInnerCornerBracket();
            }
            translate([0, 0, fSize/2]) {
                translate([_printbedArmSeparation, 0, 0])
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
            explode([_printbedArmSeparation/2 + 10, 0, 0])
                rotate([-90, 0, 0])
                    nutM4SlidingT();
            rotate([90, 0, 0])
                explode(60)
                    boltM4Buttonhead(12);
        }
        translate([-antiBacklashNutBoltSeparation()/2, 0, 0]) {
            explode([-_printbedArmSeparation/2 - 10, 0, 0])
                rotate([-90, 0, 0])
                    nutM4SlidingT();
            rotate([90, 0, 0])
                explode(60)
                    boltM4Buttonhead(12);
        }
    }
}

//!1. Slide the **Z_Carriage_Center_assembly** to the approximate center of the first 2040 extrusion and loosely tighten
//! the bolts. The bolts will be fully tightened when the Z_Carriage is aligned.
//!2. Slide the 2040 extrusion into the 2020 extrusions and loosely tighten the bolts. The bolts will be fully tightened after
//!the Z carriages are added.
//
module Printbed_Frame_assembly()
assembly("Printbed_Frame", big=true, ngb=true) {
    size = [
        _heatedBedSize.x,
        !is_undef(_useDualZRods) && _useDualZRods ? eY - 3 : eY <= 250 ? 225 : eY <= 300 ? 265 : eY <= 350 ? 300 : 375,
        _printbedExtrusionSize + _heatedBedSize.z
    ];
    fSize = _printbedExtrusionSize;
    yOffset = scs_size(scs_type).x/2; // 42/2

    translate([-_printbedArmSeparation/2, 0, -fSize/2]) {
        for (x = [-fSize/2, _printbedArmSeparation + fSize/2])
            explode([x < 0 ? -50 : 50, 0, 0])
                difference() {
                    translate([x - fSize/2, -yOffset, 0])
                        extrusionOY(size.y, fSize);
                    // access holes for Z_Carriage bolts
                    if (!zCarriageTab())
                        for (y = [scs_screw_separation_x(scs_type), -scs_screw_separation_x(scs_type)])
                            translate([x + fSize/2, -yOffset + (scs_size(scs_type).x - y)/2, fSize/2])
                                rotate([0, -90, 0])
                                    jointBoltHole();
                    // access holes for crosspiece
                    translate([x + fSize/2, 0, fSize/2]) {
                        for (y = [fSize/2, 3*fSize/2])
                            rotate([0, -90, 0]) {
                                translate([0, y + printbedFrameCrossPieceOffset(), 0])
                                    jointBoltHole();
                                if (dualCrossPieces)
                                    translate([0, -y + eY + printbedFrameCrossPiece2Offset, 0])
                                        jointBoltHole();
                            }
                    }
                    if (_printbed4PointSupport) {
                        for (y = [_heatedBedHoleOffset, _heatedBedSize.y - _heatedBedHoleOffset])
                            translate([x, y + heatedBedOffset.y, 0]) {
                                //echo(y=y + yOffset + heatedBedOffset.y);
                                //echo(y=size.y-(y + yOffset + heatedBedOffset.y));
                                // hole for bolt
                                cylinder(h=eSize, r=M4_clearance_radius);
                                //cutout for spring
                                translate_z(eSize - 3)
                                    cylinder(h=4, r=5);
                                *translate_z(-1)
                                    cylinder(h=4, r=5);
                            }
                    } else {
                        ys = size.x == 254
                            ? (x != -fSize/2 ? [_heatedBedHoleOffset, _heatedBedSize.y - _heatedBedHoleOffset] : [_heatedBedSize.y/2])
                            : (x == -fSize/2 ? [_heatedBedHoleOffset, _heatedBedSize.y - _heatedBedHoleOffset] : [_heatedBedSize.y/2]);
                        for (y = ys)
                            translate([x, y + heatedBedOffset.y, 0])
                                cylinder(h=eSize, r=M4_clearance_radius);
                    }
            }

        translate([_printbedArmSeparation/2, 0]) {
            translate([0, printbedFrameCrossPieceOffset(), 0])
                printbedFrameCrossPiece();
            if (dualCrossPieces)
                //translate([0, eY - 2*eSize - 6 - printbedFrameCrossPieceOffset(), 0])
                //translate([0, eY + 2*eSize - _zRodOffsetX - 3*printbedFrameCrossPieceOffset(), 0])
                translate([0, eY + printbedFrameCrossPiece2Offset, 0])
                    rotate(180)
                        printbedFrameCrossPiece();
        }
    *if (!_printbed4PointSupport) {
        translate([-fSize/2, heatedBedOffset.y + _heatedBedSize.y/2, 27])
            boltM3Caphead(20);
        translate([fSize/2 + _printbedArmSeparation, - yOffset, 27]) {
            //boltM3Caphead(20);
            translate([0, yOffset + heatedBedOffset.y + _heatedBedHoleOffset, 0])
                boltM3Caphead(20);
            translate([0, yOffset + heatedBedOffset.y + _heatedBedSize.y - _heatedBedHoleOffset, 0])
                boltM3Caphead(20);
            //echo(eOffset = yOffset + heatedBedOffset.y + _heatedBedHoleOffset - 1.5);
        }
    }
    /*
    translate([_printbedArmSeparation, 0, fSize])
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
        translate([_printbedArmSeparation, 0, -fSize])
            explode([-50, -40, 0], true)
                rotate([-90, -90, 90])
                    Printbed_Corner_Bracket_stl();
        }
    */
    }
    explode([0, -50, 0])
        Z_Carriage_Center_assembly();
    yRight = eY - 2*_zRodOffsetX;
    if (is_true(_useDualZMotors))
        translate([0, yRight, 0])
            rotate(180)
                explode([150, 0, 0])
                    Z_Carriage_Center_assembly();

    explode([-80, 0, 0], true)
        translate([-_printbedArmSeparation/2 - eSize, cableChainBracketOffsetX(), -eSize/2])
            rotate(90) {
                color(pp3_colour)
                    Cable_Chain_Bracket_stl();
                Cable_Chain_Bracket_hardware();
            }
}


//!1. Lay the frame on a flat surface and  slide the Z carriages onto the frame as shown.
//!2. Ensure the Z carriages are square and aligned with the end of the frame and then tighten the bolts on Z_Carriages.
//!3. Ensure the 2040 extrusion is pressed firmly against the Z_Carriages and tighten the hidden bolts in the frame.
//
module Printbed_Frame_with_Z_Carriages_assembly() pose(a=[55, 180, 25 - 50])
assembly("Printbed_Frame_with_Z_Carriages", big=true, ngb=true) {

    Printbed_Frame_assembly();
    yRight = eY - 2*_zRodOffsetX;

    translate([-zRodSeparation()/2, 0, 0]) {
        explode([0, -120, 0])
            if (zCarriageTab())
                Z_Carriage_Left_assembly();
            else
                mirror([1, 0, 0])
                    zCarriageSideAssembly();
        if (is_true(_useDualZRods))
            translate([0, yRight, 0])
                rotate(180)
                    if (zCarriageTab())
                        Z_Carriage_Right_assembly();
                    else
                        zCarriageSideAssembly();
    }
    translate([zRodSeparation()/2, 0, 0]) {
        explode([0, -120, 0])
            if (zCarriageTab())
                Z_Carriage_Right_assembly();
            else
                zCarriageSideAssembly();
        if (is_true(_useDualZRods))
            translate([0, yRight, 0])
                rotate(180)
                    if (zCarriageTab())
                        Z_Carriage_Left_assembly();
                    else
                mirror([1, 0, 0])
                    zCarriageSideAssembly();
    }
}

//!1. Attach the print surface to the heated bed.
//!2. Insert a bolt into each of the bolt holes in the heated bed and add a silicone spacer and a hammer nut as shown.
//
module Heated_Bed_assembly()
assembly("Heated_Bed", big=true) {
    boltHoles = boltHoles(_heatedBedSize, _heatedBedHoleOffset, _printbed4PointSupport);
    underlayThickness = 3;
    heatedBed(_heatedBedSize, boltHoles, underlayThickness);
    heatedBedHardware(_heatedBedSize, boltHoles, underlayThickness);
}

//!1. Spiral wrap the wires from the heated bed up to where they will enter the cable chain.
//!2. Attach the headed bed to the frame.
//!3. Thread the heated be wires through the cable chain and attach the cable chain to the **Cable_Chain_Bracket**.
//!4. Secure the wires with cable ties.
//
module Printbed_assembly()  pose(a=[210, 0, 320])
assembly("Printbed", big=true) {

    if (is_undef(_printbedKinematic) || _printbedKinematic == false) {
        translate([eSize + _zRodOffsetX, eSize + zRodSeparation()/2 + _zRodOffsetY, 0])
            rotate(-90) {
                Printbed_Frame_with_Z_Carriages_assembly();
                boltHoles = boltHoles(_heatedBedSize, _heatedBedHoleOffset, _printbed4PointSupport);
                underlayThickness = 3;
                // add the heated bed
                translate(heatedBedOffset) {
                    if (_printbed4PointSupport)
                            explode(120, true)
                                heatedBed(_heatedBedSize, boltHoles, underlayThickness);
                    else {
                        if (_heatedBedSize.x != 254)
                            translate([-_heatedBedSize.y/2, 0, 0])
                                explode(40)
                                    corkUnderlay(_heatedBedSize, boltHoles, underlayThickness);
                        explode(120, true)
                            Heated_Bed_assembly();
                    }
                }
                translate([-_printbedArmSeparation/2 - eSize, cableChainBracketOffsetX(), -eSize/2])
                    rotate(90)
                        Cable_Chain_Bracket_cable_ties();
            }
        translate_z(-bedHeight())
            explode([-50, 0, 0])
                baseDragChain();
    }
}

module heatedBed_only() {
    // display the heated bed, for debugging
    translate([eSize + _zRodOffsetX, eSize + zRodSeparation()/2 + _zRodOffsetY, 0])
        rotate(-90) {
            boltHoles = boltHoles(_heatedBedSize, _heatedBedHoleOffset, _printbed4PointSupport);
            underlayThickness = 3;
            translate(heatedBedOffset) {
                if (_printbed4PointSupport)
                        explode(120, true)
                        heatedBed(_heatedBedSize, boltHoles, underlayThickness);
                else {
                    translate([-_heatedBedSize.y/2, 0, 0])
                        explode(40)
                            corkUnderlay(_heatedBedSize, boltHoles, underlayThickness);
                    explode(80, true)
                        Heated_Bed_assembly();
                }
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

module Printbed_Strain_Relief_hardware() {
    size = [40, eSize, 5];
    fillet = 1.5;

    translate([-size.x/2, 0, 0])
        for (x = [5, size.x - 5])
            translate([x, size.y/2, size.z])
                boltM3CountersunkHammerNut(_frameBoltLength);
}

module Printbed_Strain_Relief_Clamp_stl() {
    size = [eSize, eSize, 3];
    fillet = 1.5;

    stl("Printbed_Strain_Relief_Clamp")
        color(pp2_colour)
            translate([-size.x/2, 0, 8.5])
                difference() {
                    rounded_cube_xy(size, fillet);
                    for (y = [sideThickness/2, size.y - sideThickness/2])
                        translate([size.x/2, y, 0])
                            boltHoleM3(size.z, twist=5);
                }
}

module Printbed_Strain_Relief_Clamp_hardware() {
    size = [40, eSize, 5];
    fillet = 1.5;

    translate([-size.x/2, 0, 0])
        for (y = [sideThickness/2, size.y - sideThickness/2])
            translate([size.x/2, y, 11.5])
                boltM3Buttonhead(10);
}

module Printbed_Strain_Relief_assembly()
assembly("Printbed_Strain_Relief") {
    translate([0, eX - 2*eSize + printbedFrameCrossPiece2Offset, -eSize/2])
        rotate([90, 0, 0]) {
            stl_colour(pp1_colour)
                Printbed_Strain_Relief_stl();
            Printbed_Strain_Relief_hardware();
            stl_colour(pp2_colour)
                translate_z(wiringDiameter + 2)
                    Printbed_Strain_Relief_Clamp_stl();
        }
}
