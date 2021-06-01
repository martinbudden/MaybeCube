include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/core_xy.scad>

include <../Parameters_CoreXY.scad>


module CoreXYBelts(carriagePosition, x_gap=20, show_pulleys=false, xyMotorWidth=undef) {
    assert(is_list(carriagePosition) && len(carriagePosition) == 2);

    xyMotorWidth = is_undef(xyMotorWidth) ? _xyMotorDescriptor == "NEMA14" ? 35.2 : _xyMotorDescriptor == "BLDC4250"? 56 : 42.3 : xyMotorWidth;

    coreXY_belts(coreXY_type(),
        carriagePosition = carriagePosition + [-coreXYPosBL().x, 0],
        coreXYPosBL = coreXYPosBL(),
        coreXYPosTR = coreXYPosTR(xyMotorWidth),
        separation = coreXYSeparation(),
        x_gap = x_gap,
        upper_drive_pulley_offset = -rightDrivePulleyOffset(),
        lower_drive_pulley_offset = -leftDrivePulleyOffset(),
        left_lower = true,
        show_pulleys = show_pulleys);
}
