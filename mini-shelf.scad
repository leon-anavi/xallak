// bottom
cube([1246, 250, 18], false);

// left
translate([-18, 0, 0])
	cube([18, 250, 730], false);
	
// right
translate([1236, 0, 0])
	cube([18, 250, 730], false);

// top
translate([0, 0, 712])
	cube([1246, 250, 18], false);
	
// back
translate([-18, 250, 0])
	cube([1272, 8, 730], false);

// vertical sides
for ( col = [0 : 1] ) {
	translate([400+col*400+col*18, 0, 18])
		cube([18, 250, 694], false);
}

// horizontal sides
for ( col = [0 : 2] ) {
	translate([col*400+col*18, 0, 356])
		cube([400, 250, 18], false);
}