include <../global_defs.scad>

include <NopSCADlib/core.scad>

use <NopSCADlib/utils/sweep.scad>
use <NopSCADlib/utils/maths.scad>
use <NopSCADlib/utils/bezier.scad>
use <NopSCADlib/utils/tube.scad>

module bezierTube(curPos, pos, tubeRadius = 2, bowdenTube = false, length = undef) {

    endPos = curPos - pos;
    p = [ [0, 0, 0], [0, 0, 100], [0, 0, 150], [endPos.x/2, endPos.y/2, 250], endPos+[0, 0, 125], endPos];
    path = bezier_path(p, 50);

    tubeLength  = length ? length : ceil(bezier_length(p));
    if (bowdenTube)
        vitamin(str("bezierTube(): PTFE Bowden tube, ", tubeLength, " mm"));

    translate(pos)
        sweep(path, circle_points(tubeRadius, $fn = 64));
}
