include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>
include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/vitamins/hot_ends.scad>
include <NopSCADlib/vitamins/inserts.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

include <../utils/X_Carriage.scad>
include <../vitamins/nuts.scad>
include <../vitamins/inserts.scad>

function voronColor() = grey(25);
function voronAccentColor() = crimson;
function voronAdaptorColor() = pp3_colour;

xCarriageType = MGN12H_carriage;

module X_Carriage_Voron_Dragon_Burner_stl() {
    stl("X_Carriage_Voron_Dragon_Burner");
    color(pp3_colour)
        xCarriageVoronDragonBurner(inserts=true);
}

module X_Carriage_Voron_Dragon_Burner_ST_stl() {
    stl("X_Carriage_Voron_Dragon_Burner_ST");
    color(pp3_colour)
        xCarriageVoronDragonBurner(inserts=false);
}

xCarriageVoronDragonBurnerOffsetZ = 5; // was 4.25, increased for cable clearance


module xCarriageVoronDragonBurnerCowlingBoltHoles(index=undef) {
    holes = [-21, 21];
    for (x = is_undef(index) ? holes : holes[index])
        translate([x, -1.8, 0])
            children();
}

module xCarriageVoronDragonBurner(inserts=true) {
    size0 = [32.5, 23, xCarriageSize.y];
    topOffset = 0;
    size1 = [xCarriageSize.x, 9 + topOffset, xCarriageSize.y];
    size2 = [32.5, 23 + topOffset, size1.z + xCarriageVoronDragonBurnerOffsetZ];
    difference() {
        union() {
            /*sizeT = [8, 3, size0.z];
            translate([-sizeT.x/2, xCarriageSize.z -sizeT.y + 1, 0])
                rounded_cube_xy(sizeT, 1);*/
            translate([-size0.x/2, xCarriageSize.z -size0.y, 0])
                rounded_cube_xy(size0, 1);
            translate([-size1.x/2, xCarriageSize.z -size1.y + topOffset, 0])
                rounded_cube_xy(size1, 1);
            translate([-size2.x/2, xCarriageSize.z - size2.y + topOffset, 0])
                rounded_cube_xy(size2, 1);
            size3 = [5, 45, xCarriageSize.y];
            for (x = [12, -12])
                translate([x - size3.x/2, 9, 0])
                    cube(size3);
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(0)
                    cylinder(h=size1.z, r=4.5);
                translate([-xCarriageBoltSeparation.x/2, 4, 0])
                    cylinder(h=size1.z, r=4);
                translate([-xCarriageBoltSeparation.x/2 - 4, 7, 0])
                    cylinder(h=size1.z, r=1);
                translate([-xCarriageBoltSeparation.x/2 + 6, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(1)
                    cylinder(h=size1.z, r=4.5);
                translate([xCarriageBoltSeparation.x/2, 4, 0])
                    cylinder(h=size1.z, r=4);
                translate([xCarriageBoltSeparation.x/2 + 4, 7, 0])
                    cylinder(h=size1.z, r=1);
                translate([xCarriageBoltSeparation.x/2 - 6, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                translate([-xCarriageBoltSeparation.x/2 + 7, 10, 0])
                    cylinder(h=size1.z, r=2);
                translate([xCarriageBoltSeparation.x/2 - 7, 10, 0])
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
        for (x = [0, xCarriageBoltSeparation.x])
            translate([x + -xCarriageBoltSeparation.x/2, 4, xCarriageSize.y])
                vflip()
                    if (inserts)
                        insertHoleM3(xCarriageSize.y);
                    else
                        boltHoleM3Tap(xCarriageSize.y);
        for (x = [0, xCarriageBoltSeparation.x])
            translate([x + -xCarriageBoltSeparation.x/2, xCarriageBoltSeparation.y + 4, xCarriageSize.y]) {
                vflip()
                    if (inserts)
                        insertHoleM3(xCarriageSize.y);
                    else
                        boltHoleM3Tap(xCarriageSize.y);
                // clearance for inserting insert during assembly
                boltHole(2*insert_hole_radius(F1BM3) + 1, 5);
            }
        // bolt holes for attachment to Dragon Burner
        for (x = [-12.5, 12.5])
            translate([x, 44, size2.z])
                vflip()
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

module xCarriageVoronDragonBurner_hardware(inserts=true) {
    for (x = [0, xCarriageBoltSeparation.x])
        translate([x + -xCarriageBoltSeparation.x/2, 4, xCarriageSize.y])
            if (inserts)
                threadedInsertM3();
    for (x = [0, xCarriageBoltSeparation.x])
        translate([x + -xCarriageBoltSeparation.x/2, xCarriageBoltSeparation.y + 4, xCarriageSize.y])
            if (inserts)
                threadedInsertM3();
        for (x = [-12.5, 12.5])
            translate([x, 44, xCarriageSize.y + xCarriageVoronDragonBurnerOffsetZ])
                if (inserts)
                    threadedInsertM3();
    translate([0, 54.5, 0])
        vflip()
            boltM3Countersunk(16);
    xCarriageVoronDragonBurnerCowlingBoltHoles()
        vflip()
            boltM3Countersunk(10);
}

module X_Carriage_Voron_Rapid_Burner_stl() {
    stl("X_Carriage_Voron_Rapid_Burner");
    color(pp3_colour)
        xCarriageVoronRapidBurner(inserts=true);
}

module X_Carriage_Voron_Rapid_Burner_ST_stl() {
    stl("X_Carriage_Voron_Rapid_Burner_ST");
    color(pp3_colour)
        xCarriageVoronRapidBurner(inserts=false);
}

module xCarriageVoronRapidBurner(inserts=true) {
    size0 = [32.5, 23, xCarriageSize.y];
    topOffset = 0;
    size1 = [xCarriageSize.x, 9 + topOffset, xCarriageSize.y];
    size2 = [32.5, 23 + topOffset, size1.z + xCarriageVoronDragonBurnerOffsetZ];
    difference() {
        union() {
            /*sizeT = [8, 3, size0.z];
            translate([-sizeT.x/2, xCarriageSize.z -sizeT.y + 1, 0])
                rounded_cube_xy(sizeT, 1);*/
            translate([-size0.x/2, xCarriageSize.z -size0.y, 0])
                rounded_cube_xy(size0, 1);
            translate([-size1.x/2, xCarriageSize.z -size1.y + topOffset, 0])
                rounded_cube_xy(size1, 1);
            translate([-size2.x/2, xCarriageSize.z - size2.y + topOffset, 0])
                rounded_cube_xy(size2, 1);
            size3 = [5, 45, xCarriageSize.y];
            for (x = [12, -12])
                translate([x - size3.x/2, 9, 0])
                    cube(size3);
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(0)
                    cylinder(h=size1.z, r=4.5);
                translate([-xCarriageBoltSeparation.x/2, 4, 0])
                    cylinder(h=size1.z, r=4);
                translate([-xCarriageBoltSeparation.x/2 - 4, 7, 0])
                    cylinder(h=size1.z, r=1);
                translate([-xCarriageBoltSeparation.x/2 + 6, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(1)
                    cylinder(h=size1.z, r=4.5);
                translate([xCarriageBoltSeparation.x/2, 4, 0])
                    cylinder(h=size1.z, r=4);
                translate([xCarriageBoltSeparation.x/2 + 4, 7, 0])
                    cylinder(h=size1.z, r=1);
                translate([xCarriageBoltSeparation.x/2 - 6, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                translate([-xCarriageBoltSeparation.x/2 + 7, 10, 0])
                    cylinder(h=size1.z, r=2);
                translate([xCarriageBoltSeparation.x/2 - 7, 10, 0])
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
        translate([0, 35.5, -eps])
            cylinder(d=22, h=size2.z + 2*eps);
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
        for (x = [0, xCarriageBoltSeparation.x])
            translate([x + -xCarriageBoltSeparation.x/2, 4, xCarriageSize.y])
                vflip()
                    if (inserts)
                        insertHoleM3(xCarriageSize.y);
                    else
                        boltHoleM3Tap(xCarriageSize.y);
        for (x = [0, xCarriageBoltSeparation.x])
            translate([x + -xCarriageBoltSeparation.x/2, xCarriageBoltSeparation.y + 4, xCarriageSize.y]) {
                vflip()
                    if (inserts)
                        insertHoleM3(xCarriageSize.y);
                    else
                        boltHoleM3Tap(xCarriageSize.y);
                // clearance for inserting insert during assembly
                boltHole(2*insert_hole_radius(F1BM3) + 1, 5);
            }
        // bolt holes for attachment to Dragon Burner
        for (x = [-12.5, 12.5])
            translate([x, 44, size2.z])
                vflip()
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

module vdb_Boop_Front_Extended() {
    translate([0.25, 30.5, 25.85])
        rotate([0, 0, 0])
            import(str("../../../stlimport/VoronDragonBurner/Boop_Front_Extended.stl"), convexity=10);
}

module vdbImportStl(file) {
    import(str("../../../stlimport/Dragon_Burner/STLs/v0.2/", file, ".stl"), convexity=10);
}

module vrbImportStl(file) {
    import(str("../../../stlimport/Rapid_Burner/STLs/v0.2/", file, ".stl"), convexity=10);
}

module vdb_LGX_Lite_Mount() {
    vflip()
        translate([-35.75, -27.25, -37.5 -47])
            rotate([90, 180, 0])
                vdbImportStl("LGX_Lite_Mount");
}

module vdb_V6_Mount_Front() {
    translate([-147.5, -118, 33])
        rotate([180, 0, 0])
            vdbImportStl("V6_Mount_Front");
}

module vdb_V6_Mount_Rear() {
    translate([-147.5, 146.25, 12])
        rotate([0, 0, 0])
            vdbImportStl("V6_Mount_Rear");
}

module vdb_RevoVoron_Mount() {
    vflip()
        translate([167, -68, 14 - 47])
            rotate([0, 0, 180])
                vdbImportStl("RevoVoron_Mount");
}

module vdb_Cowl_NoProbe() {
    vitamin(str(": Voron Dragon Burner assembly"));
    vflip()
        translate([-147.75, 135.5, -47])
            vdbImportStl("Cowl_NoProbe");
}

module vdb_Cowl_NoProbe_hardware() {
    vflip()
        translate_z(-47)
            not_on_bom()
                if ($preview) {
                    translate([-147.75, 135.5, 0])
                        translate([131.5, -114.725, 40])
                            rotate([180, 90, 0])
                                blower(BL40x10);
                    translate([-147.75, 135.5, 0])
                        translate([164.25, -114.725, 0])
                            rotate([180, -90, 0])
                                blower(BL40x10);
                    translate([0, 0, 6])
                        fan(fan30x10);
                    translate([-147.75, 135.5, 3])
                        for (x = [0, 25])
                            translate([x + 135.4, -155.75, 0])
                                vflip()
                                    boltM3Caphead(40);
                    for (x = [0, 41.8])
                        translate([x - 20.75, 25.8, 40])
                            insert(F1BM3);
                    *for (x = [0, 25])
                        translate([x - 12.4, -30.7, 14])
                            insert(F1BM3);
                }
}

module vrb_DFA_Hotend_Mount() {
    translate([-147.5, -113.5, 33])
        rotate([0, 180, 180])
            color(voronColor())
                vrbImportStl("DFA_Hotend_Mount");
}

module vrb_Orbiter2_Hotend_Mount_stl() {
    stl("vrb_Orbiter2_Hotend_Mount")
        color(voronColor())
            vflip() // better orientation for printing
                vrb_Orbiter2_Hotend_Mount(inserts=true);
}

module vrb_Orbiter2_Hotend_Mount_ST_stl() {
    stl("vrb_Orbiter2_Hotend_Mount_ST")
        color(voronColor())
            vflip() // better orientation for printing
                vrb_Orbiter2_Hotend_Mount(inserts=false);
}

module vrb_Orbiter2_Hotend_Mount(inserts=true) {
    color(voronColor())
        difference() {
            union() {
                translate([166.9, 65.6, 33])
                    rotate([0, 180, 0])
                        vrbImportStl("Orbiter2_Hotend_Mount");
                for (x = [-19.2, 17.7])
                    translate([x, 27.5, 23.4])
                        rotate([90, 0, 0])
                            cylinder(r=3, h=6);
                if (!inserts)
                    for (x = [-16.2, 16.6])
                        translate([x, 23.2, 33])
                            vflip()
                                cylinder(r=3, h=7);

            }
            for (x = [-21.5, 22])
                translate([x, 27.5, 23.4])
                    rotate([90, 180, 0])
                        if (inserts)
                            insertHoleM3(0);
                        else
                            boltHoleM3Tap(10, horizontal=true, chamfer_both_ends=false);
            if (!inserts)
                for (x = [-16.2, 16.6])
                    translate([x, 23.2, 33])
                        vflip()
                            boltHoleM3Tap(10);
        }
}

module vrb_Orbiter2_Hotend_Mount_hardware(inserts=true) {
    *for (x = [-19.2, 17.7])
        translate([x, 27.4, 23.4])
            rotate([-90, 0, 0])
                insert(F1BM3);
    if (inserts) {
        for (x = [-21.5, 22])
            translate([x, 27.5, 23.4])
                rotate([-90, 0, 0])
                    insert(F1BM3);
        for (x = [-16.2, 16.6])
            translate([x, 23.2, 33])
                rotate([0, 0, 0])
                    insert(F1BM3);
    }
    for (x = [-12.3, 12.7])
        translate([x, 11.8, 17])
            rotate([0, 0, 0])
                boltM3Caphead(12);
}

module vrb_LGX_Lite_Mount_stl() {
    stl("vrb_LGX_Lite_Mount")
        color(voronColor())
            rotate([90, 0, 0])
                vrb_LGX_Lite_Mount();
}

module vrb_LGX_Lite_Mount() {
    vflip()
        translate([-35.75, -27.25, -37.5 -47])
            rotate([90, 180, 0])
                color(voronColor())
                    vrbImportStl("LGX_Lite_Extruder_Mount");
}

module vrb_LGX_Lite_Mount_hardware() {
    for (x = [-21.5, 22])
        translate([x, 34, 23.4])
            rotate([-90, 0, 0])
                boltM3Caphead(12);
    for (x = [-9.2, 9.8])
        translate([x, 31.8, 21.1])
            rotate([90, 0, 0])
                boltM3Caphead(8);
}

module vrb_Cowl_NoProbe_stl() {
    stl("vrb_Cowl_NoProbe")
        vflip() // better orientation for printing
            color(voronAccentColor())
                vrb_Cowl_NoProbe(inserts=true);
}

module vrb_Cowl_NoProbe_ST_stl() {
    stl("vrb_Cowl_NoProbe_ST")
        vflip() // better orientation for printing
            color(voronAccentColor())
                vrb_Cowl_NoProbe(inserts=false);
}

module vrb_Cowl_NoProbe(inserts=true) {
    //vitamin(str(": Voron Rapid Burner assembly"));
    vflip()
        union() {
            translate([-147.75, 135.5+4, -47])
                vrbImportStl("Cowl_NoProbe");
            if (!inserts)
                translate([0, 8.25, -47]) {
                    for (x = [0, 41.8])
                        translate([x - 20.75, 25.8, 40])
                            vflip()
                                cylinder(r=3, h=6.1);
                    for (x = [0, -30.2])
                        translate([x + 15.3, 23.4, 37])
                            vflip()
                                cylinder(r=2, h=3.6);
                }
        }
}
module vrb_Cowl_NoProbe_hardware(inserts=true) {
    vflip()
        translate([0, 8.25, -47])
            not_on_bom()
                if ($preview) {
                    translate([-147.75, 135.5, 0])
                        translate([131.5, -114.725, 40])
                            rotate([180, 90, 0])
                                blower(BL40x10);
                    translate([-147.75, 135.5, 0])
                        translate([164.25, -114.725, 0])
                            rotate([180, -90, 0])
                                blower(BL40x10);
                    translate([0, -11.5, 6])
                        fan(fan30x10);
                    for (x = [0, 32.8])
                        translate([x - 16.2, -31.4, 11])
                                vflip()
                                    boltM3Caphead(8);
                    if (inserts)
                        for (x = [0, 41.8])
                            translate([x - 20.75, 25.8, 40])
                                insert(F1BM3);
                    *for (x = [0, 25])
                        translate([x - 12.4, -30.7, 14])
                            insert(F1BM3);
                }
}



