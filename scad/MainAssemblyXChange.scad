//!# XChange adaptors
//!
//!MaybeCube supports the
//![Printermods XChange quick change tool head](https://www.kickstarter.com/projects/printermods/xchange-v10-hot-swap-tool-changing-for-every-3d-printer).


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageXChange.scad>
use <printed/X_CarriageAssemblies.scad>

include <utils/CoreXYBelts.scad>
include <utils/X_Rail.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>


module printheadXChange(rotate=0, explode=0, t=undef) {
    xRailCarriagePosition(carriagePosition(t), rotate)
        explode(explode, true)
            X_Carriage_XChange_assembly();
}


module XChange_assembly()
assembly("XChange", big=true) {

    xCarriageType = MGN12H_carriage;
    carriagePosition = carriagePosition();

    translate(-[eSize + eX/2, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)]) {
        if (!exploded())
            not_on_bom()
                CoreXYBelts(carriagePosition + [2, 0], x_gap=-25, show_pulleys=![1, 0, 0]);
        xRailCarriagePosition(carriagePosition, rotate=180) {
            explode([0, 60, 0])
                X_Carriage_XChange_assembly();
            no_explode()
                not_on_bom() {
                    X_Carriage_Belt_Side_MGN12H_assembly();
                    xCarriageBeltClampAssembly(xCarriageType, countersunk=true);
                }
            *translate_z(-carriage_height(xCarriageType))
                carriage(xCarriageType);
        }
    }
    not_on_bom()
        rail_assembly(xCarriageType, _xRailLength, pos=-2, carriage_end_colour="green", carriage_wiper_colour="red");
}

if ($preview)
    XChange_assembly();
