include <NopSCADlib/vitamins/stepper_motors.scad>
include <../utils/motorTypes.scad>
include <../Parameters_CoreXY.scad>

function basePlateThickness(useReversedBelts) = useReversedBelts ? 5 : 6.5;

function xyMotorMountSize(motorWidth = motorWidth(motorType(_xyMotorDescriptor)), offset = leftDrivePulleyOffset(), left=true, useReversedBelts=false)
    = [ eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + motorWidth/2 + offset.x + 1,
        eY + 2*eSize + motorWidth/2 - (left ? offset.y : -offset.y) + 1,
        eZ + basePlateThickness(useReversedBelts) + (left || useReversedBelts ? coreXYSeparation().z : 0)] - coreXYPosTR(motorWidth);

function partitionOffsetY() = xyMotorMountSize().y + 1;
