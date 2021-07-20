//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../utils/carriageTypes.scad>

use <../../../BabyCube/scad/printed/Y_Carriage.scad>

use <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>
include <../Parameters_Main.scad>


function pulleyOffset() = [-yRailShiftX(), 0, undef];
function tongueOffset() = (eX + 2*eSize - _xRailLength - 2*yRailOffset().x)/2;

topInset = 0;


module Y_Carriage_Left_stl() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    pulleyStackHeight = pulleyStackHeight(idlerHeight);
    assert(pulleyStackHeight + yCarriageBraceThickness() == coreXYSeparation().z);

    blockOffsetX = 0.5;
    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    //xMin = xPos(3);
    //endStopOffsetX = max(0, xMin - 68); // 12
    //endStopOffsetX = max(0, xMin - 75); // 5
    //endStopOffsetX = 5; // set this to zero and instead set software endstop offset (X_MIN_POS in Marlin) to -12
    endStopOffsetX = 11;

    stl("Y_Carriage_Left")
        color(pp2_colour)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=true, cnc=false);
}

module Y_Carriage_Right_stl() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = 0.5;
    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    endStopOffsetX = 0;

    stl("Y_Carriage_Right")
        color(pp2_colour)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=false, cnc=false);
}

module Y_Carriage_Left_AL_dxf() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = 0.5;
    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    //xMin = xPos(3);
    //endStopOffsetX = max(0, xMin - 68); // 12
    endStopOffsetX = 5;

    dxf("Y_Carriage_Left_AL")
        color(silver)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=true, cnc=true);
}

module Y_Carriage_Right_AL_dxf() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = 0.5;
    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    endStopOffsetX = 0;

    dxf("Y_Carriage_Right_AL")
        color(silver)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=false, cnc=true);
}

module Y_Carriage_Brace_Left_stl() {
    holeRadius = coreXYIdlerBore() == 3 ? M3_tap_radius : M5_tap_radius;

    stl("Y_Carriage_Brace_Left")
        color(pp3_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), holeRadius, left=true);
}

module Y_Carriage_Brace_Right_stl() {
    holeRadius = coreXYIdlerBore() == 3 ? M3_tap_radius : M5_tap_radius;

    stl("Y_Carriage_Brace_Right")
        color(pp3_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), holeRadius, left=false);
}

//!1. Bolt the **Y_Carriage_Brace_Left* and the pulleys to the **Y_Carriage_Left** as shown. Note the position of the washers.
//!2. Tighten the bolts until the pulleys no longer turn freely and then loosen by about 1/4 turn so the pulleys can again turn.
//
module Y_Carriage_Left_assembly() pose(a=[55 + 180, 0, 25])
assembly("Y_Carriage_Left", ngb=true) {

    yCarriageType = yCarriageType();
    railOffsetX = 1.5*eSize;

    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulleyStackHeight(pulley_height(plainIdler));

    translate([railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
        rotate([180, 0, 0]) {
            stl_colour(pp2_colour)
                Y_Carriage_Left_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp3_colour)
                            Y_Carriage_Brace_Left_stl();
            yCarriagePulleys(yCarriageType, plainIdler, toothedIdler, _beltWidth, yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=true);
        }
}

//!1. Bolt the **Y_Carriage_Brace_Right* and the pulleys to the **Y_Carriage_Right** as shown. Note the position of the washers.
//!2. Tighten the bolts until the pulleys no longer turn freely and then loosen by about 1/4 turn so the pulleys can again turn.
//
module Y_Carriage_Right_assembly() pose(a=[55 + 180, 0, 25])
assembly("Y_Carriage_Right", ngb=true) {

    yCarriageType = yCarriageType();
    railOffsetX = 1.5*eSize;

    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulleyStackHeight(pulley_height(plainIdler));

    translate([-railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
        rotate([180, 0, 180]) {
            stl_colour(pp2_colour)
                Y_Carriage_Right_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + 2*eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp3_colour)
                            Y_Carriage_Brace_Right_stl();
            yCarriagePulleys(yCarriageType, plainIdler, toothedIdler, _beltWidth, yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=false);
        }
}

module Y_Carriage_bolts(yCarriageType, thickness, left) {
    railOffsetX = 1.5*eSize;

    translate([left ? railOffsetX : -railOffsetX, carriagePosition().y, -carriage_height(yCarriageType)])
        rotate([180, 0, left ? 0 : 180])
            yCarriageBolts(yCarriageType, thickness);
}
