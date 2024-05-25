include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/e3d.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/vitamins/hot_ends.scad>
include <NopSCADlib/vitamins/inserts.scad>
include <NopSCADlib/vitamins/wire.scad>

use <../printed/X_CarriageAssemblies.scad>
include <../utils/X_Carriage.scad>
include <../vitamins/nuts.scad>
include <../vitamins/inserts.scad>

function voronColor() = grey(25);
function voronAccentColor() = crimson;
function voronAdaptorColor() = pp3_colour;
function voronRapidToDragonOffsetZ() = 8.5;

xCarriageVoronDragonBurnerOffsetZ = 5; // was 4.25, increased for cable clearance

module voronDragonBurnerAttachmentHoles(offsetZ=0) {
    for (x = [-12.5, 12.5])
        translate([x, 44, offsetZ])
            children();
}

module xCarriageVoronDragonBurnerAdapter(inserts=true) {
    size0 = [32.5, 23, xCarriageSize.y];
    topOffset = 0;
    size1 = [xCarriageSize.x, 9 + topOffset, xCarriageSize.y];
    size2 = [32.5, 23 + topOffset, size1.z + xCarriageVoronDragonBurnerOffsetZ];
    braceOffsetY = 10;
    fillet = 1.5;
    difference() {
        union() {
            /*sizeT = [8, 3, size0.z];
            translate([-sizeT.x/2, xCarriageSize.z -sizeT.y + 1, 0])
                rounded_cube_xy(sizeT, 1);*/

            translate([-size0.x/2, xCarriageSize.z -size0.y, 0])
                rounded_cube_xy(size0, 1);
            translate([-size1.x/2, xCarriageSize.z -size1.y + topOffset, 0]) {
                rounded_cube_xy(size1, 1);
                translate([(-size0.x + size1.x)/2, 0, 0])
                    rotate(180)
                        fillet(fillet, size0.z);
                translate([(size0.x + size1.x)/2, 0, 0])
                    rotate(-90)
                        fillet(fillet, size0.z);
            }
            translate([-size2.x/2, xCarriageSize.z - size2.y + topOffset, 0])
                rounded_cube_xy(size2, 1);
            size3 = [5, 45, xCarriageSize.y];
            for (x = [12, -12])
                translate([x - size3.x/2, 9, 0])
                    cube(size3);
            translate([12 - size3.x/2, 0, 0]) {
                translate([0, xCarriageSize.z - size0.y, 0])
                    rotate(180)
                        fillet(fillet, size3.z);
                translate([0, braceOffsetY + 2, 0])
                    rotate(90)
                        fillet(fillet, size3.z);
            }
            translate([-12 + size3.x/2, 0, 0]) {
                translate([0, xCarriageSize.z - size0.y, 0])
                    rotate(-90)
                        fillet(fillet, size3.z);
                translate([0, braceOffsetY + 2, 0])
                    rotate(0)
                        fillet(fillet, size3.z);
            }
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(0)
                    cylinder(h=size1.z, r=4.5);
                translate([-xCarriageBoltSeparation.x/2, 4 + xCarriageHoleOffsetBottom(), 0])
                    cylinder(h=size1.z, r=4);
                translate([-xCarriageSize.x/2 + 1, 7, 0])
                    cylinder(h=size1.z, r=1);
                translate([-xCarriageBoltSeparation.x/2 + 5, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(1)
                    cylinder(h=size1.z, r=4.5);
                translate([xCarriageBoltSeparation.x/2, 4 + xCarriageHoleOffsetBottom(), 0])
                    cylinder(h=size1.z, r=4);
                translate([xCarriageSize.x/2 - 1, 7, 0])
                    cylinder(h=size1.z, r=1);
                translate([xCarriageBoltSeparation.x/2 - 5, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                translate([-xCarriageBoltSeparation.x/2 + 7, braceOffsetY, 0])
                    cylinder(h=size1.z, r=2);
                translate([xCarriageBoltSeparation.x/2 - 7, braceOffsetY, 0])
                    cylinder(h=size1.z, r=2);
            }
        }
        // cutout for extruder mount
        hull() {
            cutoutSize1 = [15, eps, 3];
            cutoutSize2 = [7, eps, cutoutSize1.z];
            translate([-cutoutSize1.x/2, 58 + topOffset + eps, size2.z - cutoutSize1.z + eps])
                cube(cutoutSize1);
            translate([-cutoutSize1.x/2, 58 + eps, size2.z - cutoutSize1.z + eps])
                cube(cutoutSize1);
            translate([-cutoutSize2.x/2, 51, size2.z - cutoutSize2.z + eps])
                cube(cutoutSize2);
        }
        // cutout for hotend cooling fan exhaust
        translate([0, 24, -eps])
            cylinder(d=26-2, h=size2.z + 2*eps);
        // cutout to avoid heat block
        hull() {
            fillet = 1;
            r1Size = [20, 24 + fillet, eps];
            translate([-r1Size.x/2, -fillet - eps, size1.z])
                rounded_cube_xy(r1Size, fillet);
            r2Size = [5, r1Size.y, eps];
            translate([-r2Size.x/2, -fillet - eps, size1.z - 5])
                rounded_cube_xy(r2Size, fillet);
        }

        // bolt holes for attachment to X_Carriage_Beltside
        for (x = [0, xCarriageBoltSeparation.x]) {
            translate([x - xCarriageBoltSeparation.x/2, 0, xCarriageSize.y]) {
                translate([0, 4 + xCarriageHoleOffsetBottom(), 0]) {
                    vflip()
                        if (inserts)
                            insertHoleM3(xCarriageSize.y);
                        else
                            boltHoleM3Tap(xCarriageSize.y);
                }
                translate([0, xCarriageBoltSeparation.y + 4 - xCarriageHoleOffsetTop(), 0]) {
                    vflip()
                        if (inserts)
                            insertHoleM3(xCarriageSize.y);
                        else
                            boltHoleM3Tap(xCarriageSize.y);
                    // clearance for inserting insert during assembly
                    boltHole(2*insert_hole_radius(F1BM3) + 1, 5);
                }
            }
        }
        // bolt holes for attachment to Dragon Burner
        voronDragonBurnerAttachmentHoles(0)
            if (inserts)
                insertHoleM3(size2.z);
            else
                boltHoleM3Tap(size2.z);
        translate([0, 54.5, 0])
            boltPolyholeM3Countersunk(size1.z+2, sink=0.25);
            //boltHoleM3HangingCounterbore(size1.z);
        // bolt holes for attachment to Cowling
        xCarriageVoronDragonBurnerCowlingBoltHoles()
            boltPolyholeM3Countersunk(size1.z, sink=0.25);
    }
}

module xCarriageVoronDragonBurnerAdapter_hardware(inserts=true, bolts=true) {
    for (x = [0, xCarriageBoltSeparation.x])
        translate([x - xCarriageBoltSeparation.x/2, 0, xCarriageSize.y])
            if (inserts) {
                translate([0, 4 + xCarriageHoleOffsetBottom(), 0])
                    threadedInsertM3();
                translate([0, xCarriageBoltSeparation.y + 4 - xCarriageHoleOffsetTop(), 0])
                    threadedInsertM3();
            }
    voronDragonBurnerAttachmentHoles()
        if (inserts)
            explode(-20, true)
                vflip()
                    threadedInsertM3();
    if (bolts) {
        translate([0, 54.5, 0])
            vflip()
                boltM3Countersunk(16);
        xCarriageVoronDragonBurnerCowlingBoltHoles()
            vflip()
                boltM3Countersunk(10);
    }
}

module Voron_Dragon_Burner_Adapter_stl() {
    stl("Voron_Dragon_Burner_Adapter");
    color(pp3_colour)
        xCarriageVoronDragonBurnerAdapter(inserts=true);
}

module Voron_Dragon_Burner_Adapter_ST_stl() {
    stl("Voron_Dragon_Burner_Adapter_ST");
    color(pp3_colour)
        xCarriageVoronDragonBurnerAdapter(inserts=false);
}

module xCarriageVoronDragonBurnerCowlingBoltHoles(index=undef) {
    holes = [-21, 21];
    for (x = is_undef(index) ? holes : holes[index])
        translate([x, -1.8, 0])
            children();
}

module bondtechImportStl(file) {
    import(str("../../../stlimport/Bondtech/", file, ".stl"), convexity=10);
}

module bondtechLGXLite() {
    translate([0, 6.2, 88.2])
        rotate([90, 0, 180]) {
            color(grey(40))
                bondtechImportStl("LGX-Lite-Extruder");
            color(grey(20))
                bondtechImportStl("LGX-Lite-Motor");
        }
}

module vdbImportStl(file) {
    import(str("../../../stlimport/Dragon_Burner/STLs/v0.2/", file, ".stl"), convexity=10);
}

module revoImportStl(file) {
    import(str("../../../stlimport/E3D/", file, ".stl"), convexity=10);
}

module vdb_LGX_Lite_Mount_stl() {
   stl("vdb_LGX_Lite_Mount");
    color(voronColor())
        vdb_LGX_Lite_Mount();
}

module vdb_LGX_Lite_Mount() {
    translate([35.96, 61.15, 62.1965])
        rotate([0, 0, 0])
            vdbImportStl("LGX_Lite_Mount");
}

module vdb_LGX_Lite_Mount_hardware(zOffset=0, boltLength=12, nut=true) {
    translate([0, 0, 66.9 + zOffset]) {
        for (x = [-21.75, 21.75])
            translate([x, 0, 2.3])
                boltM3Caphead(boltLength);
        for (x = [-9.5, 9.5])
            translate([x, -2.2, 0])
                vflip()
                    boltM3Caphead(8);
    }
    if (nut)
        translate([0, -8.5, 65.1])
            rotate([-90, 30, 0])
                nutM3();

}

module revoVoron() {
    color(grey(40))
        intersection() {
            size = [30, 30, 50];
            rotate(45)
                translate([-size.x/2, -size.y/2, 0])
                    cube(size);
            translate([0, 0, 22.8])
                rotate([90, 0, -90])
                    revoImportStl("RevoVoron");
        }
}

module vdb_RevoVoron_Mount() {
    translate([-166.75, 9.715, 102.91])
        rotate([90, 0, 0])
            vdbImportStl("RevoVoron_Mount");
}

module vdb_RevoVoron_Mount_stl() {
    stl("vdb_RevoVoron_Mount");
    rotate([-90, 0, 0]) // better orientation for printing
        color(voronColor())
            vdb_RevoVoron_Mount();
}

module vdb_RevoVoron_Mount_hardware() {
    for (x = [-21.75, 21.75])
        translate([x, 0, 54.15])
            vflip()
                insert(F1BM3);
    for (x = [-5, 5], y = [-4.5, 4.5])
        translate([x, y, 52.3])
            boltM2p5Caphead(8);
}

module vdb_V6_Mount_Front() {
    translate([147.8, 9.71, -82.93])
        rotate([-90, 0, 180])
            vdbImportStl("V6_Mount_Front");
}

module vdb_V6_Mount_Front_stl() {
    stl("vdb_V6_Mount_Front");
    rotate([-90, 0, 0]) // better orientation for printing
        color(voronColor())
            vdb_V6_Mount_Front();
}

module vdb_V6_Mount_Rear() {
    translate([147.8, -11.3, 181.25])
        rotate([90, 0, 180])
            vdbImportStl("V6_Mount_Rear");
}

module vdb_V6_Mount_Rear_stl() {
    stl("vdb_V6_Mount_Rear");
    rotate([90, 0, 0]) // better orientation for printing
        color(voronColor())
            vdb_V6_Mount_Rear();
}

module vdbE3DV6() {
    translate([0, 0, 57.81])
        rotate([0, 0, 0])
            e3d_hot_end(E3Dv6, filament=1.75, naked=true, bowden=false);
}

module vdb_Cowl_NoProbe_stl() {
    stl("vdb_Cowl_NoProbe");
    rotate([-90, 0, 0]) // better orientation for printing
        color(voronAccentColor())
            vdb_Cowl_NoProbe();
}

module vdb_Cowl_NoProbe() {
    translate([147.905, 23.7, -100.55])
        rotate([-90, 0, 180])
            vdbImportStl("Cowl_NoProbe");
}

module vdb_Cowl_Common_hardware(fanOffsetZ=0, inserts=true) {
    translate([-16.25, 20.775, 40])
        rotate([180, 90, 0])
            blower(BL40x10);
    translate([16.5, 20.775, 0])
        rotate([180, -90, 0])
            blower(BL40x10);
    translate([0, fanOffsetZ, 6])
        fan(fan30x10);
    if (inserts)
        for (x = [0, 41.8])
            translate([x - 20.75, 25.8, 40])
                insert(F1BM3);
}

module vdb_Cowl_NoProbe_hardware(inserts=true) {
    rotate([-90, 0, 180])
        translate([-0.1, -35, -23.7])
            vdb_Cowl_Common_hardware(fanOffsetZ=0, inserts=inserts);
}

module vdb_Cowl_NoProbe_Attachment_Bolts() {
    rotate([-90, 0, 180])
        for (x = [0, 25])
            translate([x - 12.25, 6, -54.5])
                vflip()
                    boltM3Caphead(40);
}

module vdb_Boop_Front_Extended() {
    translate([0.25, 30.5, 25.85])
        rotate([0, 0, 0])
            import(str("../../../stlimport/VoronDragonBurner/Boop_Front_Extended.stl"), convexity=10);
}

module vdb_MGN12H_X_Carriage_Lite() {
    difference() {
        vflip()
            translate([0.1, -45, -12])
                import(str("../../../stlimport/VoronDragonBurner/MGN12H_X_Carriage_Lite.stl"), convexity=10);
        hull() {
            cutoutSize1 = [15, eps, 4];
            cutoutSize2 = [7, eps, 4];
            offset = [0, 34, 13];
            translate(offset) {
                translate([-cutoutSize1.x/2, 10*eps, -cutoutSize1.z + eps])
                    cube(cutoutSize1);
                translate([-cutoutSize2.x/2, -7, -cutoutSize2.z + eps])
                    cube(cutoutSize2);
            }
        }
    }
}

module vdb_Carriage_Base_Short() {
    vflip()
    translate([0.1,  -9.1, -7])
        rotate([0, 0, 0])
            import(str("../../../stlimport/VoronDragonBurner/Carriage_Base_Short.stl"), convexity=10);
}

module dragonBurnerMountTemplate() {
    intersection() {
        union() {
            vdb_MGN12H_X_Carriage_Lite();
            vdb_Carriage_Base_Short();
        }
        union() {
            size1 = [55, 35, 15];
            translate([-size1.x/2, -size1.y-5, 0])
                cube(size1);
            size2 = [33, 45, 15];
            translate([-size2.x/2, -10, 0])
                cube(size2);
        }
    }
}

module dragonBurnerMount() {
    size1 = [32.4, 23.6, 12];
    *translate([-size1.x/2, 10.51, 0])
        cube(size1);
    size2 = [10, 10, 10];
}

