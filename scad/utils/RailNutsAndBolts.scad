include <../vitamins/nuts.scad>


module railBoltsAndNuts(type, length, thickness) { //! Place bolts and tNuts in the rail
    screw = rail_screw(type);
    screw_len = screw_longer_than(rail_screw_height(type, screw) + thickness);

    if (is_undef($hide_bolts))
        translate_z(rail_screw_height(type, screw)) {
            for (i = length==250 ? [0, 2, 4, 5, 7] : length==300 ? [0, 2, 4, 7, 9] : length== 350 ? [0, 2, 4, 6, 7, 9, 11] : [0, 2, 4, 6, 7, 9, 11, 13])
                explode(10, true)
                    rail_hole_positions(type, length, first=i, screws=1, both_ends=false) {
                        screw(screw, screw_len);
                        translate_z(-5.55)
                            vflip()
                                explode(20)
                                    nutM3SlidingT();
                }
        }
}
