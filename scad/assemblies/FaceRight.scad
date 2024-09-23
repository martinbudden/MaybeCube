include <../config/global_defs.scad>

include <../utils/FrameBolts.scad>

use <../printed/AccessPanel.scad>
use <../printed/extruderBracket.scad>
use <../printed/IEC_Housing.scad>
use <../printed/RightSidePanel.scad>

include <../utils/Z_Rods.scad>

include <FaceRightExtras.scad>

use <../config/Parameters_Positions.scad>

//!1. On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown.
//!2. If using a Bowden Extruder, bolt the **Extruder_Bracket_assembly** to the upper extrusion and upright.
//
module Right_Side_assembly(bedHeight=undef, printbedKinematic=undef, sideAssemblies=undef) pose(a=[55, 0, 25 - 90])
assembly("Right_Side", big=true) {

    printbedKinematic = is_undef(printbedKinematic) ? (!is_undef(_printbedKinematic) && _printbedKinematic == true) : printbedKinematic;
    useBackMounts = !is_undef(_useBackMounts) && _useBackMounts == true;
    useElectronicsInBase = !is_undef(_useElectronicsInBase) && _useElectronicsInBase == true;
    sideAssemblies = is_undef(sideAssemblies) ? (is_undef(_useBackMounts) || _useBackMounts == false) : sideAssemblies;
    upperZRodMountsExtrusionOffsetZ = printbedKinematic ? eZ - 90 : _upperZRodMountsExtrusionOffsetZ;

    if (printbedKinematic || _useDualZRods)
        faceRightUpperZRodMountsExtrusion(upperZRodMountsExtrusionOffsetZ);

    explode([0, 70, 0], true)
        faceRightMotorUpright(upperZRodMountsExtrusionOffsetZ, useElectronicsInBase);

    explode([0, -70, 0], true)
        faceRightIdlerUpright(upperZRodMountsExtrusionOffsetZ, useElectronicsInBase, printbedKinematic);

    // extra extrusion for mounting spool holder
    if (printbedKinematic) {
        bedHeight = is_undef(bedHeight) ? bedHeight() : bedHeight;
        zRails(bedHeight, left=false, useElectronicsInBase=true, spoolHeight=spoolHeight());
        supportLength = eY - _zRodOffsetY - _printbedArmSeparation/2;
        translate([eX + eSize, eY + eSize - supportLength, spoolHeight()])
            extrusionOY2040VEndBolts(supportLength);
        translate([eX + eSize, eY + eSize - supportLength, 70])
            extrusionOY2040VEndBolts(supportLength);
    } else {
        if (eZ >= 400)
            faceRightLowerExtrusion(useElectronicsInBase && !_useDualZRods);
        if (!useBackMounts)
            translate([eX + eSize, eSize, spoolHeight()])
                extrusionOY2040VEndBolts(eY);
    }
    if ($target != "DualZRods" && $target != "KinematicBed" && !useBackMounts) {
        if (useElectronicsInBase) {
            if (useBowdenExtruder())
                if (eZ >= 400)
                    explode([50, 75, 0], true)
                        rightSidePanelAssembly();
        } else {
            explode([50, 75, 0])
                IEC_Housing_assembly();
            if (useBowdenExtruder())
                explode([75, 75, 0], true)
                    accessPanelAssembly();
        }
        if (useBowdenExtruder())
            explode([50, 75, 0])
                Extruder_Bracket_assembly();
    }
}

module faceRightUpperZRodMountsExtrusion(upperZRodMountsExtrusionOffsetZ) {
    translate([eX + eSize, eSize,  upperZRodMountsExtrusionOffsetZ - eSize]) {
        extrusionOY2040VEndBolts(eY);
        if (useDualZRods())
            translate([eSize, 0, eSize])
                mirror([1, 0, 0])
                    zMountsUpper();
    }
}

module faceRightLowerExtrusion(useElectronicsInBase) {
    zMotorLength = 40;
    translate([eX + eSize, eSize, 0]) {
        if (useElectronicsInBase)
            translate_z(70)
                extrusionOY2040VEndBolts(eY);
        else
            extrusionOY2040VEndBolts(eY);
        if (useDualZRods())
            translate([eSize, 0, 0])
                mirror([1, 0, 0])
                    zMountsLower(zMotorLength = useDualZMotors() ? zMotorLength : 0, includeMotor=true);
    }
}

function frontAndBackHolePositionsZ(upperZRodMountsExtrusionOffsetZ, upperZRodMount=false) =
    concat([eSize/2, eZ - eSize/2],
        upperZRodMount ? [upperZRodMountsExtrusionOffsetZ + eSize/2, upperZRodMountsExtrusionOffsetZ - eSize/2] : []
        );

module faceRightIdlerUpright(upperZRodMountsExtrusionOffsetZ=0, useElectronicsInBase=true, printBedKinematic=false) {
    translate([eX + eSize, 0, 0])
        difference() {
            extrusionOZ(eZ);
            printbedKinematic = is_undef(printbedKinematic) ? (!is_undef(_printbedKinematic) && _printbedKinematic == true) : printbedKinematic;
            for (z = frontAndBackHolePositionsZ(upperZRodMountsExtrusionOffsetZ, printbedKinematic || _useDualZRods))
                translate([eSize/2, 0, z])
                    rotate([-90, 0, 0])
                        jointBoltHole();
            if (!printBedKinematic) {
                for (z = [spoolHeight() + eSize/2, spoolHeight() + 3*eSize/2])
                    translate([eSize/2, 0, z])
                        rotate([-90, 0, 0])
                            jointBoltHole();
                if (eZ >= 400)
                    for (z = useElectronicsInBase ? [4*eSize, 5*eSize] : [3*eSize/2])
                        translate([eSize/2, 0, z])
                            rotate([-90, 0, 0])
                                jointBoltHole();
            }
            for (z = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, eZ - eSize/2])
                translate([0, eSize/2, z])
                    rotate([0, 90, 0])
                        jointBoltHole();
            if (!is_undef(_useRB40) && _useRB40)
                translate([0, eSize/2, eZ - 3*eSize/2])
                    rotate([0, 90, 0])
                        jointBoltHole();
        }
}

module faceRightMotorUpright(upperZRodMountsExtrusionOffsetZ, useElectronicsInBase) {
    translate([eX + eSize, eY + eSize, 0])
        difference() {
            extrusionOZ(eZ);
            printbedKinematic = is_undef(printbedKinematic) ? (!is_undef(_printbedKinematic) && _printbedKinematic == true) : printbedKinematic;
            for (z = frontAndBackHolePositionsZ(upperZRodMountsExtrusionOffsetZ, printbedKinematic || _useDualZRods))
                translate([eSize/2, eSize, z])
                    rotate([90, 0, 0])
                        jointBoltHole();
            for (z = [spoolHeight() + eSize/2, spoolHeight() + 3*eSize/2])
                translate([eSize/2, 0, z])
                    rotate([-90, 0, 0])
                        jointBoltHole();
            if (eZ >= 400)
                for (z = useElectronicsInBase ? [4*eSize, 5*eSize] : [3*eSize/2])
                    translate([eSize/2, 0, z])
                        rotate([-90, 0, 0])
                            jointBoltHole();
            for (z = [eSize/2, 3*eSize/2, 5*eSize/2, eZ - 3*eSize/2, eZ - eSize/2])
                translate([eSize, eSize/2, z])
                    rotate([0, -90, 0])
                        jointBoltHole();
            if (use2060ForTopRear())
                translate([eSize, eSize/2, eZ - 5*eSize/2])
                    rotate([0, -90, 0])
                        jointBoltHole();
        }
}
