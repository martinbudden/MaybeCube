//! Display the E3DV6 print head

use <../scad/assemblies/FaceTop.scad>
use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/PrintheadAssemblyE3DV6.scad>

//$explode = 1;
//$pose = 1;

module PrintheadE3DV6_test(wiring=false) {
    if (wiring) {
        printheadWiring(hotendDescriptor="E3DV6", showCable=true);
        BowdenTube(hotendDescriptor="E3DV6");
        xRailPrintheadPosition()
            Printhead_E3DV6_assembly();
    } else {
        //printheadE3DV6Assembly();
        Printhead_E3DV6_assembly();
    }
}

if ($preview)
    PrintheadE3DV6_test();
