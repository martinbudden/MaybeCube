include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/iecs.scad>
use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../printed/extruderBracket.scad>
use <../printed/extrusionChannels.scad>
use <../printed/IEC_Housing.scad>
use <../printed/XY_MotorMount.scad>

include <../vitamins/bolts.scad>
use <../vitamins/filament_sensor.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];
accessHoleRadius = 2.5;

function sidePanelSize(left) = [eY + 2*eSize - (left ? 0 : iecHousingSize().x + eSize), eZ, 3];
function partitionSize() = [eX, eZ, 3];
function partitionOffsetY() = xyMotorMountSize().y;


module sidePanelAccessHolePositions(size, left) {
    for (x = left ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [-size.y/2 + eSize/2, size.y/2 - eSize/2])
        translate([x, y])
            children();
    for (y = [3*eSize/2, 5*eSize/2, 7*eSize/2])
        translate([left ? size.x/2 - eSize/2 : -size.x/2 + eSize/2, y - size.y/2])
            children();
    if (left)
        for (y = [3*eSize/2, size.y - 3*eSize/2])
            translate([left ? -size.x/2 + eSize/2 : size.x/2 - eSize/2, y - size.y/2])
                children();
}

module sidePanelBoltHolePositionsX(size, left) {
    xPositionsLeft = size.x == 300 + 2*eSize
        ? [-size.x/2 + eSize + 50, 100, 0, size.x/2 - eSize - 50]
        : [-size.x/2 + 1.5*eSize, -(size.x - eSize)/6, (size.x - eSize)/6, size.x/2 - 1.5*eSize];
    xPositionsRight = [-size.x/2 + 3*eSize/2, 0, size.x/2 - eSize/2];
    for (x = left ? xPositionsLeft : xPositionsRight, y = [(-size.y + eSize)/2, (size.y - eSize)/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
}

module sidePanelBoltHolePositions(size, left) {
    for (x = left ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [-size.y/2 + eSize, size.y/2 - eSize])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
    if (!left)
        for (x = [size.x/2 - eSize/2], y = [spoolHeight() + 3*eSize/2 - size.y/2])
            translate([x, y])
                rotate(exploded() ? 0 : 90)
                    children();

    sidePanelBoltHolePositionsX(size, left)
        children();
    //for (x = [-size.x/2 + eSize/2, size.x/2 - eSize/2], y = [(size.y - eSize)/6, -(size.y - eSize)/6])
    for (x = left ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [size.y/2 - eSize - (size.y - 2*eSize)/3, -size.y/2 + eSize + (size.y - 2*eSize)/3])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
}

module Left_Side_Panel_dxf() {
    size = sidePanelSize(left=true);
    fillet = 1;
    sheet = PC3;

    dxf("Left_Side_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                sidePanelAccessHolePositions(size, left=true)
                    circle(r = accessHoleRadius);
                sidePanelBoltHolePositions(size, left=true)
                    circle(r = M4_clearance_radius);
            }
}

module leftSidePanelPC(addBolts=true) {
    size = sidePanelSize(left=true);

    translate([-size.z/2, size.x/2, size.y/2])
        rotate([90, 0, -90]) {
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Left_Side_Panel_dxf();
            if (addBolts)
                sidePanelBoltHolePositions(size, left=true)
                    translate_z(size.z/2)
                        boltM4ButtonheadHammerNut(_sideBoltLength, nutExplode=10);
        }
}

module Left_Side_Panel_assembly()
assembly("Left_Side_Panel", ngb=true) {
    size = sidePanelSize(left=true);

    leftSidePanelPC();
}

module Right_Side_Panel_dxf() {
    size = sidePanelSize(left=false);
    fillet = 1;
    sheet = PC3;

    dxf("Right_Side_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                sidePanelAccessHolePositions(size, left=false)
                    circle(r = accessHoleRadius);
                sidePanelBoltHolePositions(size, left=false)
                    circle(r = M4_clearance_radius);
                translate([-size.x/2, -size.y/2]) {
                    translate([extruderPosition().y, extruderPosition().z]) {
                        extruderNEMAType = NEMA17;
                        NEMA_screw_positions(extruderNEMAType)
                            poly_circle(r=M3_clearance_radius);
                        poly_circle(r=NEMA_boss_radius(extruderNEMAType));
                        translate([filamentSensorOffset().y, filamentSensorOffset().z])
                            rotate(-90)
                                filament_sensor_hole_positions()
                                    poly_circle(r=M3_clearance_radius);
                    }
                    translate([eY + eSize - iecHousingSize().x/2, 2*eSize + iecHousingSize().y/2]) {
                        rounded_square(iecCutoutSize(), 1, center=true);
                        rotate(90)
                            iec_screw_positions(iecType())
                                poly_circle(r=M4_clearance_radius);
                    }
                }
            }
}

module rightSidePanelPC(addBolts=true) {
    size = sidePanelSize(left=false);

    translate([size.z/2 + eX + 2*eSize, size.x/2, size.y/2])
        rotate([90, 0, 90]) {
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Right_Side_Panel_dxf();
            if (addBolts)
                sidePanelBoltHolePositions(size, left=false)
                    translate_z(size.z/2)
                        if (!is_undef(_useExtrusionChannelNuts) && _useExtrusionChannelNuts)
                            boltM4Buttonhead(_sideBoltLength);
                        else
                            boltM4ButtonheadHammerNut(_sideBoltLength);
        }
}

module Channel_Nut_200_FL_stl() {
    stl("Channel_Nut_200_FL")
        color(pp2_colour)
            extrusionChannel(200, boltHoles=[20, 140], accessHoles=[10, 30, 50, 70]);
}

module Channel_Nut_200_FU_stl() {
    stl("Channel_Nut_200_FU")
        color(pp2_colour)
            extrusionChannel(200, boltHoles=[20, 140], accessHoles=[10]);
}

module Right_Side_Channel_Nuts() {
    translate([eX + 2*eSize, eSize/2, 0]) {
        rotate([90, 0, 90])
            Channel_Nut_200_FL_stl();
        translate_z(eZ)
            rotate([-90, 0, -90])
                Channel_Nut_200_FU_stl();
    }
}

module Right_Side_Panel_assembly()
assembly("Right_Side_Panel", ngb=true) {
    size = sidePanelSize(left=false);

    Extruder_Bracket_hardware(is_undef(_corkDamperThickness) ? 0 : _corkDamperThickness);
    translate([eX + 2*eSize, eY + eSize, 2*eSize])
        iecHousing();

    rightSidePanelPC();
}

module Partition_dxf() {
    size = partitionSize();
    fillet = 1;
    sheet = PC3;

    dxf("Partition")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                partitionCutouts(cncSides=0);
            }
}

module partitionCutouts(cncSides) {
    size = partitionSize();

    echo(xySize=xyMotorMountSize());
    leftCutoutSize = [eSize, xyMotorMountSize(left=true).z];
    rightCutoutSize = [eSize, xyMotorMountSize(left=false).z];
    translate([-size.x/2, -size.y/2]) {
        translate([0, size.y - leftCutoutSize.y])
            square(leftCutoutSize);
        translate([size.x - eSize, size.y - rightCutoutSize.y])
            square(rightCutoutSize);
    }
}

module partitionPC() {
    size = partitionSize();

    translate([eSize, eY + 2*eSize - partitionOffsetY() - size.z, 0])
        rotate([90, 0, 0])
            translate([size.x/2, size.y/2, -size.z/2])
                render_2D_sheet(PC3, w=size.x, d=size.y)
                    Partition_dxf();
}

module Partition_assembly()
assembly("Partition", ngb=true) {

    partitionPC();
}
