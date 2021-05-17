// printHeadHotendOffset().x must match value in BabyCube for fan duct
function printHeadHotendOffset(hotend_type=0) = [17, hotend_type == 0 ? 18 : 14, -2];
function hotendOffsetZ() = -12;
function printheadBowdenOffset() = printHeadHotendOffset() + [-11.5, 18.5, -30];
function printheadWiringOffset() = printHeadHotendOffset() + [-31,   18.5, -35];
