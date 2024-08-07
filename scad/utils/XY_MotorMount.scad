include <NopSCADlib/vitamins/stepper_motors.scad>
include <../utils/motorTypes.scad>
include <../config/Parameters_CoreXY.scad>

function basePlateThickness(useReversedBelts, cnc, flat) = cnc ? 4 : flat ? 4.5 : useReversedBelts ? 5 : 6.5;

function leftDrivePulleyOffset() = useReversedBelts() ? [25.5 + largePulleyOffset, -0.5 - coreXYTROffsetY()]: [useXYDirectDrive ? 0 : 38 + 3*largePulleyOffset, 0];
function rightDrivePulleyOffset() = [useXYDirectDrive ? 0 : -25.5 - largePulleyOffset, useReversedBelts() ? (-0.5 - coreXYTROffsetY()) : 0];
//function leftDrivePulleyOffset() = useReversedBelts() ? [26, 5 - coreXYTROffsetY() + (use2060ForTopRear() ? -5.5 : -5.5)]: [useXYDirectDrive ? 0 : 38 + 3*largePulleyOffset, 0];
//function rightDrivePulleyOffset() = [useXYDirectDrive ? 0 : -42.5 - 3*largePulleyOffset, useReversedBelts() ? (5 - coreXYTROffsetY() + (use2060ForTopRear() ? -5.5 : -5.5)) : 0]; // need to give clearance to extruder motor

function xyMotorMountSize(motorWidth, offset, left=true, useReversedBelts=false, cnc=false, flat=false)
    = [ eX + 2*eSize + coreXY_drive_pulley_x_alignment(coreXY_type()) + motorWidth/2 + offset.x + 0.74,
        eY + 2*eSize + motorWidth/2 - (left ? offset.y : -offset.y) + 1.2,
        eZ + basePlateThickness(useReversedBelts, cnc, flat) + (left || useReversedBelts ? coreXYSeparation().z : 0)] - coreXYPosTR(motorWidth);
