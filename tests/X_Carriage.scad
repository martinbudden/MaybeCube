//! Display the X carriage

include <../scad/config/global_defs.scad>

//use <../../BabyCube/scad/printed/X_CarriageBeltAttachment.scad>

use <../scad/printed/PrintheadAssemblies.scad>
use <../scad/printed/X_CarriageAssemblies.scad>
use <../scad/printed/X_CarriageE3DV6.scad>
use <../scad/printed/X_CarriageOrbiterV3.scad>
use <../scad/utils/X_Rail.scad>

//include <../scad/utils/carriageTypes.scad>

include <../scad/config/Parameters_Main.scad>
include <../scad/config/Parameters_Positions.scad>

//$explode = 1;
//$pose = 1;

/*module xCarriageBeltAttachmentTest_stl() {
    stl("xCarriageBeltAttachmentTest") {
        size = xCarriageBeltAttachmentSize(beltWidth(), beltSeparation(), 30);
        xCarriageBeltAttachment(size, beltWidth(), beltSeparation(), cutoutOffsetZ=0, cutoutOffsetY=0,endCube=true);
        *cube([3, size.x, size.y]);
        *translate_z(-2)
            cube([size.z, size.x + 3, 2]);
    }
}*/

module X_Carriage_test() {
    //X_Carriage_Groovemount_stl();
    xCarriageGroovemountAssembly();
    X_Carriage_Beltside_assembly();

    translate([-carriagePosition().x, -carriagePosition().y, -xRailCarriagePositionZ()]) {
        //printheadBeltSide();
        printheadBeltSideBolts();
    }
    *translate([-carriagePosition().x, -carriagePosition().y, -xRailCarriageOffsetZ()])
        xRail(carriagePosition());

    //xCarriageBeltClampAssembly(MGN12H_carriage);
    //xCarriageBeltAttachment([21,23.2,46], beltWidth(), beltSeparation(), inserts=true);
    //X_Carriage_Beltside_HC_16_stl();
    //X_Carriage_Beltside_RB_stl();
    //X_Carriage_Beltside_RB_ST_stl();
    //translate_z(-carriage_height(MGN12H_carriage)) carriage(MGN12H_carriage);
    //X_Carriage_Belt_Tensioner_stl();
    //Fan_Duct_stl();
    //X_Carriage_Belt_Tensioner_stl();
    //X_Carriage_Belt_Clamp_stl();
    //xCarriageBeltAttachmentTest_stl();
    //vflip() xCarriageBeltClamp([xCarriageBeltAttachmentSize().x - 0.5, 25+2, 4.5], holeSeparation=18, countersunk=true);
}

//X_Carriage_Groovemount_stl();
//X_Carriage_OrbiterV3_stl();
//xCarriageBeltAttachmentTest_stl();
//translate([0, 0, 5.5])// offset to belts
if ($preview)
    rotate(90)
        X_Carriage_test();
