rowHeight = 18;
boxSize = 330;
depth = 390;

paddingLeft = 314;

rows = 7;
columuns = 6;

// Calculate horizontal size lenght
horizontalLenght = rowHeight+(boxSize*columuns)+(columuns-2)*rowHeight;
totalH = (paddingLeft == 0) ? horizontalLenght : (horizontalLenght - boxSize + paddingLeft);

// Calculate vertical size
totalV = rows*boxSize + (rows-1)*rowHeight;

// Horizontal top and bottom
translate([rowHeight, 0])
	cube([totalH, rowHeight, depth], false);
translate([rowHeight, totalV])
	cube([totalH, rowHeight, depth], false);
	
// Calculate the number of standard size plates
platesPerRow = (paddingLeft > 0) ? columuns - 1 : columuns;
// Horizontal
for ( row = [1 : rows-1] ) {
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
cube([rowHeight, totalV+rowHeight, depth], false);
// Next vertical sides
verticalStartX = (paddingLeft > 0) ? paddingLeft + rowHeight : boxSize + rowHeight;
for ( v = [0 : columuns-1] ) {
	colHeight = (v == columuns-1) ? totalV + rowHeight: totalV;
	colStartY = (v == columuns-1) ? 0: rowHeight;
    translate([verticalStartX+(v*(boxSize+rowHeight)), 0])
		cube([rowHeight, colHeight, depth], false);
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
echo("Furniture width: ", totalH+(2*rowHeight));
// Total height is the vertical size + twice the material height
totalFurnitureHeight = totalV+2*rowHeight;
echo("Furniture height: ", totalV+2*rowHeight);
echo("Max furniture diagonal height: ", sqrt(totalFurnitureHeight*totalFurnitureHeight+depth*depth));
echo("----------------------------------------");
echo("Horizontal planes A", totalH, "x", depth, "mm: ", 2);
echo("Vertical planes sides ", totalV+2*rowHeight, "x", depth, "mm: ", 2);
echo("Vertical planes middle ", totalV, "x", depth, "mm: ", columuns-1);
echo("Horizontal planes B", boxSize, "x", depth, "mm: ", (rows-1)*(columuns-1));
echo("Horizontal planes C", paddingLeft, "x", depth, "mm: ", rows-1);
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

