//!! This is a copy of the BabyCube file
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

    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    blockOffsetX = 0.5;
    endStopOffsetX = 0;

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
    tongueOffset = tongueOffset();
    blockOffsetX = 0.5;
    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    endStopOffsetX = 12;

    dxf("Y_Carriage_Left_AL")
        color(silver)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=true, cnc=true);
}

module Y_Carriage_Right_AL_dxf() {
    idlerHeight = pulley_height(coreXY_toothed_idler(coreXY_type()));
    blockOffsetX = 0.5;
    chamfer = _xCarriageDescriptor == "MGN9C" || _xCarriageDescriptor == "MGN9H" ? 1 : 0;
    endStopOffsetX = 2;

    dxf("Y_Carriage_Right_AL")
        color(silver)
            Y_Carriage(yCarriageType(), idlerHeight, _beltWidth, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), blockOffsetX, endStopOffsetX, tongueOffset(), pulleyOffset(), topInset, left=false, cnc=true);
}

module Y_Carriage_Brace_Left_stl() {
    holeRadius = coreXYIdlerBore() == 3 ? M3_tap_radius : M5_tap_radius;

    stl("Y_Carriage_Brace_Left")
        color(pp1_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), holeRadius, left=true);
}

module Y_Carriage_Brace_Right_stl() {
    holeRadius = coreXYIdlerBore() == 3 ? M3_tap_radius : M5_tap_radius;

    stl("Y_Carriage_Brace_Right")
        color(pp1_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), holeRadius, left=false);
}

module Y_Carriage_Left_assembly()
assembly("Y_Carriage_Left", ngb=true) {

    yCarriageType = yCarriageType();
    railOffset = [1.5*eSize, 0, eZ - eSize];

    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulleyStackHeight(pulley_height(plainIdler));

    translate([railOffset.x, carriagePosition().y, railOffset.z - carriage_height(yCarriageType)])
        rotate([180, 0, 0]) {
            stl_colour(pp2_colour)
                Y_Carriage_Left_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp1_colour)
                            Y_Carriage_Brace_Left_stl();
            Y_Carriage_hardware(yCarriageType, plainIdler, toothedIdler, _beltWidth, yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=true);
        }
}

module Y_Carriage_Right_assembly()
assembly("Y_Carriage_Right", ngb=true) {

    yCarriageType = yCarriageType();
    railOffset = [1.5*eSize, 0, eZ - eSize];

    plainIdler = coreXY_plain_idler(coreXY_type());
    toothedIdler = coreXY_toothed_idler(coreXY_type());
    pulleyStackHeight = pulleyStackHeight(pulley_height(plainIdler));

    translate([eX + 2*eSize - railOffset.x, carriagePosition().y, railOffset.z - carriage_height(yCarriageType)])
        rotate([180, 0, 180]) {
            stl_colour(pp2_colour)
                Y_Carriage_Right_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight + 2*eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp1_colour)
                            Y_Carriage_Brace_Right_stl();
            Y_Carriage_hardware(yCarriageType, plainIdler, toothedIdler, _beltWidth, yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=false);
        }
}
