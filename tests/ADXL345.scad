//! Display a ADXL345 pcb

include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

include <../scad/vitamins/pcbs.scad>


module ADXL345_test() {
    pcb(ADXL345);
}

if ($preview)
    ADXL345_test();
