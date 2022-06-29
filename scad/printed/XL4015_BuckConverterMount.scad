include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/pcbs.scad>

include <../vitamins/XL4015_BuckConverter.scad>


module XL4015_buck_converter_mount_stl() {
    bcType = XL4015_BUCK_CONVERTER;
    standoffRadius = 3;
    standoffHeight = 10;
    baseHeight = 3;
    difference() {
        union() {
            hull()
                pcb_hole_positions(bcType)
                    cylinder(r=standoffRadius, h=baseHeight);
            pcb_hole_positions(bcType)
                cylinder(r=standoffRadius, h=standoffHeight);
        }
        pcb_hole_positions(bcType)
            translate_z(standoffHeight)
               vflip()
                    boltHoleM2Tap(6);
        for (x = [-15, 15])
            translate([x, 0, baseHeight])
               vflip()
                    boltHoleM3Tap(baseHeight);
    }
}
