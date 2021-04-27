//!Displays the spool holder.

use <../scad/printed/SpoolHolder.scad>

module SpoolHolder_test() {
    Spool_Holder_stl();
}

if ($preview)
    SpoolHolder_test();
