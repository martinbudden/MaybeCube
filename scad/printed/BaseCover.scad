include <../config/global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/fans.scad>
use <NopSCADlib/vitamins/psu.scad> // for psu_grill
include <NopSCADlib/printed/drag_chain.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <extruderBracket.scad> // for iecHousingMountSize()
use <WiringGuide.scad>
use <CableChainBracket.scad>

include <../config/Parameters_Main.scad>
include <../config/Parameters_Positions.scad>

supportHeight = 70;
holeOffset = 20;
function cableChainBracketOffsetX() = eX > 300 ? 240 : 210;
chainAnchorOffset = eX + 50 - cableChainBracketOffsetX();
chainAnchorSizeX = 8;
baseCoverTopSize = [eX > 300 ? 220 : 210, eY + eSize, 3.5];
baseCoverBackSupportSize = [baseCoverTopSize.x, eSize, supportHeight - 3*eSize];
function baseCoverBackSupportSizeZ() = baseCoverBackSupportSize.z;
baseCoverLeftSideSupportSize = [8, eY/2, supportHeight];
baseCoverRightSideSupportSize = [eSize + 10, eY/2, 5];
baseCoverFrontOffsetX = 10;
baseCoverFrontSupportSize = [baseCoverTopSize.x - 10 - baseCoverFrontOffsetX, 12, 3*eSize/2];


module chainAnchorHolePositions(size, offset=chainAnchorOffset) {
    chainOffset = size.x - offset;
    for (z = [0, 8])
        translate([chainOffset + chainAnchorSizeX, -5 + 10, size.z + z + 17])
            children();
}

module baseCoverBackSupport(size, offset=chainAnchorOffset) {
    chainOffset = size.x - offset;
    cutoutSize = [9, 10, size.z];
    fillet = 1.5;
    chainAnchorSize = [chainAnchorSizeX, size.y + 5, size.z + 32];
    difference() {
        union() {
            translate([0, size.y - 5, 0]) {
                rounded_cube_xy([size.x, 5, size.z], fillet);
                translate([size.x - 10, 0, 0])
                    rotate(-90)
                        fillet(2, size.z);
            }
            rounded_cube_xy([size.x - 10, size.y, size.z], fillet);
            translate([chainOffset, size.y - chainAnchorSize.y, 0]) {
                rounded_cube_xy(chainAnchorSize, fillet);
                translate([0, -size.y + chainAnchorSize.y, 0])
                    rotate(180)
                        fillet(1, size.z);
            }
        } // end union
        translate([chainOffset + chainAnchorSize.x, 0, size.z - cutoutSize.z - eps]) {
            translate([0, -fillet, 0])
                rounded_cube_xy([cutoutSize.x, cutoutSize.y + fillet, cutoutSize.z + 2*eps], fillet);
            translate([cutoutSize.x, 0, 0])
                fillet(fillet, cutoutSize.z + 2*eps);
        }
        chainAnchorHolePositions(size)
            rotate([90, 0, -90])
                boltHole(M3_tap_radius*2 + 0.4, chainAnchorSize.x, horizontal=true);
        for (x = [holeOffset - 5, size.x/2, size.x - holeOffset])
            translate([x, size.y/2, size.z])
                vflip()
                    boltHoleM3Tap(10);
        for (x = [50, 3*size.x/4])
            translate([x, size.y/2, size.z])
                vflip()
                    boltHoleM3Counterbore(size.z, boreDepth=size.z - 5);
    }
}

module Base_Cover_Back_Support_hardware() {
    size = baseCoverBackSupportSize;
    for (x = [50, 3*size.x/4])
        translate([x, size.y/2, 5])
            explode(30, true)
                boltM3ButtonheadHammerNut(8, nutExplode=50);
    chainAnchorHolePositions(size)
        rotate([0, 90, 0])
            translate_z(2)
                boltM3Countersunk(8);
}

module baseDragChain(offset=chainAnchorOffset, t=undef) {
    dragChainSize = [15, 10.5, 10];
    travel = 215;
    drag_chain = drag_chain("x", dragChainSize, travel=travel, wall=1.5, bwall=1.5, twall=1.5);

