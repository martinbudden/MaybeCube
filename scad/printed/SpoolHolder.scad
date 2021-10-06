include <../global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

include <../vitamins/bolts.scad>
use <../vitamins/nuts.scad>

use <../../../BabyCube/scad/printed/SpoolHolder.scad>

include <../Parameters_Main.scad>


function spoolOffset() = [3, 0, 7];

module Spool_Holder_stl() {
    stl("Spool_Holder")
        color(pp2_colour)
            spoolHolder(bracketSize=[5, 2*eSize-10, 20], offsetX=spoolOffset().x, catchRadius=2);
}

module Spool_Holder_Bracket_stl() {
    size = [3*eSize, 1.5*eSize, 10];
    fillet = 2;
    thickness = 5;
    catchRadius = 2;
    catchLength = eSize + 1;

    stl("Spool_Holder_Bracket")
        color(pp1_colour)
            translate([-size.x/2, 0, 0])
                difference() {
                    union() {
                        rounded_cube_xy([size.x, size.y, thickness], fillet);
                        sideSize = [eSize - 0.25, size.y, size.z];
                        for (x = [0, size.x - sideSize.x])
                            translate([x, 0, 0])
                                rounded_cube_xy(sideSize, fillet);
                    }
                    for (x = [eSize/2, size.x - eSize/2])
                        translate([x, eSize/2, 0])
                            boltHoleM4HangingCounterboreButtonhead(size.z, boreDepth=size.z - 5);
                    offset = 0.1;
                    translate([size.x/2, size.y - catchRadius - offset, 0])
                        rotate([0, 90, 0])
                             hull() {
                                cylinder(r=catchRadius, h=catchLength, center=true);
                                translate([-catchRadius, 0, -catchLength/2])
                                    cube([catchRadius, catchRadius + offset + eps, catchLength]);
                            }

                }
}

module Spool_Holder_Bracket_hardware() {
    size = [3*eSize, 1.5*eSize, 10];

    for (x = [eSize/2, size.x - eSize/2])
        translate([x - size.x/2, eSize/2, size.z - 5])
            vflip()
                boltM4ButtonheadHammerNut(!is_undef(_useSidePanels) && _useSidePanels ? 12 : _frameBoltLength);
}

//use <NopSCADlib/utils/fillet.scad>
//include <NopSCADlib/vitamins/spools.scad>

//include <../vitamins/nuts.scad>
//include <../vitamins/bolts.scad>

//include <../Parameters_Main.scad>

/*module spoolHolderCap(eSize, length=80) {
    radius = eSize*sin(45);
    x = radius*sin(45);
    translate([0, -x, 0])
        linear_extrude(length)
            difference() {
                circle(r=radius);
                translate([-eSize, -2*x])
                    square([2*eSize, 3*x]);
            }
}
//function spoolHolderSize() = [20, 40, 115];


module spoolHolderBracket(eSize, bracketThickness) {
    topThickness = bracketThickness + 2;
    difference() {
        cube([eSize, eSize, bracketThickness]);
        translate([eSize, 0, 0])
            rotate([0, -90, 0])
                fillet(1, eSize);
        translate([0, 0, bracketThickness])
            rotate([0, 90, 0])
                fillet(1, eSize);
    }
    translate([0, 0, eSize+bracketThickness])
        difference() {
            cube([eSize, eSize, bracketThickness]);
            translate([eSize, 0, 0])
                rotate([0, -90, 0])
                    fillet(1, eSize);
    }
    translate([0, eSize, 0])
        difference() {
            cube([eSize, topThickness, eSize + 2*bracketThickness]);
            //translate([eSize/2, topThickness + eps, eSize/2+bracketThickness])
                //rotate([90, -90, 0])
                    //boltHoleM4(bracketThickness);
                    //vertical_tearslot(bracketThickness + 2 + 2*eps, M4_clearance_radius, center=false, chamfer=0.5);
            translate([0, topThickness, 0])
                rotate([0, -90, 180])
                    fillet(1, eSize);
        }
    translate([0, eSize+topThickness, eSize+bracketThickness])
        rotate([0, 90, 0])
            fillet(2, eSize);
}

module Spool_Holder_stl() {
    stl("Spool_Holder");

    bracketThickness = 5;
    color(pp1_colour) rotate([0, 90, 0]) {
        spoolHolderBracket(eSize, bracketThickness);
        translate_z(eSize + bracketThickness) {
            length = 90;
            translate([0, eSize, 0])
                cube([eSize, bracketThickness, length]);
            translate([eSize/2, eSize+bracketThickness, 0])
                spoolHolderCap(eSize, length);
            translate([0, eSize, bracketThickness])
                rotate([0, -90, 180])
                    //rightTriangle3d([length-bracketThickness, eSize, eSize]);
                    right_triangle(length - bracketThickness, eSize, eSize, center=false);
            endHeight = 15;
            for (z=[0, length-bracketThickness])
                translate([0, eSize+bracketThickness, z])
                    cube([eSize, endHeight, bracketThickness]);
            for (z=[0, length-bracketThickness])
                translate([eSize/2, eSize+bracketThickness + endHeight, z])
                    spoolHolderCap(eSize, bracketThickness);
        }
    }
    thumbScrewLength = 12;
    *if ($preview)
        translate([15, eSize+bracketThickness + 2, -spoolHolderSize().x/2])
            rotate([90, 0, 0]) {
                explode(-40)
                    boltM4Thumbscrew(thumbScrewLength);
                explode(10)
                    translate_z(thumbScrewLength-5)
                        nutM4Hammer();
            }
}
*/
