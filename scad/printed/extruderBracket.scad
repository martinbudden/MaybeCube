include <../global_defs.scad>

include <NopSCADlib/vitamins/stepper_motors.scad>
use <NopSCADlib/utils/fillet.scad>

use <../../../BabyCube/scad/vitamins/extruder.scad>
use <../../../BabyCube/scad/vitamins/CorkDamper.scad>

include <../vitamins/bolts.scad>
include <../vitamins/cables.scad>
include <../vitamins/filament_sensor.scad>
include <../vitamins/nuts.scad>

include <../Parameters_Main.scad>


extruderNEMAType = eX >= 300 ? NEMA17_47 : NEMA17_40;

// height of eZ-118 give clearance to NEMA17_40 motor (length 40). Long NEMA has length 48, and E3D super whopper has length 60
// need about 22mm for BTT motor, so eZ -140 is good height
function extruderPosition(eX=eX) = [eX + 2*eSize, eY + 2*eSize - 43, eX < 400 ? eZ - 95 : eZ - 140];
//function extruderBowdenOffset() = [17.5, 4.5, 30];
function Extruder_Bracket_assembly_bowdenOffset() = [20.5, 5, 10];

// spoolHeight is declared here because it is determined by its supporting extrusion requiring to clear the extruder and filament sensor
function spoolHeight(eX=eX) = extruderPosition(eX).z - (eX < 400 ? 110 : 80);
function spoolHolderPosition(offsetX=0) = [eX + 2*eSize + 10 + offsetX, eY/2 + (eY < 350 ? 30 : 55), spoolHeight() + 2*eSize];


// iecHousing sizes here, since the extruder bracket and IEC housing sizes must match,
// and placing IEC housing size here minimises cross dependencies.
function iecHousingSize() = [70, 50, 42 + 3];
function iecHousingMountSize() = [iecHousingSize().x + eSize, iecHousingSize().y + 2*eSize, 3];
//function iecHousingMountSize() = [iecHousingSize().x + eSize, spoolHeight() + (eX < 350 ? 0 : eSize), 3];

function extruderBracketSize() = [3, iecHousingMountSize().x, eZ - spoolHeight() - eSize];
//filamentSensorOffset = [20.5, 4.5, -45];
function filamentSensorOffset() = [extruderFilamentOffset().z + extruderBracketSize().x, extruderFilamentOffset().x, -extruderFilamentOffset().y - filament_sensor_size().x/2 - 4];

counterSunk = true;

module extruderBoltPositions() {
    size = extruderBracketSize();

    translate([eX + 2*eSize, eY + 2*eSize - size.y, eZ - size.z])
        //for (y = [10, size.y - eSize/2], z = [eSize/2, size.z - eSize/2])
        //    translate([0, y, z])
        for (i = [
                [0, 7.5, eSize/2],
                [0, 7.5, size.z - eSize/2],
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

    // access holes
    translate([eX + 2*eSize, eY + 2*eSize - size.y, eZ - size.z])
        for (z = [size.z - eSize/2, size.z - 3*eSize/2])
            translate([0, size.y - eSize/2, z])
                rotate([0, 90, 0])
                    boltHole(5, size.x);

    translate(extruderPosition()) {
        rotate([0, 90, 0]) {
            NEMA_screw_positions(extruderNEMAType)
                boltHoleM3(size.x);
            translate_z(-eps)
                poly_cylinder(r=NEMA_boss_radius(extruderNEMAType), h=size.x + 2*eps);
        }
        clearance = 3.5;
        rotate([90, 0, 90])
            translate([extruderFilamentOffset().x, -extruderFilamentOffset().y - clearance, 0])
                filament_sensor_hole_positions()
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
        translate([eX + 2*eSize, eY + 2*eSize - size.y, eZ - size.z])
            rounded_cube_yz(size, fillet);
        extruderCutouts();
    }
}

module Extruder_Bracket_stl() {
    //echo(extruderFilamentOffset=extruderFilamentOffset());
    //echo(filamentSensorOffset=filamentSensorOffset());
    stl("Extruder_Bracket")
        color(pp2_colour)
            rotate([0, 90, 0])
                extruderBracket();
}

M3x10_nylon_hex_pillar = ["M3x10_nylon_hex_pillar", "hex nylon", 3, 10, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -5, -5 + eps];
M3x12_nylon_hex_pillar = ["M3x12_nylon_hex_pillar", "hex nylon", 3, 12, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -6, -6 + eps];
M3x14_nylon_hex_pillar = ["M3x14_nylon_hex_pillar", "hex nylon", 3, 14, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -7, -7 + eps];

module Extruder_Bracket_hardware(corkDamperThickness, addM4Bolts=false) {
    stepper_motor_cable(200); // extruder motor

    size = extruderBracketSize();

    pillarHeight = extruderFilamentOffset().z - filament_sensor_offset().z;
    //assert(pillarHeight == 12); // so M3x12 pillar fits

    if (addM4Bolts)
        extruderBoltPositions()
            translate_z(size.x)
                boltM4ButtonheadHammerNut(_sideBoltLength);

    translate(extruderPosition())
        rotate([90, 0, 90]) {
            translate_z(size.x)
                Extruder_MK10_Dual_Pulley(extruderNEMAType, motorOffsetZ=size.x + corkDamperThickness, motorRotate=180, extruderExplode=80, motorExplode=80);
            translate_z(-corkDamperThickness)
                explode(-40)
                    corkDamper(extruderNEMAType, corkDamperThickness);
            clearance = 3.5;
            translate([extruderFilamentOffset().x, -extruderFilamentOffset().y - clearance, pillarHeight + size.x]) {
                filament_sensor();
                filament_sensor_hole_positions() {
                    translate_z(filament_sensor_size().z)
                        boltM3Buttonhead(16);
                    vflip()
                        pillar(M3x14_nylon_hex_pillar);
                    translate_z(-pillarHeight - size.x - eps)
                        vflip()
                            if (counterSunk)
                                boltM3Countersunk(8);
                            else
                                boltM3Buttonhead(8);
                }
            }
        }
}

//!1. Bolt the stepper motor and cork damper through the **Extruder_Bracket** to the extruder as shown. The cork damper
//!thermally isolates the motor from the **Extruder_Bracket** and should not be omitted.
//!2. Align the hobb gear on the stepper motor shaft with the the hobb gear in the extruder and tighten the grub screws.
//!3. Bolt the filament sensor to the hex pillars and bolt them to the **Extruder_Bracket**.
//!4. Add the bolts and t-nuts in preparation for later attachment to the frame.
//
module Extruder_Bracket_assembly()
assembly("Extruder_Bracket", ngb=true) {
    Extruder_Bracket_hardware(is_undef(_corkDamperThickness) ? 0 : _corkDamperThickness, addM4Bolts=true);

    rotate([0, -90, 0])
        stl_colour(pp2_colour)
            Extruder_Bracket_stl();
}
