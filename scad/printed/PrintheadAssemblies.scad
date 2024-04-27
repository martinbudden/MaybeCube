//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/rails.scad>
use <NopSCADlib/vitamins/wire.scad>

include <../utils/PrintheadOffsets.scad>
include <../utils/X_Rail.scad>
include <../vitamins/OrbiterV3.scad>

include <../../../BabyCube/scad/vitamins/pcbs.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
include <OrbiterV3Fan.scad>
use <X_CarriageAssemblies.scad>
use <X_CarriageE3DV6.scad>
use <X_CarriageOrbiterV3.scad>

include <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>


function hotendClampOffset(xCarriageType, hotendDescriptor="E3DV6") =  [hotendOffset(xCarriageType, hotendDescriptor).x, 18 + xCarriageHotendOffsetY(xCarriageType) + grooveMountOffsetX(hotendDescriptor), hotendOffset(xCarriageType, hotendDescriptor).z];
grooveMountFillet = 1;
function grooveMountClampSize(blowerType, hotendDescriptor) = [grooveMountSize(blowerType, hotendDescriptor).y - 2*grooveMountFillet - grooveMountClampOffsetX(), 12, 15];

module printheadE3DV6Assembly(full=true) {
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    rotate(180)
        translate([0, -2*hotendOffset.y, 0]) {
            explode([20, 0, 0])
                hotEndHolderHardware(xCarriageType, hotendDescriptor);

            if (full)
                translate(hotendClampOffset(xCarriageType, hotendDescriptor))
                    rotate([90, 0, -90])
                        explode(-40, true) {
                            stl_colour(pp2_colour)
                                if (blower_size(blowerType).x == 30)
                                    Groovemount_Clamp_stl();
                                else
                                    Groovemount_Clamp_40_stl();
                            Groovemount_Clamp_hardware(xCarriageType, blowerType, hotendDescriptor);
                        }
        }

    if (!exploded() && full)
        translate(printheadWiringOffset(hotendDescriptor))
            for (z = [0, 10])
                translate([0, -3.5, z + 30])
                    rotate([0, 90, 90])
                        cable_tie(cable_r = 3, thickness = 4.5);
}

//!1. Bolt the fan onto the side of the **X_Carriage_Groovemount**, secure the fan wire with a ziptie.
//!2. Ensure a good fit between the fan and the **Fan_Duct** and bolt the fan duct to the X_Carriage.
//!3. Assemble the E3D hotend, including fan, thermistor cartridge and heater cartridge.
//!4. Use the **Groovemount_Clamp** to attach the E3D hotend to the X_Carriage.
//!5. Collect the wires together, wrap them in spiral wrap, and secure them to the X_Carriage using the zipties. Note that
//!the wiring is not shown in this diagram.
module Printhead_E3DV6_assembly() pose(a=[55, 0, 25 + 180])
assembly("Printhead_E3DV6", big=true) {

    xCarriageGroovemountAssembly();
    printheadE3DV6Assembly();
}

module printheadOrbiterV3Assembly() {
    xCarriageType = MGN12H_carriage;
    blowerType = RB5015;

    rotate([0, 0, 90])
        translate([39, -0.3, -31.4])
            smartOrbiterV3();
    translate([22.5, 66.5, -64.2]) {
        explode([0, 0, -50])
            stl_colour(pp1_colour)
                Smart_Orbiter_V3_Duct_stl();
        explode([0, 20, 0], true) {
            rotate([-90, 0, 0])
                stl_colour(pp2_colour)
                    vflip()
                        Smart_Orbiter_V3_Fan_Bracket_5015_stl();
            translate([-0.55, -6.5, 52.58]) {    
                translate([-17, 0, -26.25])
                    rotate([-90, 0, 0])
                        boltM3Countersunk(6);
                rotate([-90, 0, 0])
                    boltM3Countersunk(6);
            }
            translate([-2, -7.8, 20.25])
                rotate([90, 0, 90])
                    explode(20, true)
                        boltM2Caphead(10);
        }

        explode([0, 60, 0], true)
            translate([2.6, -6, 21.5])
                rotate([90, 0, 180]) {
                    blower(blowerType);
                    blower_hole_positions(blowerType)
                        translate([0, 0, blower_size(blowerType).z + 0.75])
                            boltM3Countersunk(20);
                }
    }
}

