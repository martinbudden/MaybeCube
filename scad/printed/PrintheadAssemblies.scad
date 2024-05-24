//!! This is a copy of the BabyCube file with alterations
include <../global_defs.scad>

include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/rails.scad>
use <NopSCADlib/vitamins/wire.scad>

include <../utils/PrintheadOffsets.scad>
include <../utils/X_Rail.scad>
include <../vitamins/cables.scad>
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
    boltLength = halfCarriage ? 30 : 35;

    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        explode([0, -20, 0], true)
            xCarriageBeltSideBolts(xCarriageType, xCarriageBeltSideSize, topBoltLength=boltLength, holeSeparationTop=xCarriageHoleSeparationTopMGN12H(), bottomBoltLength=boltLength, holeSeparationBottom=xCarriageHoleSeparationBottomMGN12H(), screwType=hs_cap, offsetT=xCarriageHoleOffsetTop(), offsetB=xCarriageHoleOffsetBottom());
}

module xRailPrintheadPosition(rotate=0, explode=0, t=undef, halfCarriage=false) {
    xRailCarriagePosition(carriagePosition(t), rotate) // rotate is for debug, to see belts better
        printheadPosition(explode=explode, t=t, halfCarriage=halfCarriage)
            children();
}

module printheadPosition(rotate=0, explode=0, t=undef, halfCarriage=false) {
    xCarriageType = MGN12H_carriage;
    xCarriageBeltSideSize = xCarriageBeltSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    boltLength = halfCarriage ? 30 : 35;

    explode(explode, true) {
        children();

        explode([0, -20, 0], true)
            xCarriageBeltSideBolts(xCarriageType, xCarriageBeltSideSize, topBoltLength=boltLength, holeSeparationTop=xCarriageHoleSeparationTopMGN12H(), bottomBoltLength=boltLength, holeSeparationBottom=xCarriageHoleSeparationBottomMGN12H(), screwType=hs_cap, offsetT=xCarriageHoleOffsetTop(), offsetB=xCarriageHoleOffsetBottom());
        if (halfCarriage)
            xCarriageTopBolts(xCarriageType, countersunk=_xCarriageCountersunk, positions = [ [1, 1], [-1, 1] ]);
        *translate([xCarriageFrontSize.x/2, 18, -18])
            bl_touch_mount();
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

