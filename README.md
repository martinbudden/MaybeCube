# MaybeCube

The **MaybeCube** is a CoreXY 3D printer with a linear rails motion system.

![Main Assembly](MC300/assemblies/main_assembled.png)

![MaybeCube300](pictures/maybecube300_1000.jpg)

The MaybeCube MC350 variant has a print volume of approximately 230mm by 230mm by 200mm.

The dimensions of the main MC350 cuboid are 390mm by 390mm by 400mm, and the enclosing volume (including the display, extruder, and feet, but excluding the spool holder, Bowden tube and hotend wiring) is about 405mm by 475mm by 415mm.

## Assembly instructions

The MaybeCube is still in development and these build instructions are incomplete. They are posted to allow prospective
builders a chance to look at the design and decide if they might want to build it in future. If you are an experienced constructor of 3D printers then there is probably sufficient information for you to fill in the gaps and construct the printer.

The "standard" size is the MC350 variant. I have built the MC300 variant for two reasons: to test sizing (if the components fit in the MC300 variant, then they will fit in larger variants); and because had a quantity of 300mm extrusion and the right size heated bed from an earlier project.

The assembly instructions and the BOM (parts list) for the MC350 variant will be made available when they are ready.

The assembly instructions and the BOM for the MC300 variant are [here](MC300/readme.md). The STL files are [here](MC300/stls). These are still a work in progress and are provided to allow familiarisation with the design prior to assembly.

I plan to make a series of YouTube videos giving build instructions, when I have done so I will post a link here. I won't start these, however, until I have completed the BabyCube build videos and completed the build instructions of the MaybeCube.

If you would like to build a smaller printer, you may be interested in the MaybeCube's smaller sibling, the [BabyCube](https://github.com/martinbudden/BabyCube).

## Design Goals

1. **Make the MaybeCube more easily usable in home environment (as opposed to garage or workshop)**
     * try and make it easy to transport and store the MaybeCube, so:
     * integrated design, everything is enclosed within the printer's frame with. This includes the motors,
       the motion system, the power supply, and the circuit boards. The only exceptions are the
       extruder motor and the spool holder, both of which can be removed for transport and storage.
     * include base plate so underside of printer is not exposed
     * all protrusions from frame (filament spool, extruder, power connector) are on the right hand side to minimise desk clutter
       and allow the back of the MaybeCube to be pushed right against a wall
     * all protrusions from the frame can be easily removed for storage
     * clean wiring - route wiring in extrusion channels where possible and minimise exposed wiring
2. **Improve ease of assembly**
     * Use internal blind joints on the frame
     * printed parts designed so that bolts are accessible and can be tightened when frame fully assembled (that is bolt holes are not blocked by other parts when assembled)
     * divide the main assembly into a number of independent sub-assemblies.
     * where possible printed parts push up right against frame and so "auto-align"
     * facilitate building in different size variants
3. **Use linear rails for the x and y axes**
     * linear rails are now not much more expensive than linear rods
     * linear rails make design and assembly easier, reducing the need for custom printed parts
     * linear rods are used for the z-axis, since linear rails offer no advantage here
4. **Maximise frame rigidity**
     * one of my goals is to experiment with high print speeds. A highly rigid frame allows higher acceleration settings
     * use 2040 aluminium extrusion, corner joints are about 4 times more rigid than 2020 corner joints and 2-3 times more rigid than 3030 corner joints
5. **Maximise build volume for selected extrusion lengths**
     * Z-axis assembly is on the left side of MaybeCube. This means the Z-axis assembly does not impede travel in the Y direction
     * The printhead is quite compact, so does not significantly restrict travel in the X and Y directions
6. **Enable a fully enclosed print volume**
     * The cubic shape makes enclosure straightforward.
     * Additionally a panel can be placed between the electronics and stepper motors on the back face and the build volume
     * A slide-in front panel can be added
     * A top enclosure can be placed on the frame
