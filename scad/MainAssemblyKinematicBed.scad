//!# Kinematic Bed adaptors
//!
//!MaybeCube has the ability to use a 3-point kinematic bed.


include <config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <printed/JubileeKinematicBed.scad>

use <assemblies/BasePlate.scad>
use <assemblies/FaceLeft.scad>
use <assemblies/FaceRight.scad>
use <assemblies/Printbed.scad>

use <config/Parameters_Positions.scad>
include <config/Parameters_Main.scad>


module KinematicBed_assembly()
assembly("KinematicBed", big=true) {

    Left_Side_assembly(bedHeight());
    Right_Side_assembly(bedHeight());
    basePlateAssembly(rightExtrusion=true);
    translate_z(bedHeight())
        jubilee_build_plate();
}

if ($preview)
    translate([-(eX + 2*eSize)/2, - (eY + 2*eSize)/2, -eZ/2])
        KinematicBed_assembly();
