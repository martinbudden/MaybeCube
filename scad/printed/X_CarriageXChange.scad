include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../printed/X_CarriageAssemblies.scad>
use <../utils/carriageTypes.scad>
use <../utils/PrintheadOffsets.scad>

use <../vitamins/bolts.scad>

use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>

include <../Parameters_Main.scad>


module X_Carriage_XChange_stl() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBackSize(xCarriageType, _beltWidth, clamps=false);
    topThickness = xCarriageTopThickness();
    railCarriageGap = 0.5;
    topSizeZ = 18.05 + railCarriageGap - 4.5;
    bottomSizeZ = 13.5 + railCarriageGap - 4.5;
    fillet = 1;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    stl("X_Carriage_XChange")
        color(pp1_colour)
            translate([-topThickness, -size.x/2, 6 - 20])
                difference() {
                    union() {
                        rounded_cube_xy([size.z, size.x, 0.25], fillet);
                        offsetX = 20;
                        translate([offsetX, 0, 0])
                            rounded_cube_xy([size.z - offsetX, size.x, 3.5], fillet);
                        rounded_cube_xy([xCarriageTopThickness(), size.x, topSizeZ], fillet);
                        translate([size.z - xCarriageBaseThickness(), 0, 0])
                            rounded_cube_xy([xCarriageBaseThickness(), size.x, bottomSizeZ], fillet);
                    }
                    // bolt holes  to connect to the belt side
                    holeOffset = 3;
                    for (y = xCarriageHolePositions(size.x, holeSeparationTop))
                        translate([5, y, holeOffset])
                            boltHoleM3Tap(topSizeZ - holeOffset, twist=4);
                    for (y = xCarriageHolePositions(size.x, holeSeparationBottom))
                        translate([size.z - 4, y, holeOffset])
                            boltHoleM3Tap(bottomSizeZ - holeOffset, twist=4);

                    holeSeparation = carriage_pitch_y(xCarriageType);
                    for (y = [-holeSeparation/2, holeSeparation/2]) {
                        // bolt holes to connect to the XChange
                        for (x = [4 + holeSeparation])
                        translate([x, y + size.x/2, 0])
                            boltHoleM3Tap(size.y, twist=4);
                        // bolt holes to connect to to the MGN carriage
                        translate([0, y + size.x/2, 4])
                            rotate([90, 0, 90]) {
                                boltHoleM3(topThickness, horizontal=true);
                            }
                    }
                }
}

module X_Carriage_XChange_hardware() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageBackSize(xCarriageType, _beltWidth, clamps=false);
    topThickness = xCarriageTopThickness();
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    translate([-topThickness, -size.x/2, 6 - 20]) {
        // bolt holes  to connect to the belt side
        holeOffset = 3;
        for (y = xCarriageHolePositions(size.x, holeSeparationTop))
            translate([5, y, holeOffset + 30.6])
                explode(40, true)
                    boltM3Countersunk(30);
        for (y = xCarriageHolePositions(size.x, holeSeparationBottom))
            translate([size.z - 4, y, holeOffset + 30.6])
                explode(40, true)
                    boltM3Countersunk(30);

        holeSeparation = carriage_pitch_y(xCarriageType);
        for (y = [-holeSeparation/2, holeSeparation/2]) {
            // bolt holes to connect to the XChange
            for (x = [4 + holeSeparation])
                translate([x, y + size.x/2, -2])
                    vflip()
                        boltM3Caphead(6);
            // bolt holes to connect to to the MGN carriage
            translate([-2, y + size.x/2, 4])
                rotate([90, 0, 90])
                    vflip()
                        boltM3Caphead(10);
        }
    }
}

module X_Carriage_XChange_assembly()
assembly("X_Carriage_XChange", ngb=true) {

    explode([0, 40, 0], true)
        rotate([0, 90, -90]) {
            stl_colour(pp1_colour)
                X_Carriage_XChange_stl();
            X_Carriage_XChange_hardware();
        }
}
