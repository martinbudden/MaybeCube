// printheadHotendOffset().x must match value in BabyCube for fan duct
function printheadHotendOffset(hotendDescriptor="E3DV6") =
    hotendDescriptor == "E3DV6" ? [17, 18, -6] :
    hotendDescriptor == "OrbiterV3" ? [23, 13, -10.5] :
    [0, 0, 0];
function printheadBowdenOffset(hotendDescriptor="E3DV6") =
    hotendDescriptor == "E3DV6" ? printheadHotendOffset(hotendDescriptor) + [-11, 21, -15] :
    hotendDescriptor == "OrbiterV3" ? [14.5, 47, -19] :
    hotendDescriptor == "BIQU_H2V2SRevo" ? [19.5, 40.5, -19] :
    [0, 0, 0];
function printheadWiringOffset(hotendDescriptor="E3DV6") =
    hotendDescriptor == "E3DV6" ? [15.5, 25, -11] :
    hotendDescriptor == "OrbiterV3" ? [-15, 24, -10] :
    hotendDescriptor == "BIQU_H2V2SRevo" ? [-15, 24, -10] :
    [0, 0, 0];
