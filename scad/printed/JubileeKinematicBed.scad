include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

include <../vitamins/bolts.scad>

module kinematicBedImportStl(file) {
    import(str("../stlimport/jubilee/frame/", file, ".STL"));
}

module front_left_bed_coupling_lift_stl() {
    stl("front_left_bed_coupling_lift")
        color(pp2_colour)
            translate([-124.24, -132.65, 0])
                kinematicBedImportStl("front_left_bed_coupling_lift");
}

module front_left_bed_coupling_lift_assembly()
assembly("front_left_bed_coupling_lift") {
    stl_colour(pp2_colour)
        front_left_bed_coupling_lift_stl();
}

module front_right_bed_coupling_lift_stl() {
    stl("front_right_bed_coupling_lift")
        color(pp2_colour)
            translate([-148.8, -132.65, 0])
                kinematicBedImportStl("front_right_bed_coupling_lift");
}

module front_right_bed_coupling_lift_assembly()
assembly("front_right_bed_coupling_lift") {
    stl_colour(pp2_colour)
        front_right_bed_coupling_lift_stl();
}

module back_bed_coupling_lift_stl() {
    stl("back_bed_coupling_lift")
        color(pp2_colour)
            translate([0, 0, 0])
                kinematicBedImportStl("back_bed_coupling_lift");
}

module back_bed_coupling_lift_assembly()
assembly("back_bed_coupling_lift") {
    stl_colour(pp2_colour)
        back_bed_coupling_lift_stl();
}

module jubilee_build_plate() {
    // RatRig build plate is 329x329x4 with 4 x 6mm holes offset by 10mm(guess)
    //
    // Voron V2 build plate is 300.8x304.9x6 with holes offset 7mm in Y direction and 75 mm from center in X direction.
    // Holes are 3.4mm and countersunk
    //
    //Jubilee size = [340, 305, 6.35];
    //
    size = [320, 305, 6.35];
    holeOffset = 5;
    boltHoles = [ [holeOffset, holeOffset, 0], [holeOffset, size.y - holeOffset, 0], [size.x - holeOffset, size.y/2, 0] ];
    translate([60, 25+(26+59)/2, 50+48])
    color("silver")
        difference() {
            rounded_cube_xy(size, 1);
            for (i = boltHoles)
                translate(i)
                    boltHoleM5(size.z, cnc=true);
        }
}
