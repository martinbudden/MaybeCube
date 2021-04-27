//!# MaybeCube Assembly Instructions
//!
//!![Main Assembly](assemblies/main_assembled.png)
//!## Part substitutions - read this before you order parts
//!
//!1. Most M3 button head bolts can be replaced with M3 cap head bolts.
//!2. The M3 hammer t-nuts and sliding t-nuts are mostly interchangeable. The exception being that hammer nuts are required for the
//!   thumbscrews on the extruder and spool holder. I find sliding t-nuts make for easier assembly, since they always "bite", and
//!   hammer nuts are better for parts that may be removed, like the side panels and baseplate.
//!3. The y-axis linear rails are specified to be 50mm shorter than the y-axis extrusions - eg 300mm linear rails are used with
//!   350mm extrusions. However the y-axis linear rails can be the same length as the extrusions, so 350mm linear rails could be
//!   used with 350mm extrusions. There is no such flexibility in the x-axis, however.
//!
include <global_defs.scad>

include <NopSCADlib/core.scad>

use <MainAssemblies.scad>

//!1. Attach the extruder and the spoolholder to the right face.
//!
//!2. Connect the Bowden tube between the extruder and the printhead.
//!
//!3. Attach the polycarbonate sheet to the back of the print. Make sure everything is square before tightening the bolts.
//!
module main_assembly() assembly("main") {
    FinalAssembly();
}

if ($preview) {
    main_assembly();
}
