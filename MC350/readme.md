<a name="TOP"></a>

# MaybeCube Assembly Instructions

These are the assembly instructions for the MaybeCube. These instructions are not fully comprehensive, that is they do
not show every small detail of the construction and in particular they do not show the wiring. However there is sufficient
detail that someone with a good understanding of 3D printers can build the MaybeCube.

![Main Assembly](assemblies/main_assembled.png)
## Part substitutions - read this before you order parts

1. Most M3 button head bolts can be replaced with M3 cap head bolts.
2. The M3 hammer t-nuts and sliding t-nuts are mostly interchangeable. The exception being that hammer nuts are required for the
  thumbscrews on the extruder and spool holder. I find sliding t-nuts make for easier assembly, since they always "bite", and
  hammer nuts are better for parts that may be removed, like the side panels and baseplate.
3. The y-axis linear rails are specified to be 50mm shorter than the y-axis extrusions - eg 300mm linear rails are used with
  350mm extrusions. However the y-axis linear rails can be the same length as the extrusions, so 350mm linear rails could be
  used with 350mm extrusions. There is no such flexibility in the x-axis, however.

<span></span>

---

## Table of Contents

1. [Parts list](#Parts_list)

1. [Left_Side_Panel assembly](#Left_Side_Panel_assembly)
1. [Extruder_Bracket assembly](#Extruder_Bracket_assembly)
1. [IEC_Housing_Mount assembly](#IEC_Housing_Mount_assembly)
1. [Right_Side_Panel assembly](#Right_Side_Panel_assembly)
1. [X_Carriage assembly](#X_Carriage_assembly)
1. [Printhead assembly](#Printhead_assembly)
1. [X_Carriage_Front assembly](#X_Carriage_Front_assembly)
1. [Top_Corner_Piece assembly](#Top_Corner_Piece_assembly)
1. [Wiring_Guide assembly](#Wiring_Guide_assembly)
1. [XY_Motor_Mount_Right assembly](#XY_Motor_Mount_Right_assembly)
1. [XY_Idler_Right assembly](#XY_Idler_Right_assembly)
1. [XY_Motor_Mount_Left assembly](#XY_Motor_Mount_Left_assembly)
1. [XY_Idler_Left assembly](#XY_Idler_Left_assembly)
1. [Y_Carriage_Right assembly](#Y_Carriage_Right_assembly)
1. [Right_Side_Upper_Extrusion assembly](#Right_Side_Upper_Extrusion_assembly)
1. [Y_Carriage_Left assembly](#Y_Carriage_Left_assembly)
1. [Left_Side_Upper_Extrusion assembly](#Left_Side_Upper_Extrusion_assembly)
1. [Face_Top_Stage_1 assembly](#Face_Top_Stage_1_assembly)
1. [Face_Top assembly](#Face_Top_assembly)
1. [Partition assembly](#Partition_assembly)
1. [PCB_Mounting_Plate assembly](#PCB_Mounting_Plate_assembly)
1. [PSU_Right_Mount assembly](#PSU_Right_Mount_assembly)
1. [PSU_Left_Mount assembly](#PSU_Left_Mount_assembly)
1. [Back_Panel assembly](#Back_Panel_assembly)
1. [Right_Side assembly](#Right_Side_assembly)
1. [Display_Cover_TFT35_E3 assembly](#Display_Cover_TFT35_E3_assembly)
1. [Display_Housing_TFT35_E3 assembly](#Display_Housing_TFT35_E3_assembly)
1. [Base_Plate assembly](#Base_Plate_assembly)
1. [Printbed_Strain_Relief assembly](#Printbed_Strain_Relief_assembly)
1. [Z_Carriage_Center assembly](#Z_Carriage_Center_assembly)
1. [Z_Carriage_Right assembly](#Z_Carriage_Right_assembly)
1. [Z_Carriage_Left assembly](#Z_Carriage_Left_assembly)
1. [Printbed_Frame assembly](#Printbed_Frame_assembly)
1. [Printbed_Frame_with_Z_Carriages assembly](#Printbed_Frame_with_Z_Carriages_assembly)
1. [Printbed assembly](#Printbed_assembly)
1. [Z_Motor_Mount assembly](#Z_Motor_Mount_assembly)
1. [Left_Side assembly](#Left_Side_assembly)
1. [Main assembly](#main_assembly)

<span></span>
[Top](#TOP)

---
<a name="Parts_list"></a>

## Parts list


| <span style="writing-mode: vertical-rl; text-orientation: mixed;">IEC Housing Mount</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printhead</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">X Carriage Front</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Wiring Guide</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Face Top</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Partition</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">PCB Mounting Plate</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">PSU Right Mount</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">PSU Left Mount</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Back Panel</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Right Side</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Display Housing TFT35 E3</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printbed Strain Relief</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printbed</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Left Side</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Main</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">TOTALS</span> |  |
|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|------:|:---|
|      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |       | **Vitamins** |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Aluminium sheet 390mm x 390mm x 3mm |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Belt GT2 x 6mm x nanmm |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Belt GT2 x 6mm x nanmm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  BigTreeTech SKR E3 Turbo |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  |  BigTreeTech TFT35 E3 v3.0 |
|   .  |   4  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    4  |  Bolt M2 caphead x  6mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  |  Bolt M3 buttonhead x  8mm |
|   .  |   4  |   6  |   .  |   2  |   .  |   .  |   .  |   .  |   5  |   .  |   .  |   .  |   .  |   .  |   .  |   17  |  Bolt M3 buttonhead x 10mm |
|   .  |   2  |   .  |   .  |  14  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   20  |  Bolt M3 buttonhead x 12mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  |  Bolt M3 buttonhead x 16mm |
|   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Bolt M3 buttonhead x 25mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   5  |   .  |   4  |   .  |   .  |   .  |   .  |    9  |  Bolt M3 caphead x  6mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Bolt M3 caphead x  8mm |
|   .  |   .  |   .  |   .  |  28  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   28  |  Bolt M3 caphead x 10mm |
|   .  |   .  |   .  |   .  |  10  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   10  |  Bolt M3 caphead x 16mm |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Bolt M3 caphead x 20mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   .  |   .  |   .  |    6  |  Bolt M3 caphead x 25mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Bolt M3 caphead x 30mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |  40  |   40  |  Bolt M4 buttonhead x  8mm |
|   .  |   .  |   .  |   .  |  14  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |  10  |   2  |   8  |   34  |  Bolt M4 buttonhead x 10mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   8  |   .  |    8  |  Bolt M4 buttonhead x 10mm - not shown |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |   4  |    6  |  Bolt M4 buttonhead x 12mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |  20  |   .  |   .  |   .  |   .  |   .  |   .  |   20  |  Bolt M4 countersunk x  8mm |
|   .  |   .  |   .  |   .  |  20  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   8  |   .  |   28  |  Bolt M4 countersunk x 10mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Bolt M4 countersunk x 45mm |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    4  |  Bolt M5 buttonhead x 10mm |
|   .  |   .  |   .  |   .  |  10  |   .  |   .  |   .  |   .  |   .  |   8  |   .  |   .  |   .  |   8  |  12  |   38  |  Bolt M5 buttonhead x 12mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   8  |   .  |   .  |    8  |  Bolt M5 countersunk x 12mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   2  |    5  |  Cork damper NEMA 17 |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  E3D V6 Fan Duct |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |   .  |   .  |    2  |  Extrusion E2020 x 275mm |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Extrusion E2020 x 350mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   2  |   .  |    4  |  Extrusion E2020 x 400mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  |  Extrusion E2040 x 150mm |
|   .  |   .  |   .  |   .  |   3  |   .  |   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   2  |   1  |    8  |  Extrusion E2040 x 350mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  Extrusion E2080 x 350mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Extrusion inner corner bracket 4.5 |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Fan 30mm x 10mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  |  Heated Bed 235mm x 235mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Heated bed leveling knob |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Hot end E3D V6 direct 1.75mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  IEC320 C14 switched fused inlet module |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  LED Switching Power Supply 24V 15A 360W |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  |  Leadscrew 8mm x 280mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  |  Leadscrew nut 8 x 2 |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Linear rail MGN12 x 300mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Linear rail MGN12 x 350mm |
|   .  |   .  |   .  |   .  |   3  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    3  |  Linear rail carriage MGN12H |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Linear rod 12mm x 300mm |
|   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  M3 self tapping screw x 16mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  MK10 Dual Pulley Extruder |
|   .  |   .  |   .  |   .  |  16  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   16  |  Nut M3 hammer |
|   .  |   .  |   .  |   .  |  12  |   .  |   .  |   .  |   .  |  16  |   .  |   .  |   .  |   .  |   .  |  48  |   76  |  Nut M4 hammer |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   8  |   .  |    8  |  Nut M4 hammer - not shown |
|   .  |   .  |   .  |   .  |  20  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   8  |  12  |   .  |   40  |  Nut M4 sliding T |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  |  PTFE tube 488 mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  |  Pillar hex nylon F/F M3x14 |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   5  |   .  |   .  |   .  |   .  |   .  |   .  |    5  |  Pillar hex nylon F/F M3x20 |
|   .  |   .  |   .  |   .  |   8  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    8  |  Pulley GT2 idler 16 teeth |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    4  |  Pulley GT2 idler smooth 9.63mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Pulley GT2OB 20 teeth |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |   .  |   .  |    2  |  SCS12LUU bearing block |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |    4  |  SK12 shaft support bracket |
|   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Sheet polycarbonate 390mm x 349mm x 3mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   2  |    3  |  Sheet polycarbonate 390mm x 400mm x 3mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |   .  |   .  |    4  |  Spring 8mm OD, 0.9mm gauge x 20mm long, closed end |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Square radial fan 3010 |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  |  Stepper motor NEMA17 x 40mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    4  |  Stepper motor NEMA17 x 47mm |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Stepper motor cable, 1125mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  |  Stepper motor cable, 850mm |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  Stepper motor cable, 950mm |
|   .  |   .  |   .  |   .  |  22  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   22  |  Washer  M3 |
|   .  |   .  |   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  |  Washer  M4 |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  |  Ziptie 2.5mm x 100mm min length |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  |  filament sensor |
|   .  |  19  |   8  |   .  | 210  |   1  |   .  |   .  |   .  |  54  |  12  |   9  |   .  |  53  |  64  | 144  |  574  | Total vitamins count |
|      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |       | **3D printed parts** |
|   .  |   2  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    4  | Belt_Clamp.stl |
|   .  |   .  |   2  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    2  | Belt_Tensioner.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Belt_Tidy.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Display_Housing_Bracket_TFT35_E3.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |    1  | Display_Housing_TFT35_E3.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Extruder_Bracket.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  | Extrusion_Drill_Jig_120_2.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  | Extrusion_Drill_Jig_120_4.stl |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Fan_Duct_Right.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   4  |    4  | Foot_LShaped_12mm.stl |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Hotend_Clamp.stl |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Hotend_Strain_Relief_Clamp.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |    2  | IEC_Housing.stl |
|   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | IEC_Housing_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |    2  | PCB_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |    2  | PSU_Left_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | PSU_Right_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | PSU_Upper_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  | Printbed_Strain_Relief.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |    1  | Printbed_Strain_Relief_Clamp.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Spool_Holder.stl |
|   .  |   .  |   .  |   .  |   4  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    4  | Top_Corner_Piece.stl |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Wiring_Guide.stl |
|   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Wiring_Guide_Clamp.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | XY_Idler_Left.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | XY_Idler_Right.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | XY_Motor_Mount_Left.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | XY_Motor_Mount_Right.stl |
|   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | X_Carriage.stl |
|   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | X_Carriage_Front.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Brace_Left.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Brace_Right.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Left.stl |
|   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Y_Carriage_Right.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  | Z_Carriage_Center.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  | Z_Carriage_Left.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |    1  | Z_Carriage_Right.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |    1  | Z_Motor_Mount.stl |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   2  |   .  |    2  | Z_RodMountGuide_105mm.stl |
|   1  |   6  |   6  |   2  |  12  |   .  |   1  |   1  |   1  |   3  |   .  |   2  |   2  |   3  |   5  |   8  |   53  | Total 3D printed parts count |
|      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |       | **CNC routed parts** |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Back_Panel.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | BaseAL.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Left_Side_Panel.dxf |
|   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |    1  | Partition.dxf |
|   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   .  |   1  |    1  | Right_Side_Panel.dxf |
|   .  |   .  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   1  |   .  |   .  |   .  |   .  |   .  |   3  |    5  | Total CNC routed parts count |

<span></span>
[Top](#TOP)

---
<a name="Left_Side_Panel_assembly"></a>

## Left_Side_Panel assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|16| Bolt M4 buttonhead x  8mm|
|16| Nut M4 hammer|
|1| Sheet polycarbonate 390mm x 400mm x 3mm|


### CNC Routed parts

| 1 x Left_Side_Panel.dxf |
|---|
| ![Left_Side_Panel.dxf](dxfs/Left_Side_Panel.png) 



### Assembly instructions

![Left_Side_Panel_assembly](assemblies/Left_Side_Panel_assembly.png)

![Left_Side_Panel_assembled](assemblies/Left_Side_Panel_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Extruder_Bracket_assembly"></a>

## Extruder_Bracket assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M3 buttonhead x  8mm|
|2| Bolt M3 buttonhead x 16mm|
|1| Cork damper NEMA 17|
|1| MK10 Dual Pulley Extruder|
|2| Pillar hex nylon F/F M3x14|
|1| Stepper motor NEMA17 x 47mm|
|1| Stepper motor cable, 950mm|
|1| filament sensor|


### 3D Printed parts

| 1 x Extruder_Bracket.stl |
|---|
| ![Extruder_Bracket.stl](stls/Extruder_Bracket.png) 



### Assembly instructions

![Extruder_Bracket_assembly](assemblies/Extruder_Bracket_assembly.png)

![Extruder_Bracket_assembled](assemblies/Extruder_Bracket_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="IEC_Housing_Mount_assembly"></a>

## IEC_Housing_Mount assembly

### 3D Printed parts

| 1 x IEC_Housing_Mount.stl |
|---|
| ![IEC_Housing_Mount.stl](stls/IEC_Housing_Mount.png) 



### Assembly instructions

![IEC_Housing_Mount_assembly](assemblies/IEC_Housing_Mount_assembly.png)

![IEC_Housing_Mount_assembled](assemblies/IEC_Housing_Mount_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Right_Side_Panel_assembly"></a>

## Right_Side_Panel assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M3 buttonhead x  8mm|
|2| Bolt M3 buttonhead x 16mm|
|16| Bolt M4 buttonhead x  8mm|
|2| Bolt M4 buttonhead x 12mm|
|1| Cork damper NEMA 17|
|1| IEC320 C14 switched fused inlet module|
|1| MK10 Dual Pulley Extruder|
|16| Nut M4 hammer|
|2| Pillar hex nylon F/F M3x14|
|1| Sheet polycarbonate 390mm x 400mm x 3mm|
|1| Stepper motor NEMA17 x 47mm|
|1| Stepper motor cable, 950mm|
|1| filament sensor|


### 3D Printed parts

| 1 x IEC_Housing.stl |
|---|
| ![IEC_Housing.stl](stls/IEC_Housing.png) 



### CNC Routed parts

| 1 x Right_Side_Panel.dxf |
|---|
| ![Right_Side_Panel.dxf](dxfs/Right_Side_Panel.png) 



### Assembly instructions

![Right_Side_Panel_assembly](assemblies/Right_Side_Panel_assembly.png)

![Right_Side_Panel_assembled](assemblies/Right_Side_Panel_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="X_Carriage_assembly"></a>

## X_Carriage assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M2 caphead x  6mm|
|4| Bolt M3 buttonhead x 10mm|
|1| Square radial fan 3010|
|1| Ziptie 2.5mm x 100mm min length|


### 3D Printed parts

| 2 x Belt_Clamp.stl | 1 x Fan_Duct_Right.stl | 1 x X_Carriage.stl |
|---|---|---|
| ![Belt_Clamp.stl](stls/Belt_Clamp.png) | ![Fan_Duct_Right.stl](stls/Fan_Duct_Right.png) | ![X_Carriage.stl](stls/X_Carriage.png) 



### Assembly instructions

![X_Carriage_assembly](assemblies/X_Carriage_assembly.png)

1. Bolt the belt clamps to the sides of the X_Carriage. Leave the clamps loose to allow later insertion of the belts.
2. Bolt the fan onto the side of the X_Carriage, secure the fan wire with a ziptie.
3. Ensure a good fit between the fan and the fan duct and bolt the fan duct to the X_Carriage.

![X_Carriage_assembled](assemblies/X_Carriage_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printhead_assembly"></a>

## Printhead assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M3 buttonhead x 12mm|
|2| Bolt M3 buttonhead x 25mm|
|1| E3D V6 Fan Duct|
|1| Fan 30mm x 10mm|
|1| Hot end E3D V6 direct 1.75mm|
|2| M3 self tapping screw x 16mm|


### 3D Printed parts

| 1 x Hotend_Clamp.stl | 1 x Hotend_Strain_Relief_Clamp.stl |
|---|---|
| ![Hotend_Clamp.stl](stls/Hotend_Clamp.png) | ![Hotend_Strain_Relief_Clamp.stl](stls/Hotend_Strain_Relief_Clamp.png) 



### Sub-assemblies

| 1 x X_Carriage_assembly |
|---|
| ![X_Carriage_assembled](assemblies/X_Carriage_assembled_tn.png) 



### Assembly instructions

![Printhead_assembly](assemblies/Printhead_assembly.png)

1. Assemble the E3D hotend, including fan, thermistor cartridge and heater cartridge.
2. Use the Hotend_Clamp to attach the hotend to the X_Carriage.
3. Collect the wires together and attach to the X_Carriage using the Hotend_Strain_Relief_Clamp.

![Printhead_assembled](assemblies/Printhead_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="X_Carriage_Front_assembly"></a>

## X_Carriage_Front assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|6| Bolt M3 buttonhead x 10mm|
|2| Bolt M3 caphead x 20mm|


### 3D Printed parts

| 2 x Belt_Clamp.stl | 2 x Belt_Tensioner.stl | 1 x Belt_Tidy.stl |
|---|---|---|
| ![Belt_Clamp.stl](stls/Belt_Clamp.png) | ![Belt_Tensioner.stl](stls/Belt_Tensioner.png) | ![Belt_Tidy.stl](stls/Belt_Tidy.png) 


| 1 x X_Carriage_Front.stl |
|---|
| ![X_Carriage_Front.stl](stls/X_Carriage_Front.png) 



### Assembly instructions

![X_Carriage_Front_assembly](assemblies/X_Carriage_Front_assembly.png)

1. Bolt the Belt_Clamps to the X_Carriage_Front, leaving them loose for later insertion of the belts.
2. Insert the Belt_tensioners into the X_Carriage_Front, and use the 20mm bolts to secure them in place.

![X_Carriage_Front_assembled](assemblies/X_Carriage_Front_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Top_Corner_Piece_assembly"></a>

## 4 x Top_Corner_Piece assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|20| Bolt M4 countersunk x 10mm|
|20| Nut M4 sliding T|


### 3D Printed parts

| 4 x Top_Corner_Piece.stl |
|---|
| ![Top_Corner_Piece.stl](stls/Top_Corner_Piece.png) 



### Assembly instructions

![Top_Corner_Piece_assembly](assemblies/Top_Corner_Piece_assembly_tn.png)

![Top_Corner_Piece_assembled](assemblies/Top_Corner_Piece_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Wiring_Guide_assembly"></a>

## Wiring_Guide assembly

### 3D Printed parts

| 1 x Wiring_Guide.stl | 1 x Wiring_Guide_Clamp.stl |
|---|---|
| ![Wiring_Guide.stl](stls/Wiring_Guide.png) | ![Wiring_Guide_Clamp.stl](stls/Wiring_Guide_Clamp.png) 



### Assembly instructions

![Wiring_Guide_assembly](assemblies/Wiring_Guide_assembly_tn.png)

![Wiring_Guide_assembled](assemblies/Wiring_Guide_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Motor_Mount_Right_assembly"></a>

## XY_Motor_Mount_Right assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 12mm|
|2| Bolt M3 caphead x 16mm|
|3| Bolt M4 buttonhead x 10mm|
|1| Cork damper NEMA 17|
|3| Nut M4 hammer|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 9.63mm|
|1| Pulley GT2OB 20 teeth|
|1| Stepper motor NEMA17 x 47mm|
|1| Stepper motor cable, 1125mm|
|2| Washer  M3|


### 3D Printed parts

| 1 x XY_Motor_Mount_Right.stl |
|---|
| ![XY_Motor_Mount_Right.stl](stls/XY_Motor_Mount_Right.png) 



### Assembly instructions

![XY_Motor_Mount_Right_assembly](assemblies/XY_Motor_Mount_Right_assembly.png)

![XY_Motor_Mount_Right_assembled](assemblies/XY_Motor_Mount_Right_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Idler_Right_assembly"></a>

## XY_Idler_Right assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Bolt M3 caphead x 30mm|
|4| Bolt M4 buttonhead x 10mm|
|3| Nut M4 hammer|
|2| Pulley GT2 idler 16 teeth|
|6| Washer  M3|
|1| Washer  M4|


### 3D Printed parts

| 1 x XY_Idler_Right.stl |
|---|
| ![XY_Idler_Right.stl](stls/XY_Idler_Right.png) 



### Assembly instructions

![XY_Idler_Right_assembly](assemblies/XY_Idler_Right_assembly_tn.png)

![XY_Idler_Right_assembled](assemblies/XY_Idler_Right_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Motor_Mount_Left_assembly"></a>

## XY_Motor_Mount_Left assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 12mm|
|2| Bolt M3 caphead x 16mm|
|3| Bolt M4 buttonhead x 10mm|
|1| Cork damper NEMA 17|
|3| Nut M4 hammer|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 9.63mm|
|1| Pulley GT2OB 20 teeth|
|1| Stepper motor NEMA17 x 47mm|
|1| Stepper motor cable, 1125mm|
|2| Washer  M3|


### 3D Printed parts

| 1 x XY_Motor_Mount_Left.stl |
|---|
| ![XY_Motor_Mount_Left.stl](stls/XY_Motor_Mount_Left.png) 



### Assembly instructions

![XY_Motor_Mount_Left_assembly](assemblies/XY_Motor_Mount_Left_assembly.png)

![XY_Motor_Mount_Left_assembled](assemblies/XY_Motor_Mount_Left_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Idler_Left_assembly"></a>

## XY_Idler_Left assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Bolt M3 caphead x 30mm|
|4| Bolt M4 buttonhead x 10mm|
|3| Nut M4 hammer|
|2| Pulley GT2 idler 16 teeth|
|6| Washer  M3|
|1| Washer  M4|


### 3D Printed parts

| 1 x XY_Idler_Left.stl |
|---|
| ![XY_Idler_Left.stl](stls/XY_Idler_Left.png) 



### Assembly instructions

![XY_Idler_Left_assembly](assemblies/XY_Idler_Left_assembly_tn.png)

![XY_Idler_Left_assembled](assemblies/XY_Idler_Left_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Y_Carriage_Right_assembly"></a>

## Y_Carriage_Right assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 caphead x 10mm|
|3| Bolt M3 caphead x 16mm|
|1| Bolt M3 caphead x 25mm|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 9.63mm|
|3| Washer  M3|


### 3D Printed parts

| 1 x Y_Carriage_Brace_Right.stl | 1 x Y_Carriage_Right.stl |
|---|---|
| ![Y_Carriage_Brace_Right.stl](stls/Y_Carriage_Brace_Right.png) | ![Y_Carriage_Right.stl](stls/Y_Carriage_Right.png) 



### Assembly instructions

![Y_Carriage_Right_assembly](assemblies/Y_Carriage_Right_assembly_tn.png)

![Y_Carriage_Right_assembled](assemblies/Y_Carriage_Right_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Right_Side_Upper_Extrusion_assembly"></a>

## Right_Side_Upper_Extrusion assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M3 caphead x 10mm|
|4| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2040 x 350mm|
|1| Linear rail MGN12 x 350mm|
|1| Linear rail carriage MGN12H|
|8| Nut M3 hammer|


### Sub-assemblies

| 1 x Y_Carriage_Right_assembly |
|---|
| ![Y_Carriage_Right_assembled](assemblies/Y_Carriage_Right_assembled_tn.png) 



### Assembly instructions

![Right_Side_Upper_Extrusion_assembly](assemblies/Right_Side_Upper_Extrusion_assembly.png)

![Right_Side_Upper_Extrusion_assembled](assemblies/Right_Side_Upper_Extrusion_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Y_Carriage_Left_assembly"></a>

## Y_Carriage_Left assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 caphead x 10mm|
|3| Bolt M3 caphead x 16mm|
|1| Bolt M3 caphead x 25mm|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 9.63mm|
|3| Washer  M3|


### 3D Printed parts

| 1 x Y_Carriage_Brace_Left.stl | 1 x Y_Carriage_Left.stl |
|---|---|
| ![Y_Carriage_Brace_Left.stl](stls/Y_Carriage_Brace_Left.png) | ![Y_Carriage_Left.stl](stls/Y_Carriage_Left.png) 



### Assembly instructions

![Y_Carriage_Left_assembly](assemblies/Y_Carriage_Left_assembly_tn.png)

![Y_Carriage_Left_assembled](assemblies/Y_Carriage_Left_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Left_Side_Upper_Extrusion_assembly"></a>

## Left_Side_Upper_Extrusion assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M3 caphead x 10mm|
|4| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2040 x 350mm|
|1| Linear rail MGN12 x 350mm|
|1| Linear rail carriage MGN12H|
|8| Nut M3 hammer|


### Sub-assemblies

| 1 x Y_Carriage_Left_assembly |
|---|
| ![Y_Carriage_Left_assembled](assemblies/Y_Carriage_Left_assembled_tn.png) 



### Assembly instructions

![Left_Side_Upper_Extrusion_assembly](assemblies/Left_Side_Upper_Extrusion_assembly.png)

![Left_Side_Upper_Extrusion_assembled](assemblies/Left_Side_Upper_Extrusion_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_Stage_1_assembly"></a>

## Face_Top_Stage_1 assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M5 buttonhead x 10mm|
|2| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2020 x 350mm|
|1| Extrusion E2040 x 350mm|


### Sub-assemblies

| 1 x Left_Side_Upper_Extrusion_assembly | 1 x Right_Side_Upper_Extrusion_assembly | 4 x Top_Corner_Piece_assembly |
|---|---|---|
| ![Left_Side_Upper_Extrusion_assembled](assemblies/Left_Side_Upper_Extrusion_assembled_tn.png) | ![Right_Side_Upper_Extrusion_assembled](assemblies/Right_Side_Upper_Extrusion_assembled_tn.png) | ![Top_Corner_Piece_assembled](assemblies/Top_Corner_Piece_assembled_tn.png) 


| 1 x Wiring_Guide_assembly | 1 x XY_Idler_Left_assembly | 1 x XY_Idler_Right_assembly |
|---|---|---|
| ![Wiring_Guide_assembled](assemblies/Wiring_Guide_assembled_tn.png) | ![XY_Idler_Left_assembled](assemblies/XY_Idler_Left_assembled_tn.png) | ![XY_Idler_Right_assembled](assemblies/XY_Idler_Right_assembled_tn.png) 


| 1 x XY_Motor_Mount_Left_assembly | 1 x XY_Motor_Mount_Right_assembly |
|---|---|
| ![XY_Motor_Mount_Left_assembled](assemblies/XY_Motor_Mount_Left_assembled_tn.png) | ![XY_Motor_Mount_Right_assembled](assemblies/XY_Motor_Mount_Right_assembled_tn.png) 



### Assembly instructions

![Face_Top_Stage_1_assembly](assemblies/Face_Top_Stage_1_assembly.png)

![Face_Top_Stage_1_assembled](assemblies/Face_Top_Stage_1_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_assembly"></a>

## Face_Top assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Belt GT2 x 6mm x nanmm|
|1| Belt GT2 x 6mm x nanmm|
|2| Bolt M3 buttonhead x 10mm|
|6| Bolt M3 buttonhead x 12mm|
|4| Bolt M3 caphead x 10mm|
|1| Linear rail MGN12 x 300mm|
|1| Linear rail carriage MGN12H|


### Sub-assemblies

| 1 x Face_Top_Stage_1_assembly | 1 x Printhead_assembly | 1 x X_Carriage_Front_assembly |
|---|---|---|
| ![Face_Top_Stage_1_assembled](assemblies/Face_Top_Stage_1_assembled_tn.png) | ![Printhead_assembled](assemblies/Printhead_assembled_tn.png) | ![X_Carriage_Front_assembled](assemblies/X_Carriage_Front_assembled_tn.png) 



### Assembly instructions

![Face_Top_assembly](assemblies/Face_Top_assembly.png)

![Face_Top_assembled](assemblies/Face_Top_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Partition_assembly"></a>

## Partition assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Sheet polycarbonate 390mm x 349mm x 3mm|


### CNC Routed parts

| 1 x Partition.dxf |
|---|
| ![Partition.dxf](dxfs/Partition.png) 



### Assembly instructions

![Partition_assembly](assemblies/Partition_assembly.png)

![Partition_assembled](assemblies/Partition_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="PCB_Mounting_Plate_assembly"></a>

## PCB_Mounting_Plate assembly

### 3D Printed parts

| 1 x PCB_Mount.stl |
|---|
| ![PCB_Mount.stl](stls/PCB_Mount.png) 



### Assembly instructions

![PCB_Mounting_Plate_assembly](assemblies/PCB_Mounting_Plate_assembly.png)

![PCB_Mounting_Plate_assembled](assemblies/PCB_Mounting_Plate_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="PSU_Right_Mount_assembly"></a>

## PSU_Right_Mount assembly

### 3D Printed parts

| 1 x PSU_Right_Mount.stl |
|---|
| ![PSU_Right_Mount.stl](stls/PSU_Right_Mount.png) 



### Assembly instructions

![PSU_Right_Mount_assembly](assemblies/PSU_Right_Mount_assembly.png)

![PSU_Right_Mount_assembled](assemblies/PSU_Right_Mount_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="PSU_Left_Mount_assembly"></a>

## PSU_Left_Mount assembly

### 3D Printed parts

| 1 x PSU_Left_Mount.stl |
|---|
| ![PSU_Left_Mount.stl](stls/PSU_Left_Mount.png) 



### Assembly instructions

![PSU_Left_Mount_assembly](assemblies/PSU_Left_Mount_assembly.png)

![PSU_Left_Mount_assembled](assemblies/PSU_Left_Mount_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Back_Panel_assembly"></a>

## Back_Panel assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| BigTreeTech SKR E3 Turbo|
|5| Bolt M3 buttonhead x 10mm|
|5| Bolt M3 caphead x  6mm|
|20| Bolt M4 countersunk x  8mm|
|1| LED Switching Power Supply 24V 15A 360W|
|16| Nut M4 hammer|
|5| Pillar hex nylon F/F M3x20|
|1| Sheet polycarbonate 390mm x 400mm x 3mm|


### 3D Printed parts

| 1 x PCB_Mount.stl | 1 x PSU_Left_Mount.stl | 1 x PSU_Upper_Mount.stl |
|---|---|---|
| ![PCB_Mount.stl](stls/PCB_Mount.png) | ![PSU_Left_Mount.stl](stls/PSU_Left_Mount.png) | ![PSU_Upper_Mount.stl](stls/PSU_Upper_Mount.png) 



### CNC Routed parts

| 1 x Back_Panel.dxf |
|---|
| ![Back_Panel.dxf](dxfs/Back_Panel.png) 



### Sub-assemblies

| 1 x PCB_Mounting_Plate_assembly | 1 x PSU_Left_Mount_assembly | 1 x PSU_Right_Mount_assembly |
|---|---|---|
| ![PCB_Mounting_Plate_assembled](assemblies/PCB_Mounting_Plate_assembled_tn.png) | ![PSU_Left_Mount_assembled](assemblies/PSU_Left_Mount_assembled_tn.png) | ![PSU_Right_Mount_assembled](assemblies/PSU_Right_Mount_assembled_tn.png) 



### Assembly instructions

![Back_Panel_assembly](assemblies/Back_Panel_assembly.png)

![Back_Panel_assembled](assemblies/Back_Panel_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Right_Side_assembly"></a>

## Right_Side assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M5 buttonhead x 12mm|
|2| Extrusion E2020 x 400mm|
|2| Extrusion E2040 x 350mm|


### Assembly instructions

![Right_Side_assembly](assemblies/Right_Side_assembly.png)

1. On a flat surface, bolt the top, middle and lower extrusions into the left and right uprights as shown.

2. Take time to ensure everything is square and then work your way around the bolts tightening them while ensuring
the frame remains square. Don't tighten each bolt fully before moving on to the next, rather tighten each bolt a bit
and move on to the next bolt, making several circuits of the frame to get all the bolts tight.

3. Once the frame is square and tightened, align the motor mount and idler with the top extrusion and tighten them in place.

![Right_Side_assembled](assemblies/Right_Side_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Display_Cover_TFT35_E3_assembly"></a>

## Display_Cover_TFT35_E3 assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| BigTreeTech TFT35 E3 v3.0|
|4| Bolt M3 caphead x  6mm|


### 3D Printed parts

| 1 x Display_Housing_TFT35_E3.stl |
|---|
| ![Display_Housing_TFT35_E3.stl](stls/Display_Housing_TFT35_E3.png) 



### Assembly instructions

![Display_Cover_TFT35_E3_assembly](assemblies/Display_Cover_TFT35_E3_assembly.png)

![Display_Cover_TFT35_E3_assembled](assemblies/Display_Cover_TFT35_E3_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Display_Housing_TFT35_E3_assembly"></a>

## Display_Housing_TFT35_E3 assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 caphead x 25mm|


### 3D Printed parts

| 1 x Display_Housing_Bracket_TFT35_E3.stl |
|---|
| ![Display_Housing_Bracket_TFT35_E3.stl](stls/Display_Housing_Bracket_TFT35_E3.png) 



### Sub-assemblies

| 1 x Display_Cover_TFT35_E3_assembly |
|---|
| ![Display_Cover_TFT35_E3_assembled](assemblies/Display_Cover_TFT35_E3_assembled_tn.png) 



### Assembly instructions

![Display_Housing_TFT35_E3_assembly](assemblies/Display_Housing_TFT35_E3_assembly.png)

![Display_Housing_TFT35_E3_assembled](assemblies/Display_Housing_TFT35_E3_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Base_Plate_assembly"></a>

## Base_Plate assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Aluminium sheet 390mm x 390mm x 3mm|
|8| Bolt M4 buttonhead x  8mm|
|8| Bolt M4 buttonhead x 10mm|
|12| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2040 x 350mm|
|1| Extrusion E2080 x 350mm|
|16| Nut M4 hammer|


### 3D Printed parts

| 4 x Foot_LShaped_12mm.stl |
|---|
| ![Foot_LShaped_12mm.stl](stls/Foot_LShaped_12mm.png) 



### CNC Routed parts

| 1 x BaseAL.dxf |
|---|
| ![BaseAL.dxf](dxfs/BaseAL.png) 



### Sub-assemblies

| 1 x Display_Housing_TFT35_E3_assembly |
|---|
| ![Display_Housing_TFT35_E3_assembled](assemblies/Display_Housing_TFT35_E3_assembled_tn.png) 



### Assembly instructions

![Base_Plate_assembly](assemblies/Base_Plate_assembly.png)

![Base_Plate_assembled](assemblies/Base_Plate_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Strain_Relief_assembly"></a>

## Printbed_Strain_Relief assembly

### 3D Printed parts

| 1 x Printbed_Strain_Relief.stl | 1 x Printbed_Strain_Relief_Clamp.stl |
|---|---|
| ![Printbed_Strain_Relief.stl](stls/Printbed_Strain_Relief.png) | ![Printbed_Strain_Relief_Clamp.stl](stls/Printbed_Strain_Relief_Clamp.png) 



### Assembly instructions

![Printbed_Strain_Relief_assembly](assemblies/Printbed_Strain_Relief_assembly_tn.png)

![Printbed_Strain_Relief_assembled](assemblies/Printbed_Strain_Relief_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Carriage_Center_assembly"></a>

## Z_Carriage_Center assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 caphead x  8mm|
|4| Bolt M4 buttonhead x 10mm|
|1| Leadscrew nut 8 x 2|
|4| Nut M4 sliding T|


### 3D Printed parts

| 1 x Z_Carriage_Center.stl |
|---|
| ![Z_Carriage_Center.stl](stls/Z_Carriage_Center.png) 



### Assembly instructions

![Z_Carriage_Center_assembly](assemblies/Z_Carriage_Center_assembly_tn.png)

![Z_Carriage_Center_assembled](assemblies/Z_Carriage_Center_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Carriage_Right_assembly"></a>

## Z_Carriage_Right assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 10mm|
|4| Bolt M5 countersunk x 12mm|
|2| Nut M4 sliding T|
|1| SCS12LUU bearing block|


### 3D Printed parts

| 1 x Z_Carriage_Right.stl |
|---|
| ![Z_Carriage_Right.stl](stls/Z_Carriage_Right.png) 



### Assembly instructions

![Z_Carriage_Right_assembly](assemblies/Z_Carriage_Right_assembly_tn.png)

![Z_Carriage_Right_assembled](assemblies/Z_Carriage_Right_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Carriage_Left_assembly"></a>

## Z_Carriage_Left assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 10mm|
|4| Bolt M5 countersunk x 12mm|
|2| Nut M4 sliding T|
|1| SCS12LUU bearing block|


### 3D Printed parts

| 1 x Z_Carriage_Left.stl |
|---|
| ![Z_Carriage_Left.stl](stls/Z_Carriage_Left.png) 



### Assembly instructions

![Z_Carriage_Left_assembly](assemblies/Z_Carriage_Left_assembly_tn.png)

![Z_Carriage_Left_assembled](assemblies/Z_Carriage_Left_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Frame_assembly"></a>

## Printbed_Frame assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 10mm|
|2| Extrusion E2020 x 275mm|
|1| Extrusion E2040 x 150mm|
|4| Extrusion inner corner bracket 4.5|


### Assembly instructions

![Printbed_Frame_assembly](assemblies/Printbed_Frame_assembly.png)

![Printbed_Frame_assembled](assemblies/Printbed_Frame_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Frame_with_Z_Carriages_assembly"></a>

## Printbed_Frame_with_Z_Carriages assembly

### Sub-assemblies

| 1 x Printbed_Frame_assembly | 1 x Printbed_Strain_Relief_assembly | 1 x Z_Carriage_Center_assembly |
|---|---|---|
| ![Printbed_Frame_assembled](assemblies/Printbed_Frame_assembled_tn.png) | ![Printbed_Strain_Relief_assembled](assemblies/Printbed_Strain_Relief_assembled_tn.png) | ![Z_Carriage_Center_assembled](assemblies/Z_Carriage_Center_assembled_tn.png) 


| 1 x Z_Carriage_Left_assembly | 1 x Z_Carriage_Right_assembly |
|---|---|
| ![Z_Carriage_Left_assembled](assemblies/Z_Carriage_Left_assembled_tn.png) | ![Z_Carriage_Right_assembled](assemblies/Z_Carriage_Right_assembled_tn.png) 



### Assembly instructions

![Printbed_Frame_with_Z_Carriages_assembly](assemblies/Printbed_Frame_with_Z_Carriages_assembly.png)

1. Slide the Z carriages onto the frame as shown.

2. Ensure the Z carriages are square and aligned with the end of the frame and then tighten the bolts.

![Printbed_Frame_with_Z_Carriages_assembled](assemblies/Printbed_Frame_with_Z_Carriages_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_assembly"></a>

## Printbed assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M4 countersunk x 45mm|
|1| Heated Bed 235mm x 235mm|
|4| Heated bed leveling knob|
|4| Spring 8mm OD, 0.9mm gauge x 20mm long, closed end|


### Sub-assemblies

| 1 x Printbed_Frame_with_Z_Carriages_assembly |
|---|
| ![Printbed_Frame_with_Z_Carriages_assembled](assemblies/Printbed_Frame_with_Z_Carriages_assembled_tn.png) 



### Assembly instructions

![Printbed_assembly](assemblies/Printbed_assembly.png)

1. With the heatbed upside down, place the bolts through the heatbed and place the springs over the bolts.

2. Thread the bolts through the frame and add the adjusting wheels, tightening them to mid position, to allow later adjustments.

![Printbed_assembled](assemblies/Printbed_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Motor_Mount_assembly"></a>

## Z_Motor_Mount assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 12mm|
|2| Bolt M4 buttonhead x 10mm|
|2| Bolt M4 buttonhead x 12mm|
|1| Cork damper NEMA 17|
|1| Leadscrew 8mm x 280mm|
|4| Nut M4 sliding T|
|1| Stepper motor NEMA17 x 40mm|
|1| Stepper motor cable, 850mm|


### 3D Printed parts

| 1 x Z_Motor_Mount.stl |
|---|
| ![Z_Motor_Mount.stl](stls/Z_Motor_Mount.png) 



### Assembly instructions

![Z_Motor_Mount_assembly](assemblies/Z_Motor_Mount_assembly.png)

![Z_Motor_Mount_assembled](assemblies/Z_Motor_Mount_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Left_Side_assembly"></a>

## Left_Side assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M4 buttonhead x 10mm - not shown|
|8| Bolt M4 countersunk x 10mm|
|8| Bolt M5 buttonhead x 12mm|
|2| Extrusion E2020 x 400mm|
|2| Extrusion E2040 x 350mm|
|8| Nut M4 hammer - not shown|
|8| Nut M4 sliding T|
|4| SK12 shaft support bracket|


### 3D Printed parts

| 1 x Extrusion_Drill_Jig_120_2.stl | 1 x Extrusion_Drill_Jig_120_4.stl | 2 x Z_RodMountGuide_105mm.stl |
|---|---|---|
| ![Extrusion_Drill_Jig_120_2.stl](stls/Extrusion_Drill_Jig_120_2.png) | ![Extrusion_Drill_Jig_120_4.stl](stls/Extrusion_Drill_Jig_120_4.png) | ![Z_RodMountGuide_105mm.stl](stls/Z_RodMountGuide_105mm.png) 



### Sub-assemblies

| 1 x Z_Motor_Mount_assembly |
|---|
| ![Z_Motor_Mount_assembled](assemblies/Z_Motor_Mount_assembled_tn.png) 



### Assembly instructions

![Left_Side_assembly](assemblies/Left_Side_assembly.png)

1. On a flat surface, bolt the top, middle and lower extrusions into the left and right uprights as shown. Note
that the lower extrusion is 2020 extrusion, this is to allow access to the power supply and mainboard.

2. Take time to ensure everything is square and then work your way around the bolts tightening them while ensuring
the frame remains square. Don't tighten each bolt fully before moving on to the next, rather tighten each bolt a bit
and move on to the next bolt, making several circuits of the frame to get all the bolts tight.

3. Once the frame is square and tightened, align the motor mount and idler with the top extrusion and tighten them in place.

![Left_Side_assembled](assemblies/Left_Side_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="main_assembly"></a>

## main assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 12mm|
|1| IEC320 C14 switched fused inlet module|
|2| Linear rod 12mm x 300mm|
|1| PTFE tube 488 mm|


### 3D Printed parts

| 1 x IEC_Housing.stl | 1 x Spool_Holder.stl |
|---|---|
| ![IEC_Housing.stl](stls/IEC_Housing.png) | ![Spool_Holder.stl](stls/Spool_Holder.png) 



### Sub-assemblies

| 1 x Back_Panel_assembly | 1 x Base_Plate_assembly | 1 x Extruder_Bracket_assembly |
|---|---|---|
| ![Back_Panel_assembled](assemblies/Back_Panel_assembled_tn.png) | ![Base_Plate_assembled](assemblies/Base_Plate_assembled_tn.png) | ![Extruder_Bracket_assembled](assemblies/Extruder_Bracket_assembled_tn.png) 


| 1 x Face_Top_assembly | 1 x IEC_Housing_Mount_assembly | 1 x Left_Side_Panel_assembly |
|---|---|---|
| ![Face_Top_assembled](assemblies/Face_Top_assembled_tn.png) | ![IEC_Housing_Mount_assembled](assemblies/IEC_Housing_Mount_assembled_tn.png) | ![Left_Side_Panel_assembled](assemblies/Left_Side_Panel_assembled_tn.png) 


| 1 x Left_Side_assembly | 1 x Partition_assembly | 1 x Printbed_assembly |
|---|---|---|
| ![Left_Side_assembled](assemblies/Left_Side_assembled_tn.png) | ![Partition_assembled](assemblies/Partition_assembled_tn.png) | ![Printbed_assembled](assemblies/Printbed_assembled_tn.png) 


| 1 x Right_Side_Panel_assembly | 1 x Right_Side_assembly |
|---|---|
| ![Right_Side_Panel_assembled](assemblies/Right_Side_Panel_assembled_tn.png) | ![Right_Side_assembled](assemblies/Right_Side_assembled_tn.png) 



### Assembly instructions

![main_assembly](assemblies/main_assembly.png)

1. Attach the extruder and the spoolholder to the right face.

2. Connect the Bowden tube between the extruder and the printhead.

3. Attach the polycarbonate sheet to the back of the print. Make sure everything is square before tightening the bolts.

![main_assembled](assemblies/main_assembled.png)

<span></span>
[Top](#TOP)
