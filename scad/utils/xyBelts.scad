include <../global_defs.scad>

include <NopSCADlib/core.scad>
use <NopSCADlib/utils/core_xy.scad>

include <../Parameters_CoreXY.scad>

module xyBelts(carriagePosition, x_gap=20, show_pulleys=false) {
    assert(is_list(carriagePosition));

    NEMA_width = _xyNemaType == "14" ? 35.2 : 42.3;

    coreXY_belts(coreXY_type(),
        carriagePosition = carriagePosition + [-coreXYPosBL().x, 0],
        coreXYPosBL = coreXYPosBL(),
        coreXYPosTR = coreXYPosTR(NEMA_width),
        separation = coreXYSeparation(),
        x_gap = x_gap,
        upper_drive_pulley_offset = -rightDrivePulleyOffset(),
        lower_drive_pulley_offset = -leftDrivePulleyOffset(),
        left_lower = true,
        show_pulleys = show_pulleys);
}
