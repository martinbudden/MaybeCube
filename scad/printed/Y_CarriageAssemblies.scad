//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <NopSCADlib/vitamins/rails.scad>

use <../utils/carriageTypes.scad>

use <../../../BabyCube/scad/printed/Y_Carriage.scad>

include <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>


function plainIdlerOffset() = [-yRailShiftX() + plainIdlerPulleyOffset().x, 0, undef];
function toothedIdlerOffset() = [-yRailShiftX(), 0, undef];
function tongueOffset() = (eX + 2*eSize - _xRailLength - 2*yRailOffset().x)/2;
function pulleyWasherHeight(coreXYIdlerBore=coreXYIdlerBore()) = 2*washer_thickness(coreXYIdlerBore == 3 ? M3_washer : coreXYIdlerBore == 4 ? M4_washer : M5_washer);

topInset = 0;
yCarriageInserts = true;
blockOffsetX = _coreXYDescriptor == "GT2_20_25" ? 2 : 0;
blockOffset = _coreXYDescriptor == "GT2_20_25" ? [blockOffsetX, 0.5] : 0.5;

idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;

holeRadius = coreXYIdlerBore() == 3 ? M3_tap_radius : coreXYIdlerBore() == 4 ? M4_tap_radius : M5_tap_radius;


module Y_Carriage_Left_16_stl() {
    pulleyStackHeight = idlerHeight + pulleyWasherHeight();
    assert(pulleyStackHeight + yCarriageBraceThickness() == coreXYSeparation().z);
    //xMin = xPos(3);
    //endStopOffsetX = max(0, xMin - 68); // 12
    //endStopOffsetX = max(0, xMin - 75); // 5
    //endStopOffsetX = 5; // set this to zero and instead set software endstop offset (X_MIN_POS in Marlin) to -12
    endStopOffsetX = 10.15;

    stl("Y_Carriage_Left_16")
        color(pp2_colour)
            Y_Carriage(carriageType(_yCarriageDescriptor), idlerHeight, coreXYIdlerBore(), railType(_xCarriageDescriptor), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffset, endStopOffsetX, tongueOffset(), plainIdlerOffset(), toothedIdlerOffset(), topInset, inserts=yCarriageInserts, left=true, cnc=false);
}

module Y_Carriage_Right_16_stl() {
    endStopOffsetX = 0;
    stl("Y_Carriage_Right_16")
        color(pp2_colour)
            Y_Carriage(carriageType(_yCarriageDescriptor), idlerHeight, coreXYIdlerBore(), railType(_xCarriageDescriptor), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffset, endStopOffsetX, tongueOffset(), plainIdlerOffset(), toothedIdlerOffset(), topInset, inserts=yCarriageInserts, left=false, cnc=false);
}

module Y_Carriage_Left_25_stl() {
    pulleyStackHeight = idlerHeight + pulleyWasherHeight();
    assert(pulleyStackHeight + yCarriageBraceThickness() == coreXYSeparation().z);
    endStopOffsetX = 10.15;
    stl("Y_Carriage_Left_25")
        color(pp2_colour)
            Y_Carriage(carriageType(_yCarriageDescriptor), idlerHeight, coreXYIdlerBore(), railType(_xCarriageDescriptor), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffset, endStopOffsetX, tongueOffset(), plainIdlerOffset(), toothedIdlerOffset(), topInset, inserts=yCarriageInserts, left=true, cnc=false);
}

module Y_Carriage_Right_25_stl() {
    endStopOffsetX = 0;
    stl("Y_Carriage_Right_25")
        color(pp2_colour)
            Y_Carriage(carriageType(_yCarriageDescriptor), idlerHeight, coreXYIdlerBore(), railType(_xCarriageDescriptor), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffset, endStopOffsetX, tongueOffset(), plainIdlerOffset(), toothedIdlerOffset(), topInset, inserts=yCarriageInserts, left=false, cnc=false);
}

module Y_Carriage_Left_AL_dxf() {
    endStopOffsetX = 5;
    dxf("Y_Carriage_Left_AL")
        color(silver)
            Y_Carriage(carriageType(_yCarriageDescriptor), idlerHeight, coreXYIdlerBore(), railType(_xCarriageDescriptor), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffset, endStopOffsetX, tongueOffset(), plainIdlerOffset(), toothedIdlerOffset(), topInset, left=true, cnc=true);
}

module Y_Carriage_Right_AL_dxf() {
    endStopOffsetX = 0;
    dxf("Y_Carriage_Right_AL")
        color(silver)
            Y_Carriage(carriageType(_yCarriageDescriptor), idlerHeight, coreXYIdlerBore(), railType(_xCarriageDescriptor), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffset, endStopOffsetX, tongueOffset(), plainIdlerOffset(), toothedIdlerOffset(), topInset, left=false, cnc=true);
}

module Y_Carriage_Brace_Left_16_stl() {
    stl("Y_Carriage_Brace_Left_16")
        color(pp3_colour)
            yCarriageBrace(carriageType(_yCarriageDescriptor), yCarriageBraceThickness(), plainIdlerOffset(), holeRadius, _coreXYDescriptor == "GT2_20_25" ? blockOffsetX : undef, left=true);
}

