include <../global_defs.scad>

use <NopSCADlib/utils/fillet.scad>
use <NopSCADlib/vitamins/sheet.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/fans.scad>
include <NopSCADlib/printed/drag_chain.scad>

include <../vitamins/bolts.scad>
include <../vitamins/nuts.scad>

use <extruderBracket.scad> // for iecHousingMountSize()
use <WiringGuide.scad>

include <../Parameters_Main.scad>
include <../Parameters_Positions.scad>

supportHeight = 70;
holeOffset = 20;
chainAnchorOffset = 160;
baseCoverTopSize = [eX > 300 ? 250 : 210, eY + eSize, 3];
baseCoverBackSupportSize = [baseCoverTopSize.x, eSize, supportHeight - 2*eSize];
baseCoverSideSupportSize = [8, eY/2, supportHeight];
baseCoverFrontSupportSize = [baseCoverTopSize.x - baseCoverSideSupportSize.x, 12, 3*eSize/2];


module chainAnchorHolePositions(size, offset=chainAnchorOffset) {
    chainOffset = size.x - offset;
    for (z = [0, 8])
        translate([chainOffset, -5 + 10, size.z + z + 7])
            children();
}

module baseCoverBackSupport(size, offset=chainAnchorOffset) {
    chainOffset = size.x - offset;
    cutoutSize = [7, 10, 15];
    fillet = 1.5;
    chainAnchorSize = [8, size.y + 5, size.z + 22];
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
                        fillet(fillet, size.z - cutoutSize.z);
                translate([chainAnchorSize.x, -size.y + chainAnchorSize.y, 0])
                    rotate(-90)
                        fillet(fillet, size.z);
            }
        }
        translate([chainOffset - cutoutSize.x, -fillet, size.z - cutoutSize.z + eps])
            rounded_cube_xy([cutoutSize.x, cutoutSize.y + fillet, cutoutSize.z], fillet);
        translate([chainOffset - cutoutSize.x, 0, size.z - cutoutSize.z + eps])
            rotate(90)
                fillet(fillet, cutoutSize.z);
        chainAnchorHolePositions(size)
            rotate([0, 90, 0])
                boltHoleM3Tap(chainAnchorSize.x);
        for (x = [holeOffset, size.x/2, size.x - holeOffset])
            translate([x, size.y/2, size.z])
                vflip()
                    boltHoleM3Tap(10);
        for (x = [50, 3*size.x/4])
            translate([x, size.y/2, size.z])
                vflip()
                    boltHoleM3Counterbore(size.z, boreDepth = size.z - 5);
    }
}

module Base_Cover_Back_Support_hardware(chain=true, offset=chainAnchorOffset) {
    size = baseCoverBackSupportSize;
    for (x = [50, 3*size.x/4])
        translate([x, size.y/2, 5])
            explode(30, true)
                boltM3ButtonheadHammerNut(8, nutExplode=50);
    chainAnchorHolePositions(size)
        rotate([0, -90, 0])
            translate_z(2)
                boltM3Countersunk(8);
    if (chain && $preview) {
        dragChainSize = [15, 10.5, 10];
        travel = 215;
        drag_chain = drag_chain("x", dragChainSize, travel=travel, wall=1.5, bwall=1.5, twall=1.5);
        translate([size.x - offset + 40, 5, 2*eSize + size.z -15])
            rotate([0, -90, 0])
                color(grey(25))
                    not_on_bom()
                        drag_chain_assembly(drag_chain, pos=(zPos($t) - 80), radius=0);
    }
}

module Base_Cover_Back_Support_210_stl() {
    stl("Base_Cover_Back_Support_210")
        color(pp1_colour) 
            baseCoverBackSupport(baseCoverBackSupportSize);
}

module Base_Cover_Back_Support_250_stl() {
    stl("Base_Cover_Back_Support_250")
        color(pp1_colour) 
            baseCoverBackSupport(baseCoverBackSupportSize);
}

module baseCoverFrontSupport(size) {
    x1 = holeOffset - baseCoverSideSupportSize.x;
    fillet = 1;
    difference() {
        rounded_cube_xy([size.x, size.z, 3], fillet);
        for (x = [x1, baseCoverTopSize.x/2 - 8, size.x - holeOffset])
            translate([x, 20, 0])
                boltHoleM3(3);
    }
    difference() {
        rounded_cube_xy([size.x, 5, size.y], fillet);
        for (x = [x1, baseCoverTopSize.x/2 - 8, size.x - holeOffset])
            translate([x, 0, 7.5])
                rotate([-90, 180, 0])
                    boltHoleM3(5, horizontal=true);
    }
}

