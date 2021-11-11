include <../global_defs.scad>

include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/leadnuts.scad>
include <NopSCADlib/vitamins/rod.scad>

include <../utils/carriageTypes.scad>

include <../vitamins/bolts.scad>

include <../Parameters_Main.scad>

brassColor = "#B5A642";
leadnut = LSN8x2;
zCarriageType = is_undef(_zCarriageDescriptor) ? MGN12C_carriage : carriageType(_zCarriageDescriptor);

module kinematicBedImportStl(file) {
    import(str("../stlimport/jubilee/frame/", file, ".STL"));
}

module Z_Carriage_Left_Front_stl() {
    stl("Z_Carriage_Left_Front")
        color(pp2_colour)
            translate([-124.236 - 27/2, -132.65, 0])
                kinematicBedImportStl("front_left_bed_coupling_lift");
}

module Z_Carriage_Left_Front_assembly()
assembly("Z_Carriage_Left_Front") {
    rotate([90, 0, 90])
        stl_colour(pp2_colour)
            Z_Carriage_Left_Front_stl();
    translate([17, 0, 4]) {
        color(brassColor)
            //translate_z(3.5) vflip()
            leadnut(leadnut);
        leadnut_screw_positions(leadnut)
            screw(leadnut_screw(leadnut), 8);
    }
    translate([5 - carriage_height(zCarriageType), 0, 17.35])
        rotate([0, 90, 0])
            carriage_hole_positions(zCarriageType)
                screw(M3_cap_screw, 8);
    rotate([0 , 0, -60])
        for (x = [5.5, -5.5])
            translate([x, 39, 31.75])
                rotate([-90, 0, 0])
                    rod(4, 20, center=false);
}

module Z_Carriage_Left_Back_stl() {
    stl("Z_Carriage_Left_Back")
        color(pp2_colour)
            translate([-148.767 - 27/2, -132.65, 0])
                kinematicBedImportStl("front_right_bed_coupling_lift");
}

module Z_Carriage_Left_Back_assembly()
assembly("Z_Carriage_Left_Back") {
    rotate([90, 0, 90])
        stl_colour(pp2_colour)
            Z_Carriage_Left_Back_stl();
    translate([17, 0, 4]) {
        color(brassColor)
            //translate_z(3.5) vflip()
            leadnut(leadnut);
        leadnut_screw_positions(leadnut)
            screw(leadnut_screw(leadnut), 8);
    }
    translate([5 - carriage_height(zCarriageType), 0, 17.35])
        rotate([0, 90, 0])
            carriage_hole_positions(zCarriageType)
                screw(M3_cap_screw, 8);
    rotate([0 , 0, -120])
        for (x = [5.5, -5.5])
            translate([x, 39, 31.75])
                rotate([-90, 0, 0])
                    rod(4, 20, center=false);
}

module Z_Carriage_Right_Center_stl() {
    stl("Z_Carriage_Right_Center")
        color(pp2_colour)
            render(convexity=10)
                translate([-27/2, 0, 0]) {
                    difference() {
                        kinematicBedImportStl("back_bed_coupling_lift");
                        translate([-eps, -eps, -eps])
                            cube([28, 35, 15]);
                    }
                    translate_z(15)
                        difference() {
                            size = [27, 34.7, 5];
                            cube(size);
                            translate([size.x/2, size.y/2, -carriage_height(zCarriageType)])
                                rotate(90)
                                    carriage_hole_positions(zCarriageType)
                                        boltHoleM3(5);
                        }
                }
}

module Z_Carriage_Right_Center_assembly()
assembly("Z_Carriage_Right_Center") {
    rotate([90, 0, -90])
        stl_colour(pp2_colour)
            Z_Carriage_Right_Center_stl();
    translate([-32, 0, 4]) {
        color(brassColor)
            //translate_z(3.5) vflip()
            leadnut(leadnut);
        leadnut_screw_positions(leadnut)
            screw(leadnut_screw(leadnut), 8);
    }
    translate([-6, 0, 17.35])
        rotate([0, -90, 0])
            carriage_hole_positions(zCarriageType)
                screw(M3_cap_screw, 8);
    rotate([0 , 0, 90])
        for (x = [5.5, -5.5])
            translate([x, 44, 31.75])
                rotate([-90, 0, 0])
                    rod(4, 20, center=false);
}

module jubilee_build_plate() {
    // RatRig build plate is 329x329x4 with 4 x 6mm holes offset by 10mm(guess)
    //
    // Voron V2 build plate is 300.8x304.9x6 with holes offset 7mm in Y direction and 75 mm from center in X direction.
    // Holes are 3.4mm and countersunk
    //
    //Jubilee size = [340, 305, 6.35];
    //
    size = _printBedSize;
    //bedOffset = [47.7, 24.675, 48];
    bedOffset = [68.7, 36 + 35, 18];
    holeOffset = _printBedHoleOffset;
    boltHoles = [ [holeOffset.x, holeOffset.y, 0], [holeOffset.x, size.y - holeOffset.y, 0], [size.x - holeOffset.x, size.y/2, 0] ];
    //translate([60, 25+(26+59)/2, 50+48])
    explode(50)
        translate(bedOffset) {
            color("silver")
                difference() {
                    rounded_cube_xy(size, 1);
                    for (i = boltHoles)
                        translate(i + [0, 0, size.z])
                            vflip()
                                boltHoleM4Countersunk(size.z);
                }
            for (i = boltHoles)
                translate(i) {
                    translate_z(size.z)
                        boltM4Countersunk(10);
                    translate_z(-4)
                        color(silver)
                            sphere(r=5);
                }
        }
}
