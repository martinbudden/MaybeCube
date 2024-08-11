include <../config/global_defs.scad>

include <../vitamins/bolts.scad>
use <../vitamins/OrbiterV3.scad>

use <NopSCADlib/utils/fillet.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>
include <../utils/X_Carriage.scad>

use <../../../BabyCube/scad/printed/X_Carriage.scad>


function orbiterV3NozzleOffsetFromMGNCarriageZ() = 61.2; // offset from tip of nozzle to top of MGN carriage
function orbiterV3OffsetX() = 1.5;

strainReliefSizeX =  15;
cutoutZ = 17.5;
cutoutOffsetZ = 3.1;

module xCarriageOrbiterV3HolePositions(xCarriageType) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    holeSpacing = [smartOrbiterV3AttachmentBoltSpacing().x, 0, smartOrbiterV3AttachmentBoltSpacing().y];

    for (x = [0, holeSpacing.x], z = [0, holeSpacing.z])
        translate([x + orbiterV3OffsetX(), carriageSize.y/2 + railCarriageGap(), z - orbiterV3NozzleOffsetFromMGNCarriageZ() + smartOrbiterV3LowerFixingHolesToNozzleTipOffsetZ()])
            rotate([90, 90, 0])
                children();
}

module xCarriageOrbiterV3CableTieOffsets(full=true) {
    for (z = full ? [2, 15, 25, 35, 45, 55, 65] : [2, 15, 55, 65])
        translate([strainReliefSizeX/2, 0, z + 2.25-2])
            children();
}

module xCarriageOrbiterV3CableTiePositions(xCarriageType, full=false) {
    xCarriageBackSize = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);

    translate([-xCarriageBackSize.x/2, carriageSize.y/2, xCarriageBaseThickness()])
        xCarriageOrbiterV3CableTieOffsets(full)
            children();
}

module xCarriageOrbiterV3LowerCableTiePosition(xCarriageType) {
    xCarriageBackSize = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);

    offsetZ = cutoutOffsetZ + cutoutZ + smartOrbiterV3LowerFixingHolesToNozzleTipOffsetZ() - orbiterV3NozzleOffsetFromMGNCarriageZ();
    cutoutSize = [2, 7 + 2*eps, 4];
    translate([-xCarriageBackSize.x/2+1, carriageSize.y/2, 0])
        translate([2.5 - cutoutSize.x/2, -eps, offsetZ - cutoutSize.z/2])
            children();
}

module xCarriageOrbiterV3StrainRelief(carriageSize, xCarriageBackSize, topThickness, fillet) {
    size =  [xCarriageBackSize.x, xCarriageBackSize.y + carriageSize.y/2, topThickness];
    tabSize = [strainReliefSizeX, xCarriageBackSize.y, 73]; // ensure room for bolt heads

    difference() {
        translate_z(-2*fillet)
            rounded_cube_xz(tabSize, fillet);
        cutoutSize = [2.2, tabSize.y + 2*eps, 4.5];
        xCarriageOrbiterV3CableTieOffsets()
            for (x = [-4, 4])
                translate([x - cutoutSize.x/2, -eps, -cutoutSize.z/2])
                    rounded_cube_xz(cutoutSize, 0.5);
    }
}

module xCarriageOrbiterV3Back(xCarriageType, size) {
    assert(is_list(xCarriageType));
    internalFillet = 1.5;
    carriageSize = carriage_size(xCarriageType);
    topThickness = xCarriageTopThickness();
    baseThickness = xCarriageBaseThickness();
    fillet = 1.5;

    translate([-size.x/2, carriageSize.y/2, 0])
        difference() {
            union() {
                translate_z(baseThickness - size.z)
                    rounded_cube_xz([size.x, size.y, size.z], fillet);
                translate_z(topThickness)
                    xCarriageOrbiterV3StrainRelief(carriageSize, size, topThickness, fillet);
            } // end union
            // cutout for ziptie
            offsetZ = cutoutOffsetZ + cutoutZ + smartOrbiterV3LowerFixingHolesToNozzleTipOffsetZ() - orbiterV3NozzleOffsetFromMGNCarriageZ();
            cutoutSize = [2, size.y + 2*eps, 4];
            translate([2.5 - cutoutSize.x/2, -eps, offsetZ - cutoutSize.z])
                rounded_cube_xz(cutoutSize, 0.5);
        } // end difference
}

module xCarriageOrbiterV3(xCarriageType, inserts) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);

    rotate([0, 90, -90]) {
        translate([0, railCarriageGap() + 2*eps, 0])
            difference() {
                xCarriageOrbiterV3Back(xCarriageType, size);
                translate([0, carriageSize.y/2 + size.y + eps, eps]) {
                    height = xCarriageTopThickness();
                    base = 5;
                    rotate([90, 0, 0])
                        linear_extrude(size.y + 2*eps)
                            polygon(points = [ [0,0], [base + height, 0], [base+height, height], [-height, height] ]);
                    translate([base + height, 0, height])
                        rotate([90, 90, 0])
                            fillet(1, size.y + 2*eps);
                }
                // cutout for the hotend fan wiring
                cutoutSize = [size.x + 2*eps, 2, 4];
                offsetZ = cutoutOffsetZ + smartOrbiterV3LowerFixingHolesToNozzleTipOffsetZ() - orbiterV3NozzleOffsetFromMGNCarriageZ();
                translate([-size.x/2 - eps, carriageSize.y/2 + railCarriageGap() + size.y - cutoutSize.y + eps + 0.5, offsetZ]) {
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
                        rounded_cube_xz([8, cutoutSize.y, cutoutZ], 1);
                        translate([8, 0, cutoutSize.z])
                            rotate([-90, -90, 0])
                                fillet(1, cutoutSize.y + eps);
                    }
                    translate([0, 0, 17.5])
                        rotate([-90, -90, 0])
                            fillet(1, cutoutSize.y + eps);
                }

                translate([0, -railCarriageGap(), 0]) {
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

module xCarriageOrbiterV3Assembly(inserts=false) {
    stl_colour(pp1_colour)
        rotate([-90, 0, 0])
            if (inserts)
                X_Carriage_OrbiterV3_stl();
            else
                X_Carriage_OrbiterV3_ST_stl();
    if (inserts)
        xCarriageHotendSideHolePositions(MGN12H_carriage, flipSide=true)
            explode(10, true)
                threadedInsertM3();
}