module Y_Carriage_Brace_Right_16_stl() {
    stl("Y_Carriage_Brace_Right_16")
        color(pp3_colour)
            yCarriageBrace(carriageType(_yCarriageDescriptor), yCarriageBraceThickness(), plainIdlerOffset(), holeRadius, _coreXYDescriptor == "GT2_20_25" ? blockOffsetX : undef, left=false);
}

module Y_Carriage_Brace_Left_25_stl() {
    stl("Y_Carriage_Brace_Left_25")
        color(pp3_colour)
            yCarriageBrace(carriageType(_yCarriageDescriptor), yCarriageBraceThickness(), plainIdlerOffset(), holeRadius, _coreXYDescriptor == "GT2_20_25" ? blockOffsetX : undef, left=true);
}

module Y_Carriage_Brace_Right_25_stl() {
    stl("Y_Carriage_Brace_Right_25")
        color(pp3_colour)
            yCarriageBrace(carriageType(_yCarriageDescriptor), yCarriageBraceThickness(), plainIdlerOffset(), holeRadius, _coreXYDescriptor == "GT2_20_25" ? blockOffsetX : undef, left=false);
}

//!1. Insert the threaded inserts into the **Y_Carriage_Left** as shown.
//!2. Drive a long M3 bolt through the Y carriage from the insert side to self tap the part of the hole after the insert. Once this
//!hole is tapped, remove the bolt.
//!3. Bolt the **Y_Carriage_Brace_Left* and the pulleys to the **Y_Carriage_Left** as shown. Note the position of the washers.
//!4. Tighten the bolts until the pulleys no longer turn freely and then loosen by about 1/4 turn so the pulleys can again turn.
//
module Y_Carriage_Left_assembly() pose(a=[55 + 180, 0, 25])
assembly("Y_Carriage_Left", ngb=true) {

    yCarriageType = carriageType(_yCarriageDescriptor);
    railOffsetX = coreXYPosBL().x;

    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulley_height(plainIdler) + pulleyWasherHeight();

    translate([railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
        rotate([180, 0, 0]) {
            stl_colour(pp2_colour)
                if (_coreXYDescriptor == "GT2_20_25")
                    Y_Carriage_Left_25_stl();
                else
                    Y_Carriage_Left_16_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp3_colour)
                            if (_coreXYDescriptor == "GT2_20_25")
                                Y_Carriage_Brace_Left_25_stl();
                            else
                                Y_Carriage_Brace_Left_16_stl();
            yCarriagePulleys(yCarriageType, plainIdler, toothedIdler, yCarriageThickness(), yCarriageBraceThickness(), plainIdlerOffset(), toothedIdlerOffset(), blockOffsetX, left=true);
            if (yCarriageInserts)
                Y_Carriage_inserts(yCarriageType, tongueOffset(), railType(_xCarriageDescriptor), _xRailLength, thickness=yCarriageTongueThickness(yCarriageType));
       }
}

//!1. Insert the threaded inserts into the **Y_Carriage_Right** as shown.
//!2. Drive a long M3 bolt through the Y carriage from the insert side to self tap the part of the hole after the insert. Once this
//!hole is tapped, remove the bolt.
//!3. Bolt the **Y_Carriage_Brace_Right* and the pulleys to the **Y_Carriage_Right** as shown. Note the position of the washers.
//!4. Tighten the bolts until the pulleys no longer turn freely and then loosen by about 1/4 turn so the pulleys can again turn.
//
module Y_Carriage_Right_assembly() pose(a=[55 + 180, 0, 25])
assembly("Y_Carriage_Right", ngb=true) {

    yCarriageType = carriageType(_yCarriageDescriptor);
    railOffsetX = coreXYPosBL().x;

    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulley_height(plainIdler) + pulleyWasherHeight();

    translate([-railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
        rotate([180, 0, 180]) {
            stl_colour(pp2_colour)
                if (_coreXYDescriptor == "GT2_20_25")
                    Y_Carriage_Right_25_stl();
                else
                    Y_Carriage_Right_16_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + 2*eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp3_colour)
                            if (_coreXYDescriptor == "GT2_20_25")
                                Y_Carriage_Brace_Right_25_stl();
                            else
                                Y_Carriage_Brace_Right_16_stl();
            yCarriagePulleys(yCarriageType, plainIdler, toothedIdler, yCarriageThickness(), yCarriageBraceThickness(), plainIdlerOffset(), toothedIdlerOffset(), blockOffsetX, left=false);
            if (yCarriageInserts)
                Y_Carriage_inserts(yCarriageType, tongueOffset(), railType(_xCarriageDescriptor), _xRailLength, thickness=yCarriageTongueThickness(yCarriageType));
        }
}

module Y_Carriage_bolts(yCarriageType, thickness, left) {
    railOffsetX = coreXYPosBL().x;

    translate([left ? railOffsetX : -railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
        rotate([180, 0, left ? 0 : 180])
            yCarriageBolts(yCarriageType, thickness);
}
