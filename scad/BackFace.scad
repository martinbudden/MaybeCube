include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pillar.scad>
include <NopSCADlib/vitamins/pcbs.scad>
include <NopSCADlib/vitamins/psus.scad>
use <NopSCADlib/vitamins/sheet.scad>

use <printed/extruderBracket.scad>
include <utils/pcbs.scad>
use <utils/PSU.scad>

include <utils/FrameBolts.scad>

include <vitamins/nuts.scad>

use <Parameters_Positions.scad>
include <Parameters_CoreXY.scad>


PC3 = ["PC3", "Sheet polycarbonate", 3, [1,   1,   1,   0.25], false];
//PC3 = ["PC3", "Sheet polycarbonate", 3, "red", false];
accessHoleRadius = 2.5;
psuVertical = psu_size(PSUType()).y > 100 && eX == 300;

function backPanelSize() = [eX + 2*eSize, eZ, 3];
function pcbType() = BTT_SKR_V1_4_TURBO;
//function pcbType() = eX == 250 ? BTT_SKR_MINI_E3_V2_0 : BTT_SKR_E3_TURBO;
//function pcbType() = BTT_SKR_MINI_E3_V2_0;
pcbOffsetZ = eX == 250 ? 155 : 100;


module Back_Panel_dxf() {
    size = backPanelSize();
    fillet = 1;
    sheet = PC3;

    dxf("Back_Panel")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                backPanelCutouts(PSUType(), pcbType(), cncSides=0);
            }
}

module backPanelPC() {
    size = backPanelSize();

    rotate([90, 0, 0])
        translate([size.x/2, size.y/2, -size.z/2])
            render_2D_sheet(PC3, w=size.x, d=size.y)
                Back_Panel_dxf();
}

//!You can use either a polycarbonate sheet or an aluminium sheet for the back panel.
//!If you have access to a CNC, you can machine the back sheet using **Back_Panel.dxf**,
//!if not you can use the **Panel_Jig** to drill the mounting and access holes, and manually position
//!position the holes for the PCB(s) and the PSU. When positioning the mainboard, ensure that there is
//!side access to the SD card and USB port. When positioning the PSU, ensure that there is clearance
//!between the terminals and the frame, so that the wiring can be accommodated.
//!
//!Once you have the back sheet prepared:
//!
//!1. Bolt the PSU to the back sheet.
//!2. Bolt the mainboard to the back sheet, using the nylon standoffs.
//!3. Optionally bolt the Raspberry Pi to the back sheet.
//!4. Add the bolts and t-nuts in preparation for later attachment to the frame. Take take to use the correct holes
//!and don't place bolts into the access holes for the hidden bolts used to assemble the frame.
//
module Back_Panel_assembly()
assembly("Back_Panel") {

    size = backPanelSize();
    countersunk = true;

    if (is_undef(_useElectronicsInBase) || _useElectronicsInBase == false) {
        pcbAssembly(pcbType());

        pcbAssembly(RPI4);

        psuAssembly(PSUType(), psuVertical);

        PSUPosition(PSUType(), psuVertical)
            PSUBoltPositions(PSUType())
                translate_z(-size.z)
                    vflip()
                        if (countersunk)
                            boltM4Countersunk(_sideBoltLength);
                        else
                            boltM4Buttonhead(_sideBoltLength);
    }

    translate([0, eY + 2*eSize, 0]) {
        rotate([90, 0, 0])
            backPanelBoltHolePositions(size)
                translate_z(-size.z)
                    vflip()
                        if (countersunk)
                            translate_z(eps)
                                boltM4CountersunkHammerNut(_sideBoltLength);
                        else
                            boltM4ButtonheadHammerNut(_sideBoltLength);
        backPanelPC();
    }
}

module backPanelAccessHolePositions(size) {
    for (x = [eSize/2, eX + 3*eSize/2], y = [eSize/2, 3*eSize/2, size.y - eSize/2])
        translate([x, y])
            children();
    for (x = [3*eSize/2, size.x - 3*eSize/2])
        translate([x, size.y -eSize/2])
            children();
    for (y = [spoolHeight() - eSize/2, spoolHeight() + eSize/2])
        translate([size.x - eSize/2, y])
            children();
    for (y = [_upperZRodMountsExtrusionOffsetZ - eSize/2, _upperZRodMountsExtrusionOffsetZ + eSize/2])
        translate([eSize/2, y])
            children();
}

