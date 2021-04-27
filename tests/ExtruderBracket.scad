//! Display the extruder frame bracket

use <../scad/printed/ExtruderBracket.scad>
use <../scad/vitamins/filament_sensor.scad>


//$explode = 1;
//$pose = 1;
module ExtruderBracket_test() {
    //filament_sensor();
    *extruderBracket();
    *Extruder_Bracket_stl();
    Extruder_Bracket_assembly();
}

if ($preview)
    ExtruderBracket_test();
