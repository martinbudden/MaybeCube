//!Displays the spool holder.

use <../scad/printed/SpoolHolder.scad>


module SpoolHolder_test() {
    translate([0, 30, 0])
        rotate([0, 90, 0])
            Spool_Holder_stl();
    Spool_Holder_Bracket_stl();
    Spool_Holder_Bracket_hardware();
}

if ($preview)
    SpoolHolder_test();
