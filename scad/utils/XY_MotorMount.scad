include <NopSCADlib/vitamins/stepper_motors.scad>
include <../utils/motorTypes.scad>
include <../Parameters_CoreXY.scad>

basePlateThickness = 6.5;

function xyMotorMountSize(motorWidth = motorWidth(motorType(_xyMotorDescriptor)), offset = leftDrivePulleyOffset(), left=true)
    = [ eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + motorWidth/2 + offset.x + 5,
        eY + 2*eSize + motorWidth/2 - (left ? offset.y : -offset.y) + 1,
        eZ + basePlateThickness + (left ? coreXYSeparation().z : 0)] - coreXYPosTR(motorWidth);
