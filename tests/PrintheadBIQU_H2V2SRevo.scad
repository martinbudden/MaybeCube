//! Display the BIQU H2V2SRevo print head

include <NopSCADlib/utils/core/core.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/PrintheadAssemblyBIQU_H2V2SRevo.scad>
use <../scad/printed/X_CarriageAssemblies.scad>
use <../scad/printed/X_CarriageBIQU_H2V2SRevo.scad>
use <../scad/vitamins/BIQU_H2V2SRevo.scad>
use <../scad/vitamins/orbiterV3.scad>
use <../scad/assemblies/FaceTop.scad>

//$explode = 1;
//$pose = 1;

module PrintheadBIQU_H2V2SRevo_test(wiring=false) {
    if (wiring) {
        printheadWiring(hotendDescriptor="BIQU_H2V2SRevo", showCable=true);
        reverseBowdenTube(hotendDescriptor="BIQU_H2V2SRevo");
        xRailPrintheadPosition()
            Printhead_BIQU_H2V2SRevo_assembly();
    } else {
        //X_Carriage_BIQU_H2V2SRevo_stl();
        //xCarriageBIQU_H2V2SRevoAssembly();
        //X_Carriage_Beltside_assembly();
        Printhead_BIQU_H2V2SRevo_assembly();
        //biquH2V2SRevo();
        //smartOrbiterV3();
    }
}


//translate_z(biquH2V2SRevoNozzleOffsetFromMGNCarriageZ())
let($hide_bolts=true)
if ($preview)
    PrintheadBIQU_H2V2SRevo_test();
