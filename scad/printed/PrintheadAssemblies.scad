//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/rails.scad>
use <NopSCADlib/vitamins/wire.scad>

include <../utils/PrintheadOffsets.scad>
include <../utils/X_Rail.scad>

include <../../../BabyCube/scad/vitamins/pcbs.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>
use <X_CarriageAssemblies.scad>

include <../Parameters_CoreXY.scad>
use <../Parameters_Positions.scad>


function hotendClampOffset(xCarriageType, hotendDescriptor="E3DV6") =  [hotendOffset(xCarriageType, hotendDescriptor).x, 18 + xCarriageHotendOffsetY(xCarriageType) + grooveMountOffsetX(hotendDescriptor), hotendOffset(xCarriageType, hotendDescriptor).z];
grooveMountFillet = 1;
function grooveMountClampSize(blowerType, hotendDescriptor) = [grooveMountSize(blowerType, hotendDescriptor).y - 2*grooveMountFillet - grooveMountClampOffsetX(), 12, 15];

module printheadAssembly(full=true) {
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
                                    Grovemount_Clamp_stl();
                                else
                                    Grovemount_Clamp_40_stl();
                            Grovemount_Clamp_hardware(xCarriageType, blowerType, hotendDescriptor);
                        }
        }

    if (!exploded() && full)
        translate(printheadWiringOffset())
            for (z = [0, 10])
                translate([0, -3.5, z + 30])
                    rotate([0, 90, 90])
                        cable_tie(cable_r = 3, thickness = 4.5);
}

//!1. Bolt the fan onto the side of the **X_Carriage_Groovemount**, secure the fan wire with a ziptie.
//!2. Ensure a good fit between the fan and the **Fan_Duct** and bolt the fan duct to the X_Carriage.
//!3. Assemble the E3D hotend, including fan, thermistor cartridge and heater cartridge.
//!4. Use the **Grovemount_Clamp** to attach the E3D hotend to the X_Carriage.
//!5. Collect the wires together, wrap them in spiral wrap, and secure them to the X_Carriage using the zipties. Note that
//!the wiring is not shown in this diagram.
module Printhead_E3DV6_assembly() pose(a=[55, 0, 25 + 180])
assembly("Printhead_E3DV6", big=true) {

    xCarriageGroovemountAssembly();
    printheadAssembly();
}

module printheadBeltSide(rotate=0, explode=0, t=undef) {
    xCarriageType = MGN12H_carriage;
    halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode(explode, true) {
            explode([0, -20, 0], true)
                X_Carriage_Belt_Side_assembly();
            xCarriageTopBolts(xCarriageType, countersunk=_xCarriageCountersunk, positions = halfCarriage ? [ [1, -1], [-1, -1] ] : [ [1, -1], [-1, -1], [1, 1], [-1, 1] ]);
            xCarriageBeltClampAssembly(xCarriageType);
        }
}

module printheadHotendSideBolts(rotate=0, explode=0, t=undef, halfCarriage=false) {
    xCarriageType = MGN12H_carriage;
    xCarriageBeltSideSize = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    boltLength = usePulley25() ? 40 : (halfCarriage ? 30 : 40);

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode([0, -20, 0], true)
            translate([0, -pulley25Offset + (usePulley25() ? 1 : 0), 0])
                xCarriageBeltSideBolts(xCarriageType, xCarriageBeltSideSize, topBoltLength=boltLength, holeSeparationTop=xCarriageHoleSeparationTopMGN12H(), bottomBoltLength=boltLength, holeSeparationBottom=xCarriageHoleSeparationBottomMGN12H(), countersunk=true, offsetT=xCarriageHoleOffsetTop());
}

module printheadHotendSide(rotate=0, explode=0, t=undef, halfCarriage=false) {
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

module Grovemount_Clamp_stl() {
    stl("Grovemount_Clamp")
        color(pp2_colour)
            mirror([1, 0, 0])
                grooveMountClamp(grooveMountClampSize(BL30x10), tolerance=0.15);
}

module Grovemount_Clamp_40_stl() {
    stl("Grovemount_Clamp")
        color(pp2_colour)
            mirror([1, 0, 0])
                grooveMountClamp(grooveMountClampSize(BL40x10), tolerance=0.15);
}

module Grovemount_Clamp_hardware(xCarriageType, blowerType, hotendDescriptor) {
    mirror([1, 0, 0])
        grooveMountClampHardware(grooveMountClampSize(blowerType, hotendDescriptor), countersunk=true);
}
