//!# EVA 2.4.2 adaptors
//!
//!MaybeCube supports the [EVA modular printhead system](https://main.eva-3d.page). This allows a wide variety of hotends
//!and extruders to be used.
//!
//!Since the belt spacing used by the EVA system is different to that used by the MaybeCube
//!adaptors are required, an adaptor for the EVA top part and an adaptor for the EVA bottom part.
//!
//!The bottom adaptor is **EVA_MC_bottom_mgn12_short_duct.stl**.
//!The top adaptor varies according to the extruder used - the part name is the same as the EVA part, but prefixed by **EVA_MC_**.
//! So for example if you wanted to used the BMG extruder then you should use part **EVA_MC_bmg_mgn12.stl**
//!(rather than part **bmg_mgn12.stl** that you would ordinarily use).
//!
//!In the illustrations below, EVA adaptors are printed in blue, MaybeCube standard parts are printed in red, and EVA standard parts are
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


include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/screws.scad>
include <NopSCADlib/vitamins/rails.scad>

use <printed/X_CarriageEVA.scad>
include <utils/CoreXYBelts.scad>

use <../scad/Parameters_Positions.scad>
include <target.scad>


//$explode = 1;

//!1. Bolt the top part to the MGN12 carriage. This example uses the **EVA_MC_top_bmg_mgn12.stl** part, you should use the part
//!appropriate to your extruder.
//!2. Bolt the **back_corexy.stl** part to the top part.
//!3. Bolt the **EVA_MC_bottom_mgn12_short_duct.stl** part to the **back_corexy.stl** part.
//!4. Insert the belts into the **X_Carriage_Belt_Tensioner.stl**s and then bolt the tensioners into the
//!**EVA_MC_bottom_mgn12_short_duct.stl** part as shown.
//!5. Thread the belts through the printer pulleys and then clamp them to the **EVA_MC_bottom_mgn12_short_duct.stl** part.
module EVA_2_4_2_Stage_1_assembly()
assembly("EVA_2_4_2_Stage_1", big=true) {

    hidden()
        stl_colour(evaAdaptorColor())
            evaPrintheadList();

    xCarriageType = MGN12H_carriage;
    translate_z(carriage_height(xCarriageType)) {
        stl_colour(evaAdaptorColor())
            not_on_bom() {
                evaHotendTop(top="bmg_mgn12", explode=60);
                evaHotendBottom();
            }

        evaHotendBaseTopHardware(explode=100);
        evaHotendBaseBackHardware(explode=100);

        evaBeltTensioners();
        evaBeltTensionersHardware();

        explode([0, -20, 0], true, show_line=false) {
            stl_colour(pp2_colour)
                evaBeltClamp();
            evaBeltClampHardware();
        }

        translate([0, 18.5 + evaBeltAlignmentZ(), -20.5])
            explode([0, 60, 0])
                stl_colour(evaColorGreen())
                    back_corexy_stl();
    }
    explode(40)
        not_on_bom()
            rail_assembly(xCarriageType, _xRailLength, pos=0, carriage_end_colour="green", carriage_wiper_colour="red");
    carriagePosition = carriagePosition();
    *if (!exploded())
        rotate(180)
            translate(-[eSize + eX/2, carriagePosition.y, eZ - yRailOffset().x - carriage_clearance(xCarriageType)])
                not_on_bom()
                    CoreXYBelts(carriagePosition + [-2, 0], x_gap=-25);
}

//! Bolt the **universal_face.stl** part to the **EVA_MC_top_bmg_mgn12** and **EVA_MC_bottom_mgn12_short_duct** parts.
module EVA_2_4_2_assembly()
assembly("EVA_2_4_2", big=true) {

    EVA_2_4_2_Stage_1_assembly();
    xCarriageType = MGN12H_carriage;
    translate_z(carriage_height(xCarriageType))
        evaHotendBaseFrontHardware(explode=60);

    translate([0, 18.5, carriage_height(MGN12H_carriage) - 20.5])
        explode([0, -30, 0])
            translate([0, -32, 0])
                stl_colour(evaColorGreen())
                    universal_face_stl();
}

if ($preview)
    EVA_2_4_2_assembly();
