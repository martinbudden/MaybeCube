include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>
include <../utils/X_Carriage.scad>


use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>

include <../Parameters_CoreXY.scad>
include <../Parameters_Main.scad>

function orbiterV3HoleOffset() = [-5, 0, 17]; // !!MJB perhaps change z value to 18 to allign with Dragon_Burner

module xCarriageOrbiterV3HolePositions(xCarriageType) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    railCarriageGap = 0.5;
    holeSpacing = [16.5, 0, 23];
    offset = [size.x - holeSpacing.x, 0, 0] + orbiterV3HoleOffset();

    for (x = [0, holeSpacing.x], z = [0, holeSpacing.z])
        translate(offset + [x - size.x/2, carriageSize.y/2 + railCarriageGap, z - size.z + xCarriageTopThickness()])
            rotate([90, 90, 0])
                children();
}

module xCarriageOrbitrerV3CableTiePositions(full=true) {
    for (z = full ? [2, 15, 25, 35, 45,55, 65] : [2, 15, 55, 65])
        translate_z(z)
            children();
}

module xCarriageOrbitrerV3StrainRelief(xCarriageType, xCarriageBackSize, topThickness) {
    carriageSize = carriage_size(xCarriageType);
    carriageOffsetY = carriageSize.y/2;
    size =  [xCarriageBackSize.x, xCarriageBackSize.y + carriageSize.y/2, topThickness];
    tabSize = [15, xCarriageBackSize.y, 73]; // ensure room for bolt heads
    railCarriageGap = 0.5;

    fillet = 1;
    translate([0, railCarriageGap, size.z - 2*fillet])
        difference() {
            rounded_cube_xz(tabSize, fillet);
            cutoutSize = [2, tabSize.y + 2*eps, 4];
            xCarriageOrbitrerV3CableTiePositions()
                for (x = [tabSize.x/2 - 4, tabSize.x/2 + 4])
                    translate([x - cutoutSize.x/2, -eps, 0])
                        rounded_cube_xz(cutoutSize, 0.5);
        }
}

module xCarriageOrbiterV3Back(xCarriageType, size, extraX=0, holeSeparationTop, holeSeparationBottom, countersunk=0, topHoleOffset=0) {
    assert(is_list(xCarriageType));
    internalFillet = 1.5;
    carriageSize = carriage_size(xCarriageType);
    isMGN12 = carriageSize.z >= 13;
    topThickness = xCarriageTopThickness();
    baseThickness = xCarriageBaseThickness();
    railCarriageGap = 0.5;

    baseSize = [size.x, carriageSize.y + size.y - 2*beltInsetBack(xCarriageType), baseThickness];
    translate([-size.x/2, carriageSize.y/2, 0])
        difference() {
            union() {
                translate([0, railCarriageGap, baseSize.z - size.z])
                    rounded_cube_xz([size.x, size.y, size.z], 1);
                xCarriageOrbitrerV3StrainRelief(xCarriageType, size, topThickness);
            } // end union
            cutoutSize = [2, size.y + carriageSize.y/2 + 2*eps, 4];
                translate([2.5 - cutoutSize.x/2, -eps, -16])
                    rounded_cube_xz(cutoutSize, 0.5);
        } // end difference
}

module xCarriageOrbiterV3(xCarriageType, inserts) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    railCarriageGap = 0.5;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    rotate([0, 90, -90]) {
        difference() {
            xCarriageOrbiterV3Back(xCarriageType, size, 0, holeSeparationTop, holeSeparationBottom, countersunk=_xCarriageCountersunk ? 4 : 0);
            translate([0, carriageSize.y/2 + size.y + 1, eps]) {
                height = xCarriageTopThickness();
                base = 5;
                rotate([90, 0, 0])
                    linear_extrude(size.y + 1)
                        polygon(points = [ [0,0], [base + height, 0], [base+height, height], [-height, height] ]);
                translate([base + height, 0, height])
                    rotate([90, 90, 0])
                        fillet(1, size.y + 1);
            }
            offsetZ = orbiterV3HoleOffset().z + 3.5;
            cutoutSize = [size.x + 2*eps, 2, 3];
            // cutout for the hotend fan wiring
            translate([-size.x/2-eps, carriageSize.y/2 + railCarriageGap + size.y - cutoutSize.y + eps +0.5, offsetZ - size.z + xCarriageTopThickness()]) {
                cube(cutoutSize);
                rotate([-90, 0, 0])
                    fillet(1, cutoutSize.y + eps);
                translate([cutoutSize.x, 0, 0])
                    rotate([-90, 90, 0])
                        fillet(1, cutoutSize.y + eps);
                translate([cutoutSize.x, 0, cutoutSize.z])
                    rotate([-90, 180, 0])
                        fillet(1, cutoutSize.y + eps);
                translate([-1.5, 0, 0]) {
                    rounded_cube_xz([8, cutoutSize.y, 17.5], 1);
                    translate([8, 0, cutoutSize.z])
                        rotate([-90, -90, 0])
                            fillet(1, cutoutSize.y + eps);
                }
                translate([0, 0, 17.5])
                    rotate([-90, -90, 0])
                        fillet(1, cutoutSize.y + eps);
            }

            xCarriageHotendSideHolePositions(xCarriageType)
                if (inserts)
                    vflip()
                        translate_z(-size.y)
                            insertHoleM3(size.y);
                else
                    boltHoleM3Tap(size.y);
            xCarriageOrbiterV3HolePositions(xCarriageType)
                vflip()
                    boltPolyholeM3Countersunk(size.y);
        }
    }
}
module X_Carriage_OrbiterV3_ST_stl() {
    // self tapping version
    stl("X_Carriage_OrbiterV3_ST")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageOrbiterV3(MGN12H_carriage, inserts=false);
}

module X_Carriage_OrbiterV3_stl() {
    stl("X_Carriage_OrbiterV3")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageOrbiterV3(MGN12H_carriage, inserts=true);
}

module xCarriageOrbiterV3Assembly(xCarriageType, inserts=false) {
    stl_colour(pp1_colour)
        rotate([-90, 0, 0])
            if (inserts)
                X_Carriage_OrbiterV3_stl();
            else
                X_Carriage_OrbiterV3_ST_stl();
    if (inserts)
        xCarriageHotendSideHolePositions(xCarriageType, flipSide=true)
            explode(10, true)
                threadedInsertM3();
}