module Base_Cover_Front_Support_hardware() {
    size = baseCoverFrontSupportSize;
    for (x = [holeOffset - baseCoverSideSupportSize.x, baseCoverTopSize.x/2 - 8, size.x - holeOffset])
        translate([x, 20, 3])
            explode(30, true)
                boltM3ButtonheadHammerNut(8, nutExplode=40);
}

module Base_Cover_Front_Support_202_stl() {
    stl("Base_Cover_Front_Support_202")
        color(pp2_colour)
            baseCoverFrontSupport(baseCoverFrontSupportSize);
}
module Base_Cover_Front_Support_242_stl() {
    stl("Base_Cover_Front_Support_242")
        color(pp2_colour)
            baseCoverFrontSupport(baseCoverFrontSupportSize);
}

module baseCoverSideSupport(size, tap=false) {
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

module Base_Cover_Side_Support_150A_stl() {
    stl("Base_Cover_Side_Support_150A")
        color(pp1_colour)
            baseCoverSideSupport(baseCoverSideSupportSize, tap=false);
}

module Base_Cover_Side_Support_150B_stl() {
    stl("Base_Cover_Side_Support_150B")
        color(pp2_colour)
            baseCoverSideSupport(baseCoverSideSupportSize, tap=true);
}

module Base_Cover_Side_Support_175A_stl() {
    stl("Base_Cover_Side_Support_175A")
        color(pp1_colour)
            baseCoverSideSupport(baseCoverSideSupportSize, tap=false);
}

module Base_Cover_Side_Support_175B_stl() {
    stl("Base_Cover_Side_Support_175B")
        color(pp2_colour)
            baseCoverSideSupport(baseCoverSideSupportSize, tap=true);
}

BaseCover = ["BaseCover", "Sheet perspex", 3, pp3_colour, false];

module baseCoverTopHolePositions(size) {
    for (x = [holeOffset, size.x/2, size.x - holeOffset], y = [8 -size.y/2, size.y/2 -10]) {
        translate([x - size.x/2, y, 0])
            children();
    }
    yLeft = baseCoverSideSupportSize.y/4;
    for (y = [yLeft, 3*yLeft, 5*yLeft, 7*yLeft])
        translate([4 -size.x/2, y -size.y/2, 0])
            children();
}

module baseCoverTopAssembly(addBolts=true) {
    size = baseCoverTopSize;

    translate([eX + eSize - size.x/2, eSize + size.y/2, supportHeight + size.z/2]) {
        if (addBolts)
            baseCoverTopHolePositions(size)
                translate_z(size.z/2)
                    boltM3Buttonhead(8);
        render_2D_sheet(BaseCover, w=size.x, d=size.y)
            if (eX == 300)
                Base_Cover_210_dxf();
            else
                Base_Cover_250_dxf();
    }
}

module baseCoverDxf(size) {
    sheet = BaseCover;
    fillet = 1.5;

