include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/iecs.scad>
use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../vitamins/bolts.scad>
use <../printed/extruderBracket.scad>
use <../printed/IEC_Housing.scad>
use <../vitamins/filament_sensor.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];

function sidePanelSize() = [eY + 2*eSize, eZ, 3];


module sidePanelAccessHolePositions(size) {
}

module sidePanelBoltHolePositions(size) {
    cornerOffsets = false;
    for (x = [1.5*eSize - size.x/2, -(size.x - eSize)/6, (size.x - eSize)/6, size.x/2 - 1.5*eSize], y = [(-size.y + eSize)/2, (size.y - eSize)/2])
        translate([x, y])
            rotate(90)
                children();
    if (cornerOffsets)
        for (x = [eSize/2 - size.x/2, size.x/2 - eSize/2], y = [-size.y/2 + 3*eSize/2, size.y/2 - 3*eSize/2])
            translate([x, y])
                children();
    else
        for (x = [eSize/2 - size.x/2, size.x/2 - eSize/2], y = [(-size.y + eSize)/2, (size.y - eSize)/2])
            translate([x, y])
                children();
    for (y = cornerOffsets ? [0] : [(size.y - eSize)/6, -(size.y - eSize)/6])
        translate([(-size.x + eSize)/2, y])
            children();
    for (y = [(size.y - eSize)/6, -(size.y - eSize)/6])
        translate([(size.x - eSize)/2, y])
            children();
}

module Left_Side_Panel_dxf() {
    size = sidePanelSize();
    fillet = 1;
    sheet = PC3;

    dxf("Left_Side_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                sidePanelAccessHolePositions(size)
                    circle(r = M4_clearance_radius);
                sidePanelBoltHolePositions(size)
                    circle(r = M4_clearance_radius);
            }
}

module leftSidePanelPC(addBolts=true) {
    size = sidePanelSize();

    translate([-size.z/2, size.x/2, size.y/2])
        rotate([90, 0, -90]) {
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Left_Side_Panel_dxf();
            if (addBolts)
                sidePanelBoltHolePositions(size)
                    translate_z(size.z/2)
                        boltM4ButtonheadHammerNut(_sideBoltLength);
        }
}

module Left_Side_Panel_assembly()
assembly("Left_Side_Panel", ngb = true) {
    size = sidePanelSize();

    leftSidePanelPC();
}

module Right_Side_Panel_dxf() {
    size = sidePanelSize();
    fillet = 1;
    sheet = PC3;

    dxf("Right_Side_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                sidePanelAccessHolePositions(size)
                    circle(r = M4_clearance_radius);
                sidePanelBoltHolePositions(size)
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
    size = sidePanelSize();

    translate([size.z/2 + eX + 2*eSize, size.x/2, size.y/2])
        rotate([90, 0, 90]) {
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Right_Side_Panel_dxf();
            if (addBolts)
                sidePanelBoltHolePositions(size)
                    translate_z(size.z/2)
                        boltM4ButtonheadHammerNut(_sideBoltLength);
        }
}

module Right_Side_Panel_assembly()
assembly("Right_Side_Panel", ngb = true) {
    size = sidePanelSize();

    Extruder_Bracket_hardware(_corkDamperThickness);
    IEC_housing();

    rightSidePanelPC();
}
