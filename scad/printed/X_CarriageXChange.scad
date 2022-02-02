include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>

include <../vitamins/bolts.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>

include <../Parameters_CoreXY.scad>
include <../Parameters_Main.scad>

xChangeBoltOffset = 4 - 0.2; // 0.2 to allow clearance for xCarriage countersunk bolts

module X_Carriage_XChange_HC_16_stl() {
    stl("X_Carriage_XChange_HC_16")
        color(pp3_colour)
            xCarriageXChange(coreXY_GT2_20_16, halfCarriage=true);
}

module X_Carriage_XChange_16_stl() {
    stl("X_Carriage_XChange_16")
        color(pp3_colour)
            rotate([180, 0, 90]) // align for printing
                xCarriageXChange(coreXY_GT2_20_16, halfCarriage=false);
}

module X_Carriage_XChange_25_stl() {
    stl("X_Carriage_XChange_25")
        color(pp3_colour)
            rotate([180, 0, 90]) // align for printing
                xCarriageXChange(coreXY_GT2_20_25, halfCarriage=false);
}

module xCarriageXChange(coreXYType, halfCarriage) {
    xCarriageType = MGN12H_carriage;
    carriageSize = carriage_size(xCarriageType);
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(coreXYType), beltSeparation(coreXYType));
    echo(size=size);
    topThickness = xCarriageTopThickness();
    railCarriageGap = 0.5;
    topSizeZ = 18.05 + railCarriageGap - 4.5;
    bottomSizeZ = 13.5 + railCarriageGap - 4.5;
    fillet = 1;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    translate([-topThickness, -size.x/2, halfCarriage ? -14 : -carriageSize.y/2 - 8])
        difference() {
            union() {
                if (halfCarriage) {
                    rounded_cube_xy([size.z, size.x, 0.25], fillet);
                    offsetX = 20;
                    translate([offsetX, 0, 0])
                        rounded_cube_xy([size.z - offsetX, size.x, 3.5], fillet);
                    rounded_cube_xy([xCarriageTopThickness(), size.x, topSizeZ], fillet);
                    translate([size.z - xCarriageBaseThickness(), 0, 0])
                        rounded_cube_xy([xCarriageBaseThickness(), size.x, bottomSizeZ], fillet);
                } else {
                    rounded_cube_xy([size.z, size.x, 8], fillet);
                }
            }
            // bolt holes  to connect to the belt side
            holeOffset = halfCarriage ? 3 : 0;
            for (x = halfCarriage ? [5, size.z - 4] : [4, size.z - 4], y = xCarriageHolePositions(size.x, holeSeparationTop))
                translate([x, y, holeOffset])
                    boltHoleM3Tap(topSizeZ - holeOffset);

            holeSeparation = carriage_pitch_y(xCarriageType);
            for (y = [-holeSeparation/2, holeSeparation/2]) {
                // bolt holes to connect to the XChange
                for (x = halfCarriage ? [holeSeparation] : [holeSeparation, 0])
                    translate([x + xChangeBoltOffset, y + size.x/2, 0])
                        boltHoleM3Tap(size.y);
                // bolt holes to connect to to the MGN carriage
                if (halfCarriage)
                    translate([0, y + size.x/2, 4])
                        rotate([90, 0, 90])
                            boltHoleM3(topThickness, horizontal=true);
            }
        }
}

module X_Carriage_XChange_hardware(halfCarriage, usePulley25) {
    xCarriageType = MGN12H_carriage;
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth=6, beltSeparation=beltSeparation());
    topThickness = xCarriageTopThickness();
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    translate([-topThickness, -size.x/2, 6 - 20]) {
        // bolt holes  to connect to the belt side
        holeOffset = 3;
        boltLength = halfCarriage ? 30 : 40;
        for (x = halfCarriage ? [5, size.z - 4] : [4, size.z - 4], y = xCarriageHolePositions(size.x, holeSeparationTop))
            translate([x, y, halfCarriage ? holeOffset + 30.6 : usePulley25 ? 35 : 33])
                explode(40, true)
                    boltM3Countersunk(boltLength);

        holeSeparation = carriage_pitch_y(xCarriageType);
        for (y = [-holeSeparation/2, holeSeparation/2]) {
            // bolts to connect to the XChange
            for (x = halfCarriage ? [holeSeparation] :  [holeSeparation, 0])
                translate([x + xChangeBoltOffset, y + size.x/2, halfCarriage ? -2 : -10])
                    vflip()
                        boltM3Caphead(6);
            // bolts to connect to to the MGN carriage
            if (halfCarriage)
                translate([-2, y + size.x/2, halfCarriage ? 4 : -4])
                    rotate([90, 0, 90])
                        vflip()
                            boltM3Caphead(10);
        }
    }
}

module xCarriageXChangeAssembly() {

    halfCarriage = (!is_undef(_useHalfCarriage) && _useHalfCarriage==true);

    explode([0, 40, 0], true)
        rotate([0, 90, -90]) {
            stl_colour(pp3_colour)
                if (halfCarriage)
                    X_Carriage_XChange_HC_16_stl();
                else
                    rotate([180, 0, 90])
                        translate_z(0.5)
                            if (usePulley25())
                                X_Carriage_XChange_25_stl();
                            else
                                X_Carriage_XChange_16_stl();
            X_Carriage_XChange_hardware(halfCarriage, usePulley25());
        }
    hidden() stl_colour(pp3_colour) X_Carriage_XChange_25_stl();
}