    color(sheet_colour(sheet))
        difference() {
            sheet_2D(sheet, size.x, size.y, fillet);
            baseCoverTopHolePositions(size)
                circle(r=M3_clearance_radius);
            chainCutoutSize = [15, 24 + 2* fillet];
            translate([size.x/2 - chainAnchorOffset - 7, size.y/2]) {
                translate([0, -chainCutoutSize.y + fillet])
                    rounded_square(chainCutoutSize, fillet, center=false);
                rotate(180)
                    fillet(fillet);
                translate([chainCutoutSize.x, 0])
                    rotate(-90)
                        fillet(fillet);
            }
            wiringGuidePosition = wiringGuidePosition(0, wiringGuideCableOffsetY(), eSize);
            wiringCutoutSize = [8, 26 + 2* fillet];
            translate([size.x/2 - wiringGuidePosition.x - 34, size.y/2]) {
                translate([0, -wiringCutoutSize.y + fillet])
                    rounded_square(wiringCutoutSize, fillet, center=false);
                rotate(180)
                    fillet(fillet);
                translate([wiringCutoutSize.x, 0])
                    rotate(-90)
                        fillet(fillet);
            }
        }
}

module Base_Cover_210_dxf() {
    dxf("Base_Cover_210")
        baseCoverDxf(baseCoverTopSize);
}

module Base_Cover_250_dxf() {
    dxf("Base_Cover_250")
        baseCoverDxf(baseCoverTopSize);
}

module Base_Cover_Top_stl() {
    stl("Base_Cover_Top")
        color(pp3_colour)
            rounded_cube_xy(baseCoverTopSize, 2);
}


module baseCoverFrontSupportsAssembly() {
    translate([eX + eSize - baseCoverFrontSupportSize.x, eSize, supportHeight])
        rotate([-90, 0, 0]) {
            color(pp2_colour)
                if (eX == 300)
                    Base_Cover_Front_Support_202_stl();
                else
                    Base_Cover_Front_Support_242_stl();
            Base_Cover_Front_Support_hardware();
        }
}

module baseCoverBackSupportsAssembly(chain=true) {
    translate([eX + eSize - baseCoverBackSupportSize.x, eY + eSize, 2*eSize]) {
        color(pp1_colour)
            if (eX == 300)
                Base_Cover_Back_Support_210_stl();
            else
                Base_Cover_Back_Support_250_stl();
        Base_Cover_Back_Support_hardware(chain);
    }
}

module baseCoverSideSupportsAssembly() {
    size = baseCoverSideSupportSize;
    translate([eX + eSize - baseCoverBackSupportSize.x + size.x, eSize, 0])
        rotate([0, -90, 0]) {
            color(pp1_colour)
                if (eX == 300)
                    Base_Cover_Side_Support_150A_stl();
                else
                    Base_Cover_Side_Support_175A_stl();
            for (x = [size.z/4, 3*size.z/4])
                translate([x, size.y, 0])
                    vflip()
                        boltM3Buttonhead(size.x);
        }
    translate([eX + eSize - baseCoverBackSupportSize.x, eSize + 2*size.y, 0])
        rotate([180, -90, 0])
            color(pp2_colour)
                if (eX == 300)
                    Base_Cover_Side_Support_150B_stl();
                else
                    Base_Cover_Side_Support_175B_stl();
}

module baseCoverTopSupportsAssembly() {
    translate([eX - baseCoverBackSupportSize.x, eSize, supportHeight])
        Base_Cover_Top_stl();
}

module baseCoverSupportsAssembly() {
    baseCoverFrontSupportsAssembly();
    baseCoverBackSupportsAssembly();
    baseCoverSideSupportsAssembly();
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

module baseFanMount(sizeX, offsetX=0) {
    size = [sizeX, iecHousingMountSize(eX).y, 3];
    fillet = 2;
    fan = fan40x11;

    difference() {
        rounded_cube_xy(size, fillet);
        baseFanPosition(size, offsetX, size.z/2)
            fan_holes(fan, h=size.z + 2*eps);
        baseFanMountHolePositions(size)
            boltHoleM4(size.z);
    }
}

module Base_Fan_Mount_120A_stl() {
    stl("Base_Fan_Mount_120A")
        color(pp3_colour)
            vflip() // better orientation for printing
                baseFanMount(120, 50);
}

module Base_Fan_Mount_145A_stl() {
    stl("Base_Fan_Mount_145A")
        color(pp3_colour) {
            vflip() // better orientation for printing
                baseFanMount(145, 50);
        }
}

module Base_Fan_Mount_170A_stl() {
    stl("Base_Fan_Mount_170A")
        color(pp3_colour) {
            vflip() // better orientation for printing
                baseFanMount(170, 50);
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
            explode(100, true) {
                color(pp3_colour)
                    vflip()
                        if (eX == 300)
                            Base_Fan_Mount_120A_stl();
                        else
                            Base_Fan_Mount_170A_stl();
                baseFanMountHolePositions(sizeA, sizeA.z)
                    boltM4ButtonheadHammerNut(8);
                baseFanPosition(sizeA, 50, sizeA.z/2 - fan_thickness(fan)) {
                    explode(-15)
                        fan(fan);
                    fan_hole_positions(fan) {
                        translate_z(sizeA.z)
                            boltM3Buttonhead(16);
                        translate_z(-sizeA.z - fan_thickness(fan))
                            explode(-30)
                                nutM3();
                    }
            }
        }
    translate([eX + 2*eSize, sizeA.x, 0])
        rotate([90, 0, 90])
            explode(100, true) {
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

