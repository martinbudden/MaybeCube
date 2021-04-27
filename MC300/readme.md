<a name="TOP"></a>

# MaybeCube Assembly Instructions

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

1. [Left Side Panel Assembly](#Left_Side_Panel_assembly)
1. [IEC Assembly](#IEC_assembly)
1. [Right Side Panel Assembly](#Right_Side_Panel_assembly)
1. [X Carriage Assembly](#X_Carriage_assembly)
1. [Printhead Assembly](#Printhead_assembly)
1. [X Carriage Front Assembly](#X_Carriage_Front_assembly)
1. [XY Motor Mount Right Assembly](#XY_Motor_Mount_Right_assembly)
1. [XY Idler Right Assembly](#XY_Idler_Right_assembly)
1. [XY Motor Mount Left Assembly](#XY_Motor_Mount_Left_assembly)
1. [XY Idler Left, Ngb=true Assembly](#XY_Idler_Left, ngb=true_assembly)
1. [Y Carriage Right Assembly](#Y_Carriage_Right_assembly)
1. [Face Right Upper Extrusion Assembly](#Face_Right_Upper_Extrusion_assembly)
1. [Y Carriage Left Assembly](#Y_Carriage_Left_assembly)
1. [Face Left Upper Extrusion Assembly](#Face_Left_Upper_Extrusion_assembly)
1. [Face Top Stage 1 Assembly](#Face_Top_Stage_1_assembly)
1. [Face Top Assembly](#Face_Top_assembly)
1. [Back Panel Assembly](#Back_Panel_assembly)
1. [Face Right Assembly](#Face_Right_assembly)
1. [Display Cover TFT35 E3 Assembly](#Display_Cover_TFT35_E3_assembly)
1. [Display Housing TFT35 E3 Assembly](#Display_Housing_TFT35_E3_assembly)
1. [Base Plate Assembly](#Base_Plate_assembly)
1. [Z Carriage Right Assembly](#Z_Carriage_Right_assembly)
1. [Z Carriage Left Assembly](#Z_Carriage_Left_assembly)
1. [Printbed Frame Assembly](#Printbed_Frame_assembly)
1. [Printbed Frame With Z Carriages Assembly](#Printbed_Frame_with_Z_Carriages_assembly)
1. [Printbed Assembly](#Printbed_assembly)
1. [Z Motor Mount Assembly](#Z_Motor_Mount_assembly)
1. [Face Left Assembly](#Face_Left_assembly)
1. [Main Assembly](#main_assembly)

<span></span>
[Top](#TOP)

---
<a name="Parts_list"></a>

## Parts list


| <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printhead</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">X Carriage Front</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">XY Idler Left, Ngb=true</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Face Top</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Back Panel</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Face Right</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Display Housing TFT35 E3</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Printbed</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Face Left</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">Main</span> | <span style="writing-mode: vertical-rl; text-orientation: mixed;">TOTALS</span> |  |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|:---|
|  |  |  |  |  |  |  |  |  |  | | **Vitamins** |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Aluminium plate 340mm x 340mm x 3mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Belt GT2 x 6mm x nanmm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Belt GT2 x 6mm x nanmm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; BigTreeTech SKR v1.4 Turbo |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; BigTreeTech TFT35 E3 v3.0 |
| &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; Bolt M2 caphead x  6mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Bolt M3 buttonhead x  8mm |
| &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;14&nbsp; | &nbsp;&nbsp; Bolt M3 buttonhead x 10mm |
| &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;14&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;20&nbsp; | &nbsp;&nbsp; Bolt M3 buttonhead x 12mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Bolt M3 buttonhead x 16mm |
| &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Bolt M3 buttonhead x 25mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp; Bolt M3 caphead x  6mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;28&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;28&nbsp; | &nbsp;&nbsp; Bolt M3 caphead x 10mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;10&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;10&nbsp; | &nbsp;&nbsp; Bolt M3 caphead x 16mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Bolt M3 caphead x 20mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp; Bolt M3 caphead x 25mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Bolt M3 caphead x 30mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;40&nbsp; |  &nbsp;&nbsp;40&nbsp; | &nbsp;&nbsp; Bolt M4 buttonhead x  8mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Bolt M4 buttonhead x 10mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp;9&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;12&nbsp; | &nbsp;&nbsp;10&nbsp; |  &nbsp;&nbsp;38&nbsp; | &nbsp;&nbsp; Bolt M4 buttonhead x 12mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; Bolt M5 buttonhead x 10mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp;12&nbsp; |  &nbsp;&nbsp;34&nbsp; | &nbsp;&nbsp; Bolt M5 buttonhead x 12mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp; Bolt M5 countersunk x 12mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; Cork damper NEMA 17 |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; E3D V6 Fan Duct |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Extrusion E2020 x 260mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Extrusion E2020 x 300mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; Extrusion E2020 x 400mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Extrusion E2040 x 188mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp; Extrusion E2040 x 300mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Extrusion E2080 x 300mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Extrusion inner corner bracket 4.5 |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Fan 30mm x 10mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Heated Bed 214mm x 214mm |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Hot end E3D V6 direct 1.75mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; IEC320 C14 switched fused inlet module |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Leadscrew 8mm x 250mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Linear rail MGN12 x 250mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Linear rail MGN12 x 300mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp; Linear rail carriage MGN12H |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Linear rod 12mm x 300mm |
| &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; M3 self tapping screw x 16mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; MK10 Dual Pulley Extruder |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;16&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;16&nbsp; | &nbsp;&nbsp; Nut M3 hammer |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp;9&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;48&nbsp; |  &nbsp;&nbsp;60&nbsp; | &nbsp;&nbsp; Nut M4 hammer |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;12&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;16&nbsp; | &nbsp;&nbsp; Nut M4 sliding T |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; PSU Switching Power Supply 24V 15A 360W |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Pillar hex nylon F/F M3x12 |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; Pillar hex nylon F/F M3x20 |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;8&nbsp; | &nbsp;&nbsp; Pulley GT2 idler 16 teeth |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Pulley GT2 idler smooth 12mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Pulley GT2 idler smooth 9.63mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Pulley GT2OB 20 teeth |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; SCS12LUU bearing block |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; SK12 shaft support bracket |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Shaft coupling SC_5x8_rigid |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;3&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp; Sheet polycarbonate 340mm x 400mm x 3mm |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Square radial fan 3010 |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp; Stepper motor NEMA17 x 40mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Stepper motor NEMA17 x 47mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Stepper motor cable, 1050mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Stepper motor cable, 650mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Stepper motor cable, 750mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Stepper motor cable, 900mm |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;18&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;24&nbsp; | &nbsp;&nbsp; Washer  M3 |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp; Washer  M4 |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; Ziptie 2.5mm x 100mm min length |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp; filament sensor |
| &nbsp;&nbsp;19&nbsp; | &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;17&nbsp; | &nbsp;&nbsp;151&nbsp; | &nbsp;&nbsp;15&nbsp; | &nbsp;&nbsp;12&nbsp; | &nbsp;&nbsp;9&nbsp; | &nbsp;&nbsp;24&nbsp; | &nbsp;&nbsp;49&nbsp; | &nbsp;&nbsp;130&nbsp; | &nbsp;&nbsp;432&nbsp; | &nbsp;&nbsp;Total vitamins count |
|  |  |  |  |  |  |  |  |  |  | | **3D printed parts** |
| &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;Belt_Clamp.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;Belt_Tensioner.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Belt_Tidy.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Display_Housing_Bracket_TFT35_E3.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Display_Housing_TFT35_E3.stl |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Fan_Duct.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; |  &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;Foot_LShaped_12mm.stl |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Hotend_Clamp.stl |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Hotend_Strain_Relief_Clamp.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;IEC_Housing.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;PCB_Mount.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;PSU_Left_Mount.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;PSU_Top_Mount.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Spool_Holder.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;XY_Idler_Left.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;XY_Idler_Right.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;XY_Motor_Mount_Left.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;XY_Motor_Mount_Right.stl |
| &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;X_Carriage.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;X_Carriage_Front.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Y_Carriage_Brace_Left.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Y_Carriage_Brace_Right.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Y_Carriage_Left.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Y_Carriage_Right.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Z_Carriage_Left.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Z_Carriage_Right.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Z_Motor_Mount.stl |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;.&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;Z_RodMountGuide_50mm.stl |
| &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;7&nbsp; | &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;3&nbsp; | &nbsp;&nbsp;6&nbsp; | &nbsp;&nbsp;36&nbsp; | &nbsp;&nbsp;Total 3D printed parts count |
|  |  |  |  |  |  |  |  |  |  | | **CNC routed parts** |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;2&nbsp; | &nbsp;&nbsp;Back_Panel.dxf |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;BaseAL.dxf |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Left_Side_Panel.dxf |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; |  &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;Right_Side_Panel.dxf |
| &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;1&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;.&nbsp; | &nbsp;&nbsp;4&nbsp; | &nbsp;&nbsp;5&nbsp; | &nbsp;&nbsp;Total CNC routed parts count |

<span></span>
[Top](#TOP)

---
<a name="Left_Side_Panel_assembly"></a>

## Left Side Panel Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|16| Bolt M4 buttonhead x  8mm|
|16| Nut M4 hammer|
|1| Sheet polycarbonate 340mm x 400mm x 3mm|


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
<a name="IEC_assembly"></a>

## IEC Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 12mm|
|1| IEC320 C14 switched fused inlet module|


### 3D Printed parts

| 1 x IEC_Housing.stl |
|---|
| ![IEC_Housing.stl](stls/IEC_Housing.png) 



### Assembly instructions

![IEC_assembly](assemblies/IEC_assembly_tn.png)

![IEC_assembled](assemblies/IEC_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Right_Side_Panel_assembly"></a>

## Right Side Panel Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M3 buttonhead x  8mm|
|2| Bolt M3 buttonhead x 16mm|
|16| Bolt M4 buttonhead x  8mm|
|1| Cork damper NEMA 17|
|1| MK10 Dual Pulley Extruder|
|16| Nut M4 hammer|
|2| Pillar hex nylon F/F M3x12|
|1| Sheet polycarbonate 340mm x 400mm x 3mm|
|1| Stepper motor NEMA17 x 47mm|
|1| Stepper motor cable, 900mm|
|1| filament sensor|


### CNC Routed parts

| 1 x Right_Side_Panel.dxf |
|---|
| ![Right_Side_Panel.dxf](dxfs/Right_Side_Panel.png) 



### Sub-assemblies

| 1 x IEC_assembly |
|---|
| ![IEC_assembled](assemblies/IEC_assembled_tn.png) 



### Assembly instructions

![Right_Side_Panel_assembly](assemblies/Right_Side_Panel_assembly.png)

![Right_Side_Panel_assembled](assemblies/Right_Side_Panel_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="X_Carriage_assembly"></a>

## X Carriage Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M2 caphead x  6mm|
|4| Bolt M3 buttonhead x 10mm|
|1| Square radial fan 3010|
|1| Ziptie 2.5mm x 100mm min length|


### 3D Printed parts

| 2 x Belt_Clamp.stl | 1 x Fan_Duct.stl | 1 x X_Carriage.stl |
|---|---|---|
| ![Belt_Clamp.stl](stls/Belt_Clamp.png) | ![Fan_Duct.stl](stls/Fan_Duct.png) | ![X_Carriage.stl](stls/X_Carriage.png) 



### Assembly instructions

![X_Carriage_assembly](assemblies/X_Carriage_assembly.png)

![X_Carriage_assembled](assemblies/X_Carriage_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printhead_assembly"></a>

## Printhead Assembly

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

![Printhead_assembled](assemblies/Printhead_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="X_Carriage_Front_assembly"></a>

## X Carriage Front Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 10mm|
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

![X_Carriage_Front_assembled](assemblies/X_Carriage_Front_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="XY_Motor_Mount_Right_assembly"></a>

## XY Motor Mount Right Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 12mm|
|2| Bolt M3 caphead x 16mm|
|3| Bolt M4 buttonhead x 12mm|
|1| Cork damper NEMA 17|
|3| Nut M4 hammer|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 12mm|
|1| Pulley GT2OB 20 teeth|
|1| Stepper motor NEMA17 x 40mm|
|1| Stepper motor cable, 650mm|
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

## XY Idler Right Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Bolt M3 caphead x 30mm|
|1| Bolt M4 buttonhead x 10mm|
|3| Bolt M4 buttonhead x 12mm|
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

## XY Motor Mount Left Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 12mm|
|2| Bolt M3 caphead x 16mm|
|3| Bolt M4 buttonhead x 12mm|
|1| Cork damper NEMA 17|
|3| Nut M4 hammer|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 12mm|
|1| Pulley GT2OB 20 teeth|
|1| Stepper motor NEMA17 x 40mm|
|1| Stepper motor cable, 1050mm|
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
<a name="XY_Idler_Left, ngb=true_assembly"></a>

## XY Idler Left, Ngb=true Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Bolt M3 caphead x 30mm|
|1| Bolt M4 buttonhead x 10mm|
|3| Bolt M4 buttonhead x 12mm|
|3| Nut M4 hammer|
|2| Pulley GT2 idler 16 teeth|
|6| Washer  M3|
|1| Washer  M4|


### 3D Printed parts

| 1 x XY_Idler_Left.stl |
|---|
| ![XY_Idler_Left.stl](stls/XY_Idler_Left.png) 



### Assembly instructions

![XY_Idler_Left, ngb=true_assembly](assemblies/XY_Idler_Left, ngb=true_assembly_tn.png)

![XY_Idler_Left, ngb=true_assembled](assemblies/XY_Idler_Left, ngb=true_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Y_Carriage_Right_assembly"></a>

## Y Carriage Right Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 caphead x 10mm|
|3| Bolt M3 caphead x 16mm|
|1| Bolt M3 caphead x 25mm|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 9.63mm|
|4| Washer  M3|


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
<a name="Face_Right_Upper_Extrusion_assembly"></a>

## Face Right Upper Extrusion Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M3 caphead x 10mm|
|2| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2040 x 300mm|
|1| Linear rail MGN12 x 300mm|
|1| Linear rail carriage MGN12H|
|8| Nut M3 hammer|


### Sub-assemblies

| 1 x Y_Carriage_Right_assembly |
|---|
| ![Y_Carriage_Right_assembled](assemblies/Y_Carriage_Right_assembled_tn.png) 



### Assembly instructions

![Face_Right_Upper_Extrusion_assembly](assemblies/Face_Right_Upper_Extrusion_assembly.png)

![Face_Right_Upper_Extrusion_assembled](assemblies/Face_Right_Upper_Extrusion_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Y_Carriage_Left_assembly"></a>

## Y Carriage Left Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 caphead x 10mm|
|3| Bolt M3 caphead x 16mm|
|1| Bolt M3 caphead x 25mm|
|1| Pulley GT2 idler 16 teeth|
|1| Pulley GT2 idler smooth 9.63mm|
|4| Washer  M3|


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
<a name="Face_Left_Upper_Extrusion_assembly"></a>

## Face Left Upper Extrusion Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M3 caphead x 10mm|
|2| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2040 x 300mm|
|1| Linear rail MGN12 x 300mm|
|1| Linear rail carriage MGN12H|
|8| Nut M3 hammer|


### Sub-assemblies

| 1 x Y_Carriage_Left_assembly |
|---|
| ![Y_Carriage_Left_assembled](assemblies/Y_Carriage_Left_assembled_tn.png) 



### Assembly instructions

![Face_Left_Upper_Extrusion_assembly](assemblies/Face_Left_Upper_Extrusion_assembly.png)

![Face_Left_Upper_Extrusion_assembled](assemblies/Face_Left_Upper_Extrusion_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_Stage_1_assembly"></a>

## Face Top Stage 1 Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M5 buttonhead x 10mm|
|2| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2020 x 300mm|
|1| Extrusion E2040 x 300mm|


### Sub-assemblies

| 1 x Face_Left_Upper_Extrusion_assembly | 1 x Face_Right_Upper_Extrusion_assembly | 1 x XY_Idler_Left, ngb=true_assembly |
|---|---|---|
| ![Face_Left_Upper_Extrusion_assembled](assemblies/Face_Left_Upper_Extrusion_assembled_tn.png) | ![Face_Right_Upper_Extrusion_assembled](assemblies/Face_Right_Upper_Extrusion_assembled_tn.png) | ![XY_Idler_Left, ngb=true_assembled](assemblies/XY_Idler_Left, ngb=true_assembled_tn.png) 


| 1 x XY_Idler_Right_assembly | 1 x XY_Motor_Mount_Left_assembly | 1 x XY_Motor_Mount_Right_assembly |
|---|---|---|
| ![XY_Idler_Right_assembled](assemblies/XY_Idler_Right_assembled_tn.png) | ![XY_Motor_Mount_Left_assembled](assemblies/XY_Motor_Mount_Left_assembled_tn.png) | ![XY_Motor_Mount_Right_assembled](assemblies/XY_Motor_Mount_Right_assembled_tn.png) 



### Assembly instructions

![Face_Top_Stage_1_assembly](assemblies/Face_Top_Stage_1_assembly.png)

![Face_Top_Stage_1_assembled](assemblies/Face_Top_Stage_1_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Top_assembly"></a>

## Face Top Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Belt GT2 x 6mm x nanmm|
|1| Belt GT2 x 6mm x nanmm|
|2| Bolt M3 buttonhead x 10mm|
|6| Bolt M3 buttonhead x 12mm|
|4| Bolt M3 caphead x 10mm|
|1| Linear rail MGN12 x 250mm|
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
<a name="Back_Panel_assembly"></a>

## Back Panel Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| BigTreeTech SKR v1.4 Turbo|
|4| Bolt M3 buttonhead x 10mm|
|4| Bolt M3 caphead x  6mm|
|1| PSU Switching Power Supply 24V 15A 360W|
|4| Pillar hex nylon F/F M3x20|
|1| Sheet polycarbonate 340mm x 400mm x 3mm|


### 3D Printed parts

| 1 x PCB_Mount.stl | 1 x PSU_Left_Mount.stl | 1 x PSU_Top_Mount.stl |
|---|---|---|
| ![PCB_Mount.stl](stls/PCB_Mount.png) | ![PSU_Left_Mount.stl](stls/PSU_Left_Mount.png) | ![PSU_Top_Mount.stl](stls/PSU_Top_Mount.png) 



### CNC Routed parts

| 1 x Back_Panel.dxf |
|---|
| ![Back_Panel.dxf](dxfs/Back_Panel.png) 



### Assembly instructions

![Back_Panel_assembly](assemblies/Back_Panel_assembly.png)

![Back_Panel_assembled](assemblies/Back_Panel_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Face_Right_assembly"></a>

## Face Right Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M5 buttonhead x 12mm|
|2| Extrusion E2020 x 400mm|
|2| Extrusion E2040 x 300mm|


### Assembly instructions

![Face_Right_assembly](assemblies/Face_Right_assembly.png)

1. On a flat surface, bolt the top, middle and lower extrusions into the left and right uprights as shown.

2. Take time to ensure everything is square and then work your way around the bolts tightening them while ensuring
the frame remains square. Don't tighten each bolt fully before moving on to the next, rather tighten each bolt a bit
and move on to the next bolt, making several circuits of the frame to get all the bolts tight.

3. Once the frame is square and tightened, align the motor mount and idler with the top extrusion and tighten them in place.


![Face_Right_assembled](assemblies/Face_Right_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Display_Cover_TFT35_E3_assembly"></a>

## Display Cover TFT35 E3 Assembly

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

## Display Housing TFT35 E3 Assembly

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

## Base Plate Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Aluminium plate 340mm x 340mm x 3mm|
|8| Bolt M4 buttonhead x  8mm|
|8| Bolt M4 buttonhead x 12mm|
|12| Bolt M5 buttonhead x 12mm|
|1| Extrusion E2040 x 300mm|
|1| Extrusion E2080 x 300mm|
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
<a name="Z_Carriage_Right_assembly"></a>

## Z Carriage Right Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 12mm|
|4| Bolt M5 countersunk x 12mm|
|2| Nut M4 sliding T|
|1| SCS12LUU bearing block|


### 3D Printed parts

| 1 x Z_Carriage_Right.stl |
|---|
| ![Z_Carriage_Right.stl](stls/Z_Carriage_Right.png) 



### Assembly instructions

![Z_Carriage_Right_assembly](assemblies/Z_Carriage_Right_assembly_tn.png)

zCarriageRight assembly instructions.

![Z_Carriage_Right_assembled](assemblies/Z_Carriage_Right_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Z_Carriage_Left_assembly"></a>

## Z Carriage Left Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Bolt M4 buttonhead x 12mm|
|4| Bolt M5 countersunk x 12mm|
|2| Nut M4 sliding T|
|1| SCS12LUU bearing block|


### 3D Printed parts

| 1 x Z_Carriage_Left.stl |
|---|
| ![Z_Carriage_Left.stl](stls/Z_Carriage_Left.png) 



### Assembly instructions

![Z_Carriage_Left_assembly](assemblies/Z_Carriage_Left_assembly_tn.png)

zCarriageLeft assembly instructions.

![Z_Carriage_Left_assembled](assemblies/Z_Carriage_Left_assembled_tn.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Frame_assembly"></a>

## Printbed Frame Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Extrusion E2020 x 260mm|
|1| Extrusion E2040 x 188mm|
|2| Extrusion inner corner bracket 4.5|


### Assembly instructions

![Printbed_Frame_assembly](assemblies/Printbed_Frame_assembly.png)

![Printbed_Frame_assembled](assemblies/Printbed_Frame_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_Frame_with_Z_Carriages_assembly"></a>

## Printbed Frame With Z Carriages Assembly

### Sub-assemblies

| 1 x Printbed_Frame_assembly | 1 x Z_Carriage_Left_assembly | 1 x Z_Carriage_Right_assembly |
|---|---|---|
| ![Printbed_Frame_assembled](assemblies/Printbed_Frame_assembled_tn.png) | ![Z_Carriage_Left_assembled](assemblies/Z_Carriage_Left_assembled_tn.png) | ![Z_Carriage_Right_assembled](assemblies/Z_Carriage_Right_assembled_tn.png) 



### Assembly instructions

![Printbed_Frame_with_Z_Carriages_assembly](assemblies/Printbed_Frame_with_Z_Carriages_assembly.png)

1. Slide the Z carriages onto the frame as shown.

2. Ensure the Z carriages are square and aligned with the end of the frame and then tighten the bolts.


![Printbed_Frame_with_Z_Carriages_assembled](assemblies/Printbed_Frame_with_Z_Carriages_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="Printbed_assembly"></a>

## Printbed Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|1| Heated Bed 214mm x 214mm|


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

## Z Motor Mount Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|4| Bolt M3 buttonhead x 12mm|
|4| Bolt M4 buttonhead x 12mm|
|1| Cork damper NEMA 17|
|1| Leadscrew 8mm x 250mm|
|4| Nut M4 sliding T|
|1| Shaft coupling SC_5x8_rigid|
|1| Stepper motor NEMA17 x 40mm|
|1| Stepper motor cable, 750mm|


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
<a name="Face_Left_assembly"></a>

## Face Left Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|8| Bolt M4 buttonhead x 12mm|
|8| Bolt M5 buttonhead x 12mm|
|2| Extrusion E2020 x 400mm|
|2| Extrusion E2040 x 300mm|
|8| Nut M4 sliding T|
|4| SK12 shaft support bracket|


### 3D Printed parts

| 2 x Z_RodMountGuide_50mm.stl |
|---|
| ![Z_RodMountGuide_50mm.stl](stls/Z_RodMountGuide_50mm.png) 



### Sub-assemblies

| 1 x Z_Motor_Mount_assembly |
|---|
| ![Z_Motor_Mount_assembled](assemblies/Z_Motor_Mount_assembled_tn.png) 



### Assembly instructions

![Face_Left_assembly](assemblies/Face_Left_assembly.png)

1. On a flat surface, bolt the top, middle and lower extrusions into the left and right uprights as shown. Note
that the lower extrusion is 2020 extrusion, this is to allow access to the power supply and mainboard.

2. Take time to ensure everything is square and then work your way around the bolts tightening them while ensuring
the frame remains square. Don't tighten each bolt fully before moving on to the next, rather tighten each bolt a bit
and move on to the next bolt, making several circuits of the frame to get all the bolts tight.

3. Once the frame is square and tightened, align the motor mount and idler with the top extrusion and tighten them in place.


![Face_Left_assembled](assemblies/Face_Left_assembled.png)

<span></span>
[Top](#TOP)

---
<a name="main_assembly"></a>

## Main Assembly

### Vitamins

|Qty|Description|
|---:|:----------|
|2| Linear rod 12mm x 300mm|
|1| Sheet polycarbonate 340mm x 400mm x 3mm|


### 3D Printed parts

| 1 x Spool_Holder.stl |
|---|
| ![Spool_Holder.stl](stls/Spool_Holder.png) 



### CNC Routed parts

| 1 x Back_Panel.dxf |
|---|
| ![Back_Panel.dxf](dxfs/Back_Panel.png) 



### Sub-assemblies

| 1 x Back_Panel_assembly | 1 x Base_Plate_assembly | 1 x Face_Left_assembly |
|---|---|---|
| ![Back_Panel_assembled](assemblies/Back_Panel_assembled_tn.png) | ![Base_Plate_assembled](assemblies/Base_Plate_assembled_tn.png) | ![Face_Left_assembled](assemblies/Face_Left_assembled_tn.png) 


| 1 x Face_Right_assembly | 1 x Face_Top_assembly | 1 x Left_Side_Panel_assembly |
|---|---|---|
| ![Face_Right_assembled](assemblies/Face_Right_assembled_tn.png) | ![Face_Top_assembled](assemblies/Face_Top_assembled_tn.png) | ![Left_Side_Panel_assembled](assemblies/Left_Side_Panel_assembled_tn.png) 


| 1 x Printbed_assembly | 1 x Right_Side_Panel_assembly |
|---|---|
| ![Printbed_assembled](assemblies/Printbed_assembled_tn.png) | ![Right_Side_Panel_assembled](assemblies/Right_Side_Panel_assembled_tn.png) 



### Assembly instructions

![main_assembly](assemblies/main_assembly.png)

1. Attach the extruder and the spoolholder to the right face.

2. Connect the Bowden tube between the extruder and the printhead.

3. Attach the polycarbonate sheet to the back of the print. Make sure everything is square before tightening the bolts.


![main_assembled](assemblies/main_assembled.png)

<span></span>
[Top](#TOP)
