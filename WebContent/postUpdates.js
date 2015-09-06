function validateUpdate() {

	var post = document.getElementById("post").value;
	if (post.length == 0 || post == "") {
		alert("Please enter something in your post before submitting");
		document.updateStatus.post.focus();
		return false;
	}

	if (post.length > 145) {
		alert("Post Length is too large");
		document.updateStatus.post.focus();
		return false;
	}

	/*
	 * var iChars = "\\\';,/\""; alert(iChars); for ( var i = 0; i <
	 * post.length; i++) { if (iChars.indexOf(post.charAt(i)) != -1) {
	 * alert("Post cannot have these characters-\\\';,./\"");
	 * document.updateStatus.post.focus(); return false; } }
	 */
	return true;
}

function validateUpdateReply() {
	var updateReply = document.getElementById("updateReply").value;
	if (updateReply.length == 0) {
		alert("Please enter something in your post before replying "
				+ updateReply);
		document.updateReplyForm.updateReply.focus();
		return false;
	}
	if (updateReply.length > 145) {
		alert("Post Length is too large");
		document.updateReplyForm.updateReply.focus();
		return false;
	}

	var iChars = "\\\';,/\"";
	// alert(iChars);
	/*
	 * for ( var i = 0; i < updateReply.length; i++) { if
	 * (iChars.indexOf(updateReply.charAt(i)) != -1) { alert("Post cannot have
	 * these characters-\\\';,./\"");
	 * document.updateReplyForm.updateReply.focus(); return false; } }
	 */
	return true;
}