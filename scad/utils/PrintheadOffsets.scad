// printHeadHotendOffset().x must match value in BabyCube for fan duct
function printHeadHotendOffset(hotend_type=0) = [17, hotend_type == 0 ? 18 : 14, -2];
function printheadWiringOffset() = printHeadHotendOffset() + [0, 15, -10];
function printheadBowdenOffset() = printHeadHotendOffset() + [-22, 18, 0];
