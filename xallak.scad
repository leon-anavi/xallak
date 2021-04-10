rowHeight = 18;
boxSize = 330;
depth = 390;

paddingLeft = 304;

rows = 7;
columuns = 6;

// Calculate horizontal size lenght
horizontalLenght = rowHeight+(boxSize*columuns)+columuns*rowHeight;
totalH = (paddingLeft == 0) ? horizontalLenght : (horizontalLenght - boxSize + paddingLeft);

// Calculate vertical size
totalV = rows*boxSize + (rows-1)*rowHeight;

// Horizontal top and bottom 
cube([totalH, rowHeight, depth], false);
translate([0, totalV])
	cube([totalH, rowHeight, depth], false);
	
// Calculate the number of standard size plates
platesPerRow = (paddingLeft > 0) ? columuns - 1 : columuns;
// Horizontal
for ( row = [0 : rows-1] ) {
	// the first box is with different size if left padding is greater than 0
	startX = (paddingLeft > 0) ? paddingLeft+2*rowHeight : rowHeight;
	translate([rowHeight, (row*(boxSize+rowHeight))])
		// Custom plate if there is left padding
		if (paddingLeft > 0) {
			cube([paddingLeft, rowHeight, depth], false);
		}
		// Plates per row with the standard size
		if (platesPerRow > 0) {
			for ( box = [0 : platesPerRow-1] ) {
				translate([(startX+box*(boxSize+rowHeight)), (row*(boxSize+rowHeight))])
					cube([boxSize, rowHeight, depth], false);
			}
		}
	}

// Vertical columns
// The first vertical side
cube([rowHeight, totalV, depth], false);
// Next vertical sides
verticalStartX = (paddingLeft > 0) ? paddingLeft + rowHeight : boxSize + rowHeight;
for ( v = [0 : columuns-1] ) {
    translate([verticalStartX+(v*(boxSize+rowHeight)), 0])
		cube([rowHeight, totalV, depth], false);
}

// Calculate the total are and estimate min material pieces
area = (totalH*depth*2 + totalV*depth*(columuns+1)+boxSize*boxSize*rows*(columuns-1)+302*boxSize*rows);
material = 3660*1830;
materialCount = area/material;

echo("----------------------------------------");
echo("Rows: ", rows);
echo("Columns: ", columuns);
echo("Boxes: ", rows*columuns);
echo("----------------------------------------");
echo("Furniture width: ", totalH);
// Total height is the vertical size + twice the material height
totalFurnitureHeight = totalV+2*rowHeight;
echo("Furniture height: ", totalV+2*rowHeight);
echo("Max furniture diagonal height: ", sqrt(totalFurnitureHeight*totalFurnitureHeight+depth*depth));
echo("----------------------------------------");
echo("Horizontal planes A", totalH, "x", depth, "mm: ", 2);
echo("Vertical planes ", totalV, "x", depth, "mm: ", columuns+1);
echo("Horizontal planes B", boxSize, "x", depth, "mm: ", rows*(columuns-1));
echo("Horizontal planes C", 302, "x", depth, "mm: ", rows);
echo("----------------------------------------");
echo("Joint plates: ", ((columuns-1)*(rows-1)));
echo("Dowels: ", 2*((columuns+1)*(rows-1)));
// Couple of screws for each short side of each column and
// 3 screws for the joint plates
echo("Screws: ", 2*(columuns+1)+3*((columuns-1)*(rows-1)));
echo("----------------------------------------");
echo("Area: ", area, "mm2");
echo("Material count: ", materialCount);
echo("----------------------------------------");

