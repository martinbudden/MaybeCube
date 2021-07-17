include <global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/PrintheadAssemblies.scad>
use <printed/Z_MotorMount.scad>

use <utils/printParameters.scad>
use <utils/CoreXYBelts.scad>
use <utils/X_Rail.scad>
use <utils/Z_Rods.scad>

use <vitamins/AntiBacklashNut.scad>
use <vitamins/extrusion.scad>
use <vitamins/PrintHeadBIQU_B1.scad>
use <vitamins/SidePanels.scad>

use <BackFace.scad>
use <BasePlate.scad>
use <FaceLeft.scad>
use <FaceRight.scad>
use <FaceRightExtras.scad>
use <FaceTop.scad>
use <PrintBed.scad>

use <Parameters_Positions.scad>
include <Parameters_Main.scad>


_poseMainAssembly = [90 - 15, 0, 90 + 15];


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

staged_assembly = true; // set this to false for faster builds during development

module staged_assembly(name, big, ngb) {
    if (staged_assembly)
        assembly(name, big, ngb)
            children();
    else
        children();
}

//!1. Face the left face on a flat surface.
//!
//!2. Attach the print bed to the left face by sliding the linear rods through the Z_Carriages.
//!
//!3. Tighten the grub screws on the rod brackets, but don't yet tighten the bolts holding the brackets to the frame.
//!
//!4. Slide the print bed to the top of the rods, and tighten the bolts in the top right rod bracket.
//!(you will have tightened the bolts on the top left bracket in a previous step).
//!
//!5. Slide the print bed to the bottom of the rods and tighten the bolts on the bottom right rod bracket
//!(you will have tightened the bolts on the bottom left bracket in a previous step).
//!
//!6. Thread the motor's lead screw through the lead nut on the **Z_Carriage_Center** and bolt the motor to
//! the **Z_Motor_Mount**.
//!
//!8. Ensure the **Z_Carriage_Center** is aligned with the lead screw and tighten the bolts on the **Z_Carriage_Center**.
//
module Stage_1_assembly() pose(a=[55 + 90, 90 - 20, 90])
staged_assembly("Stage_1", big=true, ngb=true) {

    Left_Side_assembly();
    zRods();
    zMotor();
    translate_z(bedHeight())
        explode([200, 0, 0])
            Printbed_assembly();
}

//!1. Slide the left face into the base plate assembly.
//!2. Ensuring the frame remains square, tighten the hidden bolts and the bolts under the baseplate.
//
module Stage_2_assembly() //pose(a=_poseMainAssembly)
staged_assembly("Stage_2", big=true, ngb=true) {

    explode(150)
        Stage_1_assembly();
    Base_Plate_assembly();
}

//!1. Slide the right face into the base plate assembly.
//!2. Ensuring the frame remains square, tighten the hidden bolts and the bolts under the baseplate.
//
module Stage_3_assembly() //pose(a=_poseMainAssembly)
staged_assembly("Stage_3", big=true, ngb=true) {

    Stage_2_assembly();

    explode(150, true) {
        Right_Side_assembly();
        // add the right side Z rods if using dual Z rods
        if (useDualZRods())
            zRods(left=false);
    }
}

//!1. Attach the back face to the rest of the assembly.
//!2. Tighten the bolts on the back face.
//
module Stage_4_assembly() //pose(a=_poseMainAssembly)
staged_assembly("Stage_4", big=true, ngb=true) {

    Stage_3_assembly();
    explode([0, 150, 0])
        Back_Panel_assembly();
    //Partition_assembly();
}

//!1. Slide the **Face_Top** assembly into the rest of the frame and tighten the hidden bolts.
//!2. Check that the print head slides freely on the Y-axis. If it doesn't, then re-rack the Y-axis,
//!see [Face_Top_Stage_2 assembly](#Face_Top_Stage_2_assembly).
//!3. Bolt the **Printhead_E3DV6_MGN12H_assembly** to MGN carriage.
//!3. Route the wiring from the print head to the mainboard and secure it with the **Wiring_Guide_Clamp**.
//!4. Adjust the belt tension.
//!5. Connect the Bowden tube between the extruder and the printhead.
//
module Stage_5_assembly()
staged_assembly("Stage_5", big=true, ngb=true) {

    Stage_4_assembly();
    explode(150, true) {
        Face_Top_assembly();
        explode(50, true) {
            printheadHotendSide();
            printHeadWiring();
        }
        explode([100, 0, 100])
            BowdenTube();
    }
}

module FinalAssembly() {
    // does not use assembly(""), since made into an assembly in Main.scad
    no_explode()
        Stage_5_assembly();
    stl_colour(pp1_colour)
        faceRightSpoolHolder();
    faceRightSpool();
    leftSidePanelPC();
}
