include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/iecs.scad>
use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../printed/extruderBracket.scad>
use <../printed/extrusionChannels.scad>
use <../printed/IEC_Housing.scad>

include <../vitamins/bolts.scad>
use <../vitamins/filament_sensor.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];
accessHoleRadius = 2.5;

function sidePanelSize(left) = [eY + 2*eSize - (left ? 0 : iecHousingSize().x + eSize), eZ, 3];


module sidePanelAccessHolePositions(size, left) {
    for (x = left ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [-size.y/2 + eSize/2, size.y/2 - eSize/2])
        translate([x, y])
            children();
    for (y = [3*eSize/2, 5*eSize/2, 7*eSize/2])
        translate([left ? size.x/2 - eSize/2 : -size.x/2 + eSize/2, y - size.y/2])
            children();
    if (left)
        for (y = [3*eSize/2, size.y - 3*eSize/2])
            translate([-size.x/2 + eSize/2, y - size.y/2])
                children();
}

module sidePanelBoltHolePositionsX(size, left, spoolHolder) {
    xPositionsLeft = size.x == 300 + 2*eSize
        ? [-size.x/2 + eSize + 50, 100, 0, size.x/2 - eSize - 50]
        : [-size.x/2 + 1.5*eSize, -(size.x - eSize)/6, (size.x - eSize)/6, size.x/2 - 1.5*eSize];
    xPositionsRight = [-size.x/2 + 4*eSize/2, eSize/2, size.x/2 - eSize/2];
    for (x = left ? xPositionsLeft : xPositionsRight, y = [(-size.y + eSize)/2, (size.y - eSize)/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
    if (spoolHolder)
        for (x = [0, 40])
            translate([35 + x, spoolHeight() + 3*eSize/2 - size.y/2])
                children();
}

module sidePanelBoltHolePositions(size, left, spoolHolder=false) {
    for (x = left ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [-size.y/2 + eSize, size.y/2 - eSize])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
    if (!left)
        for (x = [size.x/2 - eSize/2], y = [spoolHeight() + 3*eSize/2 - size.y/2])
            translate([x, y])
                rotate(exploded() ? 0 : 90)
                    children();

    sidePanelBoltHolePositionsX(size, left, spoolHolder)
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
                    circle(r=accessHoleRadius);
                sidePanelBoltHolePositions(size, left=true)
                    circle(r=M4_clearance_radius);
            }
}

module leftSidePanelPC(addBolts=true, hammerNut=true) {
    size = sidePanelSize(left=true);

    translate([-size.z/2, size.x/2, size.y/2])
        rotate([90, 0, -90]) {
            if (addBolts)
                sidePanelBoltHolePositions(size, left=true)
                    translate_z(size.z/2)
                        if (hammerNut)
                            boltM4ButtonheadHammerNut(_sideBoltLength, nutExplode=10);
                        else
                            boltM4ButtonheadTNut(_sideBoltLength, nutExplode=10);
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Left_Side_Panel_dxf();
        }
}

module Left_Side_Panel_assembly(hammerNut=true)
assembly("Left_Side_Panel", ngb=true) {
    size = sidePanelSize(left=true);

    leftSidePanelPC(hammerNut=hammerNut);
}

module Left_Side_Channel_Nuts() {
    translate([0, eSize, eSize/2]) {
        rotate([0, -90, 0])
            Channel_Nut_100_L_stl();
        translate([0, 100, 0])
            rotate([0, -90, 0])
                Channel_Nut_200_L_stl();
    }
    translate([0, eSize/2, 0]) {
        rotate([90, 0, -90])
            stl_colour(pp2_colour)
                Channel_Nut_200_FL_stl();
        translate_z(eZ)
            rotate([-90, 0, 90])
                stl_colour(pp2_colour)
                    Channel_Nut_200_FU_stl();
    }
    translate([0, eY + 3*eSize/2, 0]) {
        rotate([90, 0, -90])
            stl_colour(pp2_colour)
                Channel_Nut_200_B_stl();
        translate_z(eZ)
            rotate([-90, 0, 90])
                stl_colour(pp2_colour)
                    Channel_Nut_200_B_stl();
    }
}

module Channel_Spacer_43p5_stl() {
    stl("Channel_Spacer_43p5")
        color(pp3_colour)
            extrusionChannel(43.5);
}

module Channel_Spacer_88_stl() {
    stl("Channel_Spacer_88")
        color(pp3_colour)
            extrusionChannel(88);
}

module Left_Side_Channel_Spacers() {
    tNutLength = 11;
    gap = 0.5;
    for (z = [eSize/2, eZ - eSize/2])
        translate([0, eSize + gap, z]) {
            rotate([0, -90, 0])
                Channel_Spacer_43p5_stl();
            translate([0, 50 + tNutLength/2, 0])
                rotate([0, -90, 0])
                    Channel_Spacer_88_stl();
            translate([0, 150 + tNutLength/2, 0])
                rotate([0, -90, 0])
                    Channel_Spacer_88_stl();
            translate([0, 250 + tNutLength/2, 0])
                rotate([0, -90, 0])
                    Channel_Spacer_43p5_stl();
        }
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
                    circle(r=accessHoleRadius);
                sidePanelBoltHolePositions(size, left=false, spoolHolder=true)
                    circle(r=M4_clearance_radius);
                /*translate([-size.x/2, -size.y/2]) {
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
                }*/
            }
}

