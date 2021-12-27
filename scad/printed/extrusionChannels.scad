use <NopSCADlib/utils/fillet.scad>
include <../vitamins/bolts.scad>


e20CoverSizeX = 15;
e20CoverSizeY = 1.5;
e20CoverSizeZ = 10;

e20ChannelWidth = 6.2;
e20ChannelDepth = 1.8;


module _E20Base(coverSizeX, coverSizeY) {
    translate([-coverSizeX/2, 0])
        square([coverSizeX, coverSizeY]);
}

module E20Clip2d(channelWidth=6.0, channelDepth=1.9, lipOverhang = 0.3) {
/*
    taperBottomX = 5.9;
    taperTopX = 5.9;
    taperY = 1.8;
    lipX = 6.5;
    lipY = 1.2;
    cutX = 2.3;
*/
    lipY = 1.2;
    sideWallWidth = 1.5;

    taperBottomX = channelWidth;
    taperTopX = channelWidth;
    taperY = channelDepth;
    lipX = channelWidth + 2*lipOverhang;
    cutX = channelWidth - 2*sideWallWidth;
    difference() {
        union() {
            // add the base
            polygon([ [-taperBottomX/2, 0], [taperBottomX/2, 0], [taperTopX/2, taperY], [-taperTopX/2, taperY] ]);
            //add the lip
            translate([-lipX/2, taperY])
                square([lipX, lipY]);
        }
        // make a cut down the middle so the clip can be squeezed
        translate([-cutX/2, -eps])
            square([cutX, taperY + lipY + 2*eps]);
    }
}

module E20Clip(size, channelWidth=6.0, channelDepth=1.9, lipOverhang=0.3) {
    linear_extrude(size)
        E20Clip2d(channelWidth, channelDepth);
}

module _E20Stripe(channelWidth, channelDepth, lipOverhang=0.3) {
    E20Clip2d(channelWidth, channelDepth, lipOverhang);

    stripeX = e20ChannelWidth + lipOverhang;
    totalDepth = 6 - 0.2;
    stripeY = totalDepth - e20ChannelDepth;
    thickness = 1;
    difference() {
        translate([-stripeX/2, channelDepth])
            square([stripeX, stripeY]);
        translate([-(stripeX - thickness*2)/2, channelDepth - eps])
            square([stripeX - thickness*2, stripeY + 2*eps]);
    }
}

module E20Cover(length, topOnlyLength=0, channelWidth=6.0, channelDepth=1.8, coverSizeX=e20CoverSizeX) {
    assert(length > 0);

    linear_extrude(length - topOnlyLength) {
        _E20Base(coverSizeX, e20CoverSizeY);
        translate([0, e20CoverSizeY])
            E20Clip2d(channelWidth, channelDepth);
    }
    translate_z(length - topOnlyLength)
        linear_extrude(topOnlyLength)
            _E20Base(coverSizeX, e20CoverSizeY);
}

function E20CoverSizeFn(length) = [e20CoverSizeX, e20CoverSizeY, length];

module E20RibbonCover(length) {
    assert(length > 0);

    extraX = 2.5;
    sizeY = 2;

    E20Cover(length);
    linear_extrude(length) {
        translate([-extraX/2, e20CoverSizeY - sizeY])
            _E20Base(e20CoverSizeX + extraX, sizeY);
        translate([-10, e20CoverSizeY - 2*sizeY + eps])
                _E20Base(35, sizeY);
    }
}

module extrusionPiping(length, channelWidth=6.2, channelDepth=1.8) {
    linear_extrude(length) {
        stripeSizeY = 1.0;
        _E20Base(7, stripeSizeY);
        translate([0, stripeSizeY])
            _E20Stripe(channelWidth, channelDepth);
    }
}

module extrusionChannel(length, boltHoles=undef, accessHoles=undef, sliding=false, channelWidth=5.8, boltDiameter=4) {
    channelDepth = is_undef(bolHoles) ? 1.5 : sliding ? 2.5 : boltDiameter > 3 ? 2 : 1.5;
    size1 = [channelWidth, channelDepth + eps];
    size2 = [5.8, 3.4];
    size3 = [9, 1];

    rotate([-90, 0, 0])
        difference() {
            render(convexity=8)
            union() {
                linear_extrude(length) {
                    *translate([-size1.x/2, 0])
                        square(size1);
                    hull() {
                        translate([-size2.x/2, channelDepth])
                            square(size2);
                        translate([-size3.x/2, channelDepth])
                            square(size3);
                    }
                }
                translate([-size1.x/2, 0, 0])
                    rounded_cube_xz([size1.x, size1.y + size2.y, length], 1);
            }
            rotate([-90, 0, 0]) {
                fillet = 1;
                translate([-size3.x/2, -length, size1.y - 2*eps])
                    fillet(fillet, size2.y);
                translate([-size3.x/2 - eps, -length - eps, size3.y + channelDepth])
                    rotate([0, 33, 0])
                        fillet(fillet, size2.y + 1);
                translate([size3.x/2, -length, size1.y - 2*eps])
                    rotate(90)
                        fillet(fillet, size2.y);
                translate([size3.x/2 + eps, -length - eps, size3.y + channelDepth])
                    rotate([0, -33, 0])
                        rotate(90)
                            fillet(fillet, size2.y + 1);
                translate([size3.x/2, 0, size1.y - 2*eps])
                    rotate(180)
                        fillet(fillet, size2.y);
                translate([size3.x/2 + eps, eps, size3.y + channelDepth])
                    rotate([0, -33, 0])
                        rotate(180)
                            fillet(fillet, size2.y + 1);
                translate([-size3.x/2, 0, size1.y - 2*eps])
                    rotate(270)
                        fillet(fillet, size2.y);
                translate([-size3.x/2 - eps, eps, size3.y + channelDepth])
                    rotate([0, 33, 0])
                        rotate(270)
                            fillet(fillet, size2.y + 1);
            }
            if (is_list(boltHoles))
                for (z = boltHoles)
                    translate_z(z)
                        rotate([-90, 0, 0])
                            if (boltDiameter == 4)
                                boltHoleM4Tap(size1.y + size2.y, twist=4);
                            else
                                boltHoleM3Tap(size1.y + size2.y, twist=4);
            if (is_list(accessHoles))
                for (z = accessHoles)
                    translate_z(z)
                        rotate([-90, 0, 0])
                            boltHole(4, size1.y + size2.y, twist=4);
        }
}
