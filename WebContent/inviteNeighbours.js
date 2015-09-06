function validateInvite() {

	var inviteEmail = document.getElementById("inviteEmail").value;
	// Email Validation
	if (inviteEmail.length == 0 || inviteEmail == " ") {
		alert("Please Enter an email id to send invite eg: a@b.c");
		document.inviteNeighbour.inviteEmail.focus();
		return false;
	}

	for ( var i = 0; i < inviteEmail.length; i++) {
		if (inviteEmail.charAt(i) == " ") {
			alert("Email address cannot have space");
			document.inviteNeighbour.inviteEmail.focus();
			return false;
		}
	}

	var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if (!regEmail.test(inviteEmail)) {
		alert("Please enter valid email address eg: a@b.c");
		document.inviteNeighbour.inviteEmail.focus();
		return false;

	}

	return true;

}
