//!# MaybeCube Assembly Instructions
//!
//!These are the assembly instructions for the MaybeCube. These instructions are not fully comprehensive, that is they do
//!not show every small detail of the construction and in particular they do not show the wiring. However there is
//!sufficient detail that someone with a good understanding of 3D printers can build the MaybeCube.
//!
//!![Main Assembly](assemblies/main_assembled.png)
//!
//!## Read this before you order parts
//!
//!2020, 2040 etc aluminium comes in variants with differing sized center holes - some are suitable for tapping for an
//!an M5 bolt and some are suitable for tapping for an M6 bolt. It doesn't really matter which you use, but ensure you
//!buy the bolts that correspond to your extrusion size. These build instructions assume M5 bolts, if your extrusion
//!requires M6 bolts then the 10mm and 12mm buttonhead M5 bolts should be replaced with M6 bolts.
//!
//!The motor for the Z-axis has an integrated lead screw: in the *Parts List* the length specified is the length that
//!protrudes from the motor. Some suppliers specify the total length of the lead screw, that is including the part that
//!is inside the motor, so check how your supplier specifies the part before ordering. Another option is to order a motor
//!with a lead screw that is too long and cut to size, not however that lead screws are made from hardened steel and cannot
//!be cut with a hacksaw - an angle grinder is required to cut them.
//!
//!For the MC350 variant I have specified an Ender-style 235x235mm print bed with 4 fixing bolts - this is because they are
//!readily available and cheap. A better solution is to use an aluminium tooling plate drilled for a 3 point fixing and a
//!silicone heating pad.
//!
//!This is a full build, some parts can be omitted to save cost, in particular:
//!
//!* the Raspberry Pi Camera and corresponding 8mm M2 caphead bolts
//!* the Raspberry Pi (if you don't want to run Octoprint or Klipper) and corresponding buck converter and 12mm M2 caphead bolts
//!* the filament sensor
//!* the Big Tree Tech relay module, if you don't want auto shut off
//!* the Big Tree Tech TFT display, if you are running Octoprint or Klipper
//!* I've specified a Big Tree Tech mainboard and display, you of course can use any mainboard and display you like
//!* the polycarbonate side and back panels, if you don't want to enclose your print volume for (say) printing ABS. Note
//!that these panels also add rigidity to the printer.
//!
//!I've specified buttonhead bolts for the side and back panels. For a neater look you could countersink the holes and
//!use countersunk bolts.
//!
//!## Printing the parts
//!
//!A number of parts are in proximity with heat sources, namely the hotend, the heated bed and the motors. Ideally these
//!should be printed in ABS, but I have used PETG successfully. These parts are insulated from direct contact with the heat
//!sources, by cork underlay (for the heated bed) and by cork dampers (for the motors). These insulators should not be
//!omitted from the build.
//
include <global_defs.scad>

include <MainAssemblies.scad>

//!1. Bolt the polycarbonate sheet to the left face.
//!2. Attach the spoolholder and filament spool to the right face.
//!3. You are now ready to level the bed and calibrate the printer.
//
module main_assembly() assembly("main") {
    FinalAssembly();
}

if ($preview)
    main_assembly();