module Channel_Nut_100_L_stl() {
    stl("Channel_Nut_100_L")
        color(pp3_colour)
            extrusionChannel(100, boltHoles=[50]);
}

module Channel_Nut_200_L_stl() {
    stl("Channel_Nut_200_L")
        color(pp3_colour)
            extrusionChannel(200, boltHoles=[50, 150]);
}

module Channel_Nut_200_B_stl() {
    stl("Channel_Nut_200_B")
        color(pp3_colour)
            extrusionChannel(200, boltHoles=[20, 140], accessHoles=[10, 30]);
}

module Channel_Nut_200_BL_stl() {
    stl("Channel_Nut_200_BL")
        color(pp3_colour)
            extrusionChannel(200, boltHoles=[20, iecHousingMountSize().y - eSize/2], accessHoles=[10, 30]);
}

module Channel_Nut_200_BU_stl() {
    stl("Channel_Nut_200_BU")
        color(pp3_colour)
            extrusionChannel(200, boltHoles=[20, extruderBracketSize().z - eSize/2], accessHoles=[10, 30]);
}

module Channel_Nut_200_FL_stl() {
    stl("Channel_Nut_200_FL")
        color(pp3_colour)
            extrusionChannel(200, boltHoles=[20, 140], accessHoles=[10, 30, 50, 70]);
}

module Channel_Nut_200_FU_stl() {
    stl("Channel_Nut_200_FU")
        color(pp3_colour)
            extrusionChannel(200, boltHoles=[20, 140], accessHoles=[10]);
}

module Channel_Nut_230_R_stl() {
    stl("Channel_Nut_230_R")
        color(pp3_colour)
            extrusionChannel(230, boltHoles=[10, 115, 220]);
}

module Channel_Nut_70_RU_stl() {
    stl("Channel_Nut_70_RU")
        color(pp3_colour)
            extrusionChannel(70, boltHoles=[7.5]);
}

module Channel_Nut_90_RM_stl() {
    stl("Channel_Nut_90_RM")
        color(pp3_colour)
            extrusionChannel(90, boltHoles=[10, 27.5]);
}

module Channel_Nut_70_RL_stl() {
    stl("Channel_Nut_70_RL")
        color(pp3_colour)
            extrusionChannel(70, boltHoles=[10, 60]);
}


