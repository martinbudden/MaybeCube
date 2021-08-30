//!Display the left and right motor encoder mounts.
include <../scad/global_defs.scad>

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/bldc_motors.scad>

include <../scad/printed/XY_MotorMountBLDC.scad>
include <../scad/printed/XY_EncoderMount.scad>
include <../scad/vitamins/AS5048_PCB.scad>

use <../scad/Parameters_Positions.scad>
include <../scad/Parameters_Main.scad>


//$explode = 1;
//$pose=1;
module XY_Encoder_Mount_test() {
    //CoreXYBelts(carriagePosition(), show_pulleys=![1, 0, 0], xyMotorWidth=56, leftDrivePulleyOffset=[0, 3.25], rightDrivePulleyOffset=[0, 3.25]);
    use4250 = false;
    BLDC_type = use4250 ? BLDC4250 : BLDC4933;
    if (use4250) {
        XY_Encoder_Mount_4250_stl();
        //let($hide_bolts=true)
        XY_Encoder_Mount_hardware(BLDC_type);
        //XY_Encoder_Mount_4250_Left_assembly();
        //XY_Encoder_Mount_4250_Right_assembly();
    } else {
        XY_Encoder_Mount_4933_stl();
        //let($hide_bolts=true)
        XY_Encoder_Mount_hardware(BLDC_type);
        //XY_Encoder_Mount_4933_Left_assembly();
        //XY_Encoder_Mount_4933_Right_assembly();
    }
}

if ($preview)
    XY_Encoder_Mount_test();