    drag_chain(390);
    translate([eX + eSize - offset + 60.2, eY + eSize + 5, 3*eSize + baseCoverBackSupportSize.z + 30]) {
        rotate([0, -90, 0])
            color(grey(25))
                not_on_bom()
                    drag_chain_assembly(drag_chain, pos=(zPos(is_undef(t) ? $t : t) - 85));
    }
}

module Base_Cover_Back_Support_210_stl() {
    stl("Base_Cover_Back_Support_210")
        color(pp2_colour) 
            baseCoverBackSupport(baseCoverBackSupportSize);
}

module Base_Cover_Back_Support_220_stl() {
    stl("Base_Cover_Back_Support_220")
        color(pp2_colour) 
            baseCoverBackSupport(baseCoverBackSupportSize);
}

module baseCoverFrontSupport(size, offsetX) {
    x1 = holeOffset - baseCoverLeftSideSupportSize.x;
    fillet = 1;
    translate([-offsetX, 0, 0]) {
        difference() {
            union() {
                sizeZ = 3;
                rounded_cube_xy([size.x, size.z, sizeZ], fillet);
                translate([0, 10, 0]) {
                    rounded_cube_xy([size.x + 10, size.z - 10, sizeZ], fillet);
                    translate([size.x, 0, 0])
                        rotate(-90)
                            fillet(fillet, sizeZ);

                }
            }
            for (x = [holeOffset, baseCoverTopSize.x/2, baseCoverTopSize.x - holeOffset])
                translate([x - offsetX, 20, 0])
                    boltHoleM3(3);
        }
        difference() {
            rounded_cube_xy([size.x, 5, size.y], fillet);
            for (x = [holeOffset, baseCoverTopSize.x/2, baseCoverTopSize.x - holeOffset])
                translate([x - offsetX, 0, 7.5])
                    rotate([-90, 180, 0])
                        boltHoleM3(5, horizontal=true);
        }
    }
}

module Base_Cover_Front_Support_hardware() {
    for (x = [holeOffset, baseCoverTopSize.x/2, baseCoverTopSize.x - holeOffset])
        translate([x - 2*baseCoverFrontOffsetX, 20, 3])
            boltM3ButtonheadHammerNut(8, nutExplode=40);
}

module Base_Cover_Front_Support_190_stl() {
    stl("Base_Cover_Front_Support_190")
        color(pp1_colour)
            baseCoverFrontSupport(baseCoverFrontSupportSize, baseCoverFrontOffsetX);
}
module Base_Cover_Front_Support_200_stl() {
    stl("Base_Cover_Front_Support_200")
        color(pp1_colour)
            baseCoverFrontSupport(baseCoverFrontSupportSize, baseCoverFrontOffsetX);
}

module baseCoverLeftSideSupport(size, tap=false) {
    overlap = 5;
    difference() {
        union() {
            rounded_cube_xy([size.z, size.y + overlap, size.x/2], 1);
            rounded_cube_xy([size.z, size.y - overlap, size.x], 1);
        }
        for (y = [size.y/4, 3*size.y/4]) {
            translate([0, y, size.x/2])
                rotate([0, 90, 0])
                    boltHoleM3Tap(10, horizontal=true, rotate=90, chamfer_both_ends=false);
            translate([size.z, y, size.x/2])
                rotate([0, -90, 0])
                    boltHoleM3Tap(10, horizontal=true, rotate=-90, chamfer_both_ends=false);
        }
        for (x = [size.z/4, 3*size.z/4])
            translate([x, size.y, 0])
                if (tap)
                    boltHoleM3Tap(size.x/2);
                else
                    boltHoleM3(size.x/2);
    }
}

module Base_Cover_Left_Side_Support_150A_stl() {
    stl("Base_Cover_Left_Side_Support_150A")
        color(pp2_colour)
            baseCoverLeftSideSupport(baseCoverLeftSideSupportSize, tap=false);
}

module Base_Cover_Left_Side_Support_150B_stl() {
    stl("Base_Cover_Left_Side_Support_150B")
        color(pp1_colour)
            baseCoverLeftSideSupport(baseCoverLeftSideSupportSize, tap=true);
}

module Base_Cover_Left_Side_Support_175A_stl() {
    stl("Base_Cover_Left_Side_Support_175A")
        color(pp2_colour)
            baseCoverLeftSideSupport(baseCoverLeftSideSupportSize, tap=false);
}

