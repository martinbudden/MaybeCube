include <NopSCADlib/core.scad>
include <../vitamins/bolts.scad>


e2020CoverSizeX = 15;
e2020CoverSizeY = 1.5;
e2020CoverSizeZ = 10;

e2020ChannelWidth = 6.2;
e2020ChannelDepth = 1.8;


module _E2020Base(coverSizeX, coverSizeY) {
    translate([-coverSizeX/2, 0])
        square([coverSizeX, coverSizeY]);
}

module E2020Clip2d(channelWidth=6.0, channelDepth=1.9, lipOverhang = 0.3) {
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

module E2020Clip(size, channelWidth=6.0, channelDepth=1.9, lipOverhang=0.3) {
    linear_extrude(size)
        E2020Clip2d(channelWidth, channelDepth);
}

//_E2020Stripe(6.2, 1.8);
module _E2020Stripe(channelWidth, channelDepth, lipOverhang=0.3) {
    E2020Clip2d(channelWidth, channelDepth, lipOverhang);

    stripeX = e2020ChannelWidth + lipOverhang;
    totalDepth = 6;
    stripeY = totalDepth - e2020ChannelDepth;
    thickness = 1;
    difference() {
        translate([-stripeX/2, channelDepth])
            square([stripeX, stripeY]);
        translate([-(stripeX - thickness*2)/2, channelDepth - eps])
            square([stripeX - thickness*2, stripeY + 2*eps]);
    }
}

module E2020Cover(length, topOnlyLength=0, channelWidth=6.0, channelDepth=1.8, coverSizeX=e2020CoverSizeX) {
    assert(length > 0);

    linear_extrude(length - topOnlyLength) {
        _E2020Base(coverSizeX, e2020CoverSizeY);
        translate([0, e2020CoverSizeY])
            E2020Clip2d(channelWidth, channelDepth);
    }
    translate_z(length - topOnlyLength)
        linear_extrude(topOnlyLength)
            _E2020Base(coverSizeX, e2020CoverSizeY);
}

function E2020CoverSizeFn(length) = [e2020CoverSizeX, e2020CoverSizeY, length];

module extrusionPiping(length, channelWidth=6.2, channelDepth=1.8) {
    linear_extrude(length) {
        stripeSizeY = 1.0;
        _E2020Base(7, stripeSizeY);
        translate([0, stripeSizeY])
            _E2020Stripe(channelWidth, channelDepth);
    }
}

module extrusionChannel(length, bolts, sliding=false, channelWidth=5.8, boltDiameter=4) {
    channelDepth = sliding ? 2.5 : boltDiameter == 4 ? 2 : 1.5;
    size1 = [channelWidth, channelDepth + eps];
    size2 = [5.8, 3.4];
    size3 = [9, 1];

    rotate([-90, 0, 0])
        difference() {
            linear_extrude(length) {
                translate([-size1.x/2, 0])
                    square(size1);
                hull() {
                    translate([-size2.x/2, channelDepth])
                        square(size2);
                    translate([-size3.x/2, channelDepth])
                        square(size3);
                }
            }
            if (is_list(bolts))
                for (z = bolts)
                    translate_z(z)
                        rotate([-90, 0, 0])
                            if (boltDiameter == 4)
                                boltHoleM4Tap(size1.y + size2.y, twist=3);
                            else
                                boltHoleM3Tap(size1.y + size2.y, twist=3);
        }
}
