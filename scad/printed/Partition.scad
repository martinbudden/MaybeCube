module partitionGuide(length) {
    size = [partitionOffsetY() - eSize + guideWidth/2 + 1, length, eSize];
    supportWidth = 15;
    partitionSize = [guideWidth, size.y, eSize];
    fillet = 1;
    translate([-size.x, 0, 0]) {
        difference() {
            union() {
                rounded_cube_xy([size.x, size.y, 3], fillet);
                for (y = [0, size.y - supportWidth])
                    translate([0, y, 0])
                        rounded_cube_xy([size.x, supportWidth, size.z], fillet);
                translate([0, size.y, size.z])
                    rotate([180, 0, 0])
                        partitionGuideTabs([guideWidth, size.y, size.z]);
            }
            for (y = [supportWidth/2, size.y - supportWidth/2])
                translate([0, y, eSize/2])
                    rotate([90, 0, 90])
                        boltHoleM3CounterboreButtonhead(size.x, boreDepth=size.x - 3, horizontal=true);
        }
    }
}

module Partition_Guide_hardware(length) {
    size = [partitionOffsetY() - eSize + guideWidth/2 + 1, length, eSize];
    supportWidth = 15;

    for (y = [supportWidth/2, size.y - supportWidth/2])
        translate([-3, y, eSize/2])
            rotate([90, 0, -90])
                explode(35, true)
                    boltM3ButtonheadHammerNut(8, nutExplode=55);
}

module Partition_Guide_stl() {
    stl("Partition_Guide")
        color(pp1_colour)
            partitionGuide(guideLength);
}

module partitionGuideAssembly() {
    for (z = [0, guideLength])
        translate([0, eY + eSize, 2*eSize + z])
            rotate([90, 0, 90]) {
                color(z == 0 ? pp1_colour : pp2_colour)
                    Partition_Guide_stl();
                Partition_Guide_hardware(guideLength);
            }
}

module partitionTop() {
    xyMotorMountSizeLeft = xyMotorMountSize(left=true);
    overlap = 3;
    size = [eX + 2*eSize + 2*overlap - xyMotorMountSizeLeft.x - xyMotorMountSize(left=false).x, partitionOffsetY() + 5, 6];
    filet = 1;
    translate([xyMotorMountSizeLeft.x - overlap, -size.y + eSize, 0])
        rounded_cube_xy(size, filet);
}

module Partition_Top_hardware() {
}

module Partition_Top_stl() {
    stl("Partition_Top")
        color(pp2_colour)
            partitionTop();
}

module partitionTopAssembly() {
    translate([0, eY + eSize, eZ - 90]) {
        color(pp2_colour)
            Partition_Top_stl();
        Partition_Guide_hardware(guideLength);
    }
}

module Partition_dxf() {
    size = partitionSize();
    fillet = 1;
    sheet = PC2;

    dxf("Partition")
        color(sheet_colour(sheet))
            difference() {
                sheet_2D(sheet, size.x, size.y, fillet);
                partitionCutouts(cncSides=0);
            }
}

module partitionCutouts(cncSides) {
    size = partitionSize();

    leftCutoutSize = [size.x - eSize - xyMotorMountSize(left=false).x, xyMotorMountSize(left=true).z - 2.5];
    rightCutoutSize = [eSize + xyMotorMountSize(left=false).x, xyMotorMountSize(left=false).z - 2.5];
    translate([-size.x/2, -size.y/2]) {
        if (!is_undef(_use2060ForTop) && _use2060ForTop)
            translate([0, size.y - eSize]) {
                square([2*eSize, eSize]);
                translate([size.x - 2*eSize, 0])
                    square([2*eSize, eSize]);
            }
        translate([0, size.y - leftCutoutSize.y])
            square(leftCutoutSize);
        translate(size - rightCutoutSize)
            square(rightCutoutSize);
    }
}

module partitionPC() {
    size = partitionSize();

    translate([eSize, eY + 2*eSize - partitionOffsetY() - size.z, 0])
        rotate([90, 0, 0])
            translate([size.x/2, size.y/2, -size.z/2])
                render_2D_sheet(PC2, w=size.x, d=size.y)
                    Partition_dxf();
}

module Partition_assembly()
assembly("Partition", ngb=true) {

    partitionPC();
}
