include <../vitamins/nuts.scad>


module railBoltsAndNuts(type, length, thickness) { //! Place bolts and tNuts in the rail
    screw = rail_screw(type);
    screw_len = screw_longer_than(rail_screw_height(type, screw) + thickness);

    if (is_undef($hide_bolts))
        translate_z(rail_screw_height(type, screw)) {
            for (i = length==250 ? [0, 2, 4] : length==300 ? [0, 1, 3, 5] : [0, 2, 4, 6])
                explode(10, true)
                    rail_hole_positions(type, length, i, 1) {
                        screw(screw, screw_len);
                        translate_z(-5.55)
                            vflip()
                                explode(20)
                                    nutM3Hammer();
                }
        }
}
