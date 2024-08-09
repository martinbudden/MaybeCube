//!# EVA 3.0 adaptors
//!
//!MaybeCube supports the [EVA modular printhead system](https://main.eva-3d.page). This allows a wide variety of hotends
//!and extruders to be used.
//!
//!Since the belt spacing used by the EVA system is different to that used by the MaybeCube,
//!an adaptor is required.
//!
//!The adaptor is **EVA_MC_mgn12_bottom_horns_fi.stl**.
//!
//!In the illustrations below, the EVA adaptor is printed in blue, MaybeCube standard parts are printed in red, and EVA standard parts are
//!printed in black and green.
//!
//!## License
//!
//!EVA is licensed under the [GNU General Public License v3.0](https://github.com/EVA-3D/eva-main/blob/main/LICENSE)
//!and EVA parts may be used under those terms.
//!
//!The MaybeCube EVA adaptors (ie all `.stl` files prefixed by "EVA_MC_") are hereby declared as a community contribution
//!to the EVA project and are so licensed under the [CC BY-SA 4.0 license](https://creativecommons.org/licenses/by-sa/4.0/)
//!as are all EVA community contributions.


include <config/global_defs.scad>

include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageEVA.scad>
include <utils/CoreXYBelts.scad>

use <config/Parameters_Positions.scad>
include <target.scad>


//$explode = 1;

//!1. Bolt the  **top_endstop_fi.stl** to the MGN12 carriage.
//!2. Bolt the **back_corexy_fi.stl** part to the top part.
//!3. Bolt the **EVA_MC_bottom_mgn12_short_duct.stl** part to the **back_corexy_fi.stl** part.
//!4. Insert the belts into the **X_Carriage_Belt_Tensioner.stl**s and then bolt the tensioners into the
//!**EVA_MC_mgn12_bottom_horns_fi.stl** part as shown.
//!5. Thread the belts through the printer pulleys and then clamp them to the **EVA_MC_mgn12_bottom_horns_fi.stl** part.
module EVA_3_0_Stage_1_assembly()
assembly("EVA_3_0_Stage_1", big=true) {

    xCarriageType = MGN12H_carriage;
    translate_z(carriage_height(xCarriageType)) {
        translate_z(-23)
            color(evaColorGrey())
                eva_3_0_ImportStl("top_endstop_fi");
        translate_z(-23)
            stl_colour(evaAdaptorColor())
                rotate([90, 0, 0])
                    EVA_MC_mgn12_bottom_horns_fi_stl();
        //evaHotendBaseTopHardware(explode=100);
        //evaHotendBaseBackHardware(explode=100);

        evaBeltTensioners();
        evaBeltTensionersHardware();

        explode([0, -20, 0], true, show_line=false) {
            stl_colour(pp2_colour)
                evaBeltClamp();
            evaBeltClampHardware();
        }

        translate([0, 1, -23]) {
            explode([0, 60, 0])
                stl_colour(evaColorGreen())
                    eva_3_0_ImportStl("back_core_xy_fi");
        }
    }
    *explode(40)
        not_on_bom()
            rail_assembly(xCarriageType, _xRailLength, pos=0, carriage_end_colour="green", carriage_wiper_colour="red");
    carriagePosition = carriagePosition();
    *if (!exploded())
        rotate(180)
            translate(-[eSize + eX/2, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)])
                not_on_bom()
                    CoreXYBelts(carriagePosition + [-2, 0], x_gap=-25);
}

//! Bolt the **front_universal_fi.stl** part to the **EVA_MC_top_bmg_mgn12** and **EVA_MC_bottom_mgn12_short_duct** parts.
module EVA_3_0_assembly()
assembly("EVA_3_0", big=true) {

    EVA_3_0_Stage_1_assembly();
    xCarriageType = MGN12H_carriage;
    translate_z(carriage_height(xCarriageType))
        evaHotendBackHardware(explode=60);

    //translate([0, 18.5, carriage_height(MGN12H_carriage) - 20.5])
        explode([0, -30, 0])
            //translate([0, -32, 0])
            translate_z(carriage_height(MGN12H_carriage)-23)
                stl_colour(evaColorGreen())
                    eva_3_0_ImportStl("front_universal_fi");
}

if ($preview)
    EVA_3_0_assembly();
