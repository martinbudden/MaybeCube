include <../global_defs.scad>

include <NopSCADlib/core.scad>


use <extrusionChannels.scad>

_useAsserts = is_undef(_useAsserts) ? false : _useAsserts;

module Z_RodMountGuide_40mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_40mm")
            E2020Cover(40);
}

module Z_RodMountGuide_50mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_50mm")
            E2020Cover(50);
}

module Z_RodMountGuide_70mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_70mm")
            E2020Cover(70);
}

module Z_RodMountGuide_100mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_100mm")
            E2020Cover(100);
}

module zRodMountGuide(length) {
    //echo("zRodMountGuide length=", length);
    size = E2020CoverSizeFn(length);
    translate([0, length, size.y])
        rotate([-90, 0, 180])
            if (length==0) {
                // do nothing
            } else if (length==40) {
                Z_RodMountGuide_40mm_stl();
            } else if (length==50) {
                Z_RodMountGuide_50mm_stl();
            } else if (length==70) {
                Z_RodMountGuide_70mm_stl();
            } else if (length==100) {
                Z_RodMountGuide_100mm_stl();
            } else {
                echo(zRodMountGuide_length = length);
                color("red")
                    E2020Cover(length);
                if (_useAsserts) assert(false, "Unsupported zRodMountGuide length");
            }
}

module Z_Motor_MountGuide_19mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_MountGuide_19mm")
            E2020Cover(19);
}

module Z_Motor_MountGuide_25mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_MountGuide_25mm")
            E2020Cover(25);
}

module Z_Motor_MountGuide_55mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_MountGuide_55mm")
            E2020Cover(55);
}

module Z_Motor_MountGuide_92p5mm_stl() {
    // for MC400
    color(pp2_colour)
        stl("Z_Motor_MountGuide_92p5mm")
            E2020Cover(92.5);
}

module zMotorMountGuide(length) {
    size = E2020CoverSizeFn(length);
    translate_z(size.y)
        rotate([-90, 0, 0]) {
            if (length==0) {
                // do nothing
            } else if (length==19) {
                Z_Motor_MountGuide_19mm_stl();
            } else if (length==25) {
                Z_Motor_MountGuide_25mm_stl();
            } else if (length==55) {
                Z_Motor_MountGuide_55mm_stl();
            } else if (length==92.5) {
                Z_Motor_MountGuide_92p5mm_stl();
            } else {
                echo(Z_Motor_MountGuide_length = length);
                if (length > 0)
                    color("red")
                        E2020Cover(length);
                if (_useAsserts) assert(false, "Unsupported Z_Motor_MountGuide length");
            }
    }
}
