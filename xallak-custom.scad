// bottom
cube([1374, 390, 18], false);

// right
translate([1374, 0, 0])
	cube([18, 390, 2454], false);

// top
translate([0, 0, 2436])
	cube([1374, 390, 18], false);

// left bottom
translate([-18, 0, 0])
	cube([18, 390, 1740], false);
	
// left top
translate([-18, 0, 1758])
	cube([18, 300, 696], false);

// vertical sides
for ( col = [0 : 2] ) {
	// bottom
	translate([330+col*330+col*18, 0, 18])
		cube([18, 390, 1722], false);
	// top
	translate([330+col*330+col*18, 0, 1758])
		cube([18, 300, 678], false);
}

//horizontal break
translate([-18, 0, 1740])
	cube([1392, 390, 18], false);

// back
translate([-18, 300, 1758])
	cube([1392, 8, 696], false);

// horizontal sides
for ( col = [0 : 3] ) {
	for ( row = [0 : 3] ) {
		translate([row*330+row*18, 0, 330+col*330+18+col*18])
			cube([330, 390, 18], false);
	}
}

// horizontal sides top
for ( row = [0 : 3] ) {
	translate([row*330+row*18, 0, 1740+330+18])
		cube([330, 300, 18], false);
}