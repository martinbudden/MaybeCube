//! Display the printbed

include <NopSCADlib/utils/core/core.scad>

include <../scad/utils/Z_Rods.scad>
use <../scad/Printbed.scad>
use <../scad/jigs/ExtrusionDrillJig.scad>
include <../scad/Parameters_main.scad>


//$explode = 1;
//$pose = 1;
module Printbed_test() {
    if ($target[0]=="M" || $target[0]=="D")
        Printbed_assembly();
    //translate_z(-_zRodLength/2) zRods();
    //if(is_true(_useDualZRods)) translate_z(-_zRodLength/2) zRods(left=false);
    //Heated_Bed_assembly();
    //heatedBed_only();
    //Printbed_Frame_with_Z_Carriages_assembly();
    *rotate(90)
        translate([-eSize - _zRodOffsetX, -eSize - zRodSeparation()/2 - _zRodOffsetY, -_zRodLength/2]) {
            zRods();
            zRods(left=false);
        }
    //translate([-75, 20, 0]) Printbed_Frame_assembly();
    *translate([_printbedArmSeparation/2 + 2*eSize - 5, 0, eSize/2 + 5])
        rotate([90, 0, -90])
            Extrusion_Drill_Jig_Printbed_stl();
    //Printbed_Strain_Relief_stl();
    //Printbed_Strain_Relief_assembly();
}

if ($preview)
    Printbed_test();
