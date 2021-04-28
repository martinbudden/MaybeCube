include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/rails.scad>

use <Y_Carriage.scad>

use <../utils/carriageTypes.scad>
use <../vitamins/bolts.scad>

include <../Parameters_Main.scad>
use <../Parameters_CoreXY.scad>

function pulleyOffset() = [-yRailShiftX(), 0, yCarriageThickness() + pulleyStackHeight()/2];
function tongueOffset() = (eX + 2*eSize - _xRailLength - 2*yRailOffset().z)/2;


yCarriageType = MGN12H_carriage;

module Y_Carriage_Left_stl() {
    tongueOffset = tongueOffset();
    endStopOffsetX = 12;
    chamfer = _xCarriageType == "9C" || _xCarriageType == "9H" ? 1 : 0;

    stl("Y_Carriage_Left")
        color(pp2_colour)
            Y_Carriage(yCarriageType, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), endStopOffsetX, tongueOffset, left=true, pulleyOffset=pulleyOffset(), cnc=false);
}

module Y_Carriage_Right_stl() {
    tongueOffset = tongueOffset();
    endStopOffsetX = 2;
    chamfer = _xCarriageType == "9C" || _xCarriageType == "9H" ? 1 : 0;

    stl("Y_Carriage_Right")
        color(pp2_colour)
            Y_Carriage(yCarriageType, xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), endStopOffsetX, tongueOffset, left=false, pulleyOffset=pulleyOffset(), cnc=false);
}

module Y_Carriage_Brace_Left_stl() {
    stl("Y_Carriage_Brace_Left")
        color(pp1_colour)
            yCarriageBrace(yCarriageType, yCarriageBraceThickness(), left=true);
}

module Y_Carriage_Brace_Right_stl() {
    stl("Y_Carriage_Brace_Right")
        color(pp1_colour)
            yCarriageBrace(yCarriageType, yCarriageBraceThickness(), left=false);
}

module Y_Carriage_Left_assembly()
assembly("Y_Carriage_Left", ngb=true) {

    rotate(90) {
        stl_colour(pp2_colour)
            Y_Carriage_Left_stl();
        translate_z(yCarriageThickness() + pulleyStackHeight())
            stl_colour(pp1_colour)
                Y_Carriage_Brace_Left_stl();
        Y_Carriage_hardware(yCarriageType, yCarriageThickness(), yCarriageBraceThickness(), left=true, pulleyOffset=pulleyOffset());
    }
}

module Y_Carriage_Right_assembly()
assembly("Y_Carriage_Right", ngb=true) {

    rotate(-90) {
        stl_colour(pp2_colour)
            Y_Carriage_Right_stl();
        translate_z(yCarriageThickness() + pulleyStackHeight())
            stl_colour(pp1_colour)
                Y_Carriage_Brace_Right_stl();
        Y_Carriage_hardware(yCarriageType, yCarriageThickness(), yCarriageBraceThickness(), left=false, pulleyOffset=pulleyOffset());
    }
}
