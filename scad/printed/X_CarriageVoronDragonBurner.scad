include <../config/global_defs.scad>

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
dragonBurnerAttachmentHoleOffset = [12.5, 0, -13.866];
dragonBurnerTopAttachmentHoleOffset = [0, 0, 10.116]; // offset from attachment holes
dragonBurnerCowlingBaseAttachmentHoleOffset = [-20.93, 0, -46.06];

module voronDragonBurnerAttachmentHoles(offsetZ=0) {
    for (x = [-dragonBurnerAttachmentHoleOffset.x, dragonBurnerAttachmentHoleOffset.x])
        translate([x, 44, offsetZ])
            children();
}

module xCarriageVoronDragonBurnerAdapter(inserts=true, rapid=false) {

    // "T" arms at top of adapter
    sizeT = [xCarriageSize.x, 9, xCarriageSize.y];

    // main block of adapter
    sizeB = [32.5, 23, sizeT.z + xCarriageVoronDragonBurnerOffsetZ];

    // extra block for rapid version
    sizeR = [26, 3.2, sizeB.z];

    // side bars
    sizeS = [5, 50, sizeT.z];
    sideBarOffsetX = 12;
    braceSizeY = 4;
    braceOffsetY = -50;

    fillet = 1.5;
    translate([0, xCarriageSize.z, 0])
        difference() {
            union() {
                translate([-sizeT.x/2, -sizeT.y, 0]) {
                    rounded_cube_xy(sizeT, fillet);
                    translate([(sizeT.x - sizeB.x)/2, 0, 0])
                        rotate(180)
                            fillet(fillet, sizeT.z);
                    translate([(sizeT.x + sizeB.x)/2, 0, 0])
                        rotate(-90)
                            fillet(fillet, sizeT.z);
                }
                translate([-sizeB.x/2, -sizeB.y, 0])
                    rounded_cube_xy(sizeB, 1);
                if (rapid)
                    translate([-sizeR.x/2, -sizeR.y/2, 0])
                        rounded_cube_xy(sizeR, 1);
                for (x = [sideBarOffsetX, -sideBarOffsetX])
                    translate([x - sizeS.x/2, -sizeS.y, 0])
                        cube(sizeS);
                translate([sideBarOffsetX - sizeS.x/2, -sizeB.y, 0])
                    rotate(180)
                        fillet(fillet, sizeT.z);
                translate([-sideBarOffsetX + sizeS.x/2, -sizeB.y, 0])
                    rotate(-90)
                        fillet(fillet, sizeT.z);
                for (x = [-1, 1])
                    hull()
                        linear_extrude(sizeT.z) {
                            translate([x*20.9, -60.06])
                                circle(4.5);
                            translate([x*xCarriageBoltSeparation.x/2, -54 + xCarriageHoleOffsetBottom()])
                                circle(4);
                            translate([x*(sizeT.x/2 - 1), -51])
                                circle(1);
                            translate([x*(xCarriageBoltSeparation.x/2 - 5), -48])
                                circle(3);
                        }
                translate([0, braceOffsetY, 0]) {
                    translate([sideBarOffsetX - sizeS.x/2, braceSizeY, 0])
                        rotate(90)
                            fillet(fillet, sizeT.z);
                    translate([-sideBarOffsetX + sizeS.x/2, braceSizeY, 0])
                        rotate(0)
                            fillet(fillet, sizeT.z);
                    translate([-sideBarOffsetX, 0, 0])
                        cube([2*sideBarOffsetX, braceSizeY, sizeT.z]);
                    *hull() {
                        translate([-xCarriageBoltSeparation.x/2 + 7, braceSizeY/2, 0])
                            cylinder(h=sizeT.z, r=braceSizeY/2);
                        translate([xCarriageBoltSeparation.x/2 - 7, braceSizeY/2, 0])
                            cylinder(h=sizeT.z, r=braceSizeY/2);
                    }
                }
            } // end union

            // trapezoidal cutout for extruder mount
            cutoutDepth = 3.5;
            translate_z(-cutoutDepth + eps)
                hull() {
                    cutoutSizeT = [15, eps, cutoutDepth];
                    cutoutSizeB = [7, eps, cutoutDepth];
                    if (rapid)
                        translate([-cutoutSizeT.x/2, sizeR.y/2 + eps, sizeB.z])
                            cube(cutoutSizeT);
                    translate([-cutoutSizeT.x/2, eps, sizeB.z])
                        cube(cutoutSizeT);
                    translate([-cutoutSizeB.x/2, -7, sizeB.z])
                        cube(cutoutSizeB);
                }
            // cutout for hotend cooling fan exhaust
            fanExaustOffsetY = rapid ? -22.5 : -34; 
            fanExaustDiameter = rapid ? 22 : 24;
            translate([0, fanExaustOffsetY, -eps])
                cylinder(d=fanExaustDiameter, h=sizeB.z + 2*eps);

            // trapezoidal cutout to avoid heat block
            hull() {
                r1Size = [2*sideBarOffsetX - sizeS.x, braceSizeY + 2*fillet + 2*eps, eps];
                translate([-r1Size.x/2, braceOffsetY - eps, sizeT.z])
                    cube(r1Size);
                r2Size = [5, r1Size.y, eps];
                translate([-r2Size.x/2, braceOffsetY - eps, sizeT.z - 5])
                    cube(r2Size);
            }

            // bolt holes for attachment to X_Carriage_Beltside
            for (x = [-xCarriageBoltSeparation.x/2, xCarriageBoltSeparation.x/2]) {
                translate([x, -54, sizeT.z]) {
                    translate([0, xCarriageHoleOffsetBottom(), 0]) {
                        vflip()
                            if (inserts)
                                insertHoleM3(sizeT.z);
                            else
                                boltHoleM3Tap(sizeT.z);
                    }
                    translate([0, xCarriageBoltSeparation.y - xCarriageHoleOffsetTop(), 0]) {
                        vflip()
                            if (inserts)
                                insertHoleM3(sizeT.z);
                            else
                                boltHoleM3Tap(sizeT.z);
                        // clearance for inserting insert during assembly
                        boltHole(2*insert_hole_radius(F1BM3) + 1, 5);
                    }
                }
            }

            // Dragon Burner attachment bolt holes
            translate([0, dragonBurnerAttachmentHoleOffset.z, 0]) {
                // top bolt hole for attachment to Dragon Burner
                translate([0.05, dragonBurnerTopAttachmentHoleOffset.z, 0])
                    //cylinder(h=20, r=2.17);
                    boltPolyholeM3Countersunk(sizeT.z + 2, sink=0.25);
                    //boltHoleM3HangingCounterbore(sizeT.z);
                // bolt holes for attachment to Dragon Burner
                for (x = [-dragonBurnerAttachmentHoleOffset.x, dragonBurnerAttachmentHoleOffset.x])
                    translate([x, 0, 0])
                        if (inserts)
                                insertHoleM3(sizeB.z);
                            else
                                boltHoleM3Tap(sizeB.z);

                // bolt holes for attachment to Cowling
                //xCarriageVoronDragonBurnerCowlingBoltHoles()
                for (x = [-dragonBurnerCowlingBaseAttachmentHoleOffset.x, dragonBurnerCowlingBaseAttachmentHoleOffset.x])
                    translate([x, dragonBurnerCowlingBaseAttachmentHoleOffset.z, 0])
                        //cylinder(h=20, r=2.8);
                        boltPolyholeM3Countersunk(sizeT.z, sink=0.25);
            }
        } // end difference
}

