function activateMessageForm() {

	document.getElementById("sendMessage").style.visibility = "hidden";
	document.messageForm.style.visibility = "visible";
	document.messageForm.messageField.focus();

}

function validateMessage() {

	var message = document.getElementById("messageField").value;
	var messageTopic = document.getElementById("messageTopic").value;

	if (messageTopic.length == 0 || messageTopic == " ") {

		alert("Please enter  Subject before sending message it to user");
		document.messageForm.messageTopic.focus();
		return false;
	}

	if (message.length == 0 || message == " ") {

		alert("Please enter message before sending it to user");
		document.messageForm.messageField.focus();
		return false;
	}

	if (messageTopic.length > 45) {
		alert("Message Subject exceeded the number of allowable characters");
		document.messageForm.messageTopic.focus();
		return false;
	}

	if (message.length > 175) {
		alert("Message exceeded the number of allowable characters");
		document.messageForm.messageField.focus();
		return false;
	}

	/*
	 * var iChars = "\\\';/\"";
	 * 
	 * 
	 * for ( var i = 0; i < messageTopic.length; i++) { if
	 * (iChars.indexOf(messageTopic.charAt(i)) != -1) { alert("Your Message
	 * subject cannot have these characters-\\\';,./\"");
	 * document.messageForm.messageTopic.focus(); return false; } }
	 * 
	 * 
	 * for ( var i = 0; i < message.length; i++) { if
	 * (iChars.indexOf(message.charAt(i)) != -1) { alert("Your Message cannot
	 * have these characters-\\\';,./\"");
	 * document.messageForm.messageField.focus(); return false; } }
	 */

	return true;

}

function hideText() {

	document.getElementById("sendMessage").style.visibility = "visible";
	document.messageForm.style.visibility = "hidden";

}