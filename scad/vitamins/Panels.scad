include <../vitamins/bolts.scad>

use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../printed/extruderBracket.scad> // for spoolHeight(), spoolHolderPosition()
use <../printed/extrusionChannels.scad>

include <../vitamins/filament_sensor.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];
accessHoleRadius = 2.5;

function sidePanelSize(left, useBowdenExtruder=true, useElectronicsInBase=false) = [eY + 2*eSize - (left ? 0 : (useBowdenExtruder ? iecHousingMountSize().x : 0)), left ? eZ : eZ - (useElectronicsInBase ?  iecHousingMountSize().y : 0), 3];
function rightLowerSidePanelSize() = [eY + 2*eSize - iecHousingMountSize().x, iecHousingMountSize().y, 3];


module sidePanelAccessHolePositions(size, left) {
    *for (x = left ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [-size.y/2 + eSize/2, size.y/2 - eSize/2])
        translate([x, y])
            children();
    for (y = [eSize/2, 3*eSize/2])
        translate([left ? size.x/2 - eSize/2 : -size.x/2 + eSize/2, size.y/2 - y])
            children();
    if (left || _useBowdenExtruder == false)
        for (y = [eSize/2, 3*eSize/2, 5*eSize/2])
            translate([left ? -size.x/2 + eSize/2 : size.x/2 - eSize/2, size.y/2 - y])
                children();
    *if (left)
        for (y = [3*eSize/2, size.y - 3*eSize/2])
            translate([-size.x/2 + eSize/2, y - size.y/2])
                children();
}

module sidePanelBoltHolePositionsX(size, left, spoolHolder) {
    xPositionsLeft =
        size.x <= 250 + 2*eSize ? [-size.x/2 + eSize + 60, size.x/2 - eSize - 60] :
        size.x <= 350 + 2*eSize ? [-size.x/2 + eSize + 50, 0, size.x/2 - eSize - 50] :
                                  [-size.x/2 + eSize + 20, -(size.x - 2*(eSize + 20))/6, (size.x - 2*(eSize + 20))/6, size.x/2 - eSize - 20];
    xPositionsRight = _useBowdenExtruder ? [-size.x/2 + 4*eSize/2, eSize/2, size.x/2 - eSize] : [-size.x/2 + 4*eSize/2, eSize/2, size.x/2 - 2*eSize];
    for (x = left ? xPositionsLeft : xPositionsRight,
         y = concat([(-size.y + eSize)/2, (size.y - eSize)/2], left ? [_upperZRodMountsExtrusionOffsetZ - size.y/2 - eSize/2] : []))
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
    if (spoolHolder)
        for (x = [0, 40])
            translate([x + (_useBowdenExtruder ? spoolHolderPosition().y - eY/2 + 7.5 : -20), spoolHeight() - size.y/2 + (_useElectronicsInBase ? -3*eSize : 3*eSize/2)])
                children();
}

module sidePanelBoltHolePositions(size, left, spoolHolder=false) {
    for (x = (left || _useBowdenExtruder== false) ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [-size.y/2 + eSize, size.y/2 - eSize])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
    if (!left && _useBowdenExtruder)
        for (x = [size.x/2 - eSize/2], y = [spoolHeight() +  - size.y/2 + (_useElectronicsInBase ? -3*eSize : 3*eSize/2)])
            translate([x, y])
                rotate(exploded() ? 0 : 90)
                    children();

    sidePanelBoltHolePositionsX(size, left, spoolHolder)
        children();
    //for (x = [-size.x/2 + eSize/2, size.x/2 - eSize/2], y = [(size.y - eSize)/6, -(size.y - eSize)/6])
    for (x = (left || _useBowdenExtruder== false) ? [-size.x/2 + eSize/2, size.x/2 - eSize/2] : [-size.x/2 + eSize/2], y = [size.y/2 - eSize - (size.y - 2*eSize)/3, -size.y/2 + eSize + (size.y - 2*eSize)/3])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
}

