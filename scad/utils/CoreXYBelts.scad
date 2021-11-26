include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/core_xy.scad>

include <../Parameters_CoreXY.scad>


module CoreXYBelts(carriagePosition, x_gap=0, show_pulleys=false, xyMotorWidth=undef, leftDrivePulleyOffset=leftDrivePulleyOffset(), rightDrivePulleyOffset=rightDrivePulleyOffset(), plainIdlerPulleyOffset=plainIdlerPulleyOffset()) {
    assert(is_list(carriagePosition) && len(carriagePosition) == 2);

    xyMotorWidth = is_undef(xyMotorWidth) ? _xyMotorDescriptor == "NEMA14" ? 35.2 : _xyMotorDescriptor == "BLDC4250"? 56 : 42.3 : xyMotorWidth;
    //!!TODO - fix magic number 23
    coreXY_belts(coreXY_type(),
        carriagePosition = carriagePosition + [coreXYPosBL().x - x_gap - 23, 0],
        coreXYPosBL = coreXYPosBL(),
        coreXYPosTR = coreXYPosTR(xyMotorWidth),
        separation = coreXYSeparation(),
        x_gap = x_gap,
        //plain_idler_offset = plainIdlerPulleyOffset,
        upper_drive_pulley_offset = [-rightDrivePulleyOffset.x, rightDrivePulleyOffset.y],
        lower_drive_pulley_offset = [-leftDrivePulleyOffset.x, leftDrivePulleyOffset.y],
        left_lower = true,
        show_pulleys = show_pulleys);
}