7. **Try and keep the costs down**
     * the aim is not to be as cheap as possible, but rather to avoid unnecessary costs
     * use standard extrusions lengths, as far as possible, so no custom cutting is required
8. **Facilitate customisation and experimentation**
     * Open source design
     * Parametric design in OpenSCAD
     * The open design of the frame and the easy accessibility of parts means the MaybeCube is fairly easy to customise - most parts can be changed without the need to disassemble large parts of the frame

## Variations

The canonical form is the MC350 variant.

 variant | ExtrusionSizes | Rail/rod lengths | Approx Build Volume | Bed Size   | Exterior Dimensions
 --------| -------------- | ---------------- | ------------------- | ---------- | -------------------
 MC250   | x250 y250 z350 | x200 y250 z250   | concept variant     | 180mm      | 290 x 290 x 350
 MC300   | x300 y300 z400 | x250 y300 z300   | 180 x 180 x 200     | 214mm      | 340 x 340 x 400
 MC350   | x350 y350 y400 | x300 y350 z300   | 230 x 230 x 200     | 235mm      | 390 x 390 x 400
 MC400   | x400 y400 y450 | x350 y400 z350   | 280 x 280 x 250     | 310mm      | 440 x 440 x 450

 For reference, the original [HyperCube](https://www.thingiverse.com/thing:1752766) has extrusion sizes of x340 y303 z350 to give a build volume of 200 x 200 x 155.

## Frame stiffness

The MaybeCube is a cuboid with 6 rectangular faces. Rectangles have no inherent rigidity and are subject to shearing. The rigidity of a rectangle is provided solely by the strength of its joints, and these often do not provide sufficient rigidity.
A small movement at a joint is magnified into a much larger movement at the end of a 400mm extrusion.
There are three main ways to increase the rigidity of rectangles:

1. triangulation, where the a diagonal piece divides the rectangle into two triangles, this is exemplified in [truss bridges](https://en.wikipedia.org/wiki/Truss_bridge)
2. using a shear plate, this is exemplified in the [sheer boards](https://en.wikipedia.org/wiki/Shear_wall) used to stiffen wooden framed buildings
3. reinforcing the joints.

The MaybeCube uses 2040 extrusions, these have twice the contact area at the joints and provide significantly more joint rigidity than 2020 extrusions. Additionally the MaybeCube uses shear plates on the bottom, back, left and (optionally) right faces to stiffen the frame.

The front face of the MaybeCube is the most subject to shearing, since it needs to be open to allow access to the printbed. Two measures are taken to counteract this: 2080 rather than 2040 extrusion is used at the bottom of the face, and the idler mounts at the top are extended to provide some triangulation and reinforcement of the upper joints.

## Customisations

## EVA module printhead system

In its default configuration the MaybeCube has an E3D V6 hotend with a Bowden extruder. However I've created adaptors
so that the [EVA modular printhead system](https://main.eva-3d.page) can be used. The EVA system supports a wide variety
of hotends and extruders. More details on using the EVA adaptors are [here](https://github.com/martinbudden/MaybeCube/tree/main/EVA).

## Printermods XChange quick change tool head

I've created an adaptor for the
[Printermods XChange quick change tool head](https://www.kickstarter.com/projects/printermods/xchange-v10-hot-swap-tool-changing-for-every-3d-printer).
More details on using the XChange adaptor are [here](https://github.com/martinbudden/MaybeCube/tree/main/XChange).

### E3D tool changer

Currently there is no adaptor for the  [E3D tool changer](https://e3d-online.com/pages/toolchanger), however I think it would be fairly straightforward to create one.

There should be room to dock at least two, and perhaps three [E3D ToolChanger Tools](https://e3d-online.com/products/toolchanger-tools) in the back of the MC350, this would allow experimenting with the E3D docking system in a framework
considerably less expensive than the [E3D Motion System](https://e3d-online.com/products/e3d-motion-system).

## License

MaybeCube is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Licence](https://creativecommons.org/licenses/by-nc-sa/4.0/)
(CC BY-NC-SA 4.0)<br />
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a>
