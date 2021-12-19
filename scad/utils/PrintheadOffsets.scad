// printHeadHotendOffset().x must match value in BabyCube for fan duct
function printHeadHotendOffset(hotendDescriptor="E3DV6") = hotendDescriptor == "E3DV6" ? [17, 18, -10.5] : [23, 13, -10.5];
function printheadBowdenOffset(hotendDescriptor="E3DV6") = printHeadHotendOffset(hotendDescriptor) + [-11.5, 18.5, -30];
function printheadWiringOffset(hotendDescriptor="E3DV6") = printHeadHotendOffset(hotendDescriptor) + [-1.75, 3, -5];
