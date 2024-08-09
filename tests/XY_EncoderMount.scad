//!Display the left and right motor encoder mounts.
include <../scad/config/global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/bldc_motors.scad>
include <NopSCADlib/vitamins/magnets.scad>

include <../scad/printed/XY_MotorMountBLDC.scad>
include <../scad/printed/XY_EncoderMount.scad>
include <../scad/vitamins/AS5048_PCB.scad>

include <../scad/config/Parameters_Positions.scad>


//$explode = 1;
//$pose=1;
module XY_Encoder_Mount_test() {
    //CoreXYBelts(carriagePosition(), show_pulleys=![1, 0, 0], xyMotorWidth=56, leftDrivePulleyOffset=[0, 3.25], rightDrivePulleyOffset=[0, 3.25]);
    use4250 = false;
    if (use4250) {
        BLDC_type = BLDC4250;
        XY_Encoder_Mount_4250_stl();
        XY_Encoder_Mount_hardware(BLDC_type);
        XY_Encoder_Mount_4250_Cover_stl();
        vflip()
            BLDC(BLDC_type);
        translate_z(-BLDC_height(BLDC_type))
            Encoder_Magnet_Holder_4250_stl();
        translate_z(-BLDC_height(BLDC_type) - BLDC_prop_shaft_length(BLDC_type))
            vflip()
                magnet(MAGRE6x2p5);
        //XY_Encoder_Mount_4250_Left_assembly();
        //XY_Encoder_Mount_4250_Right_assembly();
    } else {
        BLDC_type = BLDC4933;
        XY_Encoder_Mount_4933_stl();
        XY_Encoder_Mount_hardware(BLDC_type);
        XY_Encoder_Mount_4933_Cover_stl();
        vflip()
            BLDC(BLDC_type);
        translate_z(-BLDC_height(BLDC_type))
            Encoder_Magnet_Holder_4933_stl();
        translate_z(-BLDC_height(BLDC_type) - BLDC_prop_shaft_length(BLDC_type))
            vflip()
                magnet(MAGRE6x2p5);
        //let($hide_bolts=true)
        //XY_Encoder_Mount_4933_Left_assembly();
        //XY_Encoder_Mount_4933_Right_assembly();
    }
}

//XY_Encoder_Mount_4933_Cover_stl();
//XY_Encoder_Mount_4933_stl();
//Encoder_Magnet_Holder_4933_stl();
if ($preview)
    XY_Encoder_Mount_test();
