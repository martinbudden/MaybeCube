include <../config/global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/blowers.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/carriageTypes.scad>
include <../utils/PrintheadOffsets.scad>
include <../utils/X_Carriage.scad>


use <../../../BabyCube/scad/printed/PrintheadE3DV6.scad>
use <../../../BabyCube/scad/printed/X_Carriage.scad>
use <../../../BabyCube/scad/printed/X_CarriageFanDuct.scad>


function hotendOffset(xCarriageType, hotendDescriptor="E3DV6") = printheadHotendOffset(hotendDescriptor) + [-xCarriageHotendSideSizeM(xCarriageType, 0, 0).x/2, xCarriageHotendOffsetY(xCarriageType), 0];
function grooveMountSize(blowerType, hotendDescriptor="E3DV6") = [printheadHotendOffset(hotendDescriptor).x, blower_size(blowerType).x + 6.25, 12];
function blowerType() = BL30x10;


module xCarriageGroovemount(xCarriageType, blowerType, inserts) {
    size = xCarriageHotendSideSizeM(xCarriageType, beltWidth(), beltSeparation());
    hotendDescriptor = "E3DV6";
    grooveMountSize = grooveMountSize(blowerType, hotendDescriptor);
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);
    holeSeparationTop = xCarriageHoleSeparationTopMGN12H();
    holeSeparationBottom = xCarriageHoleSeparationBottomMGN12H();

    rotate([0, 90, -90]) {
        difference() {
            translate([0, railCarriageGap() - 0.5, 0])
                union() {
                    xCarriageBack(xCarriageType, size, 0, holeSeparationTop, holeSeparationBottom, halfCarriage=false, reflected=true, strainRelief=true, offsetT=xCarriageHoleOffsetTop(), accelerometerOffset=accelerometerOffset());
                    E3DV6HotendHolder(xCarriageType, xCarriageHotendSideSizeM(xCarriageType, 0, 0), grooveMountSize, hotendOffset, blowerType, baffle=true, left=false);
                }
            xCarriageHotendSideHolePositions(xCarriageType)
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

module X_Carriage_Groovemount_ST_stl() {
    // self tapping version
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    inserts = false;

    stl("X_Carriage_Groovemount_ST")
        color(pp1_colour)
            xCarriageGroovemount(xCarriageType, blowerType, inserts);
}

module X_Carriage_Groovemount_stl() {
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    inserts = true;

    stl("X_Carriage_Groovemount")
        color(pp1_colour)
            xCarriageGroovemount(xCarriageType, blowerType, inserts);
}

module xCarriageGroovemountAssembly(inserts=false) {

    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    stl_colour(pp1_colour)
        rotate([-90, 0, 90])
            if (inserts)
                X_Carriage_Groovemount_stl();
            else
                X_Carriage_Groovemount_ST_stl();
    if (inserts)
        xCarriageHotendSideHolePositions(xCarriageType)
            vflip()
                threadedInsertM3();

    grooveMountSize = grooveMountSize(blowerType, hotendDescriptor);

    explode([40, 0, 0], true)
        E3DV6HotendPartCoolingFan(xCarriageType, grooveMountSize, hotendOffset, blowerType, left=false);
    explode([40, 0, -10], true)
        E3DV6HotendHolderAlign(hotendOffset, left=false)
            blowerTranslate(xCarriageType, grooveMountSize, hotendOffset, blowerType)
                rotate([-90, 0, 0]) {
                    stl_colour(pp2_colour)
                        Fan_Duct_stl();
                    Fan_Duct_hardware(blowerType);
                }
}

module Fan_Duct_stl() {
    stl("Fan_Duct")
        color(pp2_colour)
            translate([26, 0, 0])
                mirror([1, 0, 0])
                    fanDuct(blower=BL30x10, jetOffset=[1, 24, -10], chimneySizeZ=14);
                    //fanDuct(blower_type=BL30x10, printheadHotendOffsetX=printheadHotendOffset().x, jetOffset=-0.5, chimneySizeZ=17);
}
