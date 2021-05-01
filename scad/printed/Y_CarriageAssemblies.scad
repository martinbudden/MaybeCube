include <../global_defs.scad>

include <NopSCADlib/core.scad>

include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../utils/carriageTypes.scad>

use <Y_Carriage.scad>

use <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>
include <../Parameters_Main.scad>


function pulleyOffset() = [-yRailShiftX(), 0, yCarriageThickness() + pulleyStackHeight()/2];
function tongueOffset() = (eX + 2*eSize - _xRailLength - 2*yRailOffset().z)/2;

topInset = 0;


module Y_Carriage_Left_stl() {
    tongueOffset = tongueOffset();
    endStopOffsetX = 12;
    chamfer = _xCarriageType == "9C" || _xCarriageType == "9H" ? 1 : 0;

    stl("Y_Carriage_Left")
        color(pp2_colour)
            Y_Carriage(yCarriageType(), xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), endStopOffsetX, tongueOffset, pulleyOffset(), left=true, cnc=false);
}

module Y_Carriage_Right_stl() {
    tongueOffset = tongueOffset();
    endStopOffsetX = 2;
    chamfer = _xCarriageType == "9C" || _xCarriageType == "9H" ? 1 : 0;

    stl("Y_Carriage_Right")
        color(pp2_colour)
            Y_Carriage(yCarriageType(), xRailType(), _xRailLength, yCarriageThickness(), chamfer, yCarriageBraceThickness(), endStopOffsetX, tongueOffset, pulleyOffset(), left=false, cnc=false);
}

module Y_Carriage_Brace_Left_stl() {
    stl("Y_Carriage_Brace_Left")
        color(pp1_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), left=true);
}

module Y_Carriage_Brace_Right_stl() {
    stl("Y_Carriage_Brace_Right")
        color(pp1_colour)
            yCarriageBrace(yCarriageType(), yCarriageBraceThickness(), pulleyOffset(), left=false);
}

module Y_Carriage_Left_assembly()
assembly("Y_Carriage_Left", ngb=true) {

    railOffset = [1.5*eSize, 0, eZ - eSize];

    translate([railOffset.x, carriagePosition().y, railOffset.z - carriage_height(yCarriageType())])
        rotate([180, 0, 0]) {
            stl_colour(pp2_colour)
                Y_Carriage_Left_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight() + eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp1_colour)
                            Y_Carriage_Brace_Left_stl();
            Y_Carriage_hardware(yCarriageType(), yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=true);
        }
}

module Y_Carriage_Right_assembly()
assembly("Y_Carriage_Right", ngb=true) {

    railOffset = [1.5*eSize, 0, eZ - eSize];

    translate([eX + 2*eSize - railOffset.x, carriagePosition().y, railOffset.z - carriage_height(yCarriageType())])
        rotate([180, 0, 180]) {
            stl_colour(pp2_colour)
                Y_Carriage_Right_stl();
            if (yCarriageBraceThickness())
                translate_z(yCarriageThickness() + pulleyStackHeight() + 2*eps)
                    explode(4*yCarriageExplodeFactor())
                        stl_colour(pp1_colour)
                            Y_Carriage_Brace_Right_stl();
            Y_Carriage_hardware(yCarriageType(), yCarriageThickness(), yCarriageBraceThickness(), pulleyOffset(), left=false);
        }
}