module xCarriageVoronDragonBurnerAdapter_inserts() {
    for (x = [0, xCarriageBoltSeparation.x])
        translate([x - xCarriageBoltSeparation.x/2, 0, xCarriageSize.y]) {
            translate([0, 4 + xCarriageHoleOffsetBottom(), 0])
                threadedInsertM3();
            translate([0, xCarriageBoltSeparation.y + 4 - xCarriageHoleOffsetTop(), 0])
                threadedInsertM3();
        }
    voronDragonBurnerAttachmentHoles()
        vflip()
            explode(50, false)
                threadedInsertM3();
}

module xCarriageVoronDragonBurnerAdapter_topBolt() {
    translate([0, 54.5, 0])
        vflip()
            boltM3Countersunk(16);
}

module xCarriageVoronDragonBurnerAdapter_cowlingBolts() {
    xCarriageVoronDragonBurnerCowlingBoltHoles()
        vflip()
            boltM3Countersunk(10);
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
    holes = [-20.9, 20.93];
    for (x = is_undef(index) ? holes : holes[index])
        translate([x, -2.05, 0])
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

module vdb_LGX_Lite_Mount_hotendBolts(zOffset=0, boltLength=12) {
    translate([0, 0, 66.9 + zOffset])
        for (x = [-21.75, 21.75])
            translate([x, 0, 2.3])
                boltM3Caphead(boltLength);
}

module vdb_LGX_Lite_Mount_hardware(zOffset=0, nut=true) {
    translate([0, 0, 66.9 + zOffset]) {
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

// z-distance from top of RevoVoron to tip of nozzle is 48.80mm, see https://e3d-online.zendesk.com/hc/en-us/articles/5927310441373-Revo-Voron-Datasheet
function revoVoronSizeZ() = 48.8;

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

module vdb_Cowl_fans(fanOffsetZ=0) {
    rotate([-90, 0, 180])
        translate([0, -34.8, -23.7]) {
            translate([-16.491, 20.63, 40])
                rotate([180, 90, 0])
                    blower(BL40x10);
            translate([16.515, 20.63, 0])
                rotate([180, -90, 0])
                    blower(BL40x10);
            translate([0, fanOffsetZ, 6])
                fan(fan30x10);
        }
}

module vdb_Cowl_inserts() {
    rotate([-90, 0, 180])
        for (x = [-20.9, 20.93])
            translate([x, -9.18, 16.3])
                insert(F1BM3);
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