module Base_Cover_Left_Side_Support_175B_stl() {
    stl("Base_Cover_Left_Side_Support_175B")
        color(pp1_colour)
            baseCoverLeftSideSupport(baseCoverLeftSideSupportSize, tap=true);
}
module Base_Cover_Left_Side_Support_hardware() {
    for (y = [baseCoverLeftSideSupportSize.y/4, 3*baseCoverLeftSideSupportSize.y/4])
        translate([baseCoverLeftSideSupportSize.z + _basePlateThickness, y, baseCoverLeftSideSupportSize.x/2])
            rotate([0, 90, 0])
                boltM3Buttonhead(10);
}

module baseCoverRightSideSupport(size) {
    difference() {
        translate([baseCoverTopSize.x/2 - size.x + eSize, -baseCoverTopSize.y/2, 0])
            rounded_cube_xy(size, 1.5);
        baseCoverRightHolePositions(baseCoverTopSize)
            boltHoleM3Tap(size.z);
        for (y = [10, size.y - 10])
            translate([baseCoverTopSize.x/2 + eSize/2, -baseCoverTopSize.y/2 +y, 0])
                boltHoleM3(size.z);
    }
}

module Base_Cover_Right_Side_Support_stl() {
    stl("Base_Cover_Right_Side_Support")
       color(pp2_colour)
            baseCoverRightSideSupport(baseCoverRightSideSupportSize);
}

module baseCoverRightSideSupportAssembly() {
    size = baseCoverRightSideSupportSize;
    translate([eX + eSize - baseCoverTopSize.x/2, eSize + baseCoverTopSize.y/2, supportHeight - size.z]) {
        Base_Cover_Right_Side_Support_stl();
        for (y = [10, size.y - 10])
            translate([baseCoverTopSize.x/2 + eSize/2, -baseCoverTopSize.y/2 +y, 0])
                vflip()
                    boltM4ButtonheadHammerNut(10);
    }
}

BaseCover = ["BaseCover", "Sheet perspex", 3, grey(30), false];

module baseCoverRightHolePositions(size) {
    yLeft = baseCoverLeftSideSupportSize.y/4;
    for (y = [3*yLeft, size.y - 3*yLeft])
        translate([size.x/2 - 4, y - size.y/2, 0])
            children();
}

module baseCoverLeftHolePositions(size=baseCoverTopSize) {
    yLeft = baseCoverLeftSideSupportSize.y/4;

    translate([eX + eSize - size.x/2, eSize + size.y/2, 0])
        for (y = [yLeft, 3*yLeft, 5*yLeft, 7*yLeft])
            translate([4 - size.x/2, y - size.y/2, 0])
                children();
}

module baseCoverFrontHolePositions(size=baseCoverTopSize) {
    for (x = [holeOffset, size.x/2, size.x - holeOffset])
        translate([x - size.x/2, 8 - size.y/2, 0])
            children();
}

module baseCoverBackHolePositions(size) {
    for (x = [holeOffset - 5, size.x/2, size.x - holeOffset])
        translate([x - size.x/2, size.y/2 - 10, 0])
            children();
}

module baseCoverAllHolePositions(size) {
    baseCoverFrontHolePositions(size)
        children();
    baseCoverBackHolePositions(size)
        children();
    translate(-[eX + eSize - size.x/2, eSize + size.y/2, 0])
        baseCoverLeftHolePositions(size)
            children();
    baseCoverRightHolePositions(size)
        children();
}

module baseCoverTopAssembly(addBolts=true) {
    size = baseCoverTopSize;

    translate([eX + eSize - size.x/2, eSize + size.y/2, supportHeight + size.z/2]) {
        if (addBolts)
            baseCoverAllHolePositions(size)
                translate_z(size.z/2)
                    boltM3Buttonhead(8);
        *render_2D_sheet(BaseCover, w=size.x, d=size.y)
            if (eX == 300)
                Base_Cover_210_dxf();
            else
                Base_Cover_220_dxf();
        translate_z(-size.z/2) {
            vflip()
                color(grey(30))
                    Base_Cover_Front_220_stl();
            color(grey(40))
                Base_Cover_Back_220_stl();
        }
    }
}

