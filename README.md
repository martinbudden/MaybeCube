# MaybeCube

The **MaybeCube** is a CoreXY 3D printer with a linear rails motion system.

![Main Assembly](MC350/assemblies/main_assembled.png)

The MaybeCube MC350 variant has a print volume of approximately 230mm by 230mm by 200mm.

The dimensions of the main MC350 cuboid are 390mm by 390mm by 400mm, and the enclosing volume (including the display, extruder, and feet, but excluding the spool holder, Bowden tube and hotend wiring) is about 405mm by 475mm by 415mm.

## Assembly instructions

The MaybeCube is still in development and these build instructions are incomplete. They are posted to allow prospective builders a
chance to look at the design and decide if they might want to build it in future. If you are an experienced constructor of 3D printers then there is probably sufficient information for you to fill in the gaps and construct the printer.

The assembly instructions and the BOM (parts list) for the MC350 variant are [here](MC350/readme.md). The STL files are [here](MC350/stls).

The assembly instructions and the BOM for the MC300 variant are [here](MC300/readme.md). The STL files are [here](MC300/stls).

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
5. **Maximise build volume for selected extrusion lengths**
     * Z-axis assembly is on the left side of MaybeCube. This means the Z-axis assembly does not impede travel in the Y direction
6. **Try and keep the costs down**
     * the aim is not to be as cheap as possible, but rather to avoid unnecessary costs
     * use standard extrusions sizes
7. **Facilitate customisation and experimentation**
     * Open source design
     * Parametric design in OpenSCAD
     * The open design of the frame and the easy accessibility of parts means the MaybeCube is fairly easy to customise - most parts can be changed without the need to disassemble large parts of the frame

## Variations

The canonical form is the MC350 variant.

 variant | ExtrusionSizes | Rail/rod lengths | Approx Build Volume | Bed Size   | Exterior Dimensions
 --------| -------------- | ---------------- | ------------------- | ---------- | -------------------
 MC250   | x250 y250 z350 | x200 y250 z250   | concept variant     | 180mm      | 290 x 290 x 350
 MC300   | x300 y300 z400 | x250 y300 z300   | 180 x 185 x 200     | 214mm      | 340 x 340 x 400
 MC350   | x350 y350 y400 | x300 y350 z300   | 230 x 235 x 200     | 235mm      | 390 x 390 x 400
 MC400   | x400 y400 y450 | x350 y400 z350   | 280 x 285 x 250     | 310mm      | 440 x 440 x 450

 For reference, the original HyperCube has extrusion sizes of x340 y303 z350 to give a build volume of 200 x 200 x 155.

## Frame stiffness

The MaybeCube is a cuboid with 6 rectangular faces. Rectangles have no inherent rigidity and are subject to shearing. The rigidity of a rectangle is provided solely by the strength of its joints, and these often do not provide sufficient rigidity.
A small movement at a joint is magnified into a much larger movement at the end an extrusion 400mm away.
There are three main ways to increase the rigidity of rectangles:

1. triangulation, where the a diagonal piece divides the rectangle into two triangles, this is exemplified in [truss bridges](https://en.wikipedia.org/wiki/Truss_bridge)
2. using a shear plate, this is exemplified in the [sheer boards](https://en.wikipedia.org/wiki/Shear_wall) used to stiffen wooden framed buildings
3. reinforcing the joints.

The MaybeCube uses 2040 extrusions, these have twice the contact area at the joints and provide significantly more rigidity than joints between 2020 extrusion. Additionally the MaybeCube uses shear plates on the bottom, left and back faces to stiffen the frame.

## Customisations

### E3D tool changer

While the MaybeCube was not specifically designed to use the E3D tool changer, it was designed with it in mind. That is, I tried to avoid any design decisions that would preclude the use of the tool changer. In particular the x-axis linear rail
is mounted horizontally, so it should be possible to use the E3D x-carriage (although the belt separation may be different,
so this may require variations in some of the printed components.
MaybeCube is a parametric design, so it it is possible to regenerate the printed parts for a different belt separation. Alternatively it might be better to design a new x-carriage for the E3D toolhead.
There is space in the back face for toolheads and docks. I imagine there is space for 2 or possibly 3 toolhead and docks in the back face of the 350 variant.
Having said that, I have not tried to do this and would be interested in feedback from anyone who does try this. It would be good to be able to support experimenting with the docking system by providing a framework less expensive than the E3D motion system.

## License

MaybeCube is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Licence](https://creativecommons.org/licenses/by-nc-sa/4.0/)
(CC BY-NC-SA 4.0)<br />
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a>
