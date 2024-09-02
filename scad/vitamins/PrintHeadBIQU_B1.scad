include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/e3d.scad>
include <NopSCADlib/vitamins/blowers.scad>
include <NopSCADlib/vitamins/microswitches.scad>

include <../vitamins/cables.scad>

include <../config/Parameters_Main.scad>


fan_colour = grey(20);

module fanDuct_BIQU_B1_AirGuide() {
    color(grey(90)) import("../../../stlimport/BIQU_B1_Air guide-0519.STL");
}

module insetCube(size, baseHeight=1.5, color=grey(30), boltLength=6) {
    boltInset = 2;
    cornerInset = 5;
    color(color) {
        linear_extrude(baseHeight)
            difference () {
                rounded_square([size.x, size.y], 1);
                for (x = [-size.x/2 + boltInset, size.x/2 - boltInset], y = [-size.y/2 + boltInset, size.y/2 - boltInset])
                    translate([x, y])
                        circle(d=2);
            }
        translate_z(baseHeight)
            linear_extrude(size.z-baseHeight)
                difference () {
                    square([size.x, size.y], center=true);
                    for (x = [-size.x/2, size.x/2], y = [-size.y/2, size.y/2])
                        translate([x, y])
                            circle(r=cornerInset);
                }
    }
    for (x = [-size.x/2 + boltInset, size.x/2 - boltInset], y = [-size.y/2 + boltInset, size.y/2 - boltInset])
        translate([x, y, baseHeight])
            not_on_bom() boltM2Caphead(boltLength);
}

module blowerWithBolts(type) {
    blower(type);
    translate_z(blower_base(type))
        blower_hole_positions(type)
            screw(blower_screw(type), 8);
}

module circuitBoard(size, color) {
    switchType = small_microswitch;
    color(color) {
        rounded_rectangle(size, 1, center=false);
        translate([-size.x/2, size.y/2 - 2, 0])
            cube([2, 2, size.z]);
        translate([-size.x/2 - 7, 0, 0])
            cube([7, 17, size.z]);
        translate([-size.x/2, 17, 0])
            rotate(90)
                right_triangle(5, 7, size.z, center=false);
        translate([-size.x/2, 0, 0])
            rotate(180)
                right_triangle(7, 5, size.z, center=false);
    }
    translate([-size.x/2 - microswitch_width(switchType)/2 - 0.5, size.y/2 - microswitch_length(switchType)/2 - 7, microswitch_thickness(switchType)/2 + size.z]) {
        rotate(90)
            not_on_bom() microswitch(switchType);
        color("silver")
            translate([-5, 2, size.z - 0.5])
                rotate(15)
                    cube([0.5, 15, 4.5], center=true);
    }
}

module nozzle() {
    boltColorBrass = "#B5A642";
    color(boltColorBrass) {
        threadHeight = 5;
        nozzleHeight = 10;
        nutHeight = 4;
        nutDiameter = 10;
        translate_z(0)
            cylinder(d=6, h=threadHeight);
        translate_z(-nutHeight)
            cylinder(d=nutDiameter, h=nutHeight, $fn=6);
        translate_z(-nozzleHeight)
            cylinder(d1=0.6, d2=nutDiameter-1.4, h=nozzleHeight-nutHeight);
    }
}

topSize = [46, 51, 3];
topBackSize = [topSize.x-6, 5, topSize.z];

module PrintheadBIQU_B1_boltPositions() {
    translate([-topBackSize.x/2, 0, 0])
        rotate([90, 0, 0])
            for (x = [-10, 10])
                translate([x + topBackSize.x/2, 0, topSize.z])
                    children();
}

module PrintheadBIQU_B1() {
    vitamin(str("PrintheadBIQU_B1(): BIQU B1 printhead"));
    color = grey(25);

    usb_c_to_c_cable(500);

probing = false;

    translate([0, -topSize.y-topBackSize.y, -7]) {
        // top
        if (!probing) {
        color(color) {
            difference() {
                translate([-topSize.x/2, 0, 0])
                    cube(topSize);
                translate([0, 23, -eps])
                    cylinder(h=topSize.z*2, d=12);
            }
            translate([-topBackSize.x/2, topSize.y, 0]) {
                cube(topBackSize);
                translate([0, topBackSize.y, 0])
                    rotate([90, 0, 0])
                        difference() {
                            rounded_rectangle([topBackSize.x, 14, 3], 3, center=false, xy_center=false);
                            for (x = [-10, 10])
                                translate([x + topBackSize.x/2, 7, 0])
                                    boltHoleM3(3);
                        }
            }
        }
        for (i = [ [-8, 14, 3], [8, 14, 3], [-8, 26, 3], [8, 26, 3], [-17, 40, 3], [17, 40, 3] ])
            translate(i)
                not_on_bom() boltM3Buttonhead(5);
        } // end probing

        frontSize = [46, 1, 44];
        translate([-topSize.x/2, 0, -frontSize.z]) {
            color(color) {
                // front face
                difference() {
                    cube(frontSize);
                    translate([frontSize.x/2, 2, frontSize.z - 27/2 - 3])
                        rotate([90, 0, 0])
                            cylinder(h=frontSize.y*4, d=27);
                    for (z=[0 : 3])
                        translate([frontSize.x/2, frontSize.y + eps, z*3 + 2])
                            rotate([90, 0, 0])
                                rounded_rectangle([32, 1.5, frontSize.y + 2*eps], 0.5, center=false);
                }
                //left face
                cube([frontSize.y, topSize.y, frontSize.z]);
                //right face
                translate([frontSize.z + frontSize.y, 0, 0])
                    cube([frontSize.y, topSize.y, frontSize.z]);
            }
            // back
            translate([frontSize.x/2, topSize.y, frontSize.z/2])
                rotate([-90, 0, 0])
                    circuitBoard([frontSize.x, frontSize.z, 0.5], color=grey(20));
            translate([frontSize.x/2, topSize.y + 0.5, frontSize.z/2])
                rotate([-90, 0, 0])
                    insetCube([frontSize.x, frontSize.z, 4.5], color=grey(90));
        }
        hotEndFan = fan30x10;
        translate([0, fan_depth(hotEndFan)/2+frontSize.y, -fan_width(hotEndFan)/2 - 1.5]) {
            rotate([90, 0, 0])
                not_on_bom() fan(hotEndFan);
        rotate([-90, 0, 0])
            fan_hole_positions(hotEndFan, -6)
                vflip()
                    not_on_bom() boltM3Buttonhead(5);
        }
        //translate([-topSize.x/2, topSize.y/2, 20 - frontSize.z])
        translate([-topSize.x/2, topSize.x, -frontSize.z])
            rotate([90, 0, -90])
                not_on_bom() blowerWithBolts(BL40x10);
        translate([topSize.x/2, topSize.x-blower_length(BL40x10), -frontSize.z])
            rotate([90, 0, 90])
                not_on_bom() blowerWithBolts(BL40x10);
    }

    translate([0, 23 - topSize.y, -7]) {
        translate([0, -topBackSize.y, 0]) {
            bowden_connector(grey(20));
            h = 5;
            translate_z(-35 - h)
                color("silver")
                    cylinder(h=h, d=5);
            size = [30, 20, 35];
            translate([0, -2, -size.z/2])
                color("silver")
                    cube(size, center=true);
        }
        translate([0, -4, -51 + 11.5/2])
            color("lightgrey")
                cube([16, 20, 11.5], center=true);
        translate_z(-51)
            nozzle();
    }
    *translate([32, -6.5, -58])
        rotate([90, 0, -90])
            fanDuct_BIQU_B1_AirGuide();
}
