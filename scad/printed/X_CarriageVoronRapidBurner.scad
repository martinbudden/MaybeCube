include <X_CarriageVoronDragonBurner.scad>

xCarriageVoronRapidBurnerOffsetZ = xCarriageVoronDragonBurnerOffsetZ;

module xCarriageVoronRapidBurnerAdapter(inserts=true) {
    size0 = [32.5, 23, xCarriageSize.y];
    topOffset = 0;
    size1 = [xCarriageSize.x, 9 + topOffset, xCarriageSize.y];
    size2 = [32.5, 23 + topOffset, size1.z + xCarriageVoronRapidBurnerOffsetZ];
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
                translate([0, braceOffsetY + 2, 0])
                    rotate(90)
                        fillet(fillet, size3.z);
            }
            translate([-12 + size3.x/2, 0, 0]) {
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
                translate([-xCarriageBoltSeparation.x/2 + 6, 10, 0])
                    cylinder(h=size1.z, r=3);
            }
            hull() {
                xCarriageVoronDragonBurnerCowlingBoltHoles(1)
                    cylinder(h=size1.z, r=4.5);
                translate([xCarriageBoltSeparation.x/2, 4 + xCarriageHoleOffsetBottom(), 0])
                    cylinder(h=size1.z, r=4);
                translate([xCarriageSize.x/2 - 1, 7, 0])
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

module xCarriageVoronRapidBurnerAdapter_hardware(inserts=true, bolts=true) {
    for (x = [0, xCarriageBoltSeparation.x])
        translate([x + -xCarriageBoltSeparation.x/2, 0, xCarriageSize.y])
            if (inserts) {
                translate([0, 4 + xCarriageHoleOffsetBottom(), 0])
                    threadedInsertM3();
                translate([0, xCarriageBoltSeparation.y + 4 - xCarriageHoleOffsetTop(), 0])
                    threadedInsertM3();
            }
    for (x = [-12.5, 12.5])
        translate([x, 44, xCarriageSize.y + xCarriageVoronRapidBurnerOffsetZ])
            if (inserts)
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

module X_Carriage_Voron_Rapid_Burner_stl() {
    stl("X_Carriage_Voron_Rapid_Burner");
    color(pp3_colour)
        xCarriageVoronRapidBurnerAdapter(inserts=true);
}

module X_Carriage_Voron_Rapid_Burner_ST_stl() {
    stl("X_Carriage_Voron_Rapid_Burner_ST");
    color(pp3_colour)
        xCarriageVoronRapidBurnerAdapter(inserts=false);
}

module vrbImportStl(file) {
    import(str("../../../stlimport/Rapid_Burner/STLs/v0.2/", file, ".stl"), convexity=10);
}

module phaetusImportStl(file) {
    import(str("../../../stlimport/Phaetus/", file, ".stl"), convexity=10);
}

module phaetusRapido() {
    brassColor = "#B5A642";
    translate([5.0, -21.5, 52.5])
        rotate([0, 0, 0]) {
            color("#1966FF")
                phaetusImportStl("Phaetus-Heatsink");
            color(grey(20))
                phaetusImportStl("Phaetus-Heater-Sock");
            color(brassColor)
                phaetusImportStl("Phaetus-Nozzle");
        }
}

module vrb_DFA_Hotend_Mount() {
    translate([-147.5, -113.5, 33])
        rotate([0, 180, 180])
            color(voronColor())
                vrbImportStl("DFA_Hotend_Mount");
}

module vrb_LGX_Lite_Hotend_Mount_stl() {
    stl("vrb_LGX_Lite_Hotend_Mount")
        color(voronColor())
            rotate([-90, 0, 0]) // better orientation for printing
                vrb_LGX_Lite_Hotend_Mount(inserts=true);
}

module vrb_LGX_Lite_Hotend_Mount_ST_stl() {
    stl("vrb_LGX_Lite_Hotend_Mount_ST")
        color(voronColor())
            rotate([-90, 0, 0]) // better orientation for printing
                vrb_LGX_Lite_Hotend_Mount(inserts=false);
}

module vrb_LGX_Lite_Hotend_Mount(inserts=true) {
    difference() {
        union() {
            translate([-166.7, 9.62, 108.85])
                rotate([90, 0, 0])
                    vrbImportStl("Orbiter2_Hotend_Mount");
            // block in the old top holes
            for (x = [-17.5, 19.5])
                translate([x, 0, 70.72])
                    vflip()
                        cylinder(r=2.9, h=6);
        }
        // create some new holes with LGX_Lite spacing
        for (x = [-21.5, 22])
            translate([x, 0, 70.72])
                vflip()
                    if (inserts)
                        insertHoleM3(0);
                    else
                        boltHoleM3Tap(10, horizontal=true, chamfer_both_ends=false);
    }
}

module vrb_LGX_Lite_Hotend_Mount_hardware(inserts=true) {
    for (x = [-12.5, 12.5])
        translate([x, -7, 55.1])
            rotate([-90, 0, 0])
                boltM3Caphead(12);
    translate([0, -8.5, 65.1])
        rotate([-90, 30, 0])
            nutM3();
    for (x = [-21.5, 21.5])
        translate([x, -9, 65])
            rotate([90, 90, 0])
                cable_tie(cable_r=2, thickness=0.5);

    if (inserts) {
        for (x = [-21.5, 22])
            translate([x, 0, 70.72])
                insert(F1BM3);

        for (x = [16.4, -16.4])
            translate([x, 9.8, 66.4])
                rotate([-90, 0, 0])
                    insert(F1BM3);
    }
}

module vrb_LGX_Lite_Mount_stl() {
    stl("vrb_LGX_Lite_Mount")
        color(voronColor())
            vrb_LGX_Lite_Mount();
}

module vrb_LGX_Lite_Mount() {
    translate([36, 61.1, 70.75])
        vrbImportStl("LGX_Lite_Extruder_Mount");
}

module vrb_LGX_Lite_Mount_hardware() {
    vdb_LGX_Lite_Mount_hardware(zOffset=8.5, nut=false);
}

module vrb_Cowl_NoProbe_stl() {
    stl("vrb_Cowl_NoProbe")
        rotate([-90, 0, 0]) // better orientation for printing
            color(voronAccentColor())
                vrb_Cowl_NoProbe();
}

module vrb_Cowl_NoProbe() {
    translate([147.9, 23.6, -96.2])
        rotate([-90, 0, 180])
            vrbImportStl("Cowl_NoProbe");
}

module vrb_Cowl_NoProbe_hardware(inserts=true) {
    translate([0, 23.6, 35.3])
        rotate([90, 180, 0]) {
            vdb_Cowl_Common_hardware(fanOffsetZ=-11.5, inserts=inserts);
            for (x = [0, 32.8])
                translate([x - 16.2, -31.4, 11])
                    vflip()
                        boltM3Caphead(8);
        }
}

