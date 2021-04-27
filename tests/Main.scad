//!Display the whole printer

use <../scad/Main.scad>
use <../scad/MainAssemblies.scad>

use <../scad/utils/printParameters.scad>
use <../scad/utils/xyBelts.scad>

include <../scad/Parameters_Main.scad>
include <../scad/Parameters_Positions.scad>

//$pose = 1;
//$explode = 1;
module main_test() {
    echoPrintSize();
    echoParameters();

    //xyBelts(carriagePosition, show_pulleys=false);
    //Stage_1_assembly();
    //Stage_2_assembly();
    //Stage_3_assembly();
    //let($hide_extrusions=true)
    //Stage_4_assembly();

    //let($hide_bolts=true)
    //let($hide_extrusions=true)
    //let($hide_rails=true)
    //Stage_5_assembly();
    Stage_6_assembly();
    //main_assembly();
}

if ($preview)
    translate([-eX/2 -eSize, -eY/2 -eSize, -eZ/2])
        main_test();