module baseCoverCutouts(size, fillet, cnc=true) {
    cncSides = cnc ? 0 : undef ;
    baseCoverAllHolePositions(size)
        poly_circle(M3_clearance_radius, cncSides);
    chainCutoutSize = [18, 24 + 2* fillet];
    translate([size.x/2 - chainAnchorOffset - 0.5, size.y/2]) {
        translate([0, -chainCutoutSize.y + fillet])
            rounded_square(chainCutoutSize, fillet, center=false);
        rotate(180)
            fillet(fillet);
        translate([chainCutoutSize.x, 0])
            rotate(-90)
                fillet(fillet);
        extraCutoutSize = [8, chainCutoutSize.y + 8];
        translate([0, -extraCutoutSize.y + fillet])
            rounded_square(extraCutoutSize, fillet, center=false);
        translate([extraCutoutSize.x, -chainCutoutSize.y + fillet])
            rotate(-90)
                fillet(fillet);
    }
    cutoutFillet = 1;
    cameraWiringCutoutSize = [5, 5];
    translate([size.x/2 - cameraWiringCutoutSize.x, -size.y/2]) {
        translate([0, -2*cutoutFillet])
            rounded_square([cameraWiringCutoutSize.x + 2*cutoutFillet, cameraWiringCutoutSize.y + 2*cutoutFillet], cutoutFillet, center=false);
        rotate(90)
            fillet(cutoutFillet);
        translate(cameraWiringCutoutSize)
            rotate(90)
                fillet(cutoutFillet);
    }
    wiringGuidePosition = wiringGuidePosition(offsetY=wiringGuideCableOffsetY(), offsetZ=eSize);
    //wiringCutoutSize = [8, 26 + 2*fillet];// for just wire
    wiringCutoutSize = [30, 37 + 2*fillet];
    translate([size.x/2 - eX - eSize + wiringGuidePosition.x - wiringCutoutSize.x/2 + 0.75*0, size.y/2]) {
        translate([0, -wiringCutoutSize.y + fillet])
            rounded_square(wiringCutoutSize, fillet, center=false);
        rotate(180)
            fillet(fillet);
        translate([wiringCutoutSize.x, 0])
            rotate(-90)
                fillet(fillet);
    }
    auxiliaryFanWiringCutoutSize = [2, 5];
    auxiliaryFanWiringCutoutFillet = 0.5;
    translate([size.x/2 - auxiliaryFanWiringCutoutSize.x, -35]) {
        rounded_square([auxiliaryFanWiringCutoutSize.x + 2*auxiliaryFanWiringCutoutFillet, auxiliaryFanWiringCutoutSize.y], auxiliaryFanWiringCutoutFillet, center=false);
        translate([auxiliaryFanWiringCutoutSize.x, 0]) {
            rotate(180)
                fillet(auxiliaryFanWiringCutoutFillet);
            translate([0, auxiliaryFanWiringCutoutSize.y])
                rotate(90)
                    fillet(auxiliaryFanWiringCutoutFillet);
        }
    }
}

module baseCoverDxf(size) {
    sheet = BaseCover;
    fillet = 1.5;

    color(sheet_colour(sheet))
        difference() {
            sheet_2D(sheet, size.x, size.y, fillet);
            baseCoverCutouts(size, fillet, cnc=true);
        }
}

module Base_Cover_210_dxf() {
    dxf("Base_Cover_210")
        baseCoverDxf(baseCoverTopSize);
}

module Base_Cover_220_dxf() {
    dxf("Base_Cover_220")
        baseCoverDxf(baseCoverTopSize);
}

module baseCoverStl(size) {
    fillet = 2;

    linear_extrude(size.z)
        difference() {
            rounded_square([size.x, size.y], fillet);
            baseCoverCutouts(size, fillet, cnc=false);
        }
}

module baseCoverFrontStl(size) {
    fillet = 2;
    overlapSize = [size.x, 10, 1.5];

    linear_extrude(size.z)
        difference() {
            translate([-size.x/2, -size.y/2])
                rounded_square([size.x, size.y/2 - overlapSize.y/2], fillet, center=false);
            baseCoverCutouts(size, fillet, cnc=false);
        }
    translate_z(size.z - overlapSize.z)
        difference() {
            translate([-size.x/2, -overlapSize.y/2 - 2*fillet, 0])
                rounded_cube_xy([size.x, overlapSize.y + 2*fillet, overlapSize.z], fillet, xy_center=false);
            for (x = [holeOffset - size.x/2, 0, size.x/2 - holeOffset])
                translate([x, 0, 0])
                    boltHoleM3(overlapSize.z);
        }
}

