include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <carriageTypes.scad>

use <../Parameters_Positions.scad>
include <../Parameters_Main.scad>


module xRailBoltPositions() {
    xCarriageType = xCarriageType();
    xRailType = carriage_rail(xCarriageType);
    yRailType = yRailType();
    translate([eSize + eX/2, carriagePosition().y, -eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType)])
        for (x = [1, 3], s = [-_xRailLength/2, _xRailLength/2 - 2*rail_pitch(xRailType)])
            translate([s + x*rail_pitch(xRailType)/2, 0, rail_height(xRailType) - rail_bore_depth(xRailType)])
                children();
}

module xRail(carriagePosition=carriagePosition(), xCarriageType=undef) {
    xCarriageType = is_undef(xCarriageType) ? xCarriageType() : xCarriageType;
    xRailType = carriage_rail(xCarriageType);
    yRailType = yRailType();
    translate([eSize + eX/2, carriagePosition.y, -eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType)])
        rotate(180)
            if (is_undef($hide_rails) || $hide_rails == false)
                rail_assembly(xCarriageType, _xRailLength, eX - _xRailLength/2 - 5 - carriagePosition.x, carriage_end_colour="green", carriage_wiper_colour="red");
}

module xRailCarriagePosition(t=undef) {
    xCarriageType = xCarriageType();
    xRailType = carriage_rail(xCarriageType);
    yRailType = yRailType();
    translate([ carriagePosition(t).x + eSize + 5 - (eX - _xRailLength)/2,
                carriagePosition(t).y,
                eZ - eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType) + carriage_height(xCarriageType)
            ])
        rotate(180)
            children();
}

/*
//!You may wish to temporarily put a nut and bolt through each end of the x axis linear rail, so that the carriage does
//!not fall off the rail before it is attached to the frame.
//!
//!1. Bolt the X carriage to the carriage on the linear rail.
//!2. Bolt on the bottom of the X carriage.
//
module X_Rail_with_X_Carriage_assembly()
assembly("X_Rail_with_X_Carriage") {
    xRail();
    xRailCarriagePosition()
        rotate(180)
        Printhead_MGN12H_assembly();
        explode(90, true) {
            X_Carriage_MGN12H_assembly();
            xCarriageBoltPositions()
                boltM3Caphead(8);
            explode(-70, true)
                X_Carriage_Bottom_stl();
        }
}
*/
