//!# Tool Changers
//!
//!This is proof of concept showing the MaybeCube with the Jubilee tool changers, which are compatible with the E3D
//!tool changers. It uses the
//![Jubilee toolchanger carriage](https://docs.google.com/viewer?url=github.com/machineagency/jubilee/raw/main/frame/assembly_instructions/toolchanger_mechanism/toolchanger_carriage_assembly_instructions_draft.pdf),
//!the
//![Jubilee toolchanger remote lock](https://docs.google.com/viewer?url=github.com/machineagency/jubilee/raw/main/frame/assembly_instructions/toolchanger_mechanism/toolchanger_lock_assembly_instructions.pdf),
//!and the
//![Jubilee Bondtech extruder](https://jubilee3d.com/index.php?title=Bondtech_Direct_Drive_Extruder)
//!
//!It is not complete, in particular a MaybeCube X_Carriage adaptor is still required.
//
include <config/global_defs.scad>
include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>

use <../scad/printed/JubileeToolChanger.scad>

include <utils/X_Rail.scad>

use <assemblies/FaceTop.scad>

use <config/Parameters_Positions.scad>
include <target.scad>

//$explode = 1;
//$pose = 1;

t = 2;
carriagePosition = carriagePosition(t);


module toolChanger(t=2, tool=undef, plate="jubilee") {
    offsetZ = -15;
    translate_z(offsetZ)
    xRailCarriagePosition(carriagePosition(t))
        rotate(180) {
            no_explode()
                translate_z(-offsetZ)
                    carriage_top_plate_assembly();
            explode([0, -50, 0])
                carriage_back_plate_assembly();
            //carriage_center_plate_assembly();
            if (plate=="jubilee")
                carriage_coupler_plate_assembly();
            else if (plate=="EC")
                E3D_TC_PLATE_assembly();
            explode(100)
            translate([0, 2, 0])
                if (tool=="bondtech")
                    bondtech_assembly(plate_only=false);
                else if (tool=="pen")
                    pen_assembly();
        }
}

module tools() {
    translate([130, eY + eSize, eZ])
        explode([-100, 0, 0])
            mirror([1, 0, 0])
                lock_actuator_assembly();
    function xToolPos(i) = [175, 260, 345][i];
    for (i= eX <= 350 ? [0, 1] : [0, 1, 2])
        translate([xToolPos(i), eY + eSize, eZ - 28.5]) {
            explode([0, 75, 0])
                tool_dock_55mm_assembly();
            if (i == 1 || i == 2) {
                translate([0, -82, 8.5])
                    explode([0, -50, 100])
                        bondtech_assembly();
                //parking_post_47mm_assembly();
                //tool_dock_47mm_assembly();
                *translate([0, -72, 8.5])
                    pen_assembly();
            } else if (i == 2) {
                //parking_post_55mm_assembly();
                tool_dock_55mm_assembly();
            }
        }
}

module JubileeToolChanger_assembly()
assembly("JubileeToolChanger", big=true) {
    explode(100, true) {
        toolChanger(t, "bondtech");
        tools();
    }
    not_on_bom()
        no_explode()
            Face_Top_Stage_2_assembly();
}


if ($preview)
    translate(-[eSize + eX/2, carriagePosition.y])
        translate_z(-(eZ - yRailOffset().x - carriage_clearance(carriageType(_xCarriageDescriptor))))
            JubileeToolChanger_assembly();
