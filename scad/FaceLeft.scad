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


//!1. On a flat surface, bolt the top, middle and lower extrusions into the left and right uprights as shown. Note
//!that the lower extrusion is 2020 extrusion, this is to allow access to the power supply and mainboard.
//!
//!2. Take time to ensure everything is square and then work your way around the bolts tightening them while ensuring
//!the frame remains square. Don't tighten each bolt fully before moving on to the next, rather tighten each bolt a bit
//!and move on to the next bolt, making several circuits of the frame to get all the bolts tight.
//!
//!3. Once the frame is square and tightened, align the motor mount and idler with the top extrusion and tighten them in place.
//!
module Face_Left_assembly() pose(a=[55, 0, 25 + 90])
assembly("Face_Left", big=true) {
    faceLeftMiddleExtrusion();
    faceLeftLowerExtrusion();

    explode([0, 70, 0], true)
        faceLeftMotorUpright();
    explode([0, -70, 0], true)
        faceLeftIdlerUpright();
}

module faceLeftMiddleExtrusion() {
    translate([0, eSize, middleExtrusionOffsetZ()]) {
        translate_z(-eSize)
            extrusionOY2040VEndBolts(eY);
        zMountsUpper();
    }
}

module faceLeftLowerExtrusion() {
    translate([0, eSize, 0]) {
        extrusionOY2040VEndBolts(eY);
        zMountsLower();
    }
}


module faceLeftIdlerUpright() {
    color(frameColor())
        render(convexity=2)
            difference() {
                extrusionOZ(eZ, eSize);
                for (z = [eSize/2, 3*eSize/2, eZ-eSize/2, middleExtrusionOffsetZ() + eSize/2, middleExtrusionOffsetZ() - eSize/2])
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
        color(frameColor())
            render(convexity=2)
                difference() {
                    extrusionOZ(eZ, eSize);
                    for (z = [eSize/2, 3*eSize/2, eZ - eSize/2, middleExtrusionOffsetZ() + eSize/2, middleExtrusionOffsetZ() - eSize/2])
                        translate([eSize/2, eSize, z])
                            rotate([90, 0, 0])
                                jointBoltHole();
                    for (z = [eSize/2, 3*eSize/2, eZ - 3*eSize/2, eZ - eSize/2])
                        translate([0, eSize/2, z])
                            rotate([0, 90, 0])
                                jointBoltHole();
                    }
}
