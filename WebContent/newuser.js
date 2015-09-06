function validateNewUser() {

	var fname = document.getElementById("fname").value;
	var lname = document.getElementById("lname").value;
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	var email = document.getElementById("email").value;
	var re_password = document.getElementById("re_password").value;

	/*
	 * var address1 = document.getElementById("address1").value; var address2 =
	 * document.getElementById("address2").value; var city =
	 * document.getElementById("city").value; var state =
	 * document.getElementById("state").value;
	 */// var country = document.getElementById("country").value;
	var zipcode = document.getElementById("zipcode").value;
	var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	regName = /^[A-Za-z]+$/;
	regZip = /(^\d{5}$)/;
	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
	/* var addressChars = "!@$%^&*()+=-[]\\\;/{}|\"<>?"; */
	/*
	 * alert(fname + " " + lname + " " + username + " " + password + " " + email + " " +
	 * address1 + " " + address2 + " " + city + " " + state + " " + country + " " +
	 * zipcode);
	 */
	// First Name Validation
	if (fname.length == 0 || fname == " ") {
		alert("First name field cannot be empty");
		document.newuser.fname.focus();
		return false;
	}

	for ( var i = 0; i < fname.length; i++) {
		if (fname.charAt(i) == " ") {
			alert("First Name field cannot have space");
			document.newuser.fname.focus();
			return false;
		}
	}

	if (!regName.test(fname)) {
		alert('Invalid First Name');
		document.newuser.fname.focus();
		return false;
	}

	// Last Name Validation
	if (lname.length == 0 || lname == " ") {
		alert("Last name field cannot be empty");
		document.newuser.lname.focus();
		return false;
	}

	for ( var i = 0; i < lname.length; i++) {
		if (lname.charAt(i) == " ") {
			alert("Last Name field cannot have space");
			document.newuser.lname.focus();
			return false;
		}
	}

	if (!regName.test(lname)) {
		alert('Invalid Last Name');
		document.newuser.lname.focus();
		return false;
	}

	// User Name Validation
	if (username.length == 0 || username == " ") {
		alert("UserName field cannot be empty");
		document.newuser.username.focus();
		return false;
	}

	for ( var i = 0; i < username.length; i++) {
		if (username.charAt(i) == " ") {
			alert("User Name field cannot have space");
			document.newuser.username.focus();
			return false;
		}
	}

	// Check for special characters
	for ( var i = 0; i < username.length; i++) {
		if (iChars.indexOf(username.charAt(i)) != -1) {
			alert("Username cannot have special characters");
			return false;
		}

	}

	// Password Validation
	if (password.length == 0 || password == " ") {
		alert("Password field cannot be empty");
		document.newuser.password.focus();
		return false;
	}

	for ( var i = 0; i < password.length; i++) {
		if (password.charAt(i) == " ") {
			alert("Password field cannot have space");
			document.newuser.password.focus();
			return false;
		}
	}

	// Password Validation
	if (re_password.length == 0 || re_password == " ") {
		alert("Please Re-enter your password");
		document.newuser.re_password.focus();
		return false;
	}

	for ( var i = 0; i < re_password.length; i++) {
		if (re_password.charAt(i) == " ") {
			alert("Re-Password field cannot have space");
			document.newuser.re_password.focus();
			return false;
		}
	}

	if (re_password != password) {
		alert("Password does not match with re-entered password");
		return false;
	}
	// Email Validation
	if (email.length == 0 || email == " ") {
		alert("Email field cannot be empty");
		document.newuser.email.focus();
		return false;
	}

	for ( var i = 0; i < email.length; i++) {
		if (email.charAt(i) == " ") {
			alert("Email field cannot have space");
			document.newuser.email.focus();
			return false;
		}
	}

	if (!regEmail.test(email)) {
		alert("Email is not valid");
		document.newuser.email.focus();
		return false;

	}

	/*
	 * if (address1 != " ") { if (addressChars.indexOf(address1.charAt(i)) !=
	 * -1) { alert("Address1 cannot have special characters"); return false; } }
	 * 
	 * if (address2 != " ") { if (addressChars.indexOf(address2.charAt(i)) !=
	 * -1) { alert("Address2 cannot have special characters"); return false; } } //
	 * City Name Validation if (city.length == 0 || city == " ") { alert("City
	 * field cannot be empty"); document.newuser.city.focus(); return false; }
	 * 
	 * for ( var i = 0; i < city.length; i++) { if (city.charAt(i) == " ") {
	 * alert("City field cannot have space"); document.newuser.city.focus();
	 * return false; } }
	 * 
	 * if (!regName.test(city)) { alert('Invalid City Name');
	 * document.newuser.city.focus(); return false; } // State Name Validation
	 * if (state.length == 0 || state == " ") { alert("State field cannot be
	 * empty"); document.newuser.state.focus(); return false; }
	 * 
	 * for ( var i = 0; i < state.length; i++) { if (state.charAt(i) == " ") {
	 * alert("State field cannot have space"); document.newuser.state.focus();
	 * return false; } }
	 * 
	 * if (!regName.test(state)) { alert('Invalid State Name');
	 * document.newuser.state.focus(); return false; }
	 */
	// Country Name Validation
	/*
	 * if (country.length == 0 || country == " ") { alert("Country field cannot
	 * be empty"); document.newuser.country.focus(); return false; }
	 * 
	 * for ( var i = 0; i < country.length; i++) { if (country.charAt(i) == " ") {
	 * alert("Country field cannot have space");
	 * document.newuser.country.focus(); return false; } }
	 * 
	 * if (!regName.test(country)) { alert('Invalid Country Name');
	 * document.newuser.country.focus(); return false; }
	 * 
	 */// Zipcode Validation
	if (zipcode.length == 0 || zipcode == " ") {
		alert("Zipcode field cannot be empty");
		document.newuser.zipcode.focus();
		return false;
	}

	for ( var i = 0; i < zipcode.length; i++) {
		if (zipcode.charAt(i) == " ") {
			alert("Zipcode field cannot have space");
			document.newuser.zipcode.focus();
			return false;
		}
	}

	if (!regZip.test(zipcode)) {
		alert('Invalid Zipcode  Value');
		document.newuser.zipcode.focus();
		return false;
	}

	if (zipcode.length != 5) {
		alert('Invalid Zipcode  Value');
		document.newuser.zipcode.focus();
		return false;

	}

	return true;
}
