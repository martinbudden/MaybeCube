include <global_defs.scad>

include <NopSCADlib/utils/core/core.scad>

use <NopSCADlib/vitamins/iec.scad>
include <NopSCADlib/vitamins/spools.scad>

use <printed/ExtruderBracket.scad>
use <printed/IEC_Housing.scad>
use <printed/SpoolHolder.scad>

use <utils/bezierTube.scad>
use <utils/printheadOffsets.scad>

use <vitamins/Panels.scad>

use <Parameters_Positions.scad>
include <Parameters_Main.scad>


spoolHolderPosition = [eX + 2*eSize + 10, eY/2, spoolHeight() + eSize];

module faceRightSpoolHolder() {
   // add the spool holder, place it to the back of the right side, so that the feed to the extruder is as straight as possible
    translate(spoolHolderPosition)
    //translate([-eSize - 5,  - 10, 0])
        rotate([90, 0, 0])
            Spool_Holder_stl();
}

module faceRightSpoolHolderBracket() {
    translate(spoolHolderPosition)
        rotate([-90, 0, 90])
            Spool_Holder_Bracket_stl();
}

module faceRightSpoolHolderBracketHardware() {
    translate(spoolHolderPosition)
        rotate([-90, 0, 90])
            Spool_Holder_Bracket_hardware();
}

module faceRightSpool() {
    spool = spool_200x60;
    translate(spoolHolderPosition + spoolOffset())
        translate([0.1 + spool_width(spool)/2 + spool_rim_thickness(spool), 0, -spool_hub_bore(spool)/2])
            rotate([0, 90, 0])
                not_on_bom()
                    spool(spool, 46, "DeepSkyBlue", 1.75);
}

module BowdenTube() {
    explode([0, 200, 0])
        color("white")
            bezierTube(extruderPosition() + Extruder_Bracket_assembly_bowdenOffset(),
                [carriagePosition().x, carriagePosition().y, eZ] + printheadBowdenOffset(),
                tubeRadius=2,
                bowdenTube=true,
                length = eX + eY - 100);
}

module faceRightExtras() {
    translate([eX + 2*eSize, eY + eSize, 2*eSize])
        explode([50, 75, 0])
            IEC_Housing_assembly();

    explode([50, 75, 0])
        Extruder_Bracket_assembly();
}

/*
module faceRightSpool() {
    if ($preview)
        translate([eSize + eX - 5 + spoolSize().z/2, spoolHolderPosition.y - spoolSize().x/2, spoolHeight() + spoolSize().y/2])
            explode(125)
                not_on_bom()
                    rotate([0, 90, 0])
                        spoolWithFilament(showFilamentStrand=!$exploded);
}

_spoolType = spool_200x60;
//_spoolType = spool_300x88;
module spoolWithFilament(showFilamentStrand=true) {
    size = spoolSize();
    filamentColor = "DeepSkyBlue";
    filamentDiameter = 1.75;
    translate([size.x/2, size.y/2, size.z/2])
        spool(_spoolType, 46, filamentColor, filamentDiameter);

    *if (showFilamentStrand && eY>=300)
        color(filamentColor)
            translate([100, 16, 15])
                rotate([-90, 0, 90]) {
                    p = [ [0, 0, 0], [8, 0, 20], [13, -2, 50], [13, -2, eZ - 270], [13, -2, eZ - 190] ];
                    path = bezier_path(p, 50);
                    sweep(path, circle_points(filamentDiameter/2, $fn = 32));
                }
}
function spoolSize() = [spool_diameter(_spoolType), spool_diameter(_spoolType), spool_height(_spoolType)];
*/
