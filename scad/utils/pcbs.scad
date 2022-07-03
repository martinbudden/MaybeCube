include <../vitamins/BTT_Relay.scad>
include <../vitamins/XL4015_BuckConverter.scad>
use <NopSCADlib/vitamins/pillar.scad>

function substring(string, range) = chr([for (i = range) ord(string[i])]);

M3x5_nylon_hex_pillar  = ["M3x5_nylon_hex_pillar",  "hex nylon", 3, 5, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -2, -2 + eps];
M3x10_nylon_hex_pillar = ["M3x10_nylon_hex_pillar", "hex nylon", 3, 10, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -4, -4 + eps];
M3x25_nylon_hex_pillar = ["M3x25_nylon_hex_pillar", "hex nylon", 3, 25, 6/cos(30), 6/cos(30),  6, 6,  grey(20),   grey(20),  -6, -6 + eps];

module pcbAssembly(pcbType, pcbOnBase=false) {
    rpi = substring(pcbType[0], [0:2]) == "RPI";
    mainboard = !(rpi || pcbType[0] == "BTT_RELAY_V1_2" || pcbType[0] == "XL4015_BUCK_CONVERTER");
    pcbOffsetZ = mainboard ? (pcbOnBase ? 25 : 20) : 10;

    explode = 40;
    if (is_undef($hide_pcb) || $hide_pcb == false)
        pcbPosition(pcbType, pcbOnBase, pcbOffsetZ) {
            explode(explode)
                pcb(pcbType);
            pcb_screw_positions(pcbType) {
                if (!mainboard || !pcbOnBase || $i==1 || $i == 2) {
                    translate_z(pcb_thickness(pcbType))
                        explode(explode, true)
                            boltM3Caphead(6);
                    translate_z(-pcbOffsetZ) {
                        explode(10)
                            pillar(pcbOffsetZ==10 ? M3x10_nylon_hex_pillar : M3x25_nylon_hex_pillar);
                        translate_z(-_basePlateThickness)
                            vflip()
                                boltM3Buttonhead(10);
                    }
                } else if (mainboard) {
                    translate_z(-pcbOffsetZ + eSize)
                        explode(pcbOffsetZ + 5)
                            pillar(M3x5_nylon_hex_pillar);
                    translate_z(pcb_thickness(pcbType))
                        explode(explode, true)
                            boltM3CapheadHammerNut(12, nutOffset=3.48);
                }
            }
        }
}

module pcbPosition(pcbType, pcbOnBase=false, z=0) {

    rpi = substring(pcbType[0], [0:2]) == "RPI";
    if (pcbOnBase) {
        pcbSize = pcb_size(pcbType);
        if (rpi) {
            offsetY = (pcbType[0] == "RPI0" || pcbType[0] == "RPI3APlus" ? 110 : 100);
            translate([eX + 2*eSize - pcbSize.y/2 - 25, -pcbSize.x/2 + eY + 2*eSize - offsetY, z])
                rotate(90)
                    children();
        } else if (pcbType[0] == "BTT_RELAY_V1_2") {
            translate([eX + 2*eSize - pcbSize.y/2 - 85, -pcbSize.x/2 + eY + 2*eSize - 40, z])
                rotate(90)
                    children();
        } else if (pcbType[0] == "XL4015_BUCK_CONVERTER") {
            translate([eX + 2*eSize - pcbSize.y/2 - 85, -pcbSize.x/2 + eY + 2*eSize - 130, z])
                rotate(90)
                    children();
        } else if (pcbType[0] == "BTT_SKR_E3_TURBO" || pcbType[0] == "BTT_SKR_MINI_E3_V2_0") {
            holeOffset = 4;
            pcbSize = pcb_size(BTT_SKR_E3_TURBO);
            translate([eX + 2*eSize - pcbSize.x/2 - eSize/2 + holeOffset, pcbSize.y/2 + eSize + (eY >= 300 ? 20 : 15), z])
                children();
        } else {
            holeOffset = 4;
            translate([eX + 2*eSize - pcbSize.y/2 - eSize/2 + holeOffset, pcbSize.x/2 + eSize + (eY >= 300 ? 20 : 15), z])
                rotate(90)
                    children();
        }
    } else {
        if (rpi) {
            pcbSize = pcb_size(pcbType);
            pcbStandOffHeight = 10;
            translate([eX/2 + eSize + pcbSize.y/2, eY + 2*eSize - pcbStandOffHeight, eZ - 100 - pcbSize.x/2])
                rotate([90, 90, 0])
                    children();
        } else if (pcbType[0] == "BTT_SKR_E3_TURBO" || pcbType[0] == "BTT_SKR_MINI_E3_V2_0") {
            pcbSize = pcb_size(BTT_SKR_E3_TURBO);
            pcbStandOffHeight = 20;
            translate([eX + eSize - pcbSize.x/2, eY + 2*eSize - pcbStandOffHeight, pcbSize.y/2 + pcbOffsetZ])
                rotate([90, 0, 0])
                    children();
        } else {
            pcbSize = pcb_size(pcbType);
            pcbStandOffHeight = 20;
            translate([eX + eSize - pcbSize.y/2, eY + 2*eSize - pcbStandOffHeight, pcbSize.x/2 + pcbOffsetZ])
                rotate([90, -90, 0])
                    children();
        }
    }
}
