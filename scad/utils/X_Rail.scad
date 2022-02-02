include <carriageTypes.scad>

include <../Parameters_Main.scad>


module xRailBoltPositions(carriagePosition) {
    xCarriageType = carriageType(_xCarriageDescriptor);
    xRailType = carriage_rail(xCarriageType);
    yRailType = railType(_yCarriageDescriptor);
    translate([eSize + eX/2, carriagePosition.y, -eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType)])
        for (x = [1, 3], s = [-_xRailLength/2, _xRailLength/2 - 2*rail_pitch(xRailType)])
            translate([s + x*rail_pitch(xRailType)/2, 0, rail_height(xRailType) - rail_bore_depth(xRailType)])
                children();
}

module xRail(carriagePosition, xCarriageType=undef) {
    xCarriageType = is_undef(xCarriageType) ? carriageType(_xCarriageDescriptor) : xCarriageType;
    xRailType = carriage_rail(xCarriageType);
    yRailType = railType(_yCarriageDescriptor);
    pos = eX - _xRailLength/2 - 5 - carriagePosition.x;
    translate([eSize + eX/2, carriagePosition.y, -eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType)])
        rotate(180)
            if (is_undef($hide_rails) || $hide_rails == false)
                rail_assembly(xCarriageType, _xRailLength, pos, carriage_end_colour="green", carriage_wiper_colour="red");
            else
                translate([pos, 0])
                    carriage(xCarriageType, end_colour="green", wiper_colour="red");

}
function xRailCarriagePositionZ() =
    let(xCarriageType = carriageType(_xCarriageDescriptor),
        xRailType = carriage_rail(xCarriageType),
        yRailType = railType(_yCarriageDescriptor))
    eZ - eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType) + carriage_height(xCarriageType);

module xRailCarriagePosition(carriagePosition, rotate=180) {
    xCarriageType = carriageType(_xCarriageDescriptor);
    xRailType = carriage_rail(xCarriageType);
    yRailType = railType(_yCarriageDescriptor);
    translate([ carriagePosition.x + eSize + 5 - (eX - _xRailLength)/2,
                carriagePosition.y,
                eZ - eSize - rail_height(xRailType) - rail_height(yRailType) + carriage_clearance(xCarriageType) + carriage_height(xCarriageType)
            ])
        rotate(rotate)
            children();
}
