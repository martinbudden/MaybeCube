//! Displays a reversed CoreXY

include <../scad/global_defs.scad>

include <NopSCADlib/vitamins/rails.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

use <../scad/printed/XY_Idler.scad>
use <../scad/printed/XY_MotorMount.scad>
use <../scad/printed/Y_CarriageAssemblies.scad>

use <../scad/utils/CoreXYReversed.scad>
use <../scad/Parameters_Positions.scad>
use <../scad/Parameters_CoreXY.scad>
include <../scad/Parameters_Main.scad>

t = 3;
yExtra = 0;
module CoreXYRBelts(carriagePosition, coreXY_type=coreXY_type(), x_gap=0, show_pulleys=false, xyMotorWidth=undef, leftDrivePulleyOffset=leftDrivePulleyOffset(), rightDrivePulleyOffset=rightDrivePulleyOffset(), plainIdlerPulleyOffset=plainIdlerPulleyOffset()) {
    assert(is_list(carriagePosition) && len(carriagePosition) == 2);

    xyMotorWidth = is_undef(xyMotorWidth) ? _xyMotorDescriptor == "NEMA14" ? 35.2 : _xyMotorDescriptor == "BLDC4250"? 56 : 42.3 : xyMotorWidth;
    coreXYR_belts(coreXY_type,
        carriagePosition = [eX + 2*eSize - carriagePosition.x - x_gap, carriagePosition.y],
        coreXYPosBL = coreXYPosBL(),
        coreXYPosTR = coreXYPosTR(xyMotorWidth) + [0, yExtra, 0],
        separation = coreXYSeparation(),
        x_gap = x_gap,
        plain_idler_offset = plainIdlerPulleyOffset,
        upper_drive_pulley_offset = [-rightDrivePulleyOffset.x, rightDrivePulleyOffset.y],
        lower_drive_pulley_offset = [-leftDrivePulleyOffset.x, leftDrivePulleyOffset.y],
        left_lower = true,
        show_pulleys = show_pulleys);
}

module CoreXY_test() {

    back = false;
    NEMA_width = _xyMotorDescriptor == "NEMA14" ? 35.2 : 42.3;
    coreXYSize = coreXYPosTR(NEMA_width) - coreXYPosBL();
    carriagePosition = carriagePosition(t);
    CoreXYRBelts(carriagePosition,
        //coreXY_type=coreXY_type("GT2_20_16"),
        //coreXY_type=coreXY_type("GT2_20_20"),
        coreXY_type=coreXY_type("GT2_20_20_fb"),
        x_gap = 10,
        show_pulleys = [1, 0, 0],
        leftDrivePulleyOffset = leftDrivePulleyOffset(),
        rightDrivePulleyOffset = rightDrivePulleyOffset(),
        plainIdlerPulleyOffset= [0, -20]);
    
    translate([0, carriagePosition.y - carriagePosition().y, eZ - eSize])
        Y_Carriage_Left_assembly();
    translate([eX + 2*eSize, carriagePosition.y - carriagePosition().y, eZ - eSize])
        Y_Carriage_Right_assembly();

    XY_Idler_Left_assembly();
    XY_Idler_Right_assembly();

    XY_Motor_Mount_Left_assembly();
    XY_Motor_Mount_Right_assembly();

}

if ($preview)
    translate([-eX/2 - eSize, -eY/2 - eSize, -coreXYPosBL().z])
        CoreXY_test();
