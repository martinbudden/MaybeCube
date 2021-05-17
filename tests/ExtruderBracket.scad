//! Display the extruder frame bracket
include <NopSCADlib/core.scad>
use <../scad/printed/ExtruderBracket.scad>
use <../scad/vitamins/filament_sensor.scad>
use <../../BabyCube/scad/vitamins/extruder.scad>


//$explode = 1;
//$pose = 1;
module ExtruderBracket_test() {
    clearance = 0.5;
    *translate([extruderFilamentOffset().x, -extruderFilamentOffset().y - clearance, extruderFilamentOffset().z - filament_sensor_offset().z])
        filament_sensor();
    //Extruder_MK10_Dual_Pulley();
    //extruderBracket();
    //Extruder_Bracket_stl();
    Extruder_Bracket_assembly();
}

//if ($preview)
    ExtruderBracket_test();
