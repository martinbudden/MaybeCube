include <../global_defs.scad>

include <../vitamins/bolts.scad>
use <../vitamins/OrbiterV3.scad>

use <NopSCADlib/utils/fillet.scad>

use <X_CarriageAssemblies.scad>
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
strainReliefSizeX =  15;

module ToolheadPCB() {
    color(grey(35))
        translate([82.2, -57.2, 1.6])
            rotate([0 ,-90, 0])
                import(str("../stlimport/VoronAfterBurner_Toolhead_pcb _v3.stl"), convexity=10);
}

module xCarriageBiquH2V2SRevoHolePositions(xCarriageType) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);

    for (z = [0, biquH2V2SRevoAttachmentBoltSpacing()])
        translate([biquH2V2SRevoOffsetX(), carriageSize.y/2 + railCarriageGap(), z - biquH2V2SRevoNozzleOffsetFromMGNCarriageZ() + biquH2V2SRevoLowerFixingHoleToNozzleTipOffsetZ()])
            rotate([90, 90, 0])
                children();
}

module xCarriageBiquH2V2SRevoCableTieOffsets(pcb=false) {
    for (z = pcb ? [70, 80] : [5, 15, 25, 35])
        translate([strainReliefSizeX/2, 0,z])
            children();
}

module xCarriageBiquH2V2SRevoCableTiePositions(xCarriageType, pcb=false) {
    xCarriageBackSize = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);

    translate([pcb ? xCarriageBackSize.x/2  - strainReliefSizeX : -xCarriageBackSize.x/2, carriageSize.y/2, xCarriageBaseThickness()])
        xCarriageBiquH2V2SRevoCableTieOffsets(pcb=pcb)
            children();
}

module xCarriageBiquH2V2SRevoStrainRelief(carriageSize, xCarriageBackSize, topThickness) {
    fillet = 1;
    tabSize = [strainReliefSizeX, xCarriageBackSize.y, 40 + 2*fillet]; // ensure room for bolt heads

    difference() {
        union() {
            translate_z(-2*fillet)
                rounded_cube_xz(tabSize, fillet);
            translate([tabSize.x, 0, 0])
                rotate([-90, -90, 0])
                    fillet(2, tabSize.y);
        }
        cutoutSize = [2.2, tabSize.y + 2*eps, 4.5];
        xCarriageBiquH2V2SRevoCableTieOffsets(pcb=false)
            for (x = [-4, 4])
                translate([x - cutoutSize.x/2, -eps, -cutoutSize.z/2])
                    rounded_cube_xz(cutoutSize, 0.5);
    }
}

module xCarriageBiquH2V2SRevoBack(carriageSize, size, extraX=0, holeSeparationTop, holeSeparationBottom, countersunk=0, topHoleOffset=0) {
    topThickness = xCarriageTopThickness();
    baseThickness = xCarriageBaseThickness();

    translate([-size.x/2, carriageSize.y/2, baseThickness]) {
        translate_z(-size.z)
            rounded_cube_xz(size + [1, 0, 0], 1);
        xCarriageBiquH2V2SRevoStrainRelief(carriageSize, size, topThickness);
    }
}

module xCarriageBiquH2V2SRevoStrainReliefPCB(carriageSize, xCarriageBackSize, topThickness) {
    fillet = 1;
    tabSize = [strainReliefSizeX, xCarriageBackSize.y, 85 + 2*fillet];

    difference() {
        union() {
            translate_z(-2*fillet)
                rounded_cube_xz(tabSize, fillet);
            translate([0, 0, 0])
                rotate([-90, 180, 0])
                    fillet(2, tabSize.y);
        }
        cutoutSize = [2.2, tabSize.y + 2*eps, 4.5];
        xCarriageBiquH2V2SRevoCableTieOffsets(pcb=true)
            for (x = [-4, 4])
                translate([x - cutoutSize.x/2, -eps, -cutoutSize.z/2])
                    rounded_cube_xz(cutoutSize, 0.5);
    }
}
module xCarriageBiquH2V2SRevoBackPCB(carriageSize, size, extraX=0, holeSeparationTop, holeSeparationBottom, countersunk=0, topHoleOffset=0) {
    topThickness = xCarriageTopThickness();
    baseThickness = xCarriageBaseThickness();
    fillet = 1;