module baseCoverBackStl(size) {
    fillet = 2;
    overlapSize = [size.x, 10, size.z - 1.5]; // complementary size to baseCoverFront overlap

    linear_extrude(size.z)
        difference() {
            translate([-size.x/2, overlapSize.y/2])
                rounded_square([size.x, size.y/2 - overlapSize.y/2], fillet, center=false);
            baseCoverCutouts(size, fillet, cnc=false);
        }
    difference() {
        translate([-size.x/2, -overlapSize.y/2, 0])
            rounded_cube_xy([size.x, overlapSize.y + 2*fillet, overlapSize.z], fillet, xy_center=false);
        for (x = [holeOffset - size.x/2, 0, size.x/2 - holeOffset])
            translate([x, 0, 0])
                boltHoleM3Tap(overlapSize.z);
    }
}

module Base_Cover_210_stl() {
    stl("Base_Cover_210")
        color(grey(30))
            baseCoverStl(baseCoverTopSize);
}

module Base_Cover_220_stl() {
    stl("Base_Cover_220")
        color(grey(30))
            baseCoverStl(baseCoverTopSize);
}


module Base_Cover_Front_220_stl() {
    stl("Base_Cover_Front_220")
        color(grey(30))
            vflip()
                baseCoverFrontStl(baseCoverTopSize);
}


module Base_Cover_Back_220_stl() {
    stl("Base_Cover_Back_220")
        color(grey(40))
            baseCoverBackStl(baseCoverTopSize);
}

module baseCoverFrontSupportsAssembly() {
    translate([eX + eSize - baseCoverFrontSupportSize.x, eSize, supportHeight])
        rotate([-90, 0, 0]) {
            color(pp1_colour)
                if (eX == 300)
                    Base_Cover_Front_Support_190_stl();
                else
                    Base_Cover_Front_Support_200_stl();
            Base_Cover_Front_Support_hardware();
        }
}

module baseCoverBackSupportsAssembly() {
    translate([eX + eSize - baseCoverBackSupportSize.x, eY + eSize, 3*eSize]) {
        color(pp2_colour)
            if (eX == 300)
                Base_Cover_Back_Support_210_stl();
            else
                Base_Cover_Back_Support_220_stl();
        Base_Cover_Back_Support_hardware();
    }
}

module baseCoverLeftSideSupportsAssembly() {
    size = baseCoverLeftSideSupportSize;
    translate([eX + eSize - baseCoverBackSupportSize.x, eSize, size.z])
        rotate([0, 90, 0]) {
            color(pp2_colour)
                if (eX == 300)
                    Base_Cover_Left_Side_Support_150A_stl();
                else
                    Base_Cover_Left_Side_Support_175A_stl();
            for (x = [size.z/4, 3*size.z/4])
                translate([x, size.y, 0])
                    vflip()
                        boltM3Buttonhead(size.x);
            Base_Cover_Left_Side_Support_hardware();
        }
    translate([eX + eSize - baseCoverBackSupportSize.x + size.x, eSize + 2*size.y, size.z])
        rotate([180, 90, 0]) {
            color(pp1_colour)
                if (eX == 300)
                    Base_Cover_Left_Side_Support_150B_stl();
                else
                    Base_Cover_Left_Side_Support_175B_stl();
            Base_Cover_Left_Side_Support_hardware();
        }
}

module baseCoverTopSupportsAssembly() {
    translate([eX - baseCoverBackSupportSize.x, eSize, supportHeight])
        Base_Cover_Top_stl();
}

module baseCoverSupportsAssembly() {
    baseCoverFrontSupportsAssembly();
    baseCoverBackSupportsAssembly();
    baseCoverLeftSideSupportsAssembly();
}

module baseFanMountHolePositions(size, z=0) {
    for (x = [eSize/2, size.x - eSize/2], y = [eSize/2,  size.y - eSize/2])
        translate([x, y, z])
            rotate(exploded() ? 0 : 90)
                children();

}

