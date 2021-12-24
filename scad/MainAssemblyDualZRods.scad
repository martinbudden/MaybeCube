//!# Dual Z rods.
//!
//!MaybeCube has the ability to use a dual Z rods.


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <printed/JubileeKinematicBed.scad>

use <BasePlate.scad>
use <FaceLeft.scad>
use <FaceRight.scad>
use <PrintBed.scad>

use <../scad/Parameters_Positions.scad>
include <Parameters_Main.scad>


module DualZRods_assembly()
assembly("DualZRods", big=true) {

    Left_Side_assembly(bedHeight());
    zRods();
    zMotor();
    translate_z(bedHeight())
        Printbed_assembly();
    Right_Side_assembly(bedHeight());
    zRods(left=false);
    Base_Plate_assembly();
}

if ($preview)
    translate([-(eX + 2*eSize)/2, - (eY + 2*eSize)/2, -eZ/2])
        DualZRods_assembly();
