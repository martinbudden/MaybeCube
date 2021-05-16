include <../global_defs.scad>

include <NopSCADlib/core.scad>


use <extrusionChannels.scad>

_useAsserts = is_undef(_useAsserts) ? false : _useAsserts;

module Z_RodMountGuide_40mm_stl() {
    stl("Z_RodMountGuide_40mm")
        E2020Cover(40);
}

module Z_RodMountGuide_50mm_stl() {
    stl("Z_RodMountGuide_50mm")
        E2020Cover(50);
}

module Z_RodMountGuide_60mm_stl() {
    stl("Z_RodMountGuide_60mm")
        E2020Cover(60);
}

module zRodMountGuide(length) {
    //echo("zRodMountGuide length=", length);
    size = E2020CoverSizeFn(length);
    translate([0, length, size.y]) rotate([-90, 0, 0]) {
        if (length==0) {
            // do nothing
        } else if (length==40) {
            color(pp2_colour) hflip() Z_RodMountGuide_40mm_stl();
        } else if (length==50) {
            color(pp2_colour) hflip() Z_RodMountGuide_50mm_stl();
        } else if (length==60) {
            color(pp2_colour) hflip() Z_RodMountGuide_60mm_stl();
        } else {
            echo(zRodMountGuide_length = length);
            color("red") hflip() E2020Cover(length);
            if (_useAsserts) assert(false, "Unsupported zRodMountGuide length");
        }
    }
}

module Z_Motor_MountGuide_19mm_stl() {
    stl("Z_Motor_MountGuide_19mm")
        E2020Cover(19);
}

module Z_Motor_MountGuide_25mm_stl() {
    stl("Z_Motor_MountGuide_25mm")
        E2020Cover(25);
}

module Z_Motor_MountGuide_55mm_stl() {
    stl("Z_Motor_MountGuide_55mm")
        E2020Cover(55);
}

module Z_Motor_MountGuide_92p5mm_stl() {
    // for MC400
    stl("Z_Motor_MountGuide_92p5mm")
        E2020Cover(92.5);
}

module Z_Motor_MountGuide(length) {
    size = E2020CoverSizeFn(length);
    translate_z(size.y)
        rotate([-90, 0, 0]) {
            if (length==0) {
                // do nothing
            } else if (length==19) {
                color(pp2_colour)
                    Z_Motor_MountGuide_19mm_stl();
            } else if (length==25) {
                color(pp2_colour)
                    Z_Motor_MountGuide_25mm_stl();
            } else if (length==55) {
                color(pp2_colour)
                    Z_Motor_MountGuide_55mm_stl();
            } else if (length==92.5) {
                color(pp2_colour)
                    Z_Motor_MountGuide_92p5mm_stl();
            } else {
                echo(Z_Motor_MountGuide_length = length);
                if (length > 0)
                    color("red") E2020Cover(length);
                if (_useAsserts) assert(false, "Unsupported Z_Motor_MountGuide length");
            }
    }
}
