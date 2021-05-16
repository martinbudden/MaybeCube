e2020CoverSizeX = 15;
e2020CoverSizeY = 1.5;
e2020CoverSizeZ = 10;

e2020ChannelWidth = 6.2;
e2020ChannelDepth = 1.8;

//E2020Cover(18.5);
//E2020Cover(50);
//E2020Cover(70);

module _E2020Base(coverSizeX, coverSizeY) {
    translate([-coverSizeX/2, 0]) square([coverSizeX, coverSizeY]);
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
        translate([-cutX/2, 0])
            square([cutX, taperY+lipY]);
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
        translate([-(stripeX - thickness*2)/2, channelDepth])
            square([stripeX - thickness*2, stripeY]);
    }
}

//translate([20, 0, 0]) rotate([90, 0, 0]) E2020Cover(15);
//translate([40, 0, 0]) rotate([90, 0, 0]) E2020Cover(15, coverSizeX=10);
module E2020Cover(length, topOnlyLength=0, channelWidth=6.0, channelDepth=1.8, coverSizeX=e2020CoverSizeX) {
    assert(length > 0);

    linear_extrude(length - topOnlyLength) {
        _E2020Base(coverSizeX, e2020CoverSizeY);
        translate([0, e2020CoverSizeY])
            E2020Clip2d(channelWidth, channelDepth);
    }
    translate([0, 0, length - topOnlyLength])
        linear_extrude(topOnlyLength)
            _E2020Base(coverSizeX, e2020CoverSizeY);
}

function E2020CoverSizeFn(length) = [e2020CoverSizeX, e2020CoverSizeY, length];

//rotate([90, 0, 0]) extrusionPiping(18);
module extrusionPiping(length, channelWidth=6.2, channelDepth=1.8) {
    linear_extrude(length) {
        stripeSizeY = 1.0;
        _E2020Base(7, stripeSizeY);
        translate([0, stripeSizeY]) _E2020Stripe(channelWidth, channelDepth);
    }
}
