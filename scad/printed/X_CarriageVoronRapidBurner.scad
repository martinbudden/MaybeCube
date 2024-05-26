include <X_CarriageVoronDragonBurner.scad>

module Voron_Rapid_Burner_Adapter_stl() {
    stl("Voron_Rapid_Burner_Adapter");
    color(pp3_colour)
        xCarriageVoronDragonBurnerAdapter(inserts=true, rapid=true);
}

module Voron_Rapid_Burner_Adapter_ST_stl() {
    stl("Voron_Rapid_Burner_Adapter_ST");
    color(pp3_colour)
        xCarriageVoronDragonBurnerAdapter(inserts=false, rapid=true);
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
            // block in the old top holes, which are in the wrong position
            for (x = [-17.5, 19.5])
                translate([x, 0, 70.72])
                    vflip()
                        cylinder(r=2.9, h=6);
            if (!inserts) {
                // block in the old inserts
                for (x = [16.4, -16.4])
                    translate([x, 9.625, 66.4])
                        rotate([90, 0, 0])
                            cylinder(r=2.9, h=6);
            }
        }
        // create some new holes with LGX_Lite spacing
        length = 16.45;
        for (x = [-21.75, 21.75])
            translate([x, 0, 70.72])
                if (inserts)
                    translate_z(-length)
                        rotate(180)
                            insertHoleM3(length, insertHoleLength=10.25, horizontal=true);
                else
                    vflip()
                        boltHoleM3Tap(length, horizontal=true, chamfer_both_ends=true);
        // create some new self tapping holes where the old inserts were
        if (!inserts)
            for (x = [16.4, -16.4])
                translate([x, 9.625, 66.4])
                    rotate([90, 0, 0])
                        boltHoleM3Tap(15);
    }
}

module vrb_LGX_Lite_Hotend_Mount_hardware(inserts=true) {
    // attachment bolts
    for (x = [-12.5, 12.5])
        translate([x, -7, 55.1])
            rotate([-90, 0, 0])
                boltM3Caphead(16);
    translate([0, -8.5, 65.1])
        rotate([-90, 30, 0])
            nutM3();

    // bolts for hotend
    for (x = [-5.75, 5.75], y = [-5.75, 5.75])
        translate([x, y, 67.8])
            boltM2p5Caphead(10);
    for (x = [-21.5, 21.5])
        translate([x, -9, 65])
            rotate([90, 90, 0])
                cable_tie(cable_r=2, thickness=0.5);

    if (inserts) {
        for (x = [-21.75, 21.75])
            translate([x, 0, 70.72-12])
                vflip()
                    insert(F1BM3);

        for (x = [16.4, -16.4])
            translate([x, 9.8, 66.4])
                rotate([-90, 0, 0])
                    insert(F1BM3);
    }
}

module vrb_LGX_Lite_Mount_stl() {
    stl("vrb_LGX_Lite_Mount");
    color(voronColor())
        vrb_LGX_Lite_Mount();
}

module vrb_LGX_Lite_Mount() {
    translate([36, 61.1, 70.75])
        vrbImportStl("LGX_Lite_Extruder_Mount");
}

module vrb_LGX_Lite_Mount_hardware() {
    vdb_LGX_Lite_Mount_hardware(zOffset=8.5, boltLength=20, nut=false);
}

module vrb_Cowl_NoProbe_stl() {
    stl("vrb_Cowl_NoProbe");
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
    vdb_Cowl_NoProbe_hardware(fanOffsetZ=-11.5, inserts=inserts);
    translate([0, 12.6, 66.4])
        rotate([90, 180, 0]) {
            for (x = [-16.4, 16.4])
                translate([x, 0, 0])
                    vflip()
                        boltM3Caphead(8);
        }
}

