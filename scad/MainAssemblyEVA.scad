//!# EVA adaptors
//
include <NopSCADlib/core.scad>
use <printed/X_CarriageEVA.scad>

module EVA_assembly()
assembly("EVA") {

   evaPrintheadList();
}

if ($preview)
    EVA_assembly();
