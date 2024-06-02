include <NopSCADlib/vitamins/stepper_motors.scad>
include <../utils/motorTypes.scad>
include <../Parameters_CoreXY.scad>

function basePlateThickness(useReversedBelts, cnc, flat) = cnc ? 4 : flat ? 4.5 : useReversedBelts ? 5 : 6.5;

function xyMotorMountSize(motorWidth, offset, left=true, useReversedBelts=false, cnc=false, flat=false)
    = [ eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + motorWidth/2 + offset.x + 0.74,
        eY + 2*eSize + motorWidth/2 - (left ? offset.y : -offset.y) + 1.2,
        eZ + basePlateThickness(useReversedBelts, cnc, flat) + (left || useReversedBelts ? coreXYSeparation().z : 0)] - coreXYPosTR(motorWidth);
