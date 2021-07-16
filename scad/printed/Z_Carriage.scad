include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/bearing_blocks.scad>
include <NopSCADlib/vitamins/leadnuts.scad>
include <NopSCADlib/vitamins/linear_bearings.scad>

use <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


_useSCSBearingBlocksForZAxis = true;

scsType = _zRodDiameter == 8 ? SCS8LUU : _zRodDiameter == 10 ? SCS10LUU : SCS12LUU;
baseSize = [scs_size(scsType).x + 1, scs_size(scsType).z, _zCarriageSCS_sizeZ];
shelfThickness = 5;
tabRightLength = 9.5;
//tabRightLength = 20.5; // use 20.5 for alignment with internal corner bracket
boltOffset = 26;
leadnut = LSN8x2;
leadnutInset = leadnut_flange_t(leadnut);

function printBedFrameCrossPieceOffset() = baseSize.x/2 + tabRightLength;// + 9.75;

holes = [for (i=[ [-1, 1], [1, 1], [-1, -1], [1, -1] ]) [i.x*scs_screw_separation_x(scsType)/2, i.y*scs_screw_separation_z(scsType)/2, baseSize.z] ];


module zCarriageSCS(cnc=false) {
    shelfExtension = tabRightLength;

    translate_z(scs_hole_offset(scsType)) {
        fillet = 2;
        uprightFillet = 1;
        // the base
        difference() {
            linear_extrude(baseSize.z, convexity=2) {
                translate([-baseSize.x/2, -baseSize.y/2])
                    rounded_square([baseSize.x + 1, baseSize.y], fillet, center=false);
                difference() {
                    union() {
                        if (tabRightLength > shelfExtension + 1)
                            translate([baseSize.x/2 + shelfExtension, baseSize.y/2 - eSize])
                                rotate(-90)
                                    fillet(1);
                        translate([baseSize.x/2 - 2*fillet, baseSize.y/2 - eSize])
                            rounded_square([tabRightLength + 2*fillet, eSize], fillet, center=false);
                        hull() {
                            translate([baseSize.x/2 - 2*fillet, baseSize.y/2 - eSize - shelfThickness]) {
                                rounded_square([shelfExtension + 2*fillet, eSize + shelfThickness], uprightFillet, center=false);
                                translate([0, -shelfExtension + shelfThickness])
                                    circle(r=fillet + 1);
                            }
                        }
                    }
                    translate([boltOffset, scs_screw_separation_z(scsType)/2])
                        poly_circle(r=M4_clearance_radius);
                }
                /*tabLeftLength = 10;
                difference() {
                    hull()
                        translate([-baseSize.x/2 - tabLeftLength, baseSize.y/2 - eSize - shelfThickness]) {
                            rounded_square([tabLeftLength + 3*fillet, eSize + shelfThickness], fillet, center=false);
                            translate([tabLeftLength + 3*fillet, -tabLeftLength - shelfThickness])
                                circle(r=fillet + 1);
                        }

                    translate([-baseSize.x/2 - tabLeftLength + 5, scs_screw_separation_z(scsType)/2])
                        circle(r=M4_clearance_radius);
                }*/
            }
            translate(holes[0])
                vflip() {
                    //boltHoleM5(baseSize.z);
                    boltPolyholeM5Countersunk(baseSize.z, sink=0.25);
                }
            for (i = [1, 2, 3])
                translate(holes[i])
                    vflip()
                        boltPolyholeM5Countersunk(baseSize.z, sink=0.25);
        }
        // add the shelf
        if (!cnc)
            translate([-baseSize.x/2, baseSize.y/2 - eSize - shelfThickness, 0])
                difference() {
                    rounded_cube_xy([baseSize.x + shelfExtension, shelfThickness, eSize + baseSize.z], uprightFillet);
                    translate([10, 0, baseSize.z + eSize/2])
                        rotate([-90, 180, 0])
                            boltHoleM4(shelfThickness, horizontal=true);
                }
    }
}

module zCarriageSCS_hardware(cnc=false) {
    translate_z(scs_hole_offset(scsType)) {
        translate([boltOffset, scs_screw_separation_z(scsType)/2, 0])
            vflip()
                boltM4ButtonheadTNut(_frameBoltLength, 3.25);
        if (!cnc)
            translate([10 - baseSize.x/2, baseSize.y/2 - eSize -shelfThickness, baseSize.z + eSize/2])
                rotate([-90, 0, 0])
                    vflip()
                        boltM4ButtonheadTNut(_frameBoltLength);

        //translate(holes[0] + [0, 0, 2])
        //    boltM5Buttonhead(12);
        for (i = [0, 1, 2, 3])
            translate(holes[i])
                explode(20, true)
                    boltM5Countersunk(12);
    }
}

