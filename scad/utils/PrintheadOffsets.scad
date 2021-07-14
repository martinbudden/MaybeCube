// printHeadHotendOffset().x must match value in BabyCube for fan duct
function printHeadHotendOffset(hotend_type=0) = [hotend_type == 0 ? 17 : 23, hotend_type == 0 ? 18 : 13, -10.5];
function printheadBowdenOffset() = printHeadHotendOffset() + [-11.5, 18.5, -30];
function printheadWiringOffset() = printHeadHotendOffset() + [-1.75, 3, -5];
