//! Display the top face

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/printed/extruderBracket.scad>
use <../scad/printed/PrintheadAssemblies.scad>

include <../scad/printed/XY_MotorMount.scad> // for idler offsets
include <../scad/utils/CoreXYBelts.scad>

use <../scad/vitamins/Panels.scad>

use <../scad/assemblies/FaceTop.scad>
use <../scad/assemblies/BackFace.scad>
use <../scad/printed/WiringGuide.scad>
include <../scad/utils/printParameters.scad>

use <../scad/Parameters_Positions.scad>


//$explode = 1;
//$pose = 1;
module Face_Top_test() {
    echoPrintSize();
    //if(!exploded()) CoreXYBelts(carriagePosition(), show_pulleys=[1, 0, 0]);

    //let($hide_extrusions=true)
    //let($hide_rails=true)
    //let($hide_corexy=true)
    //faceTopBack();
    //printheadOrbiterV3();

    *if (!exploded())
        printheadWiring(hotendDescriptor="OrbiterV3", showCable=true);
    *wiringGuidePosition() {
        vflip() {
            Wiring_Guide_Socket_stl();
            Wiring_Guide_Socket_hardware();
        }
    }
    //X_Rail_assembly();
    //Face_Top_Stage_1_assembly();
    //Face_Top_Stage_2_assembly();
    //Face_Top_Stage_3_assembly();
    //Face_Top_Stage_4_assembly();
    //let($hide_extrusions=true)
    Face_Top_assembly();

    //Left_Side_Upper_Extrusion_assembly();
    //Right_Side_Upper_Extrusion_assembly();
    //Extruder_Bracket_assembly();
    //Partition_assembly();
}

if ($preview)
    rotate($vpr.z == 315 ? -90 + 30 : 0)
        translate([-eX/2 - eSize, -eY/2 - eSize, -eZ])
            Face_Top_test();
