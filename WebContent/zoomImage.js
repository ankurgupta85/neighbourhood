function getElementPosition(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		} while (obj = obj.offsetParent);
	}
	return [ curleft, curtop ];
}
function removeAbsoluteOver(objname) {
	var x = document.getElementById(objname);
	x.innerHTML = ' ';
}

function absoluteOver(obj, imgsrc, width, height, lyr) {
	alert(imgsrc);
	var coors = getElementPosition(obj);
	var x = document.getElementById(lyr);
	x.style.position = 'absolute';
	x.innerHTML = '<img alt="" src="' + imgsrc + '" width="' + width
			+ '" height="' + height
			+ '" onMouseOut="removeAbsoluteOver(\'layer3\');" >';
	x.style.top = coors[1] + 'px';
	x.style.left = coors[0] + 'px';
}