function validateSearch() {

	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
	regZip = /(^\d{5}$)/;
	regName = /^[A-Za-z]+$/;

	var attribute = document.getElementById("attribute").value;

	alert(attribute);

	var searchValue = document.getElementById("searchValue").value;

	if (searchValue.length == 0 || searchValue == " ") {

		alert("Please enter some value before searching");
		return false;
	}

	if (attribute == "Username") {
		for ( var i = 0; i < searchValue.length; i++) {
			if (searchValue.charAt(i) == " ") {
				alert("User Name cannot have space");
				document.search.searchValue.focus();
				return false;
			}
		}

		// Check for special characters
		for ( var i = 0; i < searchValue.length; i++) {

			if (iChars.indexOf(searchValue.charAt(i)) != -1) {
				alert("Username cannot have special characters");
				document.search.searchValue.focus();
				return false;
			}
		}

	}
	if (attribute == "Zipcode") {
		for ( var i = 0; i < searchValue.length; i++) {
			if (searchValue.charAt(i) == " ") {
				alert("Zipcode cannot have space");
				document.search.searchValue.focus();
				return false;
			}
		}

		if (searchValue.length != 5) {
			alert('Zipcode length error');
			document.search.searchValue.focus();
			return false;

		}

		if (!regZip.test(searchValue)) {
			alert('Invalid Zipcode  Value');
			document.search.searchValue.focus();
			return false;
		}

	}

	if (attribute == "Name") {
		var index = -1;
		var count = 0;
		for ( var i = 0; i < searchValue.length; i++) {

			if (searchValue.charAt(i) == " ") {
				count++;
				if (count == 1) {
					index = i;

				}
			}
			if (count > 1) {
				alert("Full name can have only one space");
				document.search.searchValue.focus();
				return false;
			}

		}

		if (index == 0) {
			alert('Name cannot start with space character');
			document.search.searchValue.focus();
			return false;

		}
		if (index > 0) {

			alert(index);
			fname = searchValue.substr(0, index);
			lname = searchValue.substr(index + 1, searchValue.length);
			alert(fname);
			alert(lname);
			if (!regName.test(fname)) {
				alert('Invalid First Name value');
				document.search.searchValue.focus();
				return false;
			}

			if (!regName.test(lname) || (lname == " " && lname.length == 0)) {
				alert('Invalid Last Name value');
				document.search.searchValue.focus();
				return false;
			}
		}

	}

	return true;
}