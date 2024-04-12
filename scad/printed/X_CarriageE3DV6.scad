include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>
include <../utils/X_Carriage.scad>


use <../../../BabyCube/scad/printed/Printhead.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
include <../../../BabyCube/scad/printed/X_CarriageFanDuct.scad>

include <../Parameters_CoreXY.scad>
include <../Parameters_Main.scad>

function hotendOffset(xCarriageType, hotendDescriptor="E3DV6") = printheadHotendOffset(hotendDescriptor) + [-xCarriageHotendSideSizeM(xCarriageType, 0, 0).x/2, xCarriageHotendOffsetY(xCarriageType), 0];
function grooveMountSize(blowerType, hotendDescriptor="E3DV6") = [printheadHotendOffset(hotendDescriptor).x, blower_size(blowerType).x + 6.25, 12];
function blowerType() = is_undef(_blowerDescriptor) || _blowerDescriptor == "BL30x10" ? BL30x10 : BL40x10;


module xCarriageGroovemount(xCarriageType, blowerType, hotendDescriptor, halfCarriage, inserts) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    grooveMountSize = grooveMountSize(blowerType, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    rotate([0, 90, -90]) {
        difference() {
            union() {
                xCarriageBack(xCarriageType, size, 0, holeSeparationTop, holeSeparationBottom, halfCarriage=halfCarriage, reflected=true, strainRelief=true, countersunk=_xCarriageCountersunk ? 4 : 0, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                hotEndHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0), grooveMountSize, hotendOffset, hotendDescriptor, blowerType, baffle=true, left=false);
            }
            xCarriageHotendSideHolePositions()
                if (inserts)
                    insertHoleM3(size.y, horizontal=true);
                else
                    boltHoleM3Tap(size.y, horizontal=true);
            // bolt holes for Z probe mount
            for (z = [0, -8])
                translate([size.x/2, 18, z - 26])
                    rotate([0, -90, 0])
                        boltHoleM3Tap(9);
        }
    }
}

module X_Carriage_Groovemount_HC_16_stl() {
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    halfCarriage = true;
    inserts = false;

    stl("X_Carriage_Groovemount_HC_16")
        color(pp1_colour)
            xCarriageGroovemount(xCarriageType, blowerType, hotendDescriptor, halfCarriage, inserts);
}

module X_Carriage_Groovemount_stl() {
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    halfCarriage = false;
    inserts = false;

    stl("X_Carriage_Groovemount")
        color(pp1_colour)
            xCarriageGroovemount(xCarriageType, blowerType, hotendDescriptor, halfCarriage, inserts);
}

module X_Carriage_Groovemount_I_stl() {
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    halfCarriage = false;
    inserts = true;

    stl("X_Carriage_Groovemount_I")
        color(pp1_colour)
            xCarriageGroovemount(xCarriageType, blowerType, hotendDescriptor, halfCarriage, inserts);
}

module xCarriageGroovemountAssembly(inserts=false, halfCarriage=false) {

    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    if (halfCarriage) {
        stl_colour(pp1_colour)
            rotate([0, -90, 0])
                X_Carriage_Groovemount_HC_16_stl();
    } else {
        stl_colour(pp1_colour)
            rotate([-90, 0, 90])
                if (inserts)
                    X_Carriage_Groovemount_I_stl();
                else
                    X_Carriage_Groovemount_stl();
        if (inserts)
            xCarriageHotendSideHolePositions()
                vflip()
                    threadedInsertM3();
    }

    grooveMountSize = grooveMountSize(blowerType, hotendDescriptor);

    explode([40, 0, 0], true)
        hotEndPartCoolingFan(xCarriageType, grooveMountSize, hotendOffset, blowerType, left=false);
    explode([40, 0, -10], true)
        hotEndHolderAlign(hotendOffset, left=false)
            blowerTranslate(xCarriageType, grooveMountSize, hotendOffset, blowerType)
                rotate([-90, 0, 0]) {
                    stl_colour(pp2_colour)
                        Fan_Duct_stl();
                    Fan_Duct_hardware(xCarriageType, hotendDescriptor);
                }
}

module Fan_Duct_stl() {
    stl("Fan_Duct")
        color(pp2_colour)
            translate([26, 0, 0])
                mirror([1, 0, 0])
                    fanDuct(printheadHotendOffset().x, jetOffset=-0.5, chimneySizeZ=17);
}