//!The **Smart_Orbiter_V3_Fan_Bracket** and the **Smart_Orbiter_V3_Duct** are based on the
//![Smart Orbiter v3 - Detachable front 5015 fan](https://www.printables.com/es/model/700391-smart-orbiter-v3-detachable-front-5015-fan)
//!by [@PrintNC](https://www.printables.com/es/@PrintNC) and are used under the terms of their
//![Creative Commons (4.0 International License) Attribution Recognition](https://creativecommons.org/licenses/by/4.0/) license.
//!
//!1. Bolt the Smart Orbiter V3 to the **X_Carriage_OrbiterV3**
//!2. Bolt the **Smart_Orbiter_V3_Fan_Bracket** to the Smart Orbiter V3.
//!3. Bolt the RB5015 blower to the **Smart_Orbiter_V3_Fan_Bracket**
//!4. Insert the  **Smart_Orbiter_V3_Duct** into the blower outlet and bolt it to the **Smart_Orbiter_V3_Fan_Bracket**.
module Printhead_OrbiterV3_assembly() pose(a=[55, 0, 25 + 90])
assembly("Printhead_OrbiterV3", big=true) {

    xCarriageType = MGN12H_carriage;
    hotendDescriptor = "OrbiterV3";
    explode([0, -40, 0], true)
        xCarriageOrbiterV3Assembly(xCarriageType, inserts=true);
    translate_z(orbiterV3HoleOffset().z - 16)
        printheadOrbiterV3Assembly();
    explode([0, -60, 0], true)
        xCarriageOrbiterV3HolePositions(xCarriageType)
            boltM3Countersunk(10);
    if (!exploded())
        translate(printheadWiringOffset(hotendDescriptor)) {
            xCarriageOrbitrerV3CableTiePositions(full=false)
                translate([0, -3.5, 18])
                    rotate([0, 90, 90])
                        cable_tie(cable_r = 3, thickness = 4.5);
            translate([-8.5, -5.5, -4])
                rotate([0, 90, -90])
                    cable_tie(cable_r = 2.5, thickness = 3);
        }
}

module printheadBeltSide(rotate=0, explode=0, t=undef) {
    xCarriageType = MGN12H_carriage;
    halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode(explode, true) {
            explode([0, -20, 0], true)
                X_Carriage_Beltside_assembly();
            xCarriageTopBolts(xCarriageType, countersunk=_xCarriageCountersunk, positions = halfCarriage ? [ [1, -1], [-1, -1] ] : [ [1, -1], [-1, -1], [1, 1], [-1, 1] ]);
            xCarriageBeltClampAssembly(xCarriageType);
        }
}

module printheadBeltSideBolts(rotate=0, explode=0, t=undef, halfCarriage=false) {
    xCarriageType = MGN12H_carriage;
    xCarriageBeltSideSize = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    boltLength = usePulley25() ? 40 : (halfCarriage ? 30 : 40);

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode([0, -20, 0], true)
            translate([0, -pulley25Offset + (usePulley25() ? 1 : 0), 0])
                xCarriageBeltSideBolts(xCarriageType, xCarriageBeltSideSize, topBoltLength=boltLength, holeSeparationTop=xCarriageHoleSeparationTopMGN12H(), bottomBoltLength=boltLength, holeSeparationBottom=xCarriageHoleSeparationBottomMGN12H(), countersunk=true, offsetT=xCarriageHoleOffsetTop());
}

module printheadE3DV6(rotate=0, explode=0, t=undef, halfCarriage=false) {
    xCarriageType = MGN12H_carriage;
    xCarriageBeltSideSize = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);
    boltLength = usePulley25() ? 40 : (halfCarriage ? 30 : 40);

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode(explode, true) {
            Printhead_E3DV6_assembly();

            explode([0, -20, 0], true)
                translate([0, -pulley25Offset + (usePulley25() ? 1 : 0), 0])
                    xCarriageBeltSideBolts(xCarriageType, xCarriageBeltSideSize, topBoltLength=boltLength, holeSeparationTop=xCarriageHoleSeparationTopMGN12H(), bottomBoltLength=boltLength, holeSeparationBottom=xCarriageHoleSeparationBottomMGN12H(), countersunk=true, offsetT=xCarriageHoleOffsetTop());
            *translate([xCarriageFrontSize.x/2, 18, -18])
                bl_touch_mount();
            if (halfCarriage && !usePulley25())
                xCarriageTopBolts(xCarriageType, countersunk=_xCarriageCountersunk, positions = [ [1, 1], [-1, 1] ]);
        }
}

