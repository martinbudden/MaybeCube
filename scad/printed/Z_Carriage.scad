include <../global_defs.scad>

include <../vitamins/bolts.scad>

use <NopSCADlib/utils/fillet.scad>
include <NopSCADlib/vitamins/bearing_blocks.scad>
include <NopSCADlib/vitamins/leadnuts.scad>
include <NopSCADlib/vitamins/linear_bearings.scad>

include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


_useSCSBearingBlocksForZAxis = true;

scsType = _zRodDiameter == 8 ? SCS8LUU : _zRodDiameter == 10 ? SCS10LUU : SCS12LUU;
baseSize = [scs_size(scsType).x, scs_size(scsType).z - eSize, 5];
shelfThickness = 5;
function zCarriageTab() = false;
useTab = zCarriageTab();
tabRightLength = useTab ? 9.5 : 0;
//tabRightLength = 20.5; // use 20.5 for alignment with internal corner bracket
boltOffset = 26;
leadnut = LSN8x2;
leadnutInset = leadnut_flange_t(leadnut);

function printbedFrameCrossPieceOffset() = baseSize.x/2 + tabRightLength + (useTab ? 0 : 1);// + 9.75;

holes = [for (i=[ [-1, 1], [1, 1], [-1, -1], [1, -1] ]) [i.x*scs_screw_separation_x(scsType)/2, i.y*scs_screw_separation_z(scsType)/2, baseSize.z] ];


module zCarriageSCS(cnc=false) {
    shelfExtension = tabRightLength;

    translate_z(scs_hole_offset(scsType)) {
        fillet = 2;
        uprightFillet = 1;
        // the base
        difference() {
            linear_extrude(baseSize.z, convexity=2) {
                translate([-baseSize.x/2, -baseSize.y/2 -eSize/2])
                    rounded_square([baseSize.x, baseSize.y], fillet, center=false);
                if (useTab)
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
                        if (useTab)
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
            for (i = [0, 1])
                translate(holes[i])
                    vflip()
                        if (useTab)
                            boltPolyholeM5Countersunk(baseSize.z, sink=0.25);
                        else
                            boltHoleM5(baseSize.z);
            for (i = [2, 3])
                translate(holes[i])
                    vflip()
                        boltPolyholeM5Countersunk(baseSize.z, sink=0.25);
        }
        // add the shelf
        if (!cnc)
            translate([-baseSize.x/2, baseSize.y/2 - eSize/2 - shelfThickness, 0])
                difference() {
                    sizeX = baseSize.x + shelfExtension;
                    rounded_cube_xy([sizeX, shelfThickness, eSize], uprightFillet);
                    for (x = useTab ? [10] : [sizeX/4, 3*sizeX/4])
                        translate([x, 0, eSize/2])
                            rotate([-90, 180, 0])
                                boltHoleM4(shelfThickness, horizontal=true);
                }
    }
}

module zCarriageSCS_hardware(sideSupports=true, cnc=false) {
    translate_z(scs_hole_offset(scsType)) {
        if (useTab)
            translate([boltOffset, scs_screw_separation_z(scsType)/2, 0])
                vflip()
                    boltM4ButtonheadTNut(_frameBoltLength, 3.25);
        if (sideSupports && !cnc) {
            sizeX = baseSize.x + tabRightLength;
            for (x = useTab ? [(10 - baseSize.x/2)] : [-sizeX/4, sizeX/4])
               translate([x, baseSize.y/2 - eSize/2 -shelfThickness, eSize/2])
                    rotate([-90, 0, 180])
                        boltM4ButtonheadTNut(_frameBoltLength);
        }

        for (i = [0, 1])
            translate(holes[i])
                explode(20, true)
                    if (useTab)
                        boltM5Countersunk(12);
                    else
                        translate_z(2 - baseSize.z) // offset for extrusion channel
                            boltM5Buttonhead(10);
        if (sideSupports)
            for (i = [2, 3])
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

module Z_Carriage_Side_stl() {
    stl("Z_Carriage_Side")
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
                zCarriageSCS_hardware(sideSupports=true);
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
            zCarriageSCS_hardware(sideSupports=true);
        }
        explode([-30, 0, 0])
            rotate(90)
                scs_bearing_block(scsType);
    }
}


module zCarriageSideAssembly(sideSupports=true) {
    if (sideSupports) {
        Z_Carriage_Side_assembly();
    } else {  
        rotate(_invertedZRods ? 180 : 0)
            translate_z(-scs_screw_separation_z(scsType)/2) {
                rotate([90, 0, 90])
                    zCarriageSCS_hardware(sideSupports);
                explode([-30, 0, 0])
                    rotate(90)
                        scs_bearing_block(scsType);
            }
    }
}
//!1. Bolt the SCS bearing block to the **Z_Carriage**.
//!2. Add the bolts and t-nuts in preparation for connection to the printbed.
//
module Z_Carriage_Side_assembly()
assembly("Z_Carriage_Side", ngb=true) {

    rotate(_invertedZRods ? 180 : 0)
        translate_z(-scs_screw_separation_z(scsType)/2) {
            rotate([90, 0, 90]) {
                stl_colour(pp1_colour)
                    Z_Carriage_Side_stl();
                zCarriageSCS_hardware();
            }
            explode([-30, 0, 0])
                rotate(90)
                    scs_bearing_block(scsType);
        }
}

module leadnut_screw_positions_i(type) { //! Position children at the screw holes
    holes = leadnut_holes(type);
    flat = leadnut_flat(type);
    angles = flat ? [let(h = holes / 2, a = 90 / (h - 1)) for(i = [0 : h - 1], side = [-1, 1]) side * (45 + i * a)]
                  : [for(i = [0 : holes - 1]) i * 360 / holes + 180];
    for($i = angles)
        rotate($i)
            translate([leadnut_hole_pitch(type), 0, leadnut_flange_t(type)])
                children();
}

module zCarriageCenter() {
    baseThickness = 5;
    size = [30, printbedFrameCrossPieceOffset() + 15, eSize + baseThickness];
    tabSize = [size.x + 20, 5, size.z];
    fillet = 2;

