<a name="TOP"></a>

# MaybeCube Assembly Instructions

These are the assembly instructions for the MaybeCube. These instructions are not fully comprehensive, that is they do
not show every small detail of the construction and in particular they do not show the wiring. However there is
sufficient detail that someone with a good understanding of 3D printers can build the MaybeCube.

![Main Assembly](assemblies/main_assembled.png)

## Read this before you order parts

2020, 2040 etc aluminium comes in variants with differing sized center holes - some are suitable for tapping for an
an M5 bolt and some are suitable for tapping for an M6 bolt. It doesn't really matter which you use, but ensure you
buy the bolts that correspond to your extrusion size. These build instructions assume M5 bolts, if your extrusion
requires M6 bolts then the 10mm and 12mm buttonhead M5 bolts should be replaced with M6 bolts.

This is a full build, some parts can be omitted to save cost, in particular:

* the Raspberry Pi camera (and corresponding 8mm M2 caphead bolts)
* the Raspberry Pi (if you don't want to run Octoprint or Klipper) and corresponding buck converter
* the Big Tree Tech relay module, if you don't want auto shut off
* the Big Tree Tech TFT display, if you are running Octoprint or Klipper
* I've specified a Big Tree Tech mainboard and display, you of course can use any mainboard and display you like
* the filament sensor
* the polycarbonate side and back panels, if you don't want to enclose your print volume for (say) printing ABS. Note
that these also add rigidity to the printer.
* I've specified buttonhead bolts for the side and back panels. For a neater look you could countersink the holes
use countersunk bolts.

## Printing the parts

A number of parts are in proximity with heat sources, namely the hotend, the heated bed and the motors. Ideally these
should be printed in ABS, but I have used PETG successfully. These parts are insulated from direct contact with the heat
sources, by cork underlay (for the heated bed) and by cork dampers (for the motors). These insulators should not be
omitted from the build.

<span></span>

---

## Table of Contents

1. [Parts list](#Parts_list)
1. [Printhead_E3DV6 assembly](#Printhead_E3DV6_assembly)
1. [X_Carriage_Belt_Side assembly](#X_Carriage_Belt_Side_assembly)
1. [XY_Motor_Mount_Right assembly](#XY_Motor_Mount_Right_assembly)
1. [XY_Motor_Mount_Left assembly](#XY_Motor_Mount_Left_assembly)
1. [XY_Idler_Right assembly](#XY_Idler_Right_assembly)
1. [XY_Idler_Left assembly](#XY_Idler_Left_assembly)
1. [Y_Carriage_Right assembly](#Y_Carriage_Right_assembly)
1. [Right_Side_Upper_Extrusion assembly](#Right_Side_Upper_Extrusion_assembly)
1. [Y_Carriage_Left assembly](#Y_Carriage_Left_assembly)
1. [Left_Side_Upper_Extrusion assembly](#Left_Side_Upper_Extrusion_assembly)
1. [Face_Top_Stage_1 assembly](#Face_Top_Stage_1_assembly)
1. [Face_Top_Stage_2 assembly](#Face_Top_Stage_2_assembly)
1. [Face_Top assembly](#Face_Top_assembly)
1. [Extruder_Bracket assembly](#Extruder_Bracket_assembly)
1. [Right_Side assembly](#Right_Side_assembly)
1. [Display_Cover_TFT35_E3 assembly](#Display_Cover_TFT35_E3_assembly)
1. [IEC_Housing assembly](#IEC_Housing_assembly)
1. [Base_Plate_Stage_1 assembly](#Base_Plate_Stage_1_assembly)
1. [Base_Plate assembly](#Base_Plate_assembly)
1. [Z_Carriage_Side assembly](#Z_Carriage_Side_assembly)
1. [Z_Carriage_Center assembly](#Z_Carriage_Center_assembly)
1. [Printbed_Frame assembly](#Printbed_Frame_assembly)
1. [Printbed_Frame_with_Z_Carriages assembly](#Printbed_Frame_with_Z_Carriages_assembly)
1. [Printbed assembly](#Printbed_assembly)
1. [Left_Side assembly](#Left_Side_assembly)
1. [Left_Side_with_Printbed assembly](#Left_Side_with_Printbed_assembly)
1. [Stage_1 assembly](#Stage_1_assembly)
1. [Stage_2 assembly](#Stage_2_assembly)
1. [Stage_3 assembly](#Stage_3_assembly)
1. [Stage_4 assembly](#Stage_4_assembly)
1. [Main assembly](#main_assembly)

<span></span>
[Top](#TOP)

---
<a name="Parts_list"></a>

## Parts list

| <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printhead E3DV6</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">X Carriage Belt Side</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Face Top</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Right Side</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printbed</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Left Side</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Main</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">TOTALS</span> |  |
|-----:|-----:|-----:|-----:|-----:|-----:|-----:|------:|:-------------|
|      |      |      |      |      |      |      |       | **Vitamins** |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Aluminium sheet 390mm x 390mm x 3mm |
|   .  |   .  |  24  |   .  |   .  |   .  |   .  |   24  |  Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Belt GT2 x 6mm x 1476mm |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Belt GT2 x 6mm x 1500mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  BigTreeTech Relay Module v1.2 |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  BigTreeTech SKR v1.4 Turbo |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  BigTreeTech TFT35 E3 v3.0 |
|   4  |   .  |   .  |   .  |   .  |   .  |   .  |    4  |  Bolt M2 caphead x  6mm |
|   .  |   .  |   4  |   .  |   .  |   .  |   .  |    4  |  Bolt M2 caphead x  8mm |
|   .  |   .  |  14  |   2  |   2  |   .  |  20  |   38  |  Bolt M3 buttonhead x 10mm |
|   .  |   .  |   .  |   .  |   .  |   .  |  18  |   18  |  Bolt M3 caphead x  6mm |
|   .  |   .  |  32  |   .  |   4  |   .  |   .  |   36  |  Bolt M3 caphead x 10mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Bolt M3 caphead x 12mm |
|   .  |   .  |   2  |   2  |   .  |   .  |   .  |    4  |  Bolt M3 caphead x 16mm |
|   .  |   .  |   3  |   .  |   .  |   .  |   4  |    7  |  Bolt M3 caphead x 25mm |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Bolt M3 caphead x 35mm |
|   .  |   2  |   .  |   .  |   .  |   .  |   .  |    2  |  Bolt M3 caphead x 40mm |
|   .  |   .  |   2  |   .  |   2  |   .  |   2  |    6  |  Bolt M3 countersunk x 10mm |
|   .  |   .  |   4  |   .  |   .  |   .  |   2  |    6  |  Bolt M3 countersunk x 12mm |
|   2  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Bolt M3 countersunk x 25mm |
|   .  |   .  |   4  |   .  |   .  |   .  |   .  |    4  |  Bolt M3 countersunk x 35mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  |  Bolt M3 countersunk x 40mm |
|   .  |   .  |   .  |   8  |   .  |   .  |  52  |   60  |  Bolt M4 buttonhead x  8mm |
|   .  |   .  |  12  |   .  |   6  |   4  |  14  |   36  |  Bolt M4 buttonhead x 10mm |
|   .  |   .  |   8  |   .  |   .  |   .  |   4  |   12  |  Bolt M4 buttonhead x 12mm |
|   .  |   .  |  20  |   .  |   .  |   8  |   .  |   28  |  Bolt M4 countersunk x 10mm |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Bolt M4 countersunk x 45mm |
|   .  |   .  |   6  |   .  |   .  |   .  |   .  |    6  |  Bolt M5 buttonhead x 10mm |
|   .  |   .  |  14  |   8  |   8  |   8  |  14  |   52  |  Bolt M5 buttonhead x 12mm |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Bolt M5 buttonhead x 16mm |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Bolt M5 countersunk x 12mm |
|   .  |   .  |   2  |   1  |   .  |   .  |   1  |    4  |  Cork damper NEMA 17 |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |    2  |  Extrusion E2020 x 300mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Extrusion E2020 x 350mm |
|   .  |   .  |   .  |   2  |   .  |   2  |   .  |    4  |  Extrusion E2020 x 400mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |    2  |  Extrusion E2040 x 150mm |
|   .  |   .  |   2  |   2  |   .  |   2  |   1  |    7  |  Extrusion E2040 x 350mm |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |    2  |  Extrusion E2060 x 350mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Extrusion E2080 x 350mm |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Fan 30mm x 10mm |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  |  Filament sensor |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  |  Heated Bed 235mm x 235mm |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Heated bed leveling knob |
|   .  |   .  |   4  |   .  |   .  |   .  |   .  |    4  |  Heatfit insert M3 |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Hot end E3D V6 direct 1.75mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  IEC320 C14 switched fused inlet module |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  |  Leadscrew nut 8 x 2 |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Linear rail MGN12 x 300mm |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |    2  |  Linear rail MGN12 x 350mm |
|   .  |   .  |   3  |   .  |   .  |   .  |   .  |    3  |  Linear rail carriage MGN12H |
|   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Linear rod 12mm x 300mm |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  |  MK10 Dual Pulley Extruder |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Micro SD card |
|   .  |   .  |  20  |   .  |   2  |   .  |   6  |   28  |  Nut M3 hammer |
|   .  |   .  |  12  |   8  |   .  |   .  |  66  |   86  |  Nut M4 hammer |
|   .  |   .  |  36  |   .  |   6  |  12  |   .  |   54  |  Nut M4 sliding T |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  PSU NIUGUY CB-500W-24V |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  PTFE Bowden tube, 600 mm |
|   .  |   .  |   .  |   .  |   .  |   .  |  12  |   12  |  Pillar hex nylon F/F M3x10 |
|   .  |   .  |   .  |   2  |   .  |   .  |   .  |    2  |  Pillar hex nylon F/F M3x14 |
|   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Pillar hex nylon F/F M3x25 |
|   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Pillar hex nylon F/F M3x5 |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |    2  |  Pulley GT2OB 20 teeth |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Raspberry Pi 3A+ |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Raspberry Pi camera V2 |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |    2  |  SCS12LUU bearing block |
|   .  |   .  |   .  |   .  |   .  |   4  |   .  |    4  |  SK12 shaft support bracket |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Sheet polycarbonate 295mm x 400mm x 3mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Sheet polycarbonate 390mm x 400mm x 3mm |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Spring 8mm OD, 0.9mm gauge x 20mm long, closed end |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Square radial fan 3010 |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Stepper motor NEMA17 x 40mm, 280mm integrated leadscrew |
|   .  |   .  |   2  |   1  |   .  |   .  |   .  |    3  |  Stepper motor NEMA17 x 47mm |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  |  Stepper motor cable, 200mm |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Stepper motor cable, 300mm |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  Stepper motor cable, 500mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Stepper motor cable, 850mm |
|   .  |   2  |  38  |   .  |   .  |   .  |   .  |   40  |  Washer M3 |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  XL4015 buck converter |
|   3  |   .  |   .  |   .  |   .  |   .  |   .  |    3  |  Ziptie 2.5mm x 100mm min length |
|  12  |   4  | 281  |  39  |  58  |  40  | 245  |  679  | Total vitamins count |
|      |      |      |      |      |      |      |       | **3D printed parts** |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Camera_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Display_Housing_Bracket_TFT35_E3.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Display_Housing_TFT35_E3.stl |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  | Extruder_Bracket.stl |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Fan_Duct.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  | Foot_LShaped_12mm.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Front_Cover_350.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Front_Display_Wiring_Cover_350.stl |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |    2  | Handle.stl |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Hotend_Clamp.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | IEC_Housing.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | IEC_Housing_Mount.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  | Printbed_Strain_Relief.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  | Printbed_Strain_Relief_Clamp.stl |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  | Right_Side_Panel.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Spool_Holder.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Spool_Holder_36.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Spool_Holder_Bracket.stl |
|   .  |   .  |   4  |   .  |   .  |   .  |   .  |    4  | Top_Corner_Piece.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Wiring_Guide.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Wiring_Guide_Clamp.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Wiring_Guide_Socket.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | XY_Idler_Left_RB_40.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | XY_Idler_Right_RB_40.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | XY_Motor_Mount_Brace_Left_RB.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | XY_Motor_Mount_Brace_Right_RB.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | XY_Motor_Mount_Left_RB.stl |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |    2  | XY_Motor_Mount_Pulley_Spacer.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | XY_Motor_Mount_Right_RB.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | X_Carriage_Belt_Clamp.stl |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |    1  | X_Carriage_Belt_Side_RB.stl |
|   .  |   2  |   .  |   .  |   .  |   .  |   .  |    2  | X_Carriage_Belt_Tensioner_RB.stl |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | X_Carriage_Groovemount.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Brace_Left_RB.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Brace_Right_RB.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Left_RB.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Right_RB.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  | Z_Carriage_Center.stl |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |    2  | Z_Carriage_Side.stl |
|   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  | Z_Motor_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  | Z_Motor_MountGuide_61mm.stl |
|   .  |   .  |   .  |   .  |   .  |   2  |   .  |    2  | Z_RodMountGuide_40mm.stl |
|   3  |   3  |  21  |   2  |   5  |   4  |  15  |   53  | Total 3D printed parts count |
|      |      |      |      |      |      |      |       | **CNC routed parts** |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Back_Panel.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | BaseAL.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Left_Side_Panel.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Right_Side_Panel.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  | Total CNC routed parts count |

<span></span>
[Top](#TOP)

---
<a name="Printhead_E3DV6_assembly"></a>

## Printhead_E3DV6 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M2 caphead x  6mm |
|   2 | Bolt M3 countersunk x 25mm |
|   1 | Fan 30mm x 10mm |
|   1 | Hot end E3D V6 direct 1.75mm |
|   1 | Square radial fan 3010 |
|   3 | Ziptie 2.5mm x 100mm min length |

### 3D Printed parts

| 1 x Fan_Duct.stl | 1 x Hotend_Clamp.stl | 1 x X_Carriage_Groovemount.stl |
|----------|----------|----------|
| ![Fan_Duct.stl](stls/Fan_Duct.png) | ![Hotend_Clamp.stl](stls/Hotend_Clamp.png) | ![X_Carriage_Groovemount.stl](stls/X_Carriage_Groovemount.png) |

### Assembly instructions

![Printhead_E3DV6_assembly](assemblies/Printhead_E3DV6_assembly.png)

1. Bolt the fan onto the side of the **X_Carriage_Groovemount**, secure the fan wire with a ziptie.
2. Ensure a good fit between the fan and the **Fan_Duct** and bolt the fan duct to the X_Carriage.
3. Assemble the E3D hotend, including fan, thermistor cartridge and heater cartridge.
4. Use the **Hotend_Clamp** to attach the E3D hotend to the X_Carriage.
5. Collect the wires together, wrap them in spiral wrap, and secure them to the X_Carriage using the zipties. Note that
the wiring is not shown in this diagram.

![Printhead_E3DV6_assembled](assemblies/Printhead_E3DV6_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="X_Carriage_Belt_Side_assembly"></a>

## X_Carriage_Belt_Side assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Bolt M3 caphead x 40mm |
|   2 | Washer M3 |

### 3D Printed parts

| 1 x X_Carriage_Belt_Side_RB.stl | 2 x X_Carriage_Belt_Tensioner_RB.stl |
|----------|----------|
| ![X_Carriage_Belt_Side_RB.stl](stls/X_Carriage_Belt_Side_RB.png) | ![X_Carriage_Belt_Tensioner_RB.stl](stls/X_Carriage_Belt_Tensioner_RB.png) |

### Assembly instructions

![X_Carriage_Belt_Side_assembly](assemblies/X_Carriage_Belt_Side_assembly.png)

Insert the belts into the **X_Carriage_Belt_Tensioner**s and then bolt the tensioners into the
**X_Carriage_Belt_Side** part as shown. Note the belts are not shown in this diagram.

![X_Carriage_Belt_Side_assembled](assemblies/X_Carriage_Belt_Side_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Motor_Mount_Right_assembly"></a>

## XY_Motor_Mount_Right assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   6 | Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   6 | Bolt M3 buttonhead x 10mm |
|   2 | Bolt M3 countersunk x 35mm |
|   3 | Bolt M4 buttonhead x 10mm |
|   1 | Cork damper NEMA 17 |
|   3 | Nut M4 hammer |
|   1 | Pulley GT2OB 20 teeth |
|   1 | Stepper motor NEMA17 x 47mm |
|   1 | Stepper motor cable, 300mm |
|  11 | Washer M3 |

### 3D Printed parts

| 1 x XY_Motor_Mount_Brace_Right_RB.stl | 1 x XY_Motor_Mount_Pulley_Spacer.stl | 1 x XY_Motor_Mount_Right_RB.stl |
|----------|----------|----------|
| ![XY_Motor_Mount_Brace_Right_RB.stl](stls/XY_Motor_Mount_Brace_Right_RB.png) | ![XY_Motor_Mount_Pulley_Spacer.stl](stls/XY_Motor_Mount_Pulley_Spacer.png) | ![XY_Motor_Mount_Right_RB.stl](stls/XY_Motor_Mount_Right_RB.png) |

### Assembly instructions

![XY_Motor_Mount_Right_assembly](assemblies/XY_Motor_Mount_Right_assembly.png)

1. Bolt the idler pulleys and the **XY_Motor_Mount_Brace_Right** to the **XY_Motor_Mount_Right**. Note the brace is not
symmetrical - there is an orientation indicator and this should point towards the back of the printer. Tighten the
pulley bolts until the pulleys no longer turn freely, and then loosen the bolts by about 1/4 turn until the pulleys
turn freely again.
2. Bolt the motor and the cork damper to the motor mount. The core damper thermally insulates the motor from the mount
and should not be omitted.
3. Align the drive pulley with the idler pulleys and bolt it to the motor shaft.
4. Add the bolts and t-nuts in preparation for later attachment to the frame.

![XY_Motor_Mount_Right_assembled](assemblies/XY_Motor_Mount_Right_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Motor_Mount_Left_assembly"></a>

## XY_Motor_Mount_Left assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   6 | Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   6 | Bolt M3 buttonhead x 10mm |
|   2 | Bolt M3 countersunk x 35mm |
|   3 | Bolt M4 buttonhead x 10mm |
|   1 | Cork damper NEMA 17 |
|   3 | Nut M4 hammer |
|   1 | Pulley GT2OB 20 teeth |
|   1 | Stepper motor NEMA17 x 47mm |
|   1 | Stepper motor cable, 500mm |
|  11 | Washer M3 |

### 3D Printed parts

| 1 x XY_Motor_Mount_Brace_Left_RB.stl | 1 x XY_Motor_Mount_Left_RB.stl | 1 x XY_Motor_Mount_Pulley_Spacer.stl |
|----------|----------|----------|
| ![XY_Motor_Mount_Brace_Left_RB.stl](stls/XY_Motor_Mount_Brace_Left_RB.png) | ![XY_Motor_Mount_Left_RB.stl](stls/XY_Motor_Mount_Left_RB.png) | ![XY_Motor_Mount_Pulley_Spacer.stl](stls/XY_Motor_Mount_Pulley_Spacer.png) |

### Assembly instructions

![XY_Motor_Mount_Left_assembly](assemblies/XY_Motor_Mount_Left_assembly.png)

1. Bolt the idler pulleys and the **XY_Motor_Mount_Brace_Left** to the **XY_Motor_Mount_Left**. Note the brace is not
symmetrical - there is an orientation indicator and this should point towards the back of the printer. Tighten the
pulley bolts until the pulleys no longer turn freely, and then loosen the bolts by about 1/4 turn until the pulleys
turn freely again.
2. Bolt the motor and the cork damper to the motor mount. The core damper thermally insulates the motor from the mount
and should not be omitted.
3. Align the drive pulley with the idler pulleys and bolt it to the motor shaft.
4. Add the bolts and t-nuts in preparation for later attachment to the frame.

![XY_Motor_Mount_Left_assembled](assemblies/XY_Motor_Mount_Left_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Idler_Right_assembly"></a>

## XY_Idler_Right assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   1 | Bolt M3 caphead x 25mm |
|   2 | Bolt M4 buttonhead x 10mm |
|   1 | Nut M3 hammer |
|   2 | Nut M4 hammer |
|   3 | Washer M3 |

### 3D Printed parts

| 1 x XY_Idler_Right_RB_40.stl |
|----------|
| ![XY_Idler_Right_RB_40.stl](stls/XY_Idler_Right_RB_40.png) |

### Assembly instructions

![XY_Idler_Right_assembly](assemblies/XY_Idler_Right_assembly_tn.png)

1. Bolt the pulley stack into the **XY_Idler_Right**. Note that there are 4 washers between the two pulleys and one
washer at the top and the bottom of the pulley stack.
2. Tighten the bolt until the pulleys no longer turn freely, and then loosen the bolt by about 1/4 turn to allow the pulleys
to turn freely again.
3. Add the bolts and t-nuts in preparation for later attachment to the frame.
4. Add the button head bolt and washer.

![XY_Idler_Right_assembled](assemblies/XY_Idler_Right_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Idler_Left_assembly"></a>

## XY_Idler_Left assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   1 | Bolt M3 caphead x 35mm |
|   2 | Bolt M4 buttonhead x 10mm |
|   1 | Nut M3 hammer |
|   2 | Nut M4 hammer |
|   3 | Washer M3 |

### 3D Printed parts

| 1 x XY_Idler_Left_RB_40.stl |
|----------|
| ![XY_Idler_Left_RB_40.stl](stls/XY_Idler_Left_RB_40.png) |

### Assembly instructions

![XY_Idler_Left_assembly](assemblies/XY_Idler_Left_assembly_tn.png)

1. Bolt the pulley stack into the **XY_Idler_Left**. Note that there are 4 washers between the two pulleys and one
washer at the top and the bottom of the pulley stack.
2. Tighten the bolt until the pulleys no longer turn freely, and then loosen the bolt by about 1/4 turn to allow the pulleys
to turn freely again.
3. Add the bolts and t-nuts in preparation for later attachment to the frame.
4. Add the button head bolt and washer.

![XY_Idler_Left_assembled](assemblies/XY_Idler_Left_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Y_Carriage_Right_assembly"></a>

## Y_Carriage_Right assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   2 | Bolt M3 caphead x 10mm |
|   1 | Bolt M3 caphead x 16mm |
|   1 | Bolt M3 caphead x 25mm |
|   2 | Heatfit insert M3 |
|   5 | Washer M3 |

### 3D Printed parts

| 1 x Y_Carriage_Brace_Right_RB.stl | 1 x Y_Carriage_Right_RB.stl |
|----------|----------|
| ![Y_Carriage_Brace_Right_RB.stl](stls/Y_Carriage_Brace_Right_RB.png) | ![Y_Carriage_Right_RB.stl](stls/Y_Carriage_Right_RB.png) |

### Assembly instructions

![Y_Carriage_Right_assembly](assemblies/Y_Carriage_Right_assembly_tn.png)

1. Insert the threaded inserts into the **Y_Carriage_Right** as shown.
2. Drive a long M3 bolt through the Y carriage from the insert side to self tap the part of the hole after the insert.
Once this hole is tapped, remove the bolt.
3. Bolt the **Y_Carriage_Brace_Right** and the pulleys to the **Y_Carriage_Right** as shown. Note the position of the washers.
4. Tighten the bolts until the pulleys no longer turn freely and then loosen by about 1/4 turn so the pulleys can again turn.

![Y_Carriage_Right_assembled](assemblies/Y_Carriage_Right_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Right_Side_Upper_Extrusion_assembly"></a>

## Right_Side_Upper_Extrusion assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|  12 | Bolt M3 caphead x 10mm |
|   6 | Bolt M5 buttonhead x 12mm |
|   1 | Extrusion E2060 x 350mm |
|   1 | Linear rail MGN12 x 350mm |
|   1 | Linear rail carriage MGN12H |
|   8 | Nut M3 hammer |

### Sub-assemblies

| 1 x Y_Carriage_Right_assembly |
|----------|
| ![Y_Carriage_Right_assembled](assemblies/Y_Carriage_Right_assembled_tn.png) |

### Assembly instructions

![Right_Side_Upper_Extrusion_assembly](assemblies/Right_Side_Upper_Extrusion_assembly.png)

1. Bolt the MGN linear rail to the extrusion, using the **Rail_Centering_Jig** to align the rail. Do not fully tighten the
bolts at this stage - they will be fully tightened when the rail is racked at a later stage.
2. Bolt the **Y_Carriage_Right_assembly** to the MGN carriage.
3. Screw the bolts into ends of the extrusion in preparation for attachment to the rest of the top face.

![Right_Side_Upper_Extrusion_assembled](assemblies/Right_Side_Upper_Extrusion_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Y_Carriage_Left_assembly"></a>

## Y_Carriage_Left assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Ball bearing F623-2RS 3mm x 10mm x 4mm |
|   2 | Bolt M3 caphead x 10mm |
|   1 | Bolt M3 caphead x 16mm |
|   1 | Bolt M3 caphead x 25mm |
|   2 | Heatfit insert M3 |
|   5 | Washer M3 |

### 3D Printed parts

| 1 x Y_Carriage_Brace_Left_RB.stl | 1 x Y_Carriage_Left_RB.stl |
|----------|----------|
| ![Y_Carriage_Brace_Left_RB.stl](stls/Y_Carriage_Brace_Left_RB.png) | ![Y_Carriage_Left_RB.stl](stls/Y_Carriage_Left_RB.png) |

### Assembly instructions

![Y_Carriage_Left_assembly](assemblies/Y_Carriage_Left_assembly_tn.png)

1. Insert the threaded inserts into the **Y_Carriage_Left** as shown.
2. Drive a long M3 bolt through the Y carriage from the insert side to self tap the part of the hole after the insert.
Once this hole is tapped, remove the bolt.
3. Bolt the **Y_Carriage_Brace_Left** and the pulleys to the **Y_Carriage_Left** as shown. Note the position of the washers.
4. Tighten the bolts until the pulleys no longer turn freely and then loosen by about 1/4 turn so the pulleys can again turn.

![Y_Carriage_Left_assembled](assemblies/Y_Carriage_Left_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Left_Side_Upper_Extrusion_assembly"></a>

## Left_Side_Upper_Extrusion assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|  12 | Bolt M3 caphead x 10mm |
|   6 | Bolt M5 buttonhead x 12mm |
|   1 | Extrusion E2060 x 350mm |
|   1 | Linear rail MGN12 x 350mm |
|   1 | Linear rail carriage MGN12H |
|   8 | Nut M3 hammer |

### Sub-assemblies

| 1 x Y_Carriage_Left_assembly |
|----------|
| ![Y_Carriage_Left_assembled](assemblies/Y_Carriage_Left_assembled_tn.png) |

### Assembly instructions

![Left_Side_Upper_Extrusion_assembly](assemblies/Left_Side_Upper_Extrusion_assembly.png)

1. Bolt the MGN linear rail to the extrusion, using the **Rail_Centering_Jig** to align the rail. Fully tighten the
bolts - the left rail is the fixed rail and the right rail will be aligned to it.
bolts at this stage - they will be fully tightened when the rail is racked at a later stage.
2. Bolt the **Y_Carriage_Left_assembly** to the MGN carriage.
3. Screw the bolts into ends of the extrusion in preparation for attachment to the rest of the top face.

![Left_Side_Upper_Extrusion_assembled](assemblies/Left_Side_Upper_Extrusion_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_Stage_1_assembly"></a>

## Face_Top_Stage_1 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M2 caphead x  8mm |
|   2 | Bolt M3 buttonhead x 10mm |
|   2 | Bolt M4 buttonhead x 10mm |
|  20 | Bolt M4 countersunk x 10mm |
|   6 | Bolt M5 buttonhead x 10mm |
|   2 | Bolt M5 buttonhead x 12mm |
|   2 | Extrusion E2040 x 350mm |
|   2 | Nut M3 hammer |
|   2 | Nut M4 hammer |
|  28 | Nut M4 sliding T |
|   1 | Raspberry Pi camera V2 |

### 3D Printed parts

| 1 x Camera_Mount.stl | 4 x Top_Corner_Piece.stl | 1 x Wiring_Guide_Socket.stl |
|----------|----------|----------|
| ![Camera_Mount.stl](stls/Camera_Mount.png) | ![Top_Corner_Piece.stl](stls/Top_Corner_Piece.png) | ![Wiring_Guide_Socket.stl](stls/Wiring_Guide_Socket.png) |

### Sub-assemblies

| 1 x Left_Side_Upper_Extrusion_assembly | 1 x Right_Side_Upper_Extrusion_assembly | 1 x XY_Idler_Left_assembly |
|----------|----------|----------|
| ![Left_Side_Upper_Extrusion_assembled](assemblies/Left_Side_Upper_Extrusion_assembled_tn.png) | ![Right_Side_Upper_Extrusion_assembled](assemblies/Right_Side_Upper_Extrusion_assembled_tn.png) | ![XY_Idler_Left_assembled](assemblies/XY_Idler_Left_assembled_tn.png) |
| 1 x XY_Idler_Right_assembly | 1 x XY_Motor_Mount_Left_assembly | 1 x XY_Motor_Mount_Right_assembly |
|----------|----------|----------|
| ![XY_Idler_Right_assembled](assemblies/XY_Idler_Right_assembled_tn.png) | ![XY_Motor_Mount_Left_assembled](assemblies/XY_Motor_Mount_Left_assembled_tn.png) | ![XY_Motor_Mount_Right_assembled](assemblies/XY_Motor_Mount_Right_assembled_tn.png) |

### Assembly instructions

![Face_Top_Stage_1_assembly](assemblies/Face_Top_Stage_1_assembly.png)

1. Bolt the two motor mounts, the **Wiring_Guide**, and optionally the **Camera_Mount** to the rear extrusion.
2. Bolt the two idlers to the front extrusion.
3. Screw the bolts into the ends of the front and rear extrusions.
4. Insert the t-nuts for the **Handle** into the extrusions.
5. Insert the t-nuts for the **Top_Corner_Piece**s into the extrusions.
6. Bolt the front and rear extrusions to the side extrusions, leaving the bolts slightly loose.
7. Bolt the **Top_Corner_Piece**s to the extrusions leaving the bolts slightly loose.
8. Turn the top face upside down and place on a flat surface. Ensure it is square and tighten the hidden bolts.
9. Turn the top face the right way up and tighten the bolts on the **Top_Corner_Piece**s.

![Face_Top_Stage_1_assembled](assemblies/Face_Top_Stage_1_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_Stage_2_assembly"></a>

## Face_Top_Stage_2 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M3 caphead x 10mm |
|   1 | Linear rail MGN12 x 300mm |
|   1 | Linear rail carriage MGN12H |

### Sub-assemblies

| 1 x Face_Top_Stage_1_assembly |
|----------|
| ![Face_Top_Stage_1_assembled](assemblies/Face_Top_Stage_1_assembled_tn.png) |

### Assembly instructions

![Face_Top_Stage_2_assembly](assemblies/Face_Top_Stage_2_assembly.png)

1. Bolt the MGN rail to the Y_Carriages as shown. Ensure the MGN rail is square to the frame.
2. Turn the top face upside down and place on a flat surface. Rack the right side linear rail - move the X-rail
to one extreme of the frame and tighten the bolts on that end of the Y-rail. Then move the X-rail to the other
extreme and tighten the bolts on that end of the Y-rail. Finally tighten the remaining bolts on the Y-rail.
3. Ensure the X-rail moves freely, if it doesn't loosen the bolts you have just tightened and repeat step 2.

![Face_Top_Stage_2_assembled](assemblies/Face_Top_Stage_2_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_assembly"></a>

## Face_Top assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   1 | Belt GT2 x 6mm x 1476mm |
|   1 | Belt GT2 x 6mm x 1500mm |
|   2 | Bolt M3 countersunk x 10mm |
|   4 | Bolt M3 countersunk x 12mm |
|   8 | Bolt M4 buttonhead x 12mm |
|   8 | Nut M4 sliding T |

### 3D Printed parts

| 2 x Handle.stl | 1 x X_Carriage_Belt_Clamp.stl |
|----------|----------|
| ![Handle.stl](stls/Handle.png) | ![X_Carriage_Belt_Clamp.stl](stls/X_Carriage_Belt_Clamp.png) |

### Sub-assemblies

| 1 x Face_Top_Stage_2_assembly | 1 x X_Carriage_Belt_Side_assembly |
|----------|----------|
| ![Face_Top_Stage_2_assembled](assemblies/Face_Top_Stage_2_assembled_tn.png) | ![X_Carriage_Belt_Side_assembled](assemblies/X_Carriage_Belt_Side_assembled_tn.png) |

### Assembly instructions

![Face_Top_assembly](assemblies/Face_Top_assembly.png)

1. Bolt the **X_Carriage_Belt_Side_assembly** to the MGN carriage.
2. Thread the belts as shown and attach them to the **X_Carriage_Belt_Side_assembly**
using the **X_Carriage_Belt_Clamp**.
3. Leave the belts fairly loose - tensioning of the belts is done after the frame is assembled.
4. Bolt the handles to the previously inserted t-nuts.

![Face_Top_assembled](assemblies/Face_Top_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Extruder_Bracket_assembly"></a>

## Extruder_Bracket assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Bolt M3 buttonhead x 10mm |
|   2 | Bolt M3 caphead x 16mm |
|   4 | Bolt M4 buttonhead x  8mm |
|   1 | Cork damper NEMA 17 |
|   1 | Filament sensor |
|   1 | MK10 Dual Pulley Extruder |
|   4 | Nut M4 hammer |
|   2 | Pillar hex nylon F/F M3x14 |
|   1 | Stepper motor NEMA17 x 47mm |
|   1 | Stepper motor cable, 200mm |

### 3D Printed parts

| 1 x Extruder_Bracket.stl |
|----------|
| ![Extruder_Bracket.stl](stls/Extruder_Bracket.png) |

### Assembly instructions

![Extruder_Bracket_assembly](assemblies/Extruder_Bracket_assembly.png)

1. Bolt the stepper motor and cork damper through the **Extruder_Bracket** to the extruder as shown. The cork damper
thermally isolates the motor from the **Extruder_Bracket** and should not be omitted.
2. Align the hobb gear on the stepper motor shaft with the the hobb gear in the extruder and tighten the grub screws.
3. Bolt the filament sensor to the hex pillars and bolt them to the **Extruder_Bracket**.
4. Add the bolts and t-nuts in preparation for later attachment to the frame.

![Extruder_Bracket_assembled](assemblies/Extruder_Bracket_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Right_Side_assembly"></a>

## Right_Side assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M4 buttonhead x  8mm |
|   8 | Bolt M5 buttonhead x 12mm |
|   2 | Extrusion E2020 x 400mm |
|   2 | Extrusion E2040 x 350mm |
|   4 | Nut M4 hammer |

### 3D Printed parts

| 1 x Right_Side_Panel.stl |
|----------|
| ![Right_Side_Panel.stl](stls/Right_Side_Panel.png) |

### Sub-assemblies

| 1 x Extruder_Bracket_assembly |
|----------|
| ![Extruder_Bracket_assembled](assemblies/Extruder_Bracket_assembled_tn.png) |

### Assembly instructions

![Right_Side_assembly](assemblies/Right_Side_assembly.png)

1. On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown.
2. Bolt the **IEC_Housing_assembly** to the lower extrusion and upright.
3. Bolt the **Extruder_Bracket_assembly** to the upper extrusion and upright.

![Right_Side_assembled](assemblies/Right_Side_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Display_Cover_TFT35_E3_assembly"></a>

## Display_Cover_TFT35_E3 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   1 | BigTreeTech TFT35 E3 v3.0 |
|   4 | Bolt M3 caphead x  6mm |

### 3D Printed parts

| 1 x Display_Housing_TFT35_E3.stl |
|----------|
| ![Display_Housing_TFT35_E3.stl](stls/Display_Housing_TFT35_E3.png) |

### Assembly instructions

![Display_Cover_TFT35_E3_assembly](assemblies/Display_Cover_TFT35_E3_assembly.png)

1. Bolt the TFT35 E3 display to the **Display_Housing_TFT35_E3**.
2. Attach the knob to the display.

![Display_Cover_TFT35_E3_assembled](assemblies/Display_Cover_TFT35_E3_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="IEC_Housing_assembly"></a>

## IEC_Housing assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   5 | Bolt M4 buttonhead x  8mm |
|   2 | Bolt M4 buttonhead x 12mm |
|   1 | IEC320 C14 switched fused inlet module |
|   5 | Nut M4 hammer |

### 3D Printed parts

| 1 x IEC_Housing.stl | 1 x IEC_Housing_Mount.stl |
|----------|----------|
| ![IEC_Housing.stl](stls/IEC_Housing.png) | ![IEC_Housing_Mount.stl](stls/IEC_Housing_Mount.png) |

### Assembly instructions

![IEC_Housing_assembly](assemblies/IEC_Housing_assembly.png)

1. Attach the power cables to the IEC connector.
2. Thread the power cables through the hole in the **IEC_Housing** and bolt the **IEC_Housing_Mount** to the **IEC_housing**.
3. Add the bolts and t-nuts in preparation for attachment to the frame.

![IEC_Housing_assembled](assemblies/IEC_Housing_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Base_Plate_Stage_1_assembly"></a>

## Base_Plate_Stage_1 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   1 | Aluminium sheet 390mm x 390mm x 3mm |
|   1 | BigTreeTech Relay Module v1.2 |
|   1 | BigTreeTech SKR v1.4 Turbo |
|  14 | Bolt M3 buttonhead x 10mm |
|  14 | Bolt M3 caphead x  6mm |
|   2 | Bolt M3 caphead x 12mm |
|   8 | Bolt M4 buttonhead x  8mm |
|  10 | Bolt M4 buttonhead x 10mm |
|  14 | Bolt M5 buttonhead x 12mm |
|   1 | Extrusion E2020 x 350mm |
|   1 | Extrusion E2040 x 350mm |
|   1 | Extrusion E2080 x 350mm |
|   1 | Micro SD card |
|   2 | Nut M3 hammer |
|  16 | Nut M4 hammer |
|   1 | PSU NIUGUY CB-500W-24V |
|  12 | Pillar hex nylon F/F M3x10 |
|   2 | Pillar hex nylon F/F M3x25 |
|   2 | Pillar hex nylon F/F M3x5 |
|   1 | Raspberry Pi 3A+ |
|   1 | XL4015 buck converter |

### 3D Printed parts

| 4 x Foot_LShaped_12mm.stl |
|----------|
| ![Foot_LShaped_12mm.stl](stls/Foot_LShaped_12mm.png) |

### CNC Routed parts

| 1 x BaseAL.dxf |
|----------|
| ![BaseAL.dxf](dxfs/BaseAL.png) |

### Sub-assemblies

| 1 x IEC_Housing_assembly |
|----------|
| ![IEC_Housing_assembled](assemblies/IEC_Housing_assembled_tn.png) |

### Assembly instructions

![Base_Plate_Stage_1_assembly](assemblies/Base_Plate_Stage_1_assembly.png)

If you have access to a CNC, you can machine the base plate using **BaseAL.dxf**, if not you can use the **Panel_Jig**
as a template to drill the holes in the base plate.

1. Insert the bolts into the ends of the E2040 and E2080 extrusions in preparation for connection to the frame uprights.
2. Bolt the extrusions and the L-shaped feet to the baseplate as shown.
3. Bolt the PSU and the pcbs to the baseplate, using standoffs as appropriate.

![Base_Plate_Stage_1_assembled](assemblies/Base_Plate_Stage_1_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Base_Plate_assembly"></a>

## Base_Plate assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M3 caphead x 25mm |
|   2 | Bolt M3 countersunk x 10mm |
|   2 | Bolt M3 countersunk x 12mm |
|   4 | Bolt M4 buttonhead x 10mm |
|   4 | Nut M3 hammer |
|   4 | Nut M4 hammer |

### 3D Printed parts

| 1 x Display_Housing_Bracket_TFT35_E3.stl | 1 x Front_Cover_350.stl | 1 x Front_Display_Wiring_Cover_350.stl |
|----------|----------|----------|
| ![Display_Housing_Bracket_TFT35_E3.stl](stls/Display_Housing_Bracket_TFT35_E3.png) | ![Front_Cover_350.stl](stls/Front_Cover_350.png) | ![Front_Display_Wiring_Cover_350.stl](stls/Front_Display_Wiring_Cover_350.png) |

### Sub-assemblies

| 1 x Base_Plate_Stage_1_assembly | 1 x Display_Cover_TFT35_E3_assembly |
|----------|----------|
| ![Base_Plate_Stage_1_assembled](assemblies/Base_Plate_Stage_1_assembled_tn.png) | ![Display_Cover_TFT35_E3_assembled](assemblies/Display_Cover_TFT35_E3_assembled_tn.png) |

### Assembly instructions

![Base_Plate_assembly](assemblies/Base_Plate_assembly.png)

1. Bolt the **Display_Housing_Bracket_TFT35_E3** to the 2080 extrusion.
2. Thread the display wiring through the hole in the **Display_Housing_Bracket_TFT35_E3** and connect it to the TFT display.
3. Bolt the **Display_Cover_TFT35_E3_assembly** to the **Display_Housing_Bracket_TFT35_E3**.
4. Bolt the **Front_Cover** to the top of the 2080 extrusion.
5. Bolt the **Front_Display_Wiring_Cover** to the top of the 2080 extrusion, covering the wiring.
6. Route the wiring to the back of the base, ready for later connection to the mainboard.

![Base_Plate_assembled](assemblies/Base_Plate_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Carriage_Side_assembly"></a>

## 2 x Z_Carriage_Side assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Bolt M4 buttonhead x 10mm |
|   4 | Bolt M5 buttonhead x 16mm |
|   4 | Bolt M5 countersunk x 12mm |
|   2 | Nut M4 sliding T |
|   2 | SCS12LUU bearing block |

### 3D Printed parts

| 2 x Z_Carriage_Side.stl |
|----------|
| ![Z_Carriage_Side.stl](stls/Z_Carriage_Side.png) |

### Assembly instructions

![Z_Carriage_Side_assembly](assemblies/Z_Carriage_Side_assembly_tn.png)

1. Bolt the SCS bearing block to the **Z_Carriage**.
2. Add the bolts and t-nuts in preparation for connection to the printbed.

![Z_Carriage_Side_assembled](assemblies/Z_Carriage_Side_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Carriage_Center_assembly"></a>

## Z_Carriage_Center assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M3 caphead x 10mm |
|   4 | Bolt M4 buttonhead x 10mm |
|   1 | Leadscrew nut 8 x 2 |
|   4 | Nut M4 sliding T |

### 3D Printed parts

| 1 x Z_Carriage_Center.stl |
|----------|
| ![Z_Carriage_Center.stl](stls/Z_Carriage_Center.png) |

### Assembly instructions

![Z_Carriage_Center_assembly](assemblies/Z_Carriage_Center_assembly_tn.png)

1. Bolt the leadscrew to the **Z_Carriage_Center**.
2. Add the bolts and t-nuts in preparation for later attachment to the printbed frame.

![Z_Carriage_Center_assembled](assemblies/Z_Carriage_Center_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Frame_assembly"></a>

## Printbed_Frame assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Bolt M3 countersunk x 10mm |
|   8 | Bolt M5 buttonhead x 12mm |
|   2 | Extrusion E2020 x 300mm |
|   2 | Extrusion E2040 x 150mm |
|   2 | Nut M3 hammer |

### 3D Printed parts

| 1 x Printbed_Strain_Relief.stl |
|----------|
| ![Printbed_Strain_Relief.stl](stls/Printbed_Strain_Relief.png) |

### Sub-assemblies

| 1 x Z_Carriage_Center_assembly |
|----------|
| ![Z_Carriage_Center_assembled](assemblies/Z_Carriage_Center_assembled_tn.png) |

### Assembly instructions

![Printbed_Frame_assembly](assemblies/Printbed_Frame_assembly.png)

1. Slide the **Z_Carriage_Center_assembly** to the approximate center of the first 2040 extrusion and loosely tighten
the bolts. The bolts will be fully tightened when the Z_Carriage is aligned.
2. Bolt the **Printbed_Strain_Relief** to the second extrusion.
3. Slide the 2040 extrusion into the 2020 extrusions and loosely tighten the bolts. The bolts will be fully tightened after
the Z carriages are added.

![Printbed_Frame_assembled](assemblies/Printbed_Frame_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Frame_with_Z_Carriages_assembly"></a>

## Printbed_Frame_with_Z_Carriages assembly

### Sub-assemblies

| 1 x Printbed_Frame_assembly | 2 x Z_Carriage_Side_assembly |
|----------|----------|
| ![Printbed_Frame_assembled](assemblies/Printbed_Frame_assembled_tn.png) | ![Z_Carriage_Side_assembled](assemblies/Z_Carriage_Side_assembled_tn.png) |

### Assembly instructions

![Printbed_Frame_with_Z_Carriages_assembly](assemblies/Printbed_Frame_with_Z_Carriages_assembly.png)

1. Lay the frame on a flat surface and  slide the Z carriages onto the frame as shown.
2. Ensure the Z carriages are square and aligned with the end of the frame and then tighten the bolts on Z_carriages.
3. Ensure the 2040 extrusion is pressed firmly against the Z_Carriages and tighten the hidden bolts in the frame.

![Printbed_Frame_with_Z_Carriages_assembled](assemblies/Printbed_Frame_with_Z_Carriages_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_assembly"></a>

## Printbed assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Bolt M3 buttonhead x 10mm |
|   4 | Bolt M4 countersunk x 45mm |
|   1 | Heated Bed 235mm x 235mm |
|   4 | Heated bed leveling knob |
|   4 | Spring 8mm OD, 0.9mm gauge x 20mm long, closed end |

### 3D Printed parts

| 1 x Printbed_Strain_Relief_Clamp.stl |
|----------|
| ![Printbed_Strain_Relief_Clamp.stl](stls/Printbed_Strain_Relief_Clamp.png) |

### Sub-assemblies

| 1 x Printbed_Frame_with_Z_Carriages_assembly |
|----------|
| ![Printbed_Frame_with_Z_Carriages_assembled](assemblies/Printbed_Frame_with_Z_Carriages_assembled_tn.png) |

### Assembly instructions

![Printbed_assembly](assemblies/Printbed_assembly.png)

1. Attach the heated bed to the frame using the stacks of washers and O-rings as shown.
2. Spiral wrap the wires from the heated bed.
3. Use the **Printbed_Strain_Relief_Clamp** to clamp the wires to the frame.

![Printbed_assembled](assemblies/Printbed_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Left_Side_assembly"></a>

## Left_Side assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M4 buttonhead x 10mm |
|   8 | Bolt M4 countersunk x 10mm |
|   8 | Bolt M5 buttonhead x 12mm |
|   2 | Extrusion E2020 x 400mm |
|   2 | Extrusion E2040 x 350mm |
|  12 | Nut M4 sliding T |
|   4 | SK12 shaft support bracket |

### 3D Printed parts

| 1 x Z_Motor_Mount.stl | 1 x Z_Motor_MountGuide_61mm.stl | 2 x Z_RodMountGuide_40mm.stl |
|----------|----------|----------|
| ![Z_Motor_Mount.stl](stls/Z_Motor_Mount.png) | ![Z_Motor_MountGuide_61mm.stl](stls/Z_Motor_MountGuide_61mm.png) | ![Z_RodMountGuide_40mm.stl](stls/Z_RodMountGuide_40mm.png) |

### Assembly instructions

![Left_Side_assembly](assemblies/Left_Side_assembly.png)

1. Attach the SK brackets to the upper extrusion, use the **Z_RodMountGuide** to align the left bracket.
2. Tighten the bolts for the left bracket. Leave the bolts to the right bracket loosely tightened for now.
3. Attach the SK brackets and the **Z_Motor_Mount** to the lower extrusion, use the **Z_RodMountGuide** to
align the left bracket and the **Z_Motor_MountGuide** to align the motor mount. The motor itself will be added at a later
stage of the assembly.
4. Tighten the bolts for the left bracket and the **Z_Motor_Mount**. Leave the bolts to the right bracket loosely
tightened for now.
5. On a flat surface, bolt the upper and lower extrusions into the left and right uprights as shown. Tighten the bolts
continuously ensuring the frame is square.

![Left_Side_assembled](assemblies/Left_Side_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Left_Side_with_Printbed_assembly"></a>

## Left_Side_with_Printbed assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   4 | Bolt M3 buttonhead x 10mm |
|   1 | Cork damper NEMA 17 |
|   2 | Linear rod 12mm x 300mm |
|   1 | Stepper motor NEMA17 x 40mm, 280mm integrated leadscrew |
|   1 | Stepper motor cable, 850mm |

### Sub-assemblies

| 1 x Left_Side_assembly | 1 x Printbed_assembly |
|----------|----------|
| ![Left_Side_assembled](assemblies/Left_Side_assembled_tn.png) | ![Printbed_assembled](assemblies/Printbed_assembled_tn.png) |

### Assembly instructions

![Left_Side_with_Printbed_assembly](assemblies/Left_Side_with_Printbed_assembly.png)

1. Face the left face on a flat surface.
2. Attach the print bed to the left face by sliding the linear rods through the Z_Carriages.
3. Tighten the grub screws on the rod brackets, but don't yet tighten the bolts holding the brackets to the frame.
4. Slide the print bed to the top of the rods, and tighten the bolts in the top right rod bracket.
(you will have tightened the bolts on the top left bracket in a previous step).
5. Slide the print bed to the bottom of the rods and tighten the bolts on the bottom right rod bracket
(you will have tightened the bolts on the bottom left bracket in a previous step).
6. Thread the motor's lead screw through the lead nut on the **Z_Carriage_Center** and loosely bolt the motor to
the **Z_Motor_Mount**.
7. Ensure the **Z_Carriage_Center** is aligned with the lead screw and tighten the bolts on the **Z_Carriage_Center**
and the **Z_Motor_Mount**. The bolt holes on the **Z_Motor_Mount** are oval to allow some adjustment.
8. Route the motor wire through the lower extrusion channel and use the **E20_ChannelCover_50mm**s to hold it in place.

![Left_Side_with_Printbed_assembled](assemblies/Left_Side_with_Printbed_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Stage_1_assembly"></a>

## Stage_1 assembly

### Sub-assemblies

| 1 x Base_Plate_assembly | 1 x Left_Side_with_Printbed_assembly |
|----------|----------|
| ![Base_Plate_assembled](assemblies/Base_Plate_assembled_tn.png) | ![Left_Side_with_Printbed_assembled](assemblies/Left_Side_with_Printbed_assembled_tn.png) |

### Assembly instructions

![Stage_1_assembly](assemblies/Stage_1_assembly.png)

1. Slide the left face into the base plate assembly.
2. Ensuring the frame remains square, tighten the hidden bolts and the bolts under the baseplate.

![Stage_1_assembled](assemblies/Stage_1_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Stage_2_assembly"></a>

## Stage_2 assembly

### Sub-assemblies

| 1 x Right_Side_assembly | 1 x Stage_1_assembly |
|----------|----------|
| ![Right_Side_assembled](assemblies/Right_Side_assembled_tn.png) | ![Stage_1_assembled](assemblies/Stage_1_assembled_tn.png) |

### Assembly instructions

![Stage_2_assembly](assemblies/Stage_2_assembly.png)

1. Slide the right face into the base plate assembly.
2. Ensuring the frame remains square, tighten the hidden bolts and the bolts under the baseplate.
3. Route the serial cable for the display in the top channel of the right side lower extrusion and route
the ribbon cable along the bottom of the extrusion and cover with the **E20_RibbonCover_50mm**s to keep
the cables in place.

![Stage_2_assembled](assemblies/Stage_2_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Stage_3_assembly"></a>

## Stage_3 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|  14 | Bolt M4 buttonhead x  8mm |
|  14 | Nut M4 hammer |
|   1 | Sheet polycarbonate 390mm x 400mm x 3mm |

### CNC Routed parts

| 1 x Back_Panel.dxf |
|----------|
| ![Back_Panel.dxf](dxfs/Back_Panel.png) |

### Sub-assemblies

| 1 x Face_Top_assembly | 1 x Stage_2_assembly |
|----------|----------|
| ![Face_Top_assembled](assemblies/Face_Top_assembled_tn.png) | ![Stage_2_assembled](assemblies/Stage_2_assembled_tn.png) |

### Assembly instructions

![Stage_3_assembly](assemblies/Stage_3_assembly.png)

1. Slide the **Face_Top** assembly into the rest of the frame and tighten the hidden bolts.
2. Check that the print head slides freely on the Y-axis. If it doesn't, then re-rack the Y-axis,
see [Face_Top_Stage_2 assembly](#Face_Top_Stage_2_assembly).
3. Attach the back panel to the rest of the assembly.
4. Tighten the bolts on the back panel.

![Stage_3_assembled](assemblies/Stage_3_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Stage_4_assembly"></a>

## Stage_4 assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|   2 | Bolt M3 buttonhead x 10mm |
|   4 | Bolt M3 countersunk x 40mm |
|   1 | PTFE Bowden tube, 600 mm |

### 3D Printed parts

| 1 x Wiring_Guide.stl | 1 x Wiring_Guide_Clamp.stl |
|----------|----------|
| ![Wiring_Guide.stl](stls/Wiring_Guide.png) | ![Wiring_Guide_Clamp.stl](stls/Wiring_Guide_Clamp.png) |

### Sub-assemblies

| 1 x Printhead_E3DV6_assembly | 1 x Stage_3_assembly |
|----------|----------|
| ![Printhead_E3DV6_assembled](assemblies/Printhead_E3DV6_assembled_tn.png) | ![Stage_3_assembled](assemblies/Stage_3_assembled_tn.png) |

### Assembly instructions

![Stage_4_assembly](assemblies/Stage_4_assembly.png)

1. Bolt the **Printhead_E3DV6_assembly** to the MGN carriage.
2. Route the wiring from the print head to the mainboard and secure it with the **Wiring_Guide_Clamp**.
3. Adjust the belt tension.
4. Connect the Bowden tube between the extruder and the printhead.

![Stage_4_assembled](assemblies/Stage_4_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="main_assembly"></a>

## main assembly

### Vitamins

| Qty | Description |
|----:|:------------|
|  25 | Bolt M4 buttonhead x  8mm |
|   2 | Bolt M4 buttonhead x 12mm |
|  27 | Nut M4 hammer |
|   1 | Sheet polycarbonate 295mm x 400mm x 3mm |
|   1 | Sheet polycarbonate 390mm x 400mm x 3mm |

### 3D Printed parts

| 1 x Spool_Holder.stl | 1 x Spool_Holder_36.stl | 1 x Spool_Holder_Bracket.stl |
|----------|----------|----------|
| ![Spool_Holder.stl](stls/Spool_Holder.png) | ![Spool_Holder_36.stl](stls/Spool_Holder_36.png) | ![Spool_Holder_Bracket.stl](stls/Spool_Holder_Bracket.png) |

### CNC Routed parts

| 1 x Left_Side_Panel.dxf | 1 x Right_Side_Panel.dxf |
|----------|----------|
| ![Left_Side_Panel.dxf](dxfs/Left_Side_Panel.png) | ![Right_Side_Panel.dxf](dxfs/Right_Side_Panel.png) |

### Sub-assemblies

| 1 x Stage_4_assembly |
|----------|
| ![Stage_4_assembled](assemblies/Stage_4_assembled_tn.png) |

### Assembly instructions

![main_assembly](assemblies/main_assembly.png)

1. Bolt the polycarbonate sheet to the left face.
2. Attach the spoolholder and filament spool to the right face.
3. You are now ready to level the bed and calibrate the printer.

![main_assembled](assemblies/main_assembled.png)

<span></span>
[Top](#TOP)
