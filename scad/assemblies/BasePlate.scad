include <../config/global_defs.scad>

use <NopSCADlib/vitamins/sheet.scad>

include <../printed/DisplayHousingAssemblies.scad>
include <../printed/BaseFoot.scad>
include <NopSCADlib/vitamins/psus.scad>
include <NopSCADlib/vitamins/pcbs.scad>

use <../printed/BaseFrontCover.scad>
use <../printed/BaseCover.scad>
use <../printed/BreakoutPCBBracket.scad>
use <../printed/IEC_Housing.scad>

use <../utils/PSU.scad>
include <../utils/pcbs.scad>

include <../utils/FrameBolts.scad>
include <../vitamins/RPI3APlus.scad>
include <../vitamins/BTT_MANTA_5MP.scad>
include <../vitamins/BTT_MANTA_8MP.scad>
include <../vitamins/BTT_KRAKEN.scad>
include <../vitamins/psus.scad>

AL3 = ["AL3", "Aluminium sheet", 3, [0.9, 0.9, 0.9, 1], false];

basePlateSize = [eX + 2*eSize, eY + 2*eSize, _basePlateThickness];

psuOnBase = !is_undef(_useElectronicsInBase) && _useElectronicsInBase == true;
pcbOnBase = !is_undef(_useElectronicsInBase) && _useElectronicsInBase == true;
basePSUType = NG_CB_500W_24V;
//basePSUType = S_300_12;
pcbType = eY <= 250 ? BTT_SKR_MINI_E3_V2_0 : eY <= 300 ? BTT_MANTA_5MP_V1_0 : BTT_MANTA_8MP_V2_0;
//pcbType = eY <= 250 ? BTT_SKR_MINI_E3_V2_0 : eY==350 ? BTT_MANTA_8MP_V2_0 : BTT_SKR_V1_4_TURBO;
rpiType = RPI3APlus;
basePCBs = eY <= 250 ? [pcbType] : 
            pcbType[0] == "BTT_SKR_V1_4_TURBO" ? [pcbType, rpiType, BTT_RELAY_V1_2, XL4015_BUCK_CONVERTER] :
            (pcbType[0] == "BTT_MANTA_8MP_V2_0" || pcbType[0] == "BTT_MANTA_5MP_V1_0") ? [pcbType, BTT_RELAY_V1_2] :
            [pcbType, rpiType, BTT_RELAY_V1_2];


module BaseAL_dxf() {
    size = basePlateSize;

    dxf("BaseAL")
        color(silver)
            difference() {
                sheet_2D(AL3, size.x, size.y, corners=2);
                translate([-size.x/2, -size.y/2])
                    baseCutouts(cncSides=0);
            }
}

module BaseAL() {
    size = basePlateSize;

    translate([size.x/2, size.y/2, -size.z/2])
        render_2D_sheet(AL3, w=size.x, d=size.y)
            BaseAL_dxf();
}

module Base_Plate_stl() {
    size = basePlateSize;

    stl("Base_Plate")
        color(pp1_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        rounded_square([size.x, size.y], 1.5, center=false);
                        baseCutouts();
                    }
}

module Base_Plate_template_stl() {
    size = basePlateSize;

    stl("Base_Plate_template")
        color(pp1_colour)
            translate_z(-size.z)
                linear_extrude(size.z)
                    difference() {
                        rounded_square([size.x, size.y], 1.5, center=false);
                        baseCutouts(radius=1);
                    }
}

module baseplateM6BoltPositions(size) {
    size = basePlateSize;

    for (x = [eSize/2, size.x - eSize/2], y = [eSize/2, size.x - eSize/2])
        translate([x, y, 0])
            children();
}

module basePSUPosition() {
    psuSize = psu_size(basePSUType);

    translate([eX + 2*eSize - 180, eY + 2*eSize - (eY > 250 ? 60 : 25), 0])
        translate([-psuSize.y/2, -psuSize.x/2, 0])
            rotate(90)
                children();
}

module baseCutouts(cncSides=undef, radius=undef) {
// set radius=1 to make drill template

    size = basePlateSize;