module rightLowerSidePanelBoltHolePositions(size) {
    for (x = [-size.x/2 + eSize/2, 0, size.x/2 - eSize/2], y = [-size.y/2 + eSize/2,  size.y/2 - eSize/2])
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

module Channel_Spacer_44p5_stl() {
    // 50 - tNutLength/2 - 0.5(tolerance)
    length = 44.5;
    stl("Channel_Spacer_44p5")
        color(pp3_colour)
            extrusionChannel(length);
}

module Channel_Spacer_44p5_grubscrew_stl() {
    // 50 - tNutLength/2 - 0.5(tolerance)
    length = 44.5;
    stl("Channel_Spacer_44p5_grubscrew")
        color(pp3_colour)
            extrusionChannel(length, boltHoles=[length/2]);
}

module Channel_Spacer_54p5_stl() {
    // 50 - tNutLength/2 - 0.5(tolerance)
    length = 54.5;
    stl("Channel_Spacer_54p5")
        color(pp3_colour)
            extrusionChannel(length);
}

module Channel_Spacer_54p5_grubscrew_stl() {
    // 50 - tNutLength/2 - 0.5(tolerance)
    length = 54.5;
    stl("Channel_Spacer_54p5_grubscrew")
        color(pp3_colour)
            extrusionChannel(length, boltHoles=[length/2]);
}

module Channel_Spacer_44p5_narrow_stl() {
    length = 44.5;
    stl("Channel_Spacer_44p5_narrow")
        color(pp3_colour)
            extrusionChannel(length, boltHoles=[length/2], channelWidth=4.8); // use channelWidth=4.8 for narrow channel extrusions
}

module Channel_Spacer_79p5_stl() {
    stl("Channel_Spacer_79p5")
        color(pp3_colour)
            extrusionChannel(79.5);
}

module Channel_Spacer_96_stl() {
    stl("Channel_Spacer_96")
        color(pp3_colour)
            extrusionChannel(96);
}

module Channel_Spacer_89p5_stl() {
    // (eX-100)/2 - tNutLength - 0.5(tolerance)
    stl("Channel_Spacer_89p5")
        color(pp3_colour)
            extrusionChannel(89.5);
}

module Channel_Spacer_114p5_stl() {
    // (eX-100)/2 - tNutLength - 0.5(tolerance)
    stl("Channel_Spacer_114p5")
        color(pp3_colour)
            extrusionChannel(114.5);
}

module Channel_Spacer_150_stl() {
    stl("Channel_Spacer_150")
        color(pp3_colour)
            extrusionChannel(150);
}

module Channel_Spacer_175_stl() {
    stl("Channel_Spacer_175")
        color(pp3_colour)
            extrusionChannel(175);
}

module Channel_Spacer_Left_Long() {
    if (eX == 300)
        Channel_Spacer_89p5_stl();
    else if (eX == 350)
        Channel_Spacer_114p5_stl();
}

module Left_Side_Channel_Spacers() {
    tNutLength = 10;
    gap = 0.25;
    for (z = [eSize/2, eZ - eSize/2])
        translate([0, eSize + gap, z]) {
            rotate([0, -90, 0])
                if (z == eSize/2)
                    if (eZ < 400)
                        Channel_Spacer_54p5_stl();
                    else
                        Channel_Spacer_44p5_stl();
                else
                    if (eZ < 400)
                        Channel_Spacer_54p5_grubscrew_stl();
                    else
                        Channel_Spacer_44p5_grubscrew_stl();
            translate([0, 50 + tNutLength/2, 0])
                rotate([0, -90, 0])
                    Channel_Spacer_Left_Long();
            translate([0, eY/2 + tNutLength/2, 0])
                rotate([0, -90, 0])
                    Channel_Spacer_Left_Long();
            translate([0, eY - (eZ < 400 ? 60 : 50) + tNutLength/2, 0])
                rotate([0, -90, 0])
                    if (z == eSize/2)
                        if (eZ < 400)
                            Channel_Spacer_54p5_stl();
                        else
                            Channel_Spacer_44p5_stl();
                    else
                        if (eZ < 400)
                            Channel_Spacer_54p5_grubscrew_stl();
                        else
                            Channel_Spacer_44p5_grubscrew_stl();
        }
}

module Left_Base_Channel_Spacers() {
    tNutLength = 10;
    gap = 0.25;
    length = (eY - 10*2 - 4*tNutLength - 6*gap) /3;// 79.5 for MC300,  96.1667 for MC350
    *translate([eSize/2, eSize, 0])
        rotate([0, 180, 0])
            extrusionChannel(10);
    translate([eSize/2, eSize + 15 + tNutLength/2 + gap, 0]) {
        for (y = [0 : length + tNutLength + 2*gap : eY - length])
        translate([0, y, 0])
            rotate([0, 180, 0])
                if (eY==300)
                    Channel_Spacer_79p5_stl();
                else if (eY==350)
                    Channel_Spacer_96_stl();
    }
}

module Back_Panel_Channel_Spacers() {
    translate([0, eY + 2*eSize, 0])
        rotate(-90)
            Left_Side_Channel_Spacers();
}


module Right_Side_Panel_dxf() {
    size = sidePanelSize(left=false, useBowdenExtruder=_useBowdenExtruder, useElectronicsInBase=_useElectronicsInBase);
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

module Right_Lower_Side_Panel_dxf() {
    size = rightLowerSidePanelSize();
    fillet = 1;
    sheet = PC3;

