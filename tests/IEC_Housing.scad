//! Display the IEC housing

include <NopSCADlib/utils/core/core.scad>
include <../scad/vitamins/BTT_Relay.scad>
include <../scad/vitamins/BTT_MANTA_5MP.scad>
include <../scad/vitamins/BTT_MANTA_8MP.scad>
use <../scad/printed/IEC_Housing.scad>
use <../scad/vitamins/Panels.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose = 1;
module IEC_Housing_test() {
    //IEC_Housing_stl();
    //iecHousingStl();
    //IEC_Housing_Bevelled_stl();
    //IEC_Housing_Mount_stl();
    translate([-eX - 2*eSize, -eY - 2*eSize, 0])
        IEC_Housing_assembly();
    //pcb(BTT_RELAY_V1_2);
    //btt_relay_v1_2_pcb();
    //BTT_Relay_Base_stl();
    //pcb(BTT_MANTA_5MP_V1_0);
    //BTT_MANTA_5MP_V1_Base_stl();
    //BTT_MANTA_8MP_V2_Base_stl();
    //Partition_assembly();
    //Partition_Guide_stl();
    //Partition_Guide_assembly();
}

if ($preview)
    IEC_Housing_test();