    translate([-size.x/2, carriageSize.y/2, baseThickness]) {
        extraSize = [1, 0, 0];
        translate_z(-size.z)
            rounded_cube_xz(size + extraSize, fillet);
        pcbCubeSize = [38, size.y, 45 + 2*fillet];
        pcbOffsetY = 2.5;
        translate([size.x + extraSize.x, 0, 0]) {
            difference() {
                union() {
                    translate([-pcbCubeSize.x , 0, -2*fillet])
                        rounded_cube_xz(pcbCubeSize, fillet);
                    translate([-strainReliefSizeX , 0, 0])
                        xCarriageBiquH2V2SRevoStrainReliefPCB(carriageSize, size, topThickness);
                    b1Size = [20, size.y + pcbOffsetY, 12];
                    translate([-pcbCubeSize.x, 0, 0])
                        rounded_cube_xz(b1Size, 1);
                    b2Size = [15, size.y + pcbOffsetY, 10];
                    translate([-b2Size.x, 0, 21])
                        rounded_cube_xz(b2Size, 1);
                }
                translate([-pcbCubeSize.x + 2, -eps, 4])
                    rounded_cube_xz([2.2, size.y + pcbOffsetY +2*eps, 4.5], 0.5);
                translate([-24.3, 0, 7.7]) {
                    rotate([-90, 180, 0])
                        boltHoleM3Tap(size.y + pcbOffsetY);
                    translate([14.3, 0, 17.8])
                        rotate([-90, 180, 0])
                            boltHoleM3Tap(size.y + pcbOffsetY);
                }
            }
            translate([-pcbCubeSize.x, 0, 0])
                rotate([-90, 180, 0])
                    fillet(2, size.y);
            translate([-strainReliefSizeX, 0, pcbCubeSize.z - 2*fillet])
                rotate([-90, 180, 0])
                    fillet(2, size.y);
        }
    }
}
module xCarriageBiquH2V2SRevo(xCarriageType, inserts, pcb) {
    assert(is_list(xCarriageType));
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    rotate([0, 90, -90])
        difference() {
            translate([0, railCarriageGap(), 0])
                if (pcb)
                    xCarriageBiquH2V2SRevoBackPCB(carriageSize, size, 0, holeSeparationTop, holeSeparationBottom, countersunk=_xCarriageCountersunk ? 4 : 0);
                else
                    xCarriageBiquH2V2SRevoBack(carriageSize, size, 0, holeSeparationTop, holeSeparationBottom, countersunk=_xCarriageCountersunk ? 4 : 0);

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

module X_Carriage_BIQU_H2V2SRevo_ST_stl() {
    // self tapping version
    stl("X_Carriage_BIQU_H2V2SRevo_ST")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageBiquH2V2SRevo(MGN12H_carriage, inserts=false, pcb=false);
}

module X_Carriage_BIQU_H2V2SRevo_PCB_ST_stl() {
    // self tapping version
    stl("X_Carriage_BIQU_H2V2SRevo_PCB_ST")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageBiquH2V2SRevo(MGN12H_carriage, inserts=false, pcb=true);
}

module X_Carriage_BIQU_H2V2SRevo_stl() {
    stl("X_Carriage_BIQU_H2V2SRevo")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageBiquH2V2SRevo(MGN12H_carriage, inserts=true, pcb=false);
}

module X_Carriage_BIQU_H2V2SRevo_PCB_stl() {
    stl("X_Carriage_BIQU_H2V2SRevo_PCB")
        color(pp1_colour)
            rotate([0, -90, 0])
                xCarriageBiquH2V2SRevo(MGN12H_carriage, inserts=true, pcb=true);
}

module xCarriageBIQU_H2V2SRevoAssembly(inserts=false, pcb=false) {
    stl_colour(pp1_colour)
        rotate([-90, 0, 0])
            if (inserts)
                if (pcb)
                    X_Carriage_BIQU_H2V2SRevo_PCB_stl();
                else
                    X_Carriage_BIQU_H2V2SRevo_stl();
            else
                if (pcb)
                    X_Carriage_BIQU_H2V2SRevo_PCB_ST_stl();
                else
                    X_Carriage_BIQU_H2V2SRevo_ST_stl();

    xCarriageType = MGN12H_carriage;

    if (pcb) {
        xCarriageBackSize = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
        carriageSize = carriage_size(xCarriageType);
        translate([xCarriageBackSize.x/2, carriageSize.y/2 + xCarriageBackSize.y - 0.5, xCarriageBaseThickness()])
            translate([0, 5, 0])
                rotate([90, 0, 180])
                    ToolheadPCB();
    }

    if (inserts)
        xCarriageHotendSideHolePositions(xCarriageType, flipSide=true)
            explode(10, true)
                threadedInsertM3();
}

