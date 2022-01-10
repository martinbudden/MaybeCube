include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <printed/IEC_Housing.scad>
use <printed/extruderBracket.scad>

include <utils/FrameBolts.scad>
include <utils/Z_Rods.scad>

include <FaceRightExtras.scad>

use <Parameters_Positions.scad>

//!1. On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown.
//!2. Bolt the **IEC_Housing_assembly** to the lower extrusion and upright.
//!3. Bolt the **Extruder_Bracket_assembly** to the upper extrusion and upright.
//
module Right_Side_assembly(bedHeight=undef, printbedKinematic=undef, sideAssemblies=undef) pose(a=[55, 0, 25 - 90])
assembly("Right_Side", big=true) {

    printbedKinematic = is_undef(printbedKinematic) ? (!is_undef(_printbedKinematic) && _printbedKinematic == true) : printbedKinematic;
    bedHeight = is_undef(bedHeight) ? bedHeight() : bedHeight;
    useBackMounts = !is_undef(_useBackMounts) && _useBackMounts == true;
    sideAssemblies = is_undef(sideAssemblies) ? (is_undef(_useBackMounts) || _useBackMounts == false) : sideAssemblies;
    upperZRodMountsExtrusionOffsetZ = printbedKinematic ? eZ - 90 : _upperZRodMountsExtrusionOffsetZ;

    faceRightLowerExtrusion();
    if (eX >= 350 || printbedKinematic)
        faceRightUpperZRodMountsExtrusion(upperZRodMountsExtrusionOffsetZ);

    explode([0, 70, 0], true)
        faceRightMotorUpright(upperZRodMountsExtrusionOffsetZ);

    explode([0, -70, 0], true)
        faceRightIdlerUpright(upperZRodMountsExtrusionOffsetZ);

    // extra extrusion for mounting spool holder
    if (printbedKinematic) {
        zRails(bedHeight, left=false);
        supportLength = eY - _zRodOffsetY - _printbedArmSeparation/2;
        translate([eX + eSize, eY + eSize - supportLength, spoolHeight()])
            extrusionOY2040VEndBolts(supportLength);
    } else if(!useBackMounts) {
        translate([eX + eSize, eSize, spoolHeight()])
            extrusionOY2040VEndBolts(eY);
    }
    if ($target != "DualZRods" && $target != "KinematicBed" && !useBackMounts) {
        explode([50, 75, 0])
            IEC_Housing_assembly();
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

module faceRightLowerExtrusion() {
    zMotorLength = 40;
    translate([eX + eSize, eSize, 0]) {
        extrusionOY2040VEndBolts(eY);
        if (useDualZRods())
            translate([eSize, 0, 0])
                mirror([1, 0, 0])
                    zMountsLower(zMotorLength = useDualZMotors() ? zMotorLength : 0, includeMotor=true);
    }
}

function frontAndBackHolePositionsZ(upperZRodMountsExtrusionOffsetZ) = concat([eSize/2, 3*eSize/2, eZ - eSize/2, spoolHeight() + eSize/2, spoolHeight() - (eX == 350 ? -3*eSize/2 : eSize/2)], eX < 350 ? [] : [upperZRodMountsExtrusionOffsetZ + eSize/2, upperZRodMountsExtrusionOffsetZ - eSize/2]);

module faceRightIdlerUpright(upperZRodMountsExtrusionOffsetZ) {
    translate([eX + eSize, 0, 0])
        difference() {
            extrusionOZ(eZ);
            for (z = frontAndBackHolePositionsZ(upperZRodMountsExtrusionOffsetZ))
                translate([eSize/2, 0, z])
                    rotate([-90, 0, 0])
                        jointBoltHole();
            for (z = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, eZ - eSize/2])
                translate([eSize, eSize/2, z])
                    rotate([0, -90, 0])
                        jointBoltHole();
        }
}

module faceRightMotorUpright(upperZRodMountsExtrusionOffsetZ) {
    translate([eX + eSize, eY + eSize, 0])
        difference() {
            extrusionOZ(eZ);
            for (z = frontAndBackHolePositionsZ(upperZRodMountsExtrusionOffsetZ))
                translate([eSize/2, eSize, z])
                    rotate([90, 0, 0])
                        jointBoltHole();
            for (z = [eSize/2, 3*eSize/2, eZ - 3*eSize/2, eZ - eSize/2])
                translate([eSize, eSize/2, z])
                    rotate([0, -90, 0])
                        jointBoltHole();
        }
}
