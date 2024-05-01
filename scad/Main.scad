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
//!**Extrusion:** 2020, 2040 etc aluminium comes in variants with differing sized center holes - some are suitable for tapping for an
//!an M5 bolt and some are suitable for tapping for an M6 bolt. It doesn't really matter which you use, but ensure you
//!buy the bolts that correspond to your extrusion size. These build instructions assume M5 bolts, if your extrusion
//!requires M6 bolts then the 10mm and 12mm buttonhead M5 bolts should be replaced with M6 bolts.
//!
//!**Z-motor and leadscrew:** The motor for the Z-axis has an integrated lead screw: in the *Parts List* the length specified is the length that
//!protrudes from the motor. Some suppliers specify the total length of the lead screw, that is including the part that
//!is inside the motor, so check how your supplier specifies the part before ordering. Another option is to order a motor
//!with a lead screw that is too long and cut to size, note however that lead screws are made from hardened steel and cannot
//!be cut with a hacksaw - an angle grinder is required to cut them.
//!
//!**Build plate:** For the MC350 variant I have specified a Voron Trident build plate (this is an 250x250mm aluminium tooling plate drilled for a
//!3-point fixing) and a silicone heating pad.
//!A cheapr alternative would be an Ender-style 235x235mm print bed with 4 fixing bolts.
//!
//!**Sliding T-nuts and hammer nuts:** Sliding T-nuts and hammer nuts are somewhat interchangeable. I find T-nuts easier to use: sometimes it can be
//!to get a hammer nut to "bite". Hammer nuts allow more flexibility: they can always be added or removed without disassembling the frame. Genenerally
//!hammer nuts can be replaced with sliding T-nuts, as long as it is done early enough in the assembly. Sliding T-nuts can always be replaced with hammer
//!nuts.
//!
//!**Washers/shims:** Standard M4 washers are 1mm thick. Where "M4 x 9mm x 0.5mm" washers are specified, these may be ordered as "M4 shims".
//!
//!**Side panels and base:** These are specified as "CNC routed parts" in the parts list, for the convenience of those with access to a CNC. CNC routing
//!is not required, the only "machining" required is to drill holes for attachment to the frame, which can easily be done with a hand drill.
//!
//!
//!This is a full build, some parts can be omitted to save cost, in particular:
//!
//!* the Big Tree Tech relay module, if you don't want auto shut off
//!* I've specified a Big Tree Tech mainboard, you of course can use any mainboard you like
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
