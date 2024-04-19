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

function voronColor() = grey(25);
function voronAccentColor() = crimson;
function voronAdaptorColor() = pp3_colour;

xCarriageType = MGN12H_carriage;

module X_Carriage_Voron_Mini_Afterburner_LGX_Lite_stl() {
    stl("X_Carriage_Voron_Mini_Afterburner_LGX_Lite");
    color(pp3_colour)
        rotate(180) // align for printing
            xCarriageVoronMiniAfterburnerLGXLite();
}

xCarriageVoronMiniAfterburnerOffsetZ = 4.5; // was 4.25, increased for cable clearance

module xCarriageVoronMiniAfterburnerLGXLite() {
    size = [xCarriageSize.x, xCarriageSize.z + 5.35, xCarriageSize.y];
    size2 = [35, 20, size.z + xCarriageVoronMiniAfterburnerOffsetZ];

    difference() {
        union() {
            translate([-size.x/2, 0, 0])
                rounded_cube_xy(size, 1);
            translate([-size2.x/2, size.y - size2.y, 0])
                rounded_cube_xy(size2, 1);
        }
        // cutout for hotend cooling fan exhaust
        translate([0, 29, -eps])
            cylinder(d=26, h=size2.z + 2*eps);
        // cutout to avoid heat block
        hull() {
            fillet = 1;
            r1Size = [22, 24 + fillet, eps];
            translate([-r1Size.x/2, -fillet - eps, size.z])
                rounded_cube_xy(r1Size, fillet);
            r2Size = [5, r1Size.y, eps];
            translate([-r2Size.x/2, -fillet - eps, size.z - 5])
                rounded_cube_xy(r2Size, fillet);
        }
        // cutout at top for stepper motor
        r = 18.58;
        translate([0, 76.57, -eps])
            cylinder(r=r, h=size2.z + 2*eps);

        // bolt holes for attachment to X_Carriage_Beltside
        for (x = [0, xCarriageBoltSeparation.x], y = [0])
            translate([x + -xCarriageBoltSeparation.x/2, y + 4, 0])
                boltHoleM3Tap(xCarriageSize.y);
        for (x = [0, xCarriageBoltSeparation.x], y = [xCarriageBoltSeparation.y])
            translate([x + -xCarriageBoltSeparation.x/2, y + 4, 0])
                boltHoleM3Tap(xCarriageSize.y - 1);

        // bolt holes for attachment to Voron Mini Afterburner
        translate([6.27, 51.33, size2.z]) {
            *translate_z(size2.z - 5)
                boltHole(2*insert_hole_radius(F1BM3), 5);
            vflip()
                boltHoleM3Tap(size2.z - 1);
        }
        for (x = [-13, 13])
            translate([x, 48.05, size2.z]) {
                *translate_z(-5)
                    boltHole(2*insert_hole_radius(F1BM3), 5);
                vflip()
                    boltHoleM3Tap(size2.z - 1);
            }
        for (x = [-11.65, 11.65])
            translate([x, 57.95, size2.z])
                vflip()
                    boltHoleM2Tap(size2.z - 0.5);
    }
}

M2_self_tapping_screw    = ["M2_self_tapping", "M2 self tapping (Pan Head)", hs_pan,  2, 3.5, 1.3,  0, 0, 0,  M2_washer, false,   M2_tap_radius,    M2_clearance_radius];

module xCarriageVoronMiniAfterburnerLGXLite_hardware() {
    *translate([0, 0, 42.5]) {
        translate([6.270, 51.33, 0])
            boltM3Countersunk(40);
        for (x = [-13, 13])
            translate([x, 48.05, 0])
                boltM3Countersunk(40);
    }
    for (x = [-11.65, 11.65])
        translate([x, 57.95, xCarriageSize.y + xCarriageVoronMiniAfterburnerOffsetZ + 0.5])
            bolt(M2_self_tapping_screw, 10);
}

module vmalgxlImportStl(file) {
    import(str("../../../stlimport/voron-0/Toolheads/Mini-After-LGX-Lite/Mini-After-LGX-lite/", file, ".stl"), convexity=10);
}

module vmalgxl_x_carriage_sls() {
    translate([0, 0, 7])
        rotate([90, 0, 0])
            color(voronColor())
                vmalgxlImportStl("x-carriage_sls");
}

module vmalgxl_hotend_mount_mosquito_3010_fan() {
    translate([147.87, -0.29, -154.7])
        rotate([90, 0, 180])
            color(voronColor())
                vmalgxlImportStl("hotend_mount_mosquito_3010_fan");
}


module vmalgxl_cowling_universal() {
    vitamin(str(": Voron Mini Afterburner LGX Lite assembly"));

    translate([60, 32.2, 51])
        rotate([-90, 0, 180]) {
            //color(voronAccentColor())
            translate([60, 140, 0])
                vmalgxlImportStl("Cowling_Universal");
            if ($preview) {
                translate([45, 94, 31])
                    rotate([180, 90, 0])
                        not_on_bom()
                            blower(BL30x10);
                translate([76, 94, 2])
                    rotate([180, -90, 0])
                        not_on_bom()
                            blower(BL30x10);
                translate([60, 73, 8])
                    not_on_bom()
                        fan(fan30x10);
                for (x = [-13, 13])
                    translate([x + 60, 55, 1.5])
                        vflip()
                            boltM3Buttonhead(40);
            }
        }
}
