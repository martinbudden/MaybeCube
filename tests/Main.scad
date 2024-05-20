//!Display the whole printer

use <../scad/Main.scad>
include <../scad/utils/printParameters.scad>


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
    echoPrintParameters();

    //CoreXYBelts(carriagePosition(), show_pulleys=false);
    //Stage_1_assembly();
    //Stage_2_assembly();
    //Stage_3_assembly();
    //let($hide_extrusions=true)
    //Stage_4_assembly();

    //let($hide_bolts=true)
    //let($hide_extrusions=true)
    //let($hide_rails=true)
    rotate($vpr.z == 25 ? 0 : -90 + 30)
        main_assembly();
}

if ($preview)
    main_test();
