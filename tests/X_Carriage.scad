//! Display the X carriage

include <../scad/global_defs.scad>
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/rails.scad>

use <../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageAssemblies.scad>

use <../scad/utils/carriageTypes.scad>

include <../scad/Parameters_Main.scad>

//$explode = 1;
//$pose = 1;
module X_Carriage_test() {
    //rotate([0, -90, 0]) X_Carriage_Groovemount_MGN12H_stl();
    X_Carriage_Groovemount_MGN12H_assembly();
    //X_Carriage_Front_MGN12H_assembly();
    X_Carriage_Belt_Side_MGN12H_assembly();
    xCarriageBeltClampAssembly(MGN12H_carriage);
    //X_Carriage_Belt_Side_MGN12H_stl();
    translate_z(-carriage_height(MGN12H_carriage)) carriage(MGN12H_carriage);
    //X_Carriage_Belt_Tensioner_stl();
    //Fan_Duct_stl();
    //Belt_Tensioner_stl();
    //Belt_Clamp_stl();
    //Belt_Tidy_stl();
    //xCarriageBeltAttachmentSize(30)
    //xCarriageBeltAttachmentTest_stl();
    //vflip() xCarriageBeltClamp([xCarriageBeltAttachmentSize().x - 0.5, 25+2, 4.5], holeSeparation=18, countersunk=true);
}

if ($preview)
    X_Carriage_test();