module printheadOrbiterV3(rotate=0, explode=0, t=undef, halfCarriage=false) {
    xCarriageType = MGN12H_carriage;
    xCarriageBeltSideSize = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    boltLength = 40;

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode(explode, true) {
            Printhead_OrbiterV3_assembly();

            explode([0, -20, 0], true)
                translate([0, -pulley25Offset + (usePulley25() ? 1 : 0), 0])
                    xCarriageBeltSideBolts(xCarriageType, xCarriageBeltSideSize, topBoltLength=boltLength, holeSeparationTop=xCarriageHoleSeparationTopMGN12H(), bottomBoltLength=boltLength, holeSeparationBottom=xCarriageHoleSeparationBottomMGN12H(), countersunk=true, offsetT=xCarriageHoleOffsetTop());
        }
}

module bl_touch_mount_stl() {
    stl("bl_touch_mount")
        color(pp2_colour)
            translate([0, -4, -7.5])
                translate([20.5, -1, 4])
                    rotate([180, 0, 0])
                        import(str("../../../stlimport/eva/bl_touch_mount.stl"));
}

module bl_touch_mount() {
    translate([10, 0, -8]) {
        rotate([180, 0, 180])
            bl_touch_mount_stl();
        translate([7.25, 16, 3.5])
            rotate(90)
                color(grey(90))
                    import(str("../../../stlimporttemp/BLTouch_Model.stl"));
    }
}

/*
module fullPrinthead(rotate=180, explode=0, t=undef, accelerometer=false) {
    xCarriageType = MGN12H_carriage;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode(explode, true) {
            explode([0, -20, 0], true) {
                xCarriageFrontSize = xCarriageBeltSideSizeM(xCarriageType, _beltWidth);
                xCarriageFrontBolts(xCarriageType, xCarriageFrontSize, topBoltLength=30, holeSeparationTop=holeSeparationTop, bottomBoltLength=30, holeSeparationBottom=holeSeparationBottom, countersunk=true);
            }
            Printhead_E3DV6_assembly();
            xCarriageTopBolts(xCarriageType, countersunk=_xCarriageCountersunk);
            if (accelerometer)
                explode(50, true)
                    printheadAccelerometerAssembly();
            if (!exploded())
                xCarriageBeltFragments(xCarriageType, coreXY_belt(coreXY_type()), beltOffsetZ(), coreXYSeparation().z, coreXY_upper_belt_colour(coreXY_type()), coreXY_lower_belt_colour(coreXY_type()));
        }
}
*/

module printheadAccelerometerAssembly() {
    translate(accelerometerOffset() + [0, 0, 1])
        rotate(180) {
            pcb = ADXL345;
            pcb(pcb);
            pcb_hole_positions(pcb) {
                translate_z(pcb_size(pcb).z)
                    boltM3Caphead(10);
                explode(-5)
                    vflip()
                        washer(M3_washer)
                            washer(M3_washer);
            }
        }
}

module hotEndHolderHardware(xCarriageType, hotendDescriptor="E3DV6") {
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    translate(hotendOffset)
        E3Dv6plusFan();
}

module Hotend_Strain_Relief_Clamp_stl() {
    holeSpacing = hotendStrainReliefClampHoleSpacing();
    size = [holeSpacing + 8, 10, 3];

    stl("Hotend_Strain_Relief_Clamp")
        color(pp1_colour)
            linear_extrude(size.z)
                difference() {
                    rounded_square([size.x, size.y], 1.5);
                    for (x = [-holeSpacing/2, holeSpacing/2])
                        translate([x, 0, 0])
                            poly_circle(r=M3_clearance_radius);
                }
}

module Hotend_Strain_Relief_Clamp_hardware() {
    holeSpacing = hotendStrainReliefClampHoleSpacing();
    size = [holeSpacing + 8, 10, 3];

    for (x = [-holeSpacing/2, holeSpacing/2])
        translate([x, 0, size.z])
            boltM3Buttonhead(12);
}

module Groovemount_Clamp_stl() {
    stl("Groovemount_Clamp")
        color(pp2_colour)
            mirror([1, 0, 0])
                grooveMountClamp(grooveMountClampSize(BL30x10), tolerance=0.15);
}

module Groovemount_Clamp_40_stl() {
    stl("Groovemount_Clamp")
        color(pp2_colour)
            mirror([1, 0, 0])
                grooveMountClamp(grooveMountClampSize(BL40x10), tolerance=0.15);
}

module Groovemount_Clamp_hardware(xCarriageType, blowerType, hotendDescriptor) {
    mirror([1, 0, 0])
        grooveMountClampHardware(grooveMountClampSize(blowerType, hotendDescriptor), countersunk=true);
}
