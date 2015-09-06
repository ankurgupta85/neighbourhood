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

function validateInvite() {

	var inviteEmail = document.getElementById("inviteEmail").value;
	// Email Validation
	if (inviteEmail.length == 0 || inviteEmail == " ") {
		alert("Email field cannot be empty");
		document.inviteNeighbour.inviteEmail.focus();
		return false;
	}

	for ( var i = 0; i < inviteEmail.length; i++) {
		if (inviteEmail.charAt(i) == " ") {
			alert("Email field cannot have space");
			document.inviteNeighbour.inviteEmail.focus();
			return false;
		}
	}

	var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if (!regEmail.test(inviteEmail)) {
		alert("Email is not valid");
		document.inviteNeighbour.inviteEmail.focus();
		return false;

	}

	return true;

}

function validateUpdate() {

	var post = document.getElementById("post").value;
	if (post.length == 0 || post == " ") {
		alert("Please enter something in your post before submitting");
		document.updateStatus.post.focus();
		return false;
	}


	if(post.length > 145)
		{
			alert("Post Length is too large");
			document.updateStatus.post.focus();
			return false;
		}

	var iChars = "\\\';,/\"";
	alert(iChars);
	for ( var i = 0; i < post.length; i++) {
		if (iChars.indexOf(post.charAt(i)) != -1) {
			alert("Post cannot have these characters-\\\';,./\"");
			document.updateStatus.post.focus();
			return false;
		}
	}

	return true;
}



/*function validateUpdateReply()
{
	var updateReply = document.getElementById("updateReply").value;
	if (updateReply.length == 0 || updateReply == " ") {
		alert("Please enter something in your post before replying");
		document.updateReplyForm.updateReply.focus();
		return false;
	}
	if(updateReply.length > 145)
		{
			alert("Post Length is too large");
			document.updateReplyForm.updateReply.focus();
			return false;
		}

	var iChars = "\\\';,/\"";
	alert(iChars);
	for ( var i = 0; i < updateReply.length; i++) {
		if (iChars.indexOf(updateReply.charAt(i)) != -1) {
			alert("Post cannot have these characters-\\\';,./\"");
			document.updateReplyForm.updateReply.focus();
			return false;
		}
	}

	return true;
}*/