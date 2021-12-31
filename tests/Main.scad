//!Display the whole printer

use <../scad/Main.scad>
use <../scad/MainAssemblies.scad>

include <../scad/utils/printParameters.scad>
include <../scad/utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>


//$pose = 1;
//$explode = 1;
module main_test() {
    if (_useAsserts) {
        assert(extrusion_width >= 1.1*nozzle, "extrusion_width too small for nozzle");
        assert(extrusion_width <= 1.7*nozzle, "extrusion_width too large for nozzle");
        assert(layer_height <= 0.5*extrusion_width, "layer_height too large for extrusion_width");
        assert(layer_height >= 0.25*extrusion_width, "layer_height too small for extrusion_width"); // not sure this one is correct
    }

    echoPrintSize();
    echoParameters();

    //CoreXYBelts(carriagePosition(), show_pulleys=false);
    //Stage_1_assembly();
    //Stage_2_assembly();
    //Stage_3_assembly();
    //let($hide_extrusions=true)
    //Stage_4_assembly();

    //let($hide_bolts=true)
    //let($hide_extrusions=true)
    //let($hide_rails=true)
    //Stage_5_assembly();
    translate([eX/2 + eSize, eY/2 + eSize, eZ/2]) main_assembly();
}

if ($preview)
    rotate($vpr.z == 315 ? -90 + 30 : 0)
        translate([-eX/2 - eSize, -eY/2 - eSize, -eZ/2])
            main_test();
