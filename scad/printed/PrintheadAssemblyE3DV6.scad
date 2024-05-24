include <../global_defs.scad>

include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/blowers.scad>
use <NopSCADlib/vitamins/wire.scad>

include <../utils/X_Rail.scad>
include <../vitamins/cables.scad>

use <X_CarriageAssemblies.scad>
use <X_CarriageE3DV6.scad>


function hotendClampOffset(xCarriageType, hotendDescriptor="E3DV6") =  [hotendOffset(xCarriageType, hotendDescriptor).x, 18 + xCarriageHotendOffsetY(xCarriageType) + grooveMountOffsetX(hotendDescriptor), hotendOffset(xCarriageType, hotendDescriptor).z];
grooveMountFillet = 1;
function grooveMountClampSize(blowerType, hotendDescriptor) = [grooveMountSize(blowerType, hotendDescriptor).y - 2*grooveMountFillet - grooveMountClampOffsetX(), 12, 15];

module printheadE3DV6Assembly(full=true) {
    xCarriageType = MGN12H_carriage;
    blowerType = blowerType();
    hotendDescriptor = "E3DV6";
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    rotate(180)
        translate([0, -2*hotendOffset.y, 0]) {
            explode([20, 0, 0])
                hotEndHolderHardware(xCarriageType, hotendDescriptor);

            if (full)
                translate(hotendClampOffset(xCarriageType, hotendDescriptor))
                    rotate([90, 0, -90])
                        explode(-40, true) {
                            stl_colour(pp2_colour)
                                if (blower_size(blowerType).x == 30)
                                    Groovemount_Clamp_stl();
                                else
                                    Groovemount_Clamp_40_stl();
                            Groovemount_Clamp_hardware(xCarriageType, blowerType, hotendDescriptor);
                        }
        }

    if (!exploded() && full)
        translate(printheadWiringOffset(hotendDescriptor))
            for (z = [0, 10])
                translate([0, -3.5, z + 30])
                    rotate([0, 90, 90])
                        cable_tie(cable_r = 3, thickness = 4.5);
}

//!1. Bolt the fan onto the side of the **X_Carriage_Groovemount**, secure the fan wire with a ziptie.
//!2. Ensure a good fit between the fan and the **Fan_Duct** and bolt the fan duct to the X_Carriage.
//!3. Assemble the E3D hotend, including fan, thermistor cartridge and heater cartridge.
//!4. Use the **Groovemount_Clamp** to attach the E3D hotend to the X_Carriage.
//!5. Collect the wires together, wrap them in spiral wrap, and secure them to the X_Carriage using the zipties. Note that
//!the wiring is not shown in this diagram.
module Printhead_E3DV6_assembly() pose(a=[55, 0, 25 + 180])
assembly("Printhead_E3DV6", big=true) {

    xCarriageGroovemountAssembly();
    printheadE3DV6Assembly();
}

module hotEndHolderHardware(xCarriageType, hotendDescriptor="E3DV6") {
    hotendOffset = hotendOffset(xCarriageType, hotendDescriptor);

    translate(hotendOffset)
        E3Dv6plusFan();
}

/*module Hotend_Strain_Relief_Clamp_stl() {
    holeSpacing = hotendStrainReliefClampHoleSpacing();
    size = [holeSpacing + 8, 10, 3];

    stl("Hotend_Strain_Relief_Clamp")
        color(pp1_colour)
            linear_extrude(size.z)
                difference() {
                    rounded_square([size.x, size.y], 1.5);
                    for (x = [-holeSpacing/2, holeSpacing/2])
                        translate([x, 0, 0])
                            poly_circle(r=M3_clearance_radius);
                }
}

module Hotend_Strain_Relief_Clamp_hardware() {
    holeSpacing = hotendStrainReliefClampHoleSpacing();
    size = [holeSpacing + 8, 10, 3];

    for (x = [-holeSpacing/2, holeSpacing/2])
        translate([x, 0, size.z])
            boltM3Buttonhead(12);
}
*/

module Groovemount_Clamp_stl() {
    stl("Groovemount_Clamp")
        color(pp2_colour)
            mirror([1, 0, 0])
                grooveMountClamp(grooveMountClampSize(BL30x10), tolerance=0.15);
}

module Groovemount_Clamp_40_stl() {
    stl("Groovemount_Clamp")
        color(pp2_colour)
            mirror([1, 0, 0])
                grooveMountClamp(grooveMountClampSize(BL40x10), tolerance=0.15);
}

module Groovemount_Clamp_hardware(xCarriageType, blowerType, hotendDescriptor) {
    mirror([1, 0, 0])
        grooveMountClampHardware(grooveMountClampSize(blowerType, hotendDescriptor), countersunk=true);
}
