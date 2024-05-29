// printheadHotendOffset().x must match value in BabyCube for fan duct
function printheadHotendOffset(hotendDescriptor="E3DV6") = hotendDescriptor == "E3DV6" ? [17, 18, -10.5] : [23, 13, -10.5];
function printheadBowdenOffset(hotendDescriptor="E3DV6") = hotendDescriptor == "E3DV6" ? printheadHotendOffset(hotendDescriptor) + [-11.5, 18.5, -30] : [15, 45.5, -19];
function printheadWiringOffset(hotendDescriptor="E3DV6") = hotendDescriptor == "E3DV6" ? printheadHotendOffset(hotendDescriptor) + [-1.75, 3, -5] : [-15, 22, -10];
