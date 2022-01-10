include <global_defs.scad>

include <utils/carriageTypes.scad>
include <utils/FrameBolts.scad>
include <utils/Z_Rods.scad>

use <printed/IEC_Housing.scad>

use <Parameters_Positions.scad>


//!1. Attach the SK brackets to the upper extrusion, use the **Z_RodMountGuide** to align the left bracket.
//!2. Tighten the bolts for the left bracket. Leave the bolts to the right bracket loosely tightened for now.
//!3. Attach the SK brackets and the **Z_Motor_Mount** to the lower extrusion, use the **Z_RodMountGuide** to
//!align the left bracket and the **Z_Motor_MountGuide** to align the motor mount. The motor itself will be added at a later
//!stage of the assembly.
//!4. Tighten the bolts for the left bracket and the **Z_Motor_Mount**. Leave the bolts to the right bracket loosely tightened for now.
//!5. On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown. Tighten the bolts
//!continuously ensuring the frame is square.
//
module Left_Side_assembly(bedHeight=undef, printbedKinematic=undef) pose(a=[55, 0, 25 + 90])
assembly("Left_Side", big=true) {

    printbedKinematic = is_undef(printbedKinematic) ? (!is_undef(_printbedKinematic) && _printbedKinematic == true) : printbedKinematic;
    bedHeight = is_undef(bedHeight) ? bedHeight() : bedHeight;
    upperZRodMountsExtrusionOffsetZ = printbedKinematic ? eZ - 90 : _upperZRodMountsExtrusionOffsetZ;

    faceLeftLowerExtrusion(printbedKinematic, zMotorLength=40);
    faceLeftUpperZRodMountsExtrusion(printbedKinematic, upperZRodMountsExtrusionOffsetZ);

    explode([0, 70, 0], true)
        faceLeftMotorUpright(upperZRodMountsExtrusionOffsetZ);
    explode([0, -70, 0], true)
        faceLeftIdlerUpright(upperZRodMountsExtrusionOffsetZ);

    if (printbedKinematic)
        zRails(bedHeight, left=true);
    else if (is_undef(_useElectronicsInBase) || _useElectronicsInBase == false)
        explode([0, 10, 0], true)
            partitionGuideAssembly();
}

module faceLeftUpperZRodMountsExtrusion(printbedKinematic, upperZRodMountsExtrusionOffsetZ) {
    translate([0, eSize, upperZRodMountsExtrusionOffsetZ]) {
        translate_z(-eSize)
            extrusionOY2040VEndBolts(eY);
        if (!printbedKinematic)
            zMountsUpper();
    }
}

module faceLeftLowerExtrusion(printbedKinematic, zMotorLength) {
    translate([0, eSize, 0]) {
        extrusionOY2040VEndBolts(eY);
        if (!printbedKinematic)
            zMountsLower(zMotorLength);
    }
}


module faceLeftIdlerUpright(upperZRodMountsExtrusionOffsetZ) {
    difference() {
        extrusionOZ(eZ);
        for (z = [eSize/2, 3*eSize/2, eZ-eSize/2, upperZRodMountsExtrusionOffsetZ + eSize/2, upperZRodMountsExtrusionOffsetZ - eSize/2])
            translate([eSize/2, 0, z])
                rotate([-90, 0, 0])
                    jointBoltHole();
        for (z = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, eZ - eSize/2])
            translate([0, eSize/2, z])
                rotate([0, 90, 0])
                    jointBoltHole();
    }
}

module faceLeftMotorUpright(upperZRodMountsExtrusionOffsetZ) {
    translate([0, eY + eSize, 0])
        difference() {
            extrusionOZ(eZ);
            for (z = [eSize/2, 3*eSize/2, eZ - eSize/2, upperZRodMountsExtrusionOffsetZ + eSize/2, upperZRodMountsExtrusionOffsetZ - eSize/2])
                translate([eSize/2, eSize, z])
                    rotate([90, 0, 0])
                        jointBoltHole();
            for (z = [eSize/2, 3*eSize/2, eZ - 3*eSize/2, eZ - eSize/2])
                translate([0, eSize/2, z])
                    rotate([0, 90, 0])
                        jointBoltHole();
            }
}