    baseplateM4BoltPositions(size)
        poly_circle(is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
    baseplateM4CornerBoltPositions(size)
        poly_circle(is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
    baseplateM6BoltPositions(size)
        poly_circle(is_undef(radius) ? M6_clearance_radius : radius, sides=cncSides);
    if (psuOnBase)
        basePSUPosition()
            PSUBoltPositions(basePSUType)
                poly_circle(is_undef(radius) ? M4_clearance_radius : radius, sides=cncSides);
    if (pcbOnBase) {
        baseCoverLeftHolePositions()
            poly_circle(is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
        for (pcb = basePCBs) {
            pcbPosition(pcb, pcbOnBase)
                pcb_screw_positions(pcb)
                    if (pcb[0] == "BTT_MANTA_5MP_V1_0") {
                        if ($i != 1)
                            poly_circle(is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
                    } else if (pcb[0] == "BTT_MANTA_8MP_V2_0") {
                        if ($i == 0 || $i == 2)
                            poly_circle(is_undef(radius) ? M3_clearance_radius : radius, sides=cncSides);
                    } else if (pcb!=pcbType || $i==1 || $i==2) {
                        poly_circle(is_undef(radius) ? (pcb==pcbType ? M3_clearance_radius : pcb==XL4015_BUCK_CONVERTER? M2_tap_radius : M3_tap_radius): radius, sides=cncSides);
                    }
        }
    }

}

module baseplateM4BoltPositions(size) {
    inset = eSize + 15;

    for (x = [eSize/2, size.x - eSize/2], y = (size.y <= 250 + 2*eSize) ? [size.y/2] : [inset + (size.y - 2*inset)/3, size.y - inset - (size.y - 2*inset)/3])
        translate([x, y, 0])
            rotate(0)
                children();
    for (y = [eSize/2, size.y - eSize/2], x = (size.x <= 250 + 2*eSize) ? [size.x/2] : [inset + (size.x - 2*inset)/3, size.x - inset - (size.x - 2*inset)/3])
        translate([x, y, 0])
            rotate(90)
                children();
}

module baseplateM4CornerBoltPositions(size) {
    inset = eSize + 15;

    for (x = [eSize/2, size.x - eSize/2], y = [inset, size.y - inset])
        translate([x, y, 0])
            rotate(0)
                children();
    for (y = [eSize/2, size.y - eSize/2], x = [inset, size.x-inset])
        translate([x, y, 0])
            rotate(90)
                children();
}

function basePlateHeight() = _basePlateThickness + 12;

module basePlateAssembly(rightExtrusion=true, hammerNut=true) {
    size = basePlateSize;
    BaseAL();
    //hidden() Base_stl();
    //hidden() Base_template_stl();

    // front extrusion
    explode([0, -100, 0], true) {
        translate([eSize, 0, 0])
            extrusionOX2080VEndBolts(eX);
        if (eX < 400)
            explode(60, true)
                baseCoverFrontSupportsAssembly();
    }

    // rear extrusion
    explode([0, 100, 0], true) {
        translate([eSize, eY + eSize, 0])
            extrusionOX2060VEndBolts(eX);
        if (eX < 400)
            explode(50, true)
                baseCoverBackSupportsAssembly();
    }

    if (rightExtrusion)
        // right extrusion
        translate([eX + eSize, eSize, 0])
            explode([100, 0, 0], true)
                extrusionOYEndBolts(eY);

    translate_z(-size.z)
        baseplateM4BoltPositions(size) {
            vflip()
                explode(30)
                    boltM4Buttonhead(_sideBoltLength);
            translate_z(_sideBoltLength-3)
                explode(20)
                    if (hammerNut)
                        nutM4Hammer();
                    else
                        rotate(90)
                            nutM4SlidingT();
        }
    translate_z(-size.z - extrusionFootLShapedBoltOffsetZ())
        baseplateM4CornerBoltPositions(size) {
            vflip()
                explode(50)
                    boltM4Buttonhead(_frameBoltLength);
            translate_z(_frameBoltLength-3)
                explode(20)
                    if (hammerNut)
                        nutM4Hammer();
                    else
                        rotate(90)
                            nutM4SlidingT();
        }

    footHeight = 12;
    explode(-20) {
        translate([0, eSize, -size.z - footHeight])
            rotate([180, 0, -90])
                stl_colour(pp1_colour)
                    Foot_LShaped_12mm_stl();
        translate([eX + eSize, 0, -size.z - footHeight])
            rotate([180, 0, 0])
                stl_colour(pp1_colour)
                    Foot_LShaped_12mm_stl();
        translate([eX + 2*eSize, eY + eSize, -size.z - footHeight])
            rotate([180, 0, 90])
                stl_colour(pp1_colour)
                    Foot_LShaped_12mm_stl();
        translate([eSize, eY + 2*eSize, -size.z - footHeight])
            rotate([180, 0, 180])
                stl_colour(pp1_colour)
                    Foot_LShaped_12mm_stl();
    }
}

//!If you have access to a CNC, you can machine the base plate using **BaseAL.dxf**, if not you can use the **Panel_Jig**
//!as a template to drill the holes in the base plate.
//!
//!1. Insert the bolts into the ends of the E2040 and E2080 extrusions in preparation for connection to the frame uprights.
//!2. Bolt the extrusions and the L-shaped feet to the baseplate as shown.
//!3. Attach the **IEC Housing assembly** to the left side extrusion.
//!4. Attach the **Base_Cover_Front_Support** and the **Base_Cover_Back_Support** to the front and rear extrusions.
//
module Base_Plate_Stage_1_assembly()
assembly("Base_Plate_Stage_1", big=true, ngb=true) {

    basePlateAssembly(psuOnBase);

    if (psuOnBase)
        explode([80, 0, 20])
            IEC_Housing_assembly();
}

//!1. Bolt the PSU and the PCBs to the baseplate, using standoffs as appropriate.
//!2. Connect up the wiring, this is not shown in the illustrations.  
//
module Base_Plate_assembly()
assembly("Base_Plate", big=true, ngb=true) {

    Base_Plate_Stage_1_assembly();

    if (pcbOnBase) {
        for (pcb = basePCBs)
            pcbAssembly(pcb, pcbOnBase);
        breakoutPCBBracketAssembly();
    }

    if (psuOnBase) {
        explode(50, true)
            basePSUPosition()
                if (basePSUType[0] == "S_300_12") {
                    PSU_S_360_24();
                    PSUBoltPositions(basePSUType)
                        vflip()
                            explode(70, true)
                                boltM4Buttonhead(10);
                } else {
                    psu(basePSUType);
                    PSUBoltPositions(basePSUType)
                        explode(20, true)
                            translate_z(1.5)
                                boltM4Buttonhead(8);
                }
    }

}

//!1. Bolt the **Display_Housing_Bracket_TFT35_E3** to the 2080 extrusion.
//!2. Thread the display wiring through the hole in the **Display_Housing_Bracket_TFT35_E3** and connect it to the TFT display.
//!3. Bolt the **Display_Cover_TFT35_E3_assembly** to the **Display_Housing_Bracket_TFT35_E3**.
//!4. Bolt the **Front_Cover** to the top of the 2080 extrusion.
//!5. Bolt the **Front_Display_Wiring_Cover** to the top of the 2080 extrusion, covering the wiring.
//!6. Route the wiring to the back of the base, ready for later connection to the mainboard.
//
module Base_Plate_With_Display_assembly()
assembly("Base_Plate_With_Display", big=true, ngb=true) {

    Base_Plate_assembly();

    if (!is_undef(_useFrontDisplay) && _useFrontDisplay) {
        explode([0, -50, 0], true)
            displayHousingTFT35E3Assembly();

        translate([eSize, 0, 0]) {
            translate_z(4*eSize + 2*eps)
                explode(75, true) {
                    if (eX==300) {
                        stl_colour(pp1_colour)
                            Front_Cover_300_stl();
                    } else if (eX==350) {
                        stl_colour(pp1_colour)
                            Front_Cover_350_stl();
                    } else if (eX==400) {
                        stl_colour(pp1_colour)
                            Front_Cover_400_stl();
                    }
                    if (eX >= 300)
                        Front_Cover_hardware();
                }
            translate([eX/2, 2*eps, 4*eSize + 2*eps])
                explode(75, true)
                    vflip() {
                        if (eX==300) {
                            stl_colour(pp2_colour)
                                Front_Display_Wiring_Cover_300_stl();
                        } else if (eX==350) {
                            stl_colour(pp2_colour)
                                Front_Display_Wiring_Cover_350_stl();
                        } else if (eX==400) {
                            stl_colour(pp2_colour)
                                Front_Display_Wiring_Cover_400_stl();
                        }
                        if (eX >= 300)
                            Front_Display_Wiring_Cover_hardware();
                    }
        }
    }
}

/*
module Standoff_6mm_stl() {
    stl("Standoff_6mm");

    h = PSUStandoffHeight();
    color(pp1_colour)
        tube(or=6/2, ir = M3_clearance_radius, h=h, center=false);
}
*/