module backPanelBoltHolePositionsX(size) {
    //xPositions = size.x == 300 + 2*eSize
    //? [eSize + 50, size.x/2, size.x - eSize - 50]
    //: [-size.x/2 + 1.5*eSize, -(size.x - eSize)/6, (size.x - eSize)/6, size.x/2 - 1.5*eSize];
    xPositions = [eSize + 50, size.x/2, size.x - eSize - 50];
    for (x = xPositions, y = [eSize/2, size.y - eSize/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
}

module backPanelBoltHolePositions(size) {
    for (x = [eSize/2, size.x - eSize/2], y = [eSize, size.y - eSize])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
    *for (x = [3*eSize/2, size.x/3 - eSize/6, 2*size.x/3 - eSize/6, size.x - 3*eSize/2], y = [eSize/2, size.y - eSize/2])
        translate([x, y])
            rotate(exploded() ? 90 : 0)
                children();
    backPanelBoltHolePositionsX(size)
        children();
    for (x = [eSize/2, size.x - eSize/2], y = [size.y - eSize - (size.y - 2*eSize)/3, eSize + (size.y - 2*eSize)/3])
    //for (x = [eSize/2, size.x - eSize/2], y = [2*size.y/3 - eSize/6, size.y/3 - eSize/6])
        translate([x, y])
            rotate(exploded() ? 0 : 90)
                children();
}

module backPanelCutouts(psuType, pcbType, cncSides = undef, radius = undef) {
    size = backPanelSize();

    translate([-size.x/2, -size.y/2]) {
        if (psuVertical)
            translate([psuOffset(psuType).x, psuOffset(psuType).z])
                rotate(-90)
                    PSUBoltPositions(psuType)
                        poly_circle(r=is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
        else
            translate([eSize + psu_length(psuType)/2, 2*eSize + 3 + psu_width(psuType)/2])
                PSUBoltPositions(psuType)
                    poly_circle(r=is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
                /*mirror([0, 1, 0])
                    rotate(180) {
                        psu_shroud_hole_positions(psuType)
                            circle(r=M3_clearance_radius);
                        cutoutWidth = 1.5;
                        psu_shroud_cable_positions(psuType, psuShroudCableDiameter())
                            for (y = [-psuShroudCableDiameter()/2 - cutoutWidth/2, psuShroudCableDiameter()/2 + cutoutWidth/2])
                                translate([0, y])
                                    rounded_square([4, cutoutWidth], 0.25, center=true);
                    }*/

        translate([eX/2 + eSize, eZ - 100]) {
            pcbType = RPI4;
            pcbSize = pcb_size(pcbType);
            rotate(-90)
                translate([pcbSize.x/2, pcbSize.y/2])
                    pcb_screw_positions(pcbType)
                        poly_circle(r=is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
        }
        translate([eX + eSize, pcbOffsetZ])
            if (pcbType == BTT_SKR_E3_TURBO || pcbType == BTT_SKR_MINI_E3_V2_0) {
                pcbSize = pcb_size(BTT_SKR_E3_TURBO);
                translate([-pcbSize.x/2, pcbSize.y/2])
                    pcb_screw_positions(pcbType)
                        poly_circle(r=is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
            } else {
                pcbSize = pcb_size(pcbType);
                rotate(90)
                    translate([pcbSize.x/2, pcbSize.y/2])
                        pcb_screw_positions(pcbType)
                            poly_circle(r=is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
            }
        backPanelAccessHolePositions(size)
            poly_circle(r=accessHoleRadius, sides=cncSides);
        backPanelBoltHolePositions(size)
            poly_circle(r=M4_clearance_radius, sides=cncSides);
    }
}

module psuAssembly(psuType, psuVertical, useMounts=false) {
    PSUPosition(psuType, psuVertical)
        explode(80)
            PSU_S_360_24();

    *if (psuVertical)
        PSU_Cover_assembly();
    if (psuVertical) {
        if (useMounts) {
            PSU_Upper_Mount_assembly();
            PSU_Lower_Mount_assembly();
        }
    } else {
        if (useMounts) {
            PSU_Left_Mount_assembly();
            PSU_Right_Mount_assembly();
        }
    }
}
