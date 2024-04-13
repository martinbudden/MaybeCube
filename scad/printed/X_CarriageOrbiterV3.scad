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

module xCarriageOrbiterV3HolePositions() {
    xCarriageType = MGN12H_carriage;
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    railCarriageGap = 0.5;
    holeSpacing = [16.5, 0, 23];
    offset = [size.x - holeSpacing.x - 5, 0, 23];

    for (x = [0, holeSpacing.x], z = [0, holeSpacing.z])
        translate(offset + [x - size.x/2, carriageSize.y/2 + railCarriageGap + size.y, z - size.z + xCarriageTopThickness()])
            rotate([90, 90, 0])
                children();
}
module xCarriageOrbitrerV3StrainRelief(xCarriageType, xCarriageBackSize, topThickness) {
    carriageSize = carriage_size(xCarriageType);
    carriageOffsetY = carriageSize.y/2;
    size =  [xCarriageBackSize.x, xCarriageBackSize.y + carriageSize.y/2, topThickness];
    tabSize = [15, xCarriageBackSize.y, 30]; // ensure room for bolt heads
    railCarriageGap = 0.5;

    fillet = 1;
    translate([0, railCarriageGap, size.z - 2*fillet])
        difference() {
            rounded_cube_xz(tabSize, fillet);
            for (x = [tabSize.x/2 - 4, tabSize.x/2 + 4], z = [10 + 2, tabSize.z - 10 + 2])
                translate([x - 1, -eps, z])
                    cube([2, tabSize.y + 2*eps, 4]);
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
    difference() {
        translate([-size.x/2, carriageSize.y/2, 0])
            union() {
                translate([0, railCarriageGap, baseSize.z - size.z])
                    rounded_cube_xz([size.x, size.y, size.z], 1);
                // top
                xCarriageOrbitrerV3StrainRelief(xCarriageType, size, topThickness);
            } // end union
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
            translate([0, carriageSize.y/2 + size.y + 1, 2]) {
                height = xCarriageTopThickness();
                base = 6;
                rotate([90, 0, 0])
                    linear_extrude(size.y + 1)
                        polygon(points = [ [0,0], [base + height, 0], [base+height, height], [-height, height] ]);
                translate([base+height,0,height-2])
                    rotate([90, 90, 0])
                        fillet(1, size.y + 1);
            }
            offsetZ = 23 + 3.5;
            cutoutSize = [size.x+2*eps,2,3];
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
                    rounded_cube_xz([8, cutoutSize.y, 15], 1);
                    translate([8, 0, cutoutSize.z])
                        rotate([-90, -90, 0])
                            fillet(1, cutoutSize.y + eps);
                }
                translate([0, 0, 15])
                    rotate([-90, -90, 0])
                        fillet(1, cutoutSize.y + eps);
            }

            xCarriageHotendSideHolePositions()
                if (inserts)
                    insertHoleM3(size.y);
                else
                    boltHoleM3Tap(size.y);
            xCarriageOrbiterV3HolePositions()
                vflip()
                    translate_z(-size.y)
                        boltPolyholeM3Countersunk(size.y);
        }
    }
}

module X_Carriage_OrbiterV3_stl() {
    stl("X_Carriage_OrbiterV3")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageOrbiterV3(MGN12H_carriage, inserts=false);
}

module X_Carriage_OrbiterV3_I_stl() {
    stl("X_Carriage_OrbiterV3_I")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageOrbiterV3(MGN12H_carriage, inserts=true);
}

module xCarriageOrbiterV3Assembly(inserts=false) {
    stl_colour(pp1_colour)
        rotate([-90, 0, 0])
            if (inserts)
                X_Carriage_OrbiterV3_I_stl();
            else
                X_Carriage_OrbiterV3_stl();
    if (inserts)
        xCarriageHotendSideHolePositions()
            vflip()
                threadedInsertM3();
}

