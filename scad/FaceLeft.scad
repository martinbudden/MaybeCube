include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <utils/FrameBolts.scad>
use <utils/Z_Rods.scad>

use <vitamins/extrusion.scad>
use <vitamins/antiBacklashNut.scad>

use <Parameters_CoreXY.scad>
use <Parameters_Positions.scad>
include <Parameters_Main.scad>

//!1. Attach the SK brackets to the upper extrusion, use the **Z_RodMountGuide** to align the left bracket.
//!2. Tighten the bolts for the left bracket. Leave the bolts to the right bracket loosely tightened for now.
//!3. Attach the SK brackets and the **Z_Motor_Mount** to the lower extrusion, use the **Z_RodMountGuide** to
//!align the left bracket and the **Z_Motor_MountGuide** to align the motor mount. The motor itself will be added at a later
//!stage of the assembly.
//!4. Tighten the bolts for the left bracket and the **Z_Motor_Mount&. Leave the bolts to the right bracket loosely tightened for now.
//!5. On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown. Tighten the bolts
//!continuously ensuring the frame is square.
//
module Left_Side_assembly() pose(a=[55, 0, 25 + 90])
assembly("Left_Side", big=true) {

    zMotorLength = 40;
    faceLeftLowerExtrusion(zMotorLength);
    faceLeftUpperZRodMountsExtrusion();

    explode([0, 70, 0], true)
        faceLeftMotorUpright();
    explode([0, -70, 0], true)
        faceLeftIdlerUpright();
}

module faceLeftUpperZRodMountsExtrusion() {
    translate([0, eSize, _upperZRodMountsExtrusionOffsetZ]) {
        translate_z(-eSize)
            extrusionOY2040VEndBolts(eY);
        zMountsUpper();
    }
}

module faceLeftLowerExtrusion(zMotorLength) {
    translate([0, eSize, 0]) {
        extrusionOY2040VEndBolts(eY);
        zMountsLower(zMotorLength);
    }
}


module faceLeftIdlerUpright() {
    difference() {
        extrusionOZ(eZ, eSize);
        for (z = [eSize/2, 3*eSize/2, eZ-eSize/2, _upperZRodMountsExtrusionOffsetZ + eSize/2, _upperZRodMountsExtrusionOffsetZ - eSize/2])
            translate([eSize/2, 0, z])
                rotate([-90, 0, 0])
                    jointBoltHole();
        for (z = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, eZ - eSize/2])
            translate([0, eSize/2, z])
                rotate([0, 90, 0])
                    jointBoltHole();
    }
}

module faceLeftMotorUpright() {
    translate([0, eY + eSize, 0])
        difference() {
            extrusionOZ(eZ, eSize);
            for (z = [eSize/2, 3*eSize/2, eZ - eSize/2, _upperZRodMountsExtrusionOffsetZ + eSize/2, _upperZRodMountsExtrusionOffsetZ - eSize/2])
                translate([eSize/2, eSize, z])
                    rotate([90, 0, 0])
                        jointBoltHole();
            for (z = [eSize/2, 3*eSize/2, eZ - 3*eSize/2, eZ - eSize/2])
                translate([0, eSize/2, z])
                    rotate([0, 90, 0])
                        jointBoltHole();
            }
}
