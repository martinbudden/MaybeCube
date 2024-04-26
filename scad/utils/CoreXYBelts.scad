include <../utils/CoreXYReversed.scad>

include <../Parameters_CoreXY.scad>


module CoreXYBelts(carriagePosition, coreXY_type=coreXY_type(), x_gap=0, show_pulleys=false, xyMotorWidth=undef, leftDrivePulleyOffset=leftDrivePulleyOffset(), rightDrivePulleyOffset=rightDrivePulleyOffset(), plainIdlerPulleyOffset=plainIdlerPulleyOffset()) {
    assert(is_list(carriagePosition) && len(carriagePosition) == 2);

    xyMotorWidth = is_undef(xyMotorWidth) ? _xyMotorDescriptor == "NEMA14" ? 35.2 : _xyMotorDescriptor == "BLDC4250"? 56 : 42.3 : xyMotorWidth;
    if (useReversedBelts())
        coreXYR_belts(coreXY_type,
            carriagePosition = [eX + 2*eSize - carriagePosition.x - x_gap, carriagePosition.y],
            coreXYPosBL = coreXYPosBL(),
            coreXYPosTR = coreXYPosTR(xyMotorWidth),
            separation = coreXYSeparation(),
            offset_y = coreXYOffsetY(),
            x_gap = x_gap,
            plain_idler_offset = plainIdlerPulleyOffset,
            upper_drive_pulley_offset = [-rightDrivePulleyOffset.x, rightDrivePulleyOffset.y],
            lower_drive_pulley_offset = [-leftDrivePulleyOffset.x, leftDrivePulleyOffset.y],
            left_lower = true,
            show_pulleys = show_pulleys);
    else
        coreXY_belts(coreXY_type,
            carriagePosition = [eX + 2*eSize - carriagePosition.x - x_gap, carriagePosition.y],
            coreXYPosBL = coreXYPosBL(),
            coreXYPosTR = coreXYPosTR(xyMotorWidth),
            separation = coreXYSeparation(),
            offset_y = coreXYOffsetY(),
            x_gap = x_gap,
            plain_idler_offset = plainIdlerPulleyOffset,
            upper_drive_pulley_offset = [-rightDrivePulleyOffset.x, rightDrivePulleyOffset.y],
            lower_drive_pulley_offset = [-leftDrivePulleyOffset.x, leftDrivePulleyOffset.y],
            left_lower = true,
            show_pulleys = show_pulleys);
}
