include <config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <printed/E20Cover.scad>
use <printed/JubileeKinematicBed.scad>
use <printed/PrintheadAssemblyE3DV6.scad>
use <printed/PrintheadAssemblyOrbiterV3.scad>
use <printed/ReverseBowdenBracket.scad>
use <printed/RightSidePanel.scad>
use <printed/BaseCover.scad>

include <utils/Z_Rods.scad>

use <vitamins/Panels.scad>

use <assemblies/BackFace.scad>
use <assemblies/BasePlate.scad>
use <assemblies/FaceLeft.scad>
use <assemblies/FaceRight.scad>
use <assemblies/FaceRightExtras.scad>
include <assemblies/FaceTop.scad>
use <assemblies/Printbed.scad>


printbedKinematic = !is_undef(_printbedKinematic) && _printbedKinematic == true;
_poseMainAssembly = [90 - 15, 0, 90 + 15];


staged_assembly = true; // set this to false for faster builds during development

module staged_assembly(name, big, ngb) {
    if (staged_assembly)
        assembly(name, big, ngb)
            children();
    else
        children();
}

//!1. Place the left face on a flat surface.
//!2. Attach the print bed to the left face by sliding the linear rods through the Z_Carriages.
//!3. Tighten the grub screws on the rod brackets, but don't yet tighten the bolts holding the brackets to the frame.
//!4. Slide the print bed to the top of the rods, and tighten the bolts in the top right rod bracket.
//!(you will have tightened the bolts on the top left bracket in a previous step).
//!5. Slide the print bed to the bottom of the rods and tighten the bolts on the bottom right rod bracket
//!(you will have tightened the bolts on the bottom left bracket in a previous step).
//!6. Thread the motor's lead screw through the lead nut on the **Z_Carriage_Center** and loosely bolt the motor to
//!the **Z_Motor_Mount**.
//!7. Ensure the **Z_Carriage_Center** is aligned with the lead screw and tighten the bolts on the **Z_Carriage_Center**
//!and the **Z_Motor_Mount**. The bolt holes on the **Z_Motor_Mount** are oval to allow some adjustment.
//!8. Route the motor wire through the lower extrusion channel and use the **E20_ChannelCover_50mm**s to hold it in place.
//
module Left_Side_with_Printbed_assembly() pose(a=[55 + 90, 90 - 20, 90])
staged_assembly("Left_Side_with_Printbed", big=true, ngb=true) {

    Left_Side_assembly(bedHeight(), printbedKinematic);

    if (!printbedKinematic) {
        zRods();
        zMotor();

/*
        coverLength = 50;
        for (y = [eSize + _zRodOffsetY + zRodSeparation()/2 + Z_Motor_MountSize().x/2 + 5, eY + eSize - coverLength - 5])
            translate([eSize + 2, y, eSize/2])
                explode([50, 0, 0])
                    rotate([0, 90, 90])
                        stl_colour(pp2_colour)
                            E20_ChannelCover_50mm_stl();
*/

        translate_z(bedHeight())
            explode([200, 0, 0])
                Printbed_assembly();
    }
}

//!1. Slide the right face into the base plate assembly.
//!2. Ensuring the frame remains square, tighten the hidden bolts and the bolts under the baseplate.
//!3. Attach the fan mounts and fans to the right face.
//!4. Connect the fans to the mainboard.
//
module Stage_1_assembly() //pose(a=_poseMainAssembly)
staged_assembly("Stage_1", big=true, ngb=true) {

    if (!is_undef(_useFrontDisplay) && _useFrontDisplay)
        Base_Plate_With_Display_assembly();
    else
        Base_Plate_assembly();

    explode([0, -50, 200], true, show_line=false) {
        Right_Side_assembly(bedHeight(), printbedKinematic);

        // add the right side Z rods if using dual Z rods
        if (useDualZRods())
            zRods(left=false);
    }
    if (!printbedKinematic)
        baseFanMountAssembly();
/*
    coverLength = 50;
    explode([-50, 0, 0])
        if (!printbedKinematic)
            for (y = [eSize + 5, eSize + eY/2 - coverLength/2, eSize + eY - coverLength - 5])
                translate([eX + eSize - 1, y, 3*eSize/2])
                    rotate([-90, -90, 0])
                        E20_RibbonCover_50mm_stl();
*/
}

