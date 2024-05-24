include <../global_defs.scad>

include <../vitamins/bolts.scad>

include <NopSCADlib/vitamins/blowers.scad>
use <NopSCADlib/vitamins/wire.scad>

include <../utils/X_Rail.scad>
include <../vitamins/cables.scad>
use <../vitamins/OrbiterV3.scad>

include <OrbiterV3Fan.scad>
use <X_CarriageOrbiterV3.scad>


module printheadOrbiterV3Assembly() {
    xCarriageType = MGN12H_carriage;
    blowerType = RB5015;

    rotate([0, 0, 90])
        translate([39, -0.3, 0])
            smartOrbiterV3();
    translate([22.5, 66.5, -1.3]) {
        explode([0, 0, -50])
            stl_colour(pp1_colour)
                Smart_Orbiter_V3_Duct_stl();
        explode([0, 20, 0], true) {
            rotate([-90, 0, 0])
                stl_colour(pp2_colour)
                    vflip()
                        Smart_Orbiter_V3_Fan_Bracket_5015_stl();
            translate([-0.55, -6.5, 52.58]) {    
                translate([-smartOrbiterV3FanBoltSpacing().x, 0, -smartOrbiterV3FanBoltSpacing().y])
                    rotate([-90, 0, 0])
                        boltM3Countersunk(6);
                rotate([-90, 0, 0])
                    boltM3Countersunk(6);
            }
            translate([-2, -7.8, 20.25])
                rotate([90, 0, 90])
                    explode(20, true)
                        boltM2Caphead(10);
        }

        explode([0, 60, 0], true)
            translate([2.6, -6, 21.5])
                rotate([90, 0, 180]) {
                    blower(blowerType);
                    blower_hole_positions(blowerType)
                        translate([0, 0, blower_size(blowerType).z + 0.75])
                            boltM3Countersunk(20);
                }
    }
}

//!The **Smart_Orbiter_V3_Fan_Bracket** and the **Smart_Orbiter_V3_Duct** are based on the
//![Smart Orbiter v3 - Detachable front 5015 fan](https://www.printables.com/es/model/700391-smart-orbiter-v3-detachable-front-5015-fan)
//!by [@PrintNC](https://www.printables.com/es/@PrintNC) and are used under the terms of their
//![Creative Commons (4.0 International License) Attribution Recognition](https://creativecommons.org/licenses/by/4.0/) license.
//!
//!1. Fit the heatfit M3 inserts into the  **X_Carriage_OrbiterV3**.
//!2. Bolt the Smart Orbiter V3 to the **X_Carriage_OrbiterV3**.
//!3. Bolt the **Smart_Orbiter_V3_Fan_Bracket** to the Smart Orbiter V3.
//!4. Bolt the RB5015 blower to the **Smart_Orbiter_V3_Fan_Bracket**.
//!5. Insert the  **Smart_Orbiter_V3_Duct** into the blower outlet and bolt it to the **Smart_Orbiter_V3_Fan_Bracket**.
//!6  Wrap the cables in cable wrap.
//!7. Secure the cables to the **X_Carriage_OrbiterV3** using zipties.
//
module Printhead_OrbiterV3_assembly() pose(a=[55, 0, 25 + 90])
assembly("Printhead_OrbiterV3", big=true) {

    xCarriageType = MGN12H_carriage;
    hotendDescriptor = "OrbiterV3";
    explode([0, -40, 0], true)
        xCarriageOrbiterV3Assembly(xCarriageType, inserts=true);
    translate([-0.3, 0, -orbiterV3NozzleOffsetFromMGNCarriageZ()])
        printheadOrbiterV3Assembly();
    explode([0, -60, 0], true)
        xCarriageOrbiterV3HolePositions(xCarriageType)
            boltM3Countersunk(10);
    cable_wrap(110);
    if (!exploded())
        translate(printheadWiringOffset(hotendDescriptor)) {
            xCarriageOrbitrerV3CableTiePositions(full=false)
                translate([0, -3.5, 18])
                    rotate([0, 90, 90])
                        cable_tie(cable_r = 3, thickness = 4.5);
            translate([-8.5, -5.5, -4])
                rotate([0, 90, -90])
                    cable_tie(cable_r = 2.5, thickness = 3);
        }
}

