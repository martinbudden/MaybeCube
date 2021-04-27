include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

include <Parameters_Main.scad>
include <Parameters_Positions.scad>

use <utils/printParameters.scad>
use <utils/xyBelts.scad>
use <utils/X_Rail.scad>
use <utils/Z_Rods.scad>

use <printed/X_CarriageAssemblies.scad>
use <printed/Z_MotorMount.scad>

use <vitamins/PrintHeadBIQU_B1.scad>
use <vitamins/AntiBacklashNut.scad>
use <vitamins/extrusion.scad>

use <BackFace.scad>
use <BasePlate.scad>
use <FaceLeft.scad>
use <FaceRight.scad>
use <FaceRightExtras.scad>
use <FaceTop.scad>
use <PrintBed.scad>

include <vitamins/SidePanels.scad>

_poseMainAssembly = [90-15, 0, 90+15];


if (_useAsserts) {
    assert(extrusion_width >= 1.1*nozzle, "extrusion_width too small for nozzle");
    assert(extrusion_width <= 1.7*nozzle, "extrusion_width too large for nozzle");
    assert(layer_height <= 0.5*extrusion_width, "layer_height too large for extrusion_width");
    assert(layer_height >= 0.25*extrusion_width, "layer_height too small for extrusion_width"); // not sure this one is correct
}

module echoParameters() {
    echo("_variant=", _variant);
    echo("nozzle", nozzle);
    echo("extrusion_width", extrusion_width, "r:[ ", 1.1*nozzle, 1.7*nozzle, " ]");
    echo("layer_height", layer_height, "r:[ ", 0.25*extrusion_width, 0.5*extrusion_width, "]");

    echo(nozzle =  nozzle, extrusion_width = extrusion_width, layer_height = layer_height, show_threads = show_threads);
}

staged_assembly = !true; // set this to false for faster builds during development

module staged_assembly(name, big, ngb) {
    if (staged_assembly)
        assembly(name, big, ngb)
            children();
    else
        children();
}

//!1. Attach the print bed to the left face by sliding the linear rods through the bearing blocks.
//!
//!2. Tighten the grub screws on the rod brackets, but don't yet tighten the bolts holding the brackets to the frame.
//!
//!3. Don't yet bolt the lead nut to the print bed.
//!
//!4. Slide the print bed to the bottom of the rods and tighten the bolts on the bottom right rod bracket
//!(you will have tightened the bolts on the bottom left bracket in a previous step).
//!
//!5. Slide the print bed to the top of the rods, and tighten the bolts in the top right rod bracket.
//!
//!6. Slide the print bed to the bottom of the rods and bolt the lead nut to the print bed.
//!
//!7. Turn the lead screw to raise the print bed to the top of the rods and tighten the bolts on the upper middle bearing.
//!Taking these steps will ensure the print bed can run freely on the rods.
//!
module Stage_1_assembly() pose(a=_poseMainAssembly)
staged_assembly("Stage_1", big=true, ngb=true) {
    Face_Left_assembly();
    zRods();
    translate_z(_bedHeight) {
        explode([300, 0, 0])
            Printbed_assembly();
    }
}

//!1. Slide the left face into the bottom plate assembly.
//!
//!
module Stage_2_assembly() pose(a=_poseMainAssembly)
staged_assembly("Stage_2", big=true, ngb=true) {
    Stage_1_assembly();
    Base_Plate_assembly();
}

//!1. Slide the right face into the rest of the assembly.
//!
//!
module Stage_3_assembly() pose(a=_poseMainAssembly)
staged_assembly("Stage_3", big=true, ngb=true) {
    Stage_2_assembly();

    explode([100, 0, 100], true) {
        Face_Right_assembly();
        // add the right side Z rods if using dual Z rods
        if (useDualZRods())
            zRods(left=false);
    }
}

//!
module Stage_4_assembly() pose(a=_poseMainAssembly)
staged_assembly("Stage_4", big=true, ngb=true) {
    Stage_3_assembly();
    Back_Panel_assembly();
}

//!1. Thread the belts as shown.
//!
//!2. Attach the belts to the x-carriage and use the adjustment bolts to ensure a good tension.
//!
module Stage_5_assembly()
staged_assembly("Stage_5", big=true, ngb=true) {
    Stage_4_assembly();
    Face_Top_assembly();

}

//!Attach the print head to the x-carriage.
//!
module Stage_6_assembly()
staged_assembly("Stage_6", big=true, ngb=true) {
    Stage_5_assembly();

    /*translate_z(eZ) {
        xRailCarriagePosition()
            not_on_reduced_bom()
                xCarriagePrintHeadOffset() {
                    explode([-20, 0, 150])
                        PrintHeadBIQU_B1();
                    PrintHeadBIQU_B1_boltPositions()
                        explode([0, 150, 70])
                            boltM3Caphead(10);
                }
    }*/
    stl_colour(pp1_colour)
        faceRightSpoolHolder();
    Right_Side_Panel_assembly();
}

module FinalAssembly() {
    // does not use assembly(""), since made into an assembly in Main.scad
    translate([-(2*eSize + eX)/2, -(2*eSize + eY)/2, basePlateHeight() - eZ/2]) {
        no_explode()
            Stage_6_assembly();
        faceRightSpool();
        backPanelAssembly();
        Left_Side_Panel_assembly();
    }
}
