//!Displays the spool holder.

use <../scad/printed/SpoolHolder.scad>


module SpoolHolder_test() {
    rotate([0, 90, 180])
        Spool_Holder_stl();
    Spool_Holder_Bracket_stl();
    Spool_Holder_Bracket_hardware();
}

if ($preview)
    SpoolHolder_test();
