include <../config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <extrusionChannels.scad>


_useAsserts = is_undef(_useAsserts) ? false : _useAsserts;


module Z_RodMountGuide_40mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_40mm")
            E20Cover(40);
}

module Z_RodMountGuide_48mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_48mm")
            E20Cover(48);
}

module Z_RodMountGuide_50mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_50mm")
            E20Cover(50);
}

module Z_RodMountGuide_70mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_70mm")
            E20Cover(70);
}

module Z_RodMountGuide_100mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_100mm")
            E20Cover(100);
}

module Z_RodMountGuide_105mm_stl() {
    color(pp2_colour)
        stl("Z_RodMountGuide_105mm")
            E20Cover(105);
}

module E20_ChannelCover_50mm_stl() {
    color(pp2_colour)
        stl("E20_ChannelCover_50mm")
            E20Cover(50);
}

module E20_RibbonCover_50mm_stl() {
    color(pp2_colour)
        stl("E20_RibbonCover_50mm")
            E20RibbonCover(50);
}

module zRodMountGuide(length) {
    //echo("zRodMountGuide length=", length);
    size = E20CoverSizeFn(length);
    translate([0, length, size.y])
        rotate([-90, 0, 180])
            if (length==0) {
                // do nothing
            } else if (length==40) {
                color(pp2_colour)
                    Z_RodMountGuide_40mm_stl();
            } else if (length==48) {
                color(pp2_colour)
                    Z_RodMountGuide_48mm_stl();
            } else if (length==50) {
                color(pp2_colour)
                    Z_RodMountGuide_50mm_stl();
            } else if (length==70) {
                color(pp2_colour)
                    Z_RodMountGuide_70mm_stl();
            } else if (length==100) {
                color(pp2_colour)
                    Z_RodMountGuide_100mm_stl();
            } else if (length==105) {
                color(pp2_colour)
                    Z_RodMountGuide_105mm_stl();
            } else {
                echo(zRodMountGuide_length=length);
                color("red")
                    E20Cover(length);
                if (_useAsserts) assert(false, "Unsupported zRodMountGuide length");
            }
}

module Z_Motor_Mount_Guide_17p5mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_17p5mm")
            E20Cover(17.5);
}

module Z_Motor_Mount_Guide_19mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_19mm")
            E20Cover(19);
}

module Z_Motor_Mount_Guide_23mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_23mm")
            E20Cover(23);
}

module Z_Motor_Mount_Guide_25mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_25mm")
            E20Cover(25);
}

module Z_Motor_Mount_Guide_55mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_55mm")
            E20Cover(55);
}

module Z_Motor_Mount_Guide_61mm_stl() {
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_61mm")
            E20Cover(61);
}

module Z_Motor_Mount_Guide_92p5mm_stl() {
    // for MC400
    color(pp2_colour)
        stl("Z_Motor_Mount_Guide_92p5mm")
            E20Cover(92.5);
}

module zMotorMountGuide(length) {
    size = E20CoverSizeFn(length);
    translate_z(size.y)
        rotate([-90, 0, 0]) {
            if (length==0) {
                // do nothing
            } else if (length==17.5) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_17p5mm_stl();
            } else if (length==19) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_19mm_stl();
            } else if (length==23) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_23mm_stl();
            } else if (length==25) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_25mm_stl();
            } else if (length==55) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_55mm_stl();
            } else if (length==61) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_61mm_stl();
            } else if (length==92.5) {
                color(pp2_colour)
                    Z_Motor_Mount_Guide_92p5mm_stl();
            } else {
                echo(Z_Motor_Mount_Guide_length = length);
                if (length > 0)
                    color("red")
                        E20Cover(length);
                if (_useAsserts) assert(false, "Unsupported Z_Motor_MountGuide length");
            }
    }
}
