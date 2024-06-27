include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/utils/rounded_cylinder.scad>


function revoNozzleOffsetZ() = 22.8;

revoNozzleLength = 44.1;

module RevoNozzle() {
    brassColor="#B5A642";
    color(brassColor) {
        cylinder(h=2, r1=0.5, r2=2);
        translate_z(2)
            cylinder(h=5, r=5);
        translate_z(7)
            cylinder(h=12, r=3);
        translate_z(22)
            cylinder(h=0.8, r=3);
        translate_z(22.8)
            cylinder(h=revoNozzleLength - revoNozzleOffsetZ(), r=1.5);
    }
    color("silver")
        translate_z(18)
            cylinder(h=4, r=1);
    color("red")
        translate_z(2.5 + 4.5)
            vflip()
                rounded_cylinder(h=4.5, r=6.5, r2=1);
    color(grey(20))
        translate_z(12 + 7 - eps)
            vflip()
                rounded_cylinder(h=12, r=8, r2=1);

}

