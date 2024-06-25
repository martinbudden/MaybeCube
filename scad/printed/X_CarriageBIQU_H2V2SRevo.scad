include <../global_defs.scad>

include <../vitamins/bolts.scad>
use <../vitamins/OrbiterV3.scad>

use <NopSCADlib/utils/fillet.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>
include <../utils/X_Carriage.scad>
use <../vitamins/BIQU_H2V2SRevo.scad>


use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>

include <../Parameters_CoreXY.scad>
include <../Parameters_Main.scad>

function biquH2V2SRevoNozzleOffsetFromMGNCarriageZ() = 61.2; // offset from tip of nozzle to top of MGN carriage
function biquH2V2SRevoOffsetX() = -5;

 
module xCarriageBiquH2V2SRevoHolePositions(xCarriageType) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);

    for (z = [0, biquH2V2SRevoAttachmentBoltSpacing()])
        translate([biquH2V2SRevoOffsetX(), carriageSize.y/2 + railCarriageGap(), z - biquH2V2SRevoNozzleOffsetFromMGNCarriageZ() + biquH2V2SRevoLowerFixingHoleToNozzleTipOffsetZ()])
            rotate([90, 90, 0])
                children();
}

module xCarriageBiquH2V2SRevoCableTiePositions(full=true) {
    for (z = [5, 15, 25, 35])
        translate_z(z)
            children();
}

module xCarriageBiquH2V2SRevoStrainRelief(carriageSize, xCarriageBackSize, topThickness) {
    size =  [xCarriageBackSize.x, xCarriageBackSize.y + carriageSize.y/2, topThickness];
    tabSize = [15, xCarriageBackSize.y, 45]; // ensure room for bolt heads

    fillet = 1;
    translate_z(xCarriageBackSize.z - 2*fillet)
        difference() {
            union() {
                rounded_cube_xz(tabSize, fillet);
                translate([tabSize.x, 0, 2*fillet])
                    rotate([-90, -90, 0])
                        fillet(2, tabSize.y);
            }
            cutoutSize = [2.2, tabSize.y + 2*eps, 4.5];
            xCarriageBiquH2V2SRevoCableTiePositions()
                for (x = [tabSize.x/2 - 4, tabSize.x/2 + 4])
                    translate([x - cutoutSize.x/2, -eps, 0])
                        rounded_cube_xz(cutoutSize, 0.5);
        }
}
module xCarriageBiquH2V2SRevoBack(xCarriageType, size, extraX=0, holeSeparationTop, holeSeparationBottom, countersunk=0, topHoleOffset=0) {
    assert(is_list(xCarriageType));
    internalFillet = 1.5;
    carriageSize = carriage_size(xCarriageType);
    topThickness = xCarriageTopThickness();
    baseThickness = xCarriageBaseThickness();

    baseSize = [size.x, carriageSize.y + size.y - 2*beltInsetBack(xCarriageType), baseThickness];
    translate([-size.x/2, carriageSize.y/2, baseSize.z - size.z]) {
        rounded_cube_xz(size + [5, 0, 0], 1);
        xCarriageBiquH2V2SRevoStrainRelief(carriageSize, size, topThickness);
    }
}

module xCarriageBiquH2V2SRevo(xCarriageType, inserts) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    rotate([0, 90, -90]) {
        translate([0, railCarriageGap() + 2*eps, 0])
            difference() {
                xCarriageBiquH2V2SRevoBack(xCarriageType, size, 0, holeSeparationTop, holeSeparationBottom, countersunk=_xCarriageCountersunk ? 4 : 0);

                translate([0, -railCarriageGap(), 0]) {
                    xCarriageHotendSideHolePositions(xCarriageType)
                        if (inserts)
                            vflip()
                                translate_z(-size.y)
                                    insertHoleM3(size.y);
                        else
                            boltHoleM3Tap(size.y);
                    xCarriageBiquH2V2SRevoHolePositions(xCarriageType)
                        vflip()
                            boltPolyholeM3Countersunk(size.y);
                }
            }
    }
}
module X_Carriage_BIQU_H2V2SRevo_ST_stl() {
    // self tapping version
    stl("X_Carriage_BIQU_H2V2SRevo_ST")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageBiquH2V2SRevo(MGN12H_carriage, inserts=false);
}

module X_Carriage_BIQU_H2V2SRevo_stl() {
    stl("X_Carriage_BIQU_H2V2SRevo")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageBiquH2V2SRevo(MGN12H_carriage, inserts=true);
}

module xCarriageBIQU_H2V2SRevoAssembly(inserts=false) {
    stl_colour(pp1_colour)
        rotate([-90, 0, 0])
            if (inserts)
                X_Carriage_BIQU_H2V2SRevo_stl();
            else
                X_Carriage_BIQU_H2V2SRevo_ST_stl();
    if (inserts)
        xCarriageHotendSideHolePositions(MGN12H_carriage, flipSide=true)
            explode(10, true)
                threadedInsertM3();
}