    dxf("Right_Lower_Side_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                rightLowerSidePanelBoltHolePositions(size)
                    circle(r=M4_clearance_radius);
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
            extrusionChannel(200, boltHoles=[20, iecHousingMountSize(eX).y - eSize/2], accessHoles=[10, 30]);
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

module Channel_Spacer_14p5_stl() {
    length = 14.5;
    stl("Channel_Spacer_14p5")
        color(pp3_colour)
            extrusionChannel(length, boltHoles=[length/2]);
}

module Channel_Spacer_14p5_narrow_stl() {
    length = 14.5;
    stl("Channel_Spacer_14p5_narrow")
        color(pp3_colour)
            extrusionChannel(length, boltHoles=[length/2], channelWidth=4.8);
}

module Channel_Spacer_56_stl() {
    stl("Channel_Spacer_56")
        color(pp3_colour)
            extrusionChannel(56);
}

module Channel_Spacer_84p5_stl() {
    stl("Channel_Spacer_84p5")
        color(pp3_colour)
            extrusionChannel(84.5);
}

module Channel_Spacer_109p5_stl() {
    stl("Channel_Spacer_109p5")
        color(pp3_colour)
            extrusionChannel(109.5);
}

module Channel_Spacer_93_stl() {
    stl("Channel_Spacer_93")
        color(pp3_colour)
            extrusionChannel(93);
}

module Channel_Spacer_Right_Long() {
    if (eX == 300)
        Channel_Spacer_84p5_stl();
    else if (eX == 350)
        Channel_Spacer_109p5_stl();
}

module Right_Side_Channel_Spacers() {
    tNutLength = 10;
    gap = 0.25;
    for (z = [eSize/2, eZ - eSize/2])
        translate([eX + 2*eSize, eSize + gap, z]) {
            rotate([0, 90, 0])
                Channel_Spacer_14p5_stl();
            translate([0, 20 + tNutLength/2, 0])
                rotate([0, 90, 0])
                    Channel_Spacer_Right_Long();
            translate([0, (eX - 70)/2 + tNutLength/2, 0])
                rotate([0, 90, 0])
                    Channel_Spacer_Right_Long();
            translate([0, eX - 90 + tNutLength/2, 0])
                rotate([0, 90, 0])
                    Channel_Spacer_14p5_stl();
        }
    *translate([eX + 2*eSize, eSize + gap, eZ - eSize/2]) {
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
    size = sidePanelSize(left=false, useBowdenExtruder=_useBowdenExtruder, useElectronicsInBase=_useElectronicsInBase);
    translate([size.z/2 + eX + 2*eSize, size.x/2, (_useElectronicsInBase ? eZ - size.y/2 : size.y/2)])
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
    *if (!_useBowdenExtruder) {
        lowerSize = rightLowerSidePanelSize();
        translate([lowerSize.z/2 + eX + 2*eSize, lowerSize.x/2, lowerSize.y/2])
            rotate([90, 0, 90]) {
                if (addBolts)
                    rightLowerSidePanelBoltHolePositions(lowerSize)
                        translate_z(lowerSize.z/2)
                            boltM4ButtonheadHammerNut(_sideBoltLength);
                render_2D_sheet(PC3, w=lowerSize.x, d=lowerSize.y)
                    Right_Lower_Side_Panel_dxf();
            }
    }
}

module Right_Side_Panel_assembly(hammerNut=true)
assembly("Right_Side_Panel", ngb=true) {
    rightSidePanelPC(hammerNut=hammerNut);
}
