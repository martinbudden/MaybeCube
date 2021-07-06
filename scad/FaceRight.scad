include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/extruderBracket.scad>

use <utils/FrameBolts.scad>
use <utils/Z_Rods.scad>

use <vitamins/extrusion.scad>
use <vitamins/SidePanels.scad>

use <FaceRightExtras.scad>
use <Parameters_CoreXY.scad>
use <Parameters_Positions.scad>
include <Parameters_Main.scad>


//!On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown.
//
module Right_Side_assembly() pose(a=[55, 0, 25 - 90])
assembly("Right_Side", big=true) {

    // extra extrusion for mounting spool holder
    translate([eX + eSize, eSize, spoolHeight() - (eX == 350 ? 0 : eSize)])
        extrusionOY2040VEndBolts(eY);

    faceRightLowerExtrusion();
    if (eX >= 350)
        faceRightUpperZRodMountsExtrusion();

    explode([0, 70, 0], true)
        faceRightMotorUpright();

    explode([0, -70, 0], true)
        faceRightIdlerUpright();
    faceRightExtras();
    //Right_Side_Panel_assembly();
}

module faceRightUpperZRodMountsExtrusion() {
    translate([eX + eSize, eSize, _upperZRodMountsExtrusionOffsetZ]) {
        translate_z(-eSize)
            extrusionOY2040VEndBolts(eY);
        if (useDualZRods())
            translate([eSize, 0, 0])
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
                    zMountsLower(zMotorLength = useDualZMotors() ? zMotorLength : 0);
    }
}

frontAndBackHolePositionsZ = concat([eSize/2, 3*eSize/2, eZ - eSize/2, spoolHeight() + eSize/2, spoolHeight() - (eX == 350 ? -3*eSize/2 : eSize/2)], eX < 350 ? [] : [_upperZRodMountsExtrusionOffsetZ + eSize/2, _upperZRodMountsExtrusionOffsetZ - eSize/2]);

module faceRightIdlerUpright() {
    translate([eX + eSize, 0, 0])
        color(frameColor())
            render(convexity=2)
                difference() {
                    extrusionOZ(eZ, eSize);
                    for (z = frontAndBackHolePositionsZ)
                        translate([eSize/2, 0, z])
                            rotate([-90, 0, 0])
                                jointBoltHole();
                    for (z = [eSize/2, 3*eSize/2, 5*eSize/2, 7*eSize/2, eZ - eSize/2])
                        translate([eSize, eSize/2, z])
                            rotate([0, -90, 0])
                                jointBoltHole();
                }
}

module faceRightMotorUpright() {
    translate([eX + eSize, eY + eSize, 0])
        color(frameColor())
            render(convexity=2)
                difference() {
                    extrusionOZ(eZ, eSize);
                    for (z = frontAndBackHolePositionsZ)
                        translate([eSize/2, eSize, z])
                            rotate([90, 0, 0])
                                jointBoltHole();
                    for (z = [eSize/2, 3*eSize/2, eZ - 3*eSize/2, eZ - eSize/2])
                        translate([eSize, eSize/2, z])
                            rotate([0, -90, 0])
                                jointBoltHole();
                }
}
