include <../global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>
use <NopSCADlib/utils/fillet.scad>

include <../../../BabyCube/scad/vitamins/extruder.scad>

use <../vitamins/bolts.scad>
use <../vitamins/cables.scad>
use <../vitamins/CorkDamper.scad>
use <../vitamins/filament_sensor.scad>
use <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


// spoolHeight is declared here because it is determined by its supporting extrusion requiring to clear the extruder and filament sensor
function spoolHeight() = eZ - 170;

extruderNEMAType = eX >= 300 ? NEMA17 : NEMA17M;

// height of eZ-118 give clearance to NEMA17M motor (length 40). Long NEMA has length 48, and E3D super whopper has length 60
// need about 22mm for BTT motor, so eZ -140 is good height
function extruderPosition() = [eX + 2*eSize, eY + 2*eSize - 45, eZ - 90];
//function extruderBowdenOffset() = [17.5, 4.5, 30];
function Extruder_Bracket_assembly_bowdenOffset() = [20.5, 5, 10];

function extruderBracketSize() = [3, 70, eZ - spoolHeight()];
//filamentSensorOffset = [20.5, 4.5, -45];
function filamentSensorOffset() = [extruderFilamentOffset().z + extruderBracketSize().x, extruderFilamentOffset().x, -extruderFilamentOffset().y - filament_sensor_size().x/2-4];

counterSunk = false;

module extruderBoltPositions() {
    size = extruderBracketSize();

    translate([eX + 2*eSize, eY + 2*eSize - size.y, spoolHeight()])
        //for (y = [10, size.y - eSize/2], z = [eSize/2, size.z - eSize/2])
        //    translate([0, y, z])
        for (i = [
                [0, 5, eSize/2],
                [0, 5, size.z - eSize/2],
                //[0, size.y - 3*eSize/2, size.z - eSize/2],
                [0, size.y - eSize/2, eSize/2],
                [0, size.y - eSize/2, size.z - eSize]
            ])
            translate(i)
                rotate([0, 90, 0])
                    children();
}

module extruderCutouts() {
    size = extruderBracketSize();

    extruderBoltPositions()
        boltHoleM4(size.x);

    translate([eX + 2*eSize, eY + 2*eSize - size.y, spoolHeight()])
        for (i = [ [0, size.y - eSize/2, size.z - eSize/2], [0, size.y - eSize/2, size.z - 3*eSize/2] ])
            translate(i)
                rotate([0, 90, 0])
                    boltHoleM4(size.x);

    translate(extruderPosition()) {
        rotate([0, 90, 0]) {
            NEMA_screw_positions(extruderNEMAType)
                boltHoleM3(size.x);
            translate_z(-eps)
                poly_cylinder(r=NEMA_boss_radius(extruderNEMAType), h=size.x + 2*eps);
            }
        translate(filamentSensorOffset())
            rotate([0, 90, 0])
                filament_sensor_hole_positions(-filamentSensorOffset().x)
                    if (counterSunk)
                        boltPolyholeM3Countersunk(size.x);
                    else
                        boltHoleM3Tap(size.x);
    }
}

module extruderBracket() {
    size = extruderBracketSize();
    fillet = 3;

    difference() {
        translate([eX + 2*eSize, eY + 2*eSize - size.y, spoolHeight()])
            rounded_cube_yz(size, fillet);
        extruderCutouts();
    }
}

module Extruder_Bracket_stl() {
    //echo(extruderFilamentOffset=extruderFilamentOffset());
    //echo(filamentSensorOffset=filamentSensorOffset());
    stl("Extruder_Bracket")
        color(pp1_colour)
            rotate([0, -90, 0])
                extruderBracket();
}

M3x12_nylon_hex_pillar = ["M3x12_nylon_hex_pillar", "hex nylon", 3, 12, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -6, -6+eps];

module Extruder_Bracket_hardware(corkDamperThickness, addM4Bolts=false) {
    stepper_motor_cable(eZ + eY + 200); // extruder motor

    size = extruderBracketSize();

    pillarHeight = extruderBowdenOffset().x - filament_sensor_size().z/2;
    assert(pillarHeight == 12); // so M3x12 pillar fits

    if (addM4Bolts)
        extruderBoltPositions()
            translate_z(size.x)
                boltM4ButtonheadHammerNut(8);

    translate(extruderPosition()) {
        rotate([90, 0, 90]) {
            translate_z(size.x)
                Extruder_MK10_Dual_Pulley(extruderNEMAType, motorOffsetZ=size.x + corkDamperThickness, motorRotate=180);
            translate_z(-corkDamperThickness)
                corkDamper(extruderNEMAType, corkDamperThickness);
        }
        translate(filamentSensorOffset())
            rotate([0, 90, 0]) {
                filament_sensor();
                filament_sensor_hole_positions() {
                    translate_z(filament_sensor_size().z/2)
                        boltM3Buttonhead(16);
                    translate_z(-filament_sensor_size().z/2) {
                        vflip()
                            pillar(M3x12_nylon_hex_pillar);
                        translate_z(-pillarHeight - size.x-eps)
                            vflip()
                                if (counterSunk)
                                    boltM3Countersunk(8);
                                else
                                    boltM3Buttonhead(8);
                    }
                }
            }
    }
}

module Extruder_Bracket_assembly() pose(a=[55, 0, 25 + 180])
assembly("Extruder_Bracket", ngb=true) {

    Extruder_Bracket_hardware(_corkDamperThickness);

    rotate([0, 90, 0])
        stl_colour(pp1_colour)
            Extruder_Bracket_stl();
}
