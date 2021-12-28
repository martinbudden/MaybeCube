//!# Kinematic Bed adaptors
//!
//!MaybeCube has the ability to use a 3-point kinematic bed.


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <printed/JubileeKinematicBed.scad>

use <BasePlate.scad>
use <FaceLeft.scad>
use <FaceRight.scad>
use <Printbed.scad>

use <../scad/Parameters_Positions.scad>
include <Parameters_Main.scad>


module KinematicBed_assembly()
assembly("KinematicBed", big=true) {

    Left_Side_assembly(bedHeight());
    Right_Side_assembly(bedHeight());
    Base_Plate_assembly();
    translate_z(bedHeight())
        jubilee_build_plate();
}

if ($preview)
    translate([-(eX + 2*eSize)/2, - (eY + 2*eSize)/2, -eZ/2])
        KinematicBed_assembly();
