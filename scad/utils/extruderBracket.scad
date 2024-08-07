include <../config/Parameters_Main.scad>

// height of eZ-118 give clearance to NEMA17_40 motor (length 40). Long NEMA has length 48, and E3D super whopper has length 60
// need about 22mm for BTT motor, so eZ -140 is good height
function extruderPosition(eX=eX) = [eX + 2*eSize, eY + 2*eSize - 79, eX < 400 ? eZ - 95 : eZ - 140];
//function extruderBowdenOffset() = [17.5, 4.5, 30];
function Extruder_Bracket_assembly_bowdenOffset() = [20.5, 5, 10];

// spoolHeight is declared here because it is determined by its supporting extrusion requiring to clear the extruder and filament sensor
function spoolHeight(eX=eX) = extruderPosition(eX).z - (eX < 400 ? 110 : 80);
function spoolHolderPosition(offsetX=0) = [eX + 2*eSize + 10 + offsetX, eY/2 + (eY==250 ? -35 : eY==300 ? -10 : eY==350 ? 45 : 40), spoolHeight() + 2*eSize];


// iecHousing sizes here, since the extruder bracket and IEC housing sizes must match,
// and placing IEC housing size here minimises cross dependencies.
function iecHousingSize() = [70, 50, 42 + 3];
function iecHousingMountSize(eX=eX) = [iecHousingSize().x + eSize + (_useElectronicsInBase ? 10 : 0), eX==250 ? spoolHeight(eX) + eSize : iecHousingSize().y + 2*eSize, 3];
//function iecHousingMountSize() = [iecHousingSize().x + eSize, spoolHeight() + (eX < 350 ? 0 : eSize), 3];

function extruderBracketSize() = [3, iecHousingMountSize().x, eZ - spoolHeight() - eSize];
