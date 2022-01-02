//!# MaybeCube Assembly Instructions
//!
//!These are the assembly instructions for the MaybeCube. These instructions are not fully comprehensive, that is they do
//!not show every small detail of the construction and in particular they do not show the wiring. However there is sufficient
//!detail that someone with a good understanding of 3D printers can build the MaybeCube.
//!
//!![Main Assembly](assemblies/main_assembled.png)
//!
//!## Printing the parts
//!
//!A number of parts are in proximity with heat sources, namely the hotend, the heated bed and the motors. Ideally these should be
//!printed in ABS, but I have used PETG successfully. These parts are insulated from direct contact with the heat sources, by
//!cork underlay (for the heated bed) and by cork dampers (for the motors). These insulators should not be omitted from the build.
//
include <global_defs.scad>

include <MainAssemblies.scad>

//!1. Bolt the polycarbonate sheet to the left face.
//!2. Bolt the polycarbonate sheet and the **Access_Panel** to the right face.
//!3. Attach the spoolholder and filament spool to the right face.
//!4. You are now ready to level the bed and calibrate the printer.
//
module main_assembly() assembly("main") {
    FinalAssembly();
}

if ($preview)
    main_assembly();