//!1. Bolt together the two **Base_Cover_Left_Side_Supports** and bolt them to the base.
//!1. Thread the heated bed cables through the cable chain and secure the cable chain to the print bed.
//!2. Wrap the remaining part of the heated bed cables in cable wrap.
//!3. Slide the left face into the base plate assembly.
//!4. Ensuring the frame remains square, tighten the hidden bolts and the bolts under the baseplate.
//!5. Attach the other end of the cable chain to the rear extrusion.
//!6. Connect the heated bed cables to the mainboard.
//
module Stage_2_assembly() //pose(a=_poseMainAssembly)
staged_assembly("Stage_2", big=true, ngb=true) {

    Stage_1_assembly();

    explode([-50, 0, 250])
        Left_Side_with_Printbed_assembly();
    cable_wrap(100);
    if (eX < 400)
        explode(150)
            baseCoverLeftSideSupportsAssembly();
}

//!1. Slide the **Face_Top** assembly into the rest of the frame and tighten the hidden bolts.
//!2. Check that the print head slides freely on the Y-axis. If it doesn't, then re-rack the Y-axis,
//!see [Face_Top_Stage_2 assembly](#Face_Top_Stage_2_assembly).
//!3. Attach the back panel to the rest of the assembly.
//!4. Tighten the bolts on the back panel.
//
module Stage_3_assembly() //pose(a=_poseMainAssembly)
staged_assembly("Stage_3", big=true, ngb=true) {

    Stage_2_assembly();
    explode([0, 150, 0])
        backPanelAssembly();
    explode(150, true)
        Face_Top_assembly();
    if (printbedKinematic)
        translate_z(bedHeight())
            jubilee_build_plate(_printbedHoleOffset);
   //Partition_assembly();
}

//!1. Bolt the **Printhead_OrbiterV3_assembly** to the  X_Carriage.
//!2. Route the wiring from the print head to the mainboard and secure it with the **Wiring_Guide_Clamp**.
//!3. Adjust the belt tension.
//!4. If using a Bowden Extruder, connect the Bowden tube between the extruder and the printhead.
//
module Stage_4_assembly()
staged_assembly("Stage_4", big=true, ngb=true) {

    Stage_3_assembly();
    explode(150, true)
        if (useBowdenExtruder()) {
            explode(50, true) {
                xRailPrintheadPosition()
                    Printhead_E3DV6_assembly();
                printheadWiring(_hotendDescriptor);
            }
            if (is_undef(_useBackMounts) || _useBackMounts == false)
                explode([100, 0, 100])
                    BowdenTube(_hotendDescriptor);
        } else {
            xRailPrintheadPosition()
                Printhead_OrbiterV3_assembly();
            printheadWiring(_hotendDescriptor);
            reverseBowdenTube(_hotendDescriptor);
            Reverse_Bowden_Bracket_assembly();
        }
}

module FinalAssembly() {
    // does not use assembly(""), since made into an assembly in Main.scad
    useSidePanels = !is_undef(_useSidePanels) && _useSidePanels;
    translate([-(eX + 2*eSize)/2, - (eY + 2*eSize)/2, -eZ/2]) {
        Stage_4_assembly();
        if (is_undef(_useBackMounts) || _useBackMounts == false) {
            offsetX = useSidePanels ? sidePanelSize().z : 0;
            explode([100, 0, 80])
                stl_colour(pp2_colour)
                    faceRightSpoolHolder(offsetX);
            explode([80, 0, 0], true) {
                stl_colour(pp1_colour)
                    faceRightSpoolHolderBracket(offsetX);
                faceRightSpoolHolderBracketHardware(offsetX);
            }
            explode([200, 0, 100])
                faceRightSpool(offsetX);
        }
        if (eX < 400)
            explode([0, -400, 100], true) {
                baseCoverTopAssembly();
            }
        if (useSidePanels) {
            explode([50, 0, 0], true)
                rightSidePanelPC();
            explode([-50, 0, 0], true)
                leftSidePanelPC();
        }
    }
}
