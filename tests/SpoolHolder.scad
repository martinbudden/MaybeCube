//!Displays the spool holder.

include <NopSCADlib/vitamins/spools.scad>
use <../scad/printed/SpoolHolder.scad>


module SpoolHolder_test() {
    rotate([0, 90, 180])
        Spool_Holder_stl();
    Spool_Holder_Bracket_stl();
    Spool_Holder_Bracket_hardware();

    spool = spool_200x60;
    *translate([0, 18.5, -spool_height(spool)/2 - 6.5])
        spool(spool, 30, "red");
}

module SpoolHolder_test1() {
    rotate([0, 90, 180])
        Spool_Holder_36_stl();
    Spool_Holder_Bracket_stl();
    Spool_Holder_Bracket_hardware();

    spool = ["spool_200x60id72", 200, 60, 60, 5, 2, 72, 78,  191];
    translate([0, 29, -spool_height(spool)/2 - 6.5])
        spool(spool, 30, "red");
}

if ($preview)
    SpoolHolder_test();
