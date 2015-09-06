function validateChangePassword() {

	var old_password = document.getElementById("old_password").value;
	var new_password = document.getElementById("new_password").value;
	var re_password = document.getElementById("re_new_password").value;

	// Password Validation
	if (old_password.length == 0 || old_password == " ") {
		alert("Password field cannot be empty");
		document.changePassword.old_password.focus();
		return false;
	}

	// Password Validation
	if (new_password.length == 0 || new_password == " ") {
		alert("Password field cannot be empty");
		document.changePassword.new_password.focus();
		return false;
	}

	// Password Validation
	if (re_password.length == 0 || re_password == " ") {
		alert("Please Re-enter your password");
		document.changePassword.re_password.focus();
		return false;
	}

	for ( var i = 0; i < old_password.length; i++) {
		if (old_password.charAt(i) == " ") {
			alert("Password field cannot have space");
			document.changePassword.old_password.focus();
			return false;
		}
	}

	for ( var i = 0; i < new_password.length; i++) {
		if (new_password.charAt(i) == " ") {
			alert("Password field cannot have space");
			document.changePassword.new_password.focus();
			return false;
		}
	}

	for ( var i = 0; i < re_password.length; i++) {
		if (re_password.charAt(i) == " ") {
			alert("Re-Password field cannot have space");
			document.changePassword.re_password.focus();
			return false;
		}
	}

	if (re_password != new_password) {
		alert("New Password does not match with re-entered password");
		document.changePassword.new_password.focus();
		return false;
	}

}