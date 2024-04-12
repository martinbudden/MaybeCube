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
    offset = [size.x - holeSpacing.x - 4, 0, 15];

    for (x = [0, holeSpacing.x], z = [0, holeSpacing.z])
        translate(offset + [x - size.x/2, carriageSize.y/2 + railCarriageGap + size.y, z - size.z + xCarriageTopThickness()])
            rotate([90, 90, 0])
                children();
}

module xCarriageOrbiterV3(xCarriageType, inserts) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    carriageSize = carriage_size(xCarriageType);
    railCarriageGap = 0.5;
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    rotate([0, 90, -90]) {
        difference() {
            xCarriageBack(xCarriageType, size, 0, holeSeparationTop, holeSeparationBottom, halfCarriage=false, reflected=false, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
            translate([2, carriageSize.y/2 +size.y+1, 2]) {
                height = xCarriageTopThickness();
                base = 8;
                rotate([90, 0, 0])
                    linear_extrude(size.y+1)
                        polygon(points = [ [0,0], [base, 0], [base+height, height], [-height, height] ]);
            }
            offsetZ = 15 + 3.5;
            cutoutSize = [size.x+2*eps,2,3];
            translate([-size.x/2-eps, carriageSize.y/2 + railCarriageGap + size.y - cutoutSize.y + eps +0.5, offsetZ - size.z + xCarriageTopThickness()])
                rounded_cube_yz(cutoutSize, 0.5);

            xCarriageHotendSideHolePositions()
                if (inserts)
                    insertHoleM3(size.y, horizontal=true, rotate=180);
                else
                    boltHoleM3Tap(size.y, horizontal=true, rotate=180);
            xCarriageOrbiterV3HolePositions()
                boltHoleM3Countersunk(size.y, horizontal=true);
        }
    }
}

module X_Carriage_OrbiterV3_stl() {
    stl("X_Carriage_OrbiterV3")
        color(pp1_colour)
            xCarriageOrbiterV3(MGN12H_carriage, inserts=false);
}

module X_Carriage_OrbiterV3_I_stl() {
    stl("X_Carriage_OrbiterV3_I")
        color(pp1_colour)
            xCarriageOrbiterV3(MGN12H_carriage, inserts=true);
}

module xCarriageOrbiterV3Assembly(inserts=false) {
    stl_colour(pp1_colour)
        rotate([-90, 0, 90])
            if (inserts)
                X_Carriage_OrbiterV3_I_stl();
            else
                X_Carriage_OrbiterV3_stl();
    if (inserts)
        xCarriageHotendSideHolePositions()
            vflip()
                threadedInsertM3();
}