    translate_z(-eSize/2 - baseThickness)
        difference() {
            translate([-size.x/2, printbedFrameCrossPieceOffset() - size.y, 0])
                rounded_cube_xy(size, fillet);
            translate_z(-leadnut_flange_t(leadnut))
                leadnut_screw_positions_i(leadnut) {
                    if ($i == 180 || $i == 360)
                        boltHoleM3(size.z);
                    else
                        boltHoleM3Tap(size.z);
                }
            translate_z(-eps) {
                tolerance = 0.2;
                poly_cylinder(r=leadnut_od(leadnut)/2 + tolerance, h=size.z + 2*eps);
                if (baseThickness == 0)
                    poly_cylinder(r=leadnut_flange_dia(leadnut)/2 + tolerance, h=leadnutInset + eps);
            }
        }
    translate([-tabSize.x/2, printbedFrameCrossPieceOffset() - tabSize.y, 0]) {
        difference() {
            translate_z(-eSize/2 - baseThickness)
                rounded_cube_xy(tabSize, 1);
            for (x = [5, tabSize.x - 5])
                translate([x, 0, 0])
                    rotate([90, 0, 180])
                        boltHoleM4(tabSize.y, horizontal=true);
        }
        difference() {
            translate_z(-eSize/2 - baseThickness)
                rounded_cube_xy([tabSize.x, eSize + 5, baseThickness], 1);
            translate([tabSize.x/2, eSize/2 + 5, -eSize/2 - baseThickness])
                boltHoleM4(tabSize.y);
        }
    }
}

module Z_Carriage_Center_hardware() {
    baseThickness = 5;
    tabSize = [50, 5, eSize];

    vflip() {
        explode(25, true) {
            brassColor = "#B5A642";
            translate_z(eSize/2 + baseThickness + eps)
                color(brassColor)
                    leadnut(leadnut);
            translate_z(-leadnut_flange_t(leadnut) - eSize/2)
                leadnut_screw_positions_i(leadnut)
                    if ($i == 180 || $i == 360)
                        vflip()
                            screw(leadnut_screw(leadnut), 30);
        }
        for (x = [5, tabSize.x - 5])
            translate([x - tabSize.x/2, tabSize.y - printbedFrameCrossPieceOffset(), 0])
                rotate([-90, 0, 0])
                    boltM4ButtonheadTNut(_frameBoltLength);
        translate([0, tabSize.y - printbedFrameCrossPieceOffset() - eSize/2 - 5, eSize/2 + baseThickness])
            boltM4ButtonheadTNut(_frameBoltLength);
    }
}

module Z_Carriage_Center_stl() {
    stl("Z_Carriage_Center")
        color(pp3_colour)
            zCarriageCenter();
}

//!1. Bolt the leadscrew nut to the **Z_Carriage_Center**.
//!2. Add the bolts and t-nuts in preparation for later attachment to the printbed frame.
module Z_Carriage_Center_assembly()
assembly("Z_Carriage_Center", ngb=true) {

    stl_colour(pp3_colour)
        Z_Carriage_Center_stl();
    Z_Carriage_Center_hardware();
}
