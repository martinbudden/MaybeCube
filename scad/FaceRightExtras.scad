include <global_defs.scad>

include <NopSCADlib/core.scad>

use <NopSCADlib/utils/sweep.scad>
use <NopSCADlib/utils/maths.scad>
use <NopSCADlib/utils/bezier.scad>
use <NopSCADlib/utils/tube.scad>

use <NopSCADlib/vitamins/iec.scad>
include <NopSCADlib/vitamins/spools.scad>

use <printed/ExtruderBracket.scad>
use <printed/IEC_Housing.scad>
use <utils/printheadOffsets.scad>
use <printed/SpoolHolder.scad>

use <vitamins/SidePanels.scad>

use <Parameters_Positions.scad>
include <Parameters_Main.scad>


spoolHolderPosition = [eX + 2*eSize, eY/2, spoolHeight() + eSize];

module faceRightSpoolHolder() {
   // add the spool holder, place it to the back of the right side, so that the feed to the extruder is as straight as possible
    explode([0, 20, 50])
        translate(spoolHolderPosition)
        //translate([-eSize - 5,  - 10, 0])
            rotate([90, 0, 0])
                Spool_Holder_stl();
}

module faceRightSpool() {
    spool = spool_200x60;
    translate(spoolHolderPosition + spoolOffset())
        translate([0.1 + spool_width(spool)/2 + spool_rim_thickness(spool), 0, -spool_hub_bore(spool)/2])
            rotate([0, 90, 0])
                not_on_bom()
                    spool(spool, 46, "deepskyblue", 1.75);
}

module faceRightExtras() {
    IEC_housing();
    IEC_Housing_Mount_assembly();

 
    // add the extruder, place it in the middle of the top right edge
    //startPos = [eX+2*eSize, eSize+eY/2, eZ] + Extruder_Bracket_assembly_bowdenOffset();
    //startPos = [eX + 2*eSize, eY-50, eZ-95] + Extruder_Bracket_assembly_bowdenOffset();
    carriagePos = [carriagePosition().x, carriagePosition().y, eZ];

    explode([0, 200, 0])
        ptfeTube(extruderPosition() + Extruder_Bracket_assembly_bowdenOffset(),
                 carriagePos + printheadBowdenOffset(),
                 "white",
                 tubeRadius = 2);

    explode([25, 75, 0])
        Extruder_Bracket_assembly();

    cableRadius = 2.5;
    // don't show the incomplete cable if there are no extrusions to obscure it
    if (is_undef($hide_extrusions))
        ptfeTube([eX/2 + eSize, eY + eSize - 5, eZ], carriagePos + printheadWiringOffset(), grey(20), cableRadius);
}

module ptfeTube(curPos, pos, color, tubeRadius = 2) {

    endPos = curPos-pos;
    p = [ [0, 0, 0], [0, 0, 100], [0, 0, 150], [endPos.x/2, endPos.y/2, 250], endPos+[0, 0, 125], endPos];
    path = bezier_path(p, 50);

    if (color == "white") {
        length = ceil(bezier_length(p));
        vitamin(str("ptfeTube(): PTFE tube ", length, " mm"));
    }

    color(color)
        translate(pos)
            sweep(path, circle_points(tubeRadius, $fn = 64));
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
    filamentColor = "deepskyblue";
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