module Z_Carriage_Left_stl() {
    stl("Z_Carriage_Left")
        color(pp1_colour)
            mirror([0, 1, 0])
                zCarriageSCS();
}

module Z_Carriage_Right_stl() {
    stl("Z_Carriage_Right")
        color(pp1_colour)
            zCarriageSCS();
}


//!1. Bolt the SCS bearing block to the **Z_Carriage_Left**.
//!2. Add the bolts and t-nuts in preparation for connection to the printbed.
//
module Z_Carriage_Left_assembly() pose(a=[55 + 40, 0, 25 + 180])
assembly("Z_Carriage_Left", ngb=true) {

    translate_z(-scs_screw_separation_z(scsType)/2) {
        rotate([-90, 0, 90]) {
            stl_colour(pp1_colour)
                Z_Carriage_Left_stl();
            mirror([0, 1, 0])
                zCarriageSCS_hardware();
        }
        explode([30, 0, 0])
            rotate(-90)
                scs_bearing_block(scsType);
    }
}

//!1. Bolt the SCS bearing block to the **Z_Carriage_Right**.
//!2. Add the bolts and t-nuts in preparation for connection to the printbed.
//
module Z_Carriage_Right_assembly()
assembly("Z_Carriage_Right", ngb=true) {

    translate_z(-scs_screw_separation_z(scsType)/2) {
        rotate([90, 0, 90]) {
            stl_colour(pp1_colour)
                Z_Carriage_Right_stl();
            zCarriageSCS_hardware();
        }
        explode([-30, 0, 0])
            rotate(90)
                scs_bearing_block(scsType);
    }
}

module zCarriageCenter() {
    baseThickness = 5;
    size = [30, printBedFrameCrossPieceOffset() + 15, eSize + baseThickness];
    tabSize = [size.x + 20, 5, size.z];
    fillet = 2;

    translate_z(-eSize/2 - baseThickness)
        difference() {
            translate([-size.x/2, printBedFrameCrossPieceOffset() - size.y, 0])
                rounded_cube_xy(size, fillet);
            translate_z(-leadnut_flange_t(leadnut))
                leadnut_screw_positions(leadnut)
                    boltHoleM3Tap(size.z);
            translate_z(-eps) {
                poly_cylinder(r=leadnut_od(leadnut)/2, h=size.z + 2*eps);
                if (baseThickness == 0)
                    poly_cylinder(r=leadnut_flange_dia(leadnut)/2, h=leadnutInset + eps);
            }
        }
    translate([-tabSize.x/2, printBedFrameCrossPieceOffset() - tabSize.y, 0]) {
        difference() {
            translate_z(-eSize/2 - baseThickness)
                rounded_cube_xy(tabSize, 1);
            for (x = [5, tabSize.x -5])
                translate([x, 0, 0])
                    rotate([90, 0, 180])
                        boltHoleM4(tabSize.y, horizontal=true);
        }
        difference() {
            translate_z(-eSize/2 - baseThickness)
                rounded_cube_xy([tabSize.x, eSize + 5, baseThickness], 1);
            for (x = [5, tabSize.x -5])
                translate([x, eSize/2 + 5, -eSize/2 - baseThickness])
                    boltHoleM4(tabSize.y);
        }
    }
}

module Z_Carriage_Center_hardware() {
    baseThickness = 5;
    tabSize = [50, 5, eSize];

    vflip() {
        explode(25, true)
            translate_z(eSize/2 + baseThickness + eps) {
                brassColor = "#B5A642";
                color(brassColor)
                    leadnut(leadnut);
                leadnut_screw_positions(leadnut)
                    screw(leadnut_screw(leadnut), 8);
            }
        for (x = [5, tabSize.x -5])
            translate([x - tabSize.x/2, tabSize.y - printBedFrameCrossPieceOffset(), 0]) {
                rotate([-90, 0, 0])
                    boltM4ButtonheadTNut(_frameBoltLength);
                translate([0, -eSize/2 - 5, eSize/2 + baseThickness])
                    boltM4ButtonheadTNut(_frameBoltLength);
            }
    }
}

module Z_Carriage_Center_stl() {
    stl("Z_Carriage_Center")
        color(pp2_colour)
            zCarriageCenter();
}

module Z_Carriage_Center_assembly()
assembly("Z_Carriage_Center", ngb=true) {

    stl_colour(pp2_colour)
        Z_Carriage_Center_stl();
    Z_Carriage_Center_hardware();
}
