//! Display the OrbiterV3 print head

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/PrintheadAssemblyOrbiterV3.scad>
use <../scad/printed/X_CarriageAssemblies.scad>
use <../scad/printed/X_CarriageOrbiterV3.scad>
use <../scad/vitamins/OrbiterV3.scad>
use <../scad/assemblies/FaceTop.scad>


//$explode = 1;
//$pose = 1;

module PrintheadOrbiterV3_test(wiring=false) {
    if (wiring) {
        printheadWiring(hotendDescriptor="OrbiterV3", showCable=true);
        reverseBowdenTube(hotendDescriptor="OrbiterV3");
        xRailPrintheadPosition()
            Printhead_OrbiterV3_assembly();
    } else {
        //X_Carriage_OrbiterV3_stl();
        //printheadOrbiterV3Assembly();
        X_Carriage_Beltside_assembly();
        Printhead_OrbiterV3_assembly();
        //smartOrbiterV3();
    }
}


//translate_z(orbiterV3NozzleOffsetFromMGNCarriageZ())
//let($hide_bolts=true)
if ($preview)
    PrintheadOrbiterV3_test();