module Right_Side_Channel_Nuts() {
    translate([eX + 2*eSize, eSize/2, 0]) {
        rotate([90, 0, 90])
            stl_colour(pp3_colour)
                Channel_Nut_200_FL_stl();
        translate_z(eZ)
            rotate([-90, 0, -90])
                stl_colour(pp3_colour)
                    Channel_Nut_200_FU_stl();
    }
    translate([eX + 2*eSize, eSize, eZ - eSize/2]) {
        rotate([0, 90, 0])
            Channel_Nut_230_R_stl();
        translate([0, 230, 0])
            rotate([0, 90, 0])
                Channel_Nut_70_RU_stl();
    }
    translate([eX + 2*eSize, 210 + eSize, spoolHeight() + 30]) {
        rotate([0, 90, 0])
            Channel_Nut_90_RM_stl();
    }
    translate([eX + 2*eSize, 230 + eSize, eSize/2]) {
        rotate([0, 90, 0])
            Channel_Nut_70_RL_stl();
    }
    translate([eX + 2*eSize, eSize, eSize/2]) {
        rotate([0, 90, 0])
            Channel_Nut_230_R_stl();
    }
    translate([eX + 2*eSize, eY + 3*eSize/2, 0]) {
        rotate([90, 0, 90])
            stl_colour(pp3_colour)
                Channel_Nut_200_BL_stl();
        translate_z(eZ)
            rotate([-90, 0, -90])
                stl_colour(pp3_colour)
                    Channel_Nut_200_BU_stl();
    }
}

module Channel_Spacer_6_stl() {
    stl("Channel_Spacer_6")
        color(pp3_colour)
            extrusionChannel(6);
}

module Channel_Spacer_13p5_stl() {
    stl("Channel_Spacer_13p5")
        color(pp3_colour)
            extrusionChannel(13.5);
}

module Channel_Spacer_56_stl() {
    stl("Channel_Spacer_56")
        color(pp3_colour)
            extrusionChannel(56);
}

module Channel_Spacer_83_stl() {
    stl("Channel_Spacer_83")
        color(pp3_colour)
            extrusionChannel(83);
}

module Channel_Spacer_93_stl() {
    stl("Channel_Spacer_93")
        color(pp3_colour)
            extrusionChannel(93);
}

module Right_Side_Channel_Spacers() {
    tNutLength = 11;
    gap = 0.5;
    for (z = [eSize/2, eZ - eSize/2])
        translate([eX + 2*eSize, eSize + gap, z]) {
            rotate([0, 90, 0])
                Channel_Spacer_13p5_stl();
            translate([0, 20 + tNutLength/2, 0])
                rotate([0, 90, 0])
                    Channel_Spacer_83_stl();
            translate([0, 115 + tNutLength/2, 0])
                rotate([0, 90, 0])
                    Channel_Spacer_93_stl();
            translate([0, 237.5 + tNutLength/2, 0])
                rotate([0, 90, 0])
                    Channel_Spacer_56_stl();
        }
    translate([eX + 2*eSize, eSize + gap, eZ - eSize/2]) {
        translate([0, 219.75 + tNutLength/2, 0])
            rotate([0, 90, 0])
                Channel_Spacer_6_stl();
        *translate([3, 237, 0])
            rotate([90, 0, 90])
                boltM4ButtonheadTNut(_sideBoltLength, nutExplode=10);

    }
    *translate([eX + 2*eSize, 210 + eSize, spoolHeight() + 30]) {
        rotate([0, 90, 0])
            Channel_Nut_90_RM_stl();
    }
    *translate([eX + 2*eSize, 230 + eSize, eSize/2]) {
        rotate([0, 90, 0])
            Channel_Nut_70_RL_stl();
    }
}

module rightSidePanelPC(addBolts=true, hammerNut=true) {
    size = sidePanelSize(left=false);

    translate([size.z/2 + eX + 2*eSize, size.x/2, size.y/2])
        rotate([90, 0, 90]) {
            if (addBolts)
                sidePanelBoltHolePositions(size, left=false)
                    translate_z(size.z/2)
                        if (!is_undef(_useExtrusionChannelNuts) && _useExtrusionChannelNuts)
                            boltM4Buttonhead(_sideBoltLength);
                        else
                            if (hammerNut)
                                boltM4ButtonheadHammerNut(_sideBoltLength);
                            else
                                boltM4ButtonheadTNut(_sideBoltLength);
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Right_Side_Panel_dxf();
        }
}

module Right_Side_Panel_assembly(hammerNut=true)
assembly("Right_Side_Panel", ngb=true) {
    size = sidePanelSize(left=false);

    //translate([eX + 2*eSize, eY + eSize, 2*eSize])
    //    iecHousing();

    rightSidePanelPC(hammerNut=hammerNut);
}
