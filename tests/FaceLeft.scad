//! Display the left face

include <../scad/global_defs.scad>

//use <../scad/printed/extruderBracket.scad>
//use <../scad/printed/IEC_Housing.scad>
//use <../scad/printed/JubileeKinematicBed.scad>
use <../scad/printed/PrintheadAssemblies.scad>
//include <../scad/utils/CoreXYBelts.scad>
include <../scad/utils/printParameters.scad>
include <../scad/utils/Z_Rods.scad>
use <../scad/vitamins/Panels.scad>

use <../scad/FaceLeft.scad>
//use <../scad/FaceRight.scad>
//use <../scad/FaceTop.scad>
use <../scad/Printbed.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module Left_Side_test(showPrintBed=true) {
    t = 2;
    echoPrintSize();
    printbedKinematic = !is_undef(_printbedKinematic) && _printbedKinematic == true;
    //CoreXYBelts(carriagePosition(t=t), show_pulleys=[1, 0, 0]);
    //let($hide_extrusions=true)
    //let($hide_rails=true)
    Left_Side_assembly();
    if (showPrintBed && !printbedKinematic) zRods();
    //faceTopBack(fov_distance=0);
    //printheadWiring();
    //Right_Side_assembly(); if(is_true(_useDualZRods))zRods(left=false);
    //Extruder_Bracket_assembly();
    //let($hide_extrusions=true)
    echo(bh0=bedHeight(t=3));
    echo(bh1=bedHeight(t=7)-20);
    if (showPrintBed)
        translate_z(bedHeight(t)) 
            if (printbedKinematic)
                jubilee_build_plate();
            else
                Printbed_assembly();
    zMotor();
    //let($hide_corexy=true)
    //let($hide_extrusions=true)
    //Face_Top_Stage_1_assembly();
    //printheadBeltSide(t=t);
    //printheadE3DV6(t=t);
    //printheadOrbiterV3(t=t);

    //Partition_Guide_assembly();
    // always add the panels last, so they are transparent to other items
    //Left_Side_Channel_Nuts();
    Left_Side_Channel_Spacers();
    //Left_Side_Panel_assembly();
    leftSidePanelPC(hammerNut=false);
    //partitionPC();
}

if ($preview)
    Left_Side_test();
