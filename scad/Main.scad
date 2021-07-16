//!# MaybeCube Assembly Instructions
//!
//!The MaybeCube is still in development and these build instructions are incomplete. They are posted to allow prospective builders a
//!chance to look at the design and decide if they might want to build it in future. If you are an experienced constructor of 3D printers
//!then there is probably sufficient information for you to fill in the gaps and construct the printer.
//!
//!![Main Assembly](assemblies/main_assembled.png)
//!
//!## Printing the parts
//!
//!
//!A number of parts are in proximity with heat sources, namely the hotend, the heated bed and the motors. Ideally these should be
//!printed in ABS, but I have used PETG with some success.  These parts are insulated from direct contact with the heat sources, by
//!cork underlay (for the heated bed) and by cork dampers (for the motors). These insulators should not be omitted from the build.
//
include <global_defs.scad>

include <NopSCADlib/core.scad>

use <MainAssemblies.scad>

//!1. Bolt the polycarbonate sheet to the left face.
//!2. Attach the spoolholder and filament spool to the right face.
//
module main_assembly() assembly("main") {
    FinalAssembly();
}

if ($preview) {
    main_assembly();
}