module baseFanPosition(size, offsetX=0, z=0) {
    translate([offsetX > 0 ? offsetX : size.x + offsetX, size.y/2 - 2.5, z])
        children();
}

module baseFanMount(sizeX, offsetX=0, fan=fan40x11, support=false) {
    size = [sizeX, iecHousingMountSize(eX).y, 3];
    fillet = 2;

    difference() {
        linear_extrude(size.z)
            difference() {
                rounded_rectangle([size.x, size.y], fillet, xy_center=false);
                if (!fan)
                    baseFanPosition(size, offsetX, size.z/2)
                        psu_grill(40, 40, grill_hole=2.5, grill_gap=1.5, fn=6, avoid=[]);
            }
        if (fan)
            baseFanPosition(size, offsetX, size.z/2)
                fan_holes(fan, h=size.z + 2*eps);
        baseFanMountHolePositions(size)
            boltHoleM4(size.z);
    }
    if (support)
        difference() {
            supportSize = [25, 5, eSize + 10];
            translate([size.x - supportSize.x - 5, size.y - eSize - supportSize.y, -supportSize.z])
                rounded_cube_xy(supportSize, 1.5);
            translate([eSize + 3*baseCoverLeftSideSupportSize.y/4, size.y - eSize - supportSize.y, - 24])
                rotate([-90, 0, 0])
                    boltHoleM3Tap(supportSize.y, horizontal=true);
        }
}

module Base_Fan_Mount_120A_stl() {
    stl("Base_Fan_Mount_120A")
        color(pp3_colour)
            vflip() // better orientation for printing
                baseFanMount(120, 50, fan=false, support=true);
}

module Base_Fan_Mount_145A_stl() {
    stl("Base_Fan_Mount_145A")
        color(pp3_colour) {
            vflip() // better orientation for printing
                baseFanMount(145, 50, fan=false, support=true);
        }
}

module Base_Fan_Mount_170A_stl() {
    stl("Base_Fan_Mount_170A")
        color(pp3_colour) {
            vflip() // better orientation for printing
                baseFanMount(170, 50, fan=false, support=true);
        }
}

module Base_Fan_Mount_120B_stl() {
    stl("Base_Fan_Mount_120B")
        color(pp2_colour)
            vflip() // better orientation for printing
                baseFanMount(120, -40);
}

module Base_Fan_Mount_145B_stl() {
    stl("Base_Fan_Mount_145B")
        color(pp2_colour)
            vflip() // better orientation for printing
                baseFanMount(145, -40);
}

module baseFanMountAssembly() {
    sizeA = [eX==300 ? 120 : 170, iecHousingMountSize(eX).y, 3];
    sizeB = [120, iecHousingMountSize(eX).y, 3];
    fan = fan40x11;

    translate([eX + 2*eSize, 0, 0])
        rotate([90, 0, 90]) 
            explode(75, true) {
                color(pp3_colour)
                    vflip()
                        if (eX == 300)
                            Base_Fan_Mount_120A_stl();
                        else
                            Base_Fan_Mount_170A_stl();
                baseFanMountHolePositions(sizeA, sizeA.z)
                    boltM4ButtonheadHammerNut(8);
                /*baseFanPosition(sizeA, 50, sizeA.z/2 - fan_thickness(fan)) {
                    explode(-15)
                        fan(fan);
                    fan_hole_positions(fan) {
                        translate_z(sizeA.z)
                            boltM3Buttonhead(16);
                        translate_z(-sizeA.z - fan_thickness(fan))
                            explode(-30)
                                nutM3();
                    }
                }*/
        }
    translate([eX + 2*eSize, sizeA.x, 0])
        rotate([90, 0, 90])
            explode(150, true) {
                color(pp2_colour)
                    vflip()
                        Base_Fan_Mount_120B_stl();
                baseFanMountHolePositions(sizeB, sizeB.z)
                    boltM4ButtonheadHammerNut(8);
                baseFanPosition(sizeB, -40, sizeB.z/2 - fan_thickness(fan)) {
                    explode(-15)
                        fan(fan);
                    fan_hole_positions(fan) {
                        translate_z(sizeB.z)
                            boltM3Buttonhead(16);
                        translate_z(-sizeB.z - fan_thickness(fan))
                            explode(-30)
                                nutM3();
                    }
                }
            }
}

