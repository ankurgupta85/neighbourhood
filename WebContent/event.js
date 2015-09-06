function validateEvent() {

	var topic = document.getElementById("eventTopic").value;
	var eventDesc = document.getElementById("eventDescription").value;
	var date_time = document.getElementById("theDate3").value;

	if (topic.length == 0 || topic == " ") {
		alert("Topic cannot be empty");
		document.eventForm.topic.focus();
		return false;

	}

	if (eventDesc.length == 0 || eventDesc == " ") {
		alert("Event Description cannot be empty");
		document.eventForm.eventDesc.focus();
		return false;

	}

	if (topic.length < 4 && topic.length > 80) {
		alert("No. of characters in Topic should be between 5 and 80 characters ");
		document.eventForm.topic.focus();
		return false;
	}

	if (eventDesc.length < 10 && eventDesc.length > 375) {
		alert("No. of characters in Description should be between 10 and 375 characters ");
		document.eventForm.eventDesc.focus();
		return false;
	}

	if (date_time == " " || date_time.length == 0) {
		alert("Please select date and time for the event");
		document.eventForm.theDate3.focus();
		return false;
	}

	// Validate Date and time
	var date_time_split = date_time.split(" ");
	var date = date_time_split[0];
	var date_split = date.split("/");
	var future_year = parseInt(date_split[0], 10);
	var future_month = parseInt(date_split[1], 10);
	var future_day = parseInt(date_split[2], 10);

	/*
	 * alert("Date " + date); alert("Year " + future_year); alert("Month " +
	 * future_month); alert("Day " + future_day);
	 */
	var time = date_time_split[1];
	var time_split = time.split(":");
	var future_hours = parseInt(time_split[0], 10);
	var future_minutes = parseInt(time_split[1], 10);

	/*
	 * alert("Time " + time);
	 * 
	 * alert("Hours " + future_hours);
	 * 
	 * alert("Minutes " + future_minutes);
	 */
	var today = new Date();

	var curr_date = parseInt(today.getDate(), 10);
	var curr_year = parseInt(today.getFullYear(), 10);
	var curr_month = parseInt(today.getMonth() + 1, 10);

	var curr_hour = parseInt(today.getHours(), 10);

	var curr_minutes = parseInt(today.getMinutes(), 10);

	/*
	 * alert("Today " + today);
	 * 
	 * alert("Curr_date " + curr_date); alert("Curr_month " + curr_month);
	 * alert("Curr_year " + curr_year); alert("Curr_hour " + curr_hour);
	 */
	if (curr_year > future_year) {
		alert("Invalid date, Please check year");
		return false;
	}

	if (curr_year <= future_year && curr_month > future_month) {
		alert("Invalid date, Please check month");
		return false;
	}

	if (curr_year <= future_year && curr_month <= future_month
			&& curr_date < future_day) {
		return true;
	} else {
		if (curr_year <= future_year && curr_month <= future_month
				&& curr_date <= future_day && curr_hour > future_hours) {
			alert("Invalid time, Please check hours");
			return false;

		} else {
			if (curr_year <= future_year && curr_month <= future_month
					&& curr_date <= future_day && curr_hour <= future_hours
					&& curr_minutes > future_minutes) {
				alert("Invalid time, Please check minutes");

				return false;

			} else if (curr_year <= future_year && curr_month <= future_month
					&& curr_date <= future_day && curr_hour <= future_hours
					&& curr_minutes <= future_minutes) {
				alert("Valid time");
			}
		}

		var iChars = "\\\';,./\"";
		/* alert(iChars); */
		for ( var i = 0; i < topic.length; i++) {
			if (iChars.indexOf(topic.charAt(i)) != -1) {
				alert("Topic cannot have these characters-\\\';,./\"");
				document.eventForm.eventTopic.focus();
				return false;
			}
		}

		for ( var i = 0; i < eventDesc.length; i++) {
			if (iChars.indexOf(eventDesc.charAt(i)) != -1) {
				alert("Event Description cannot have these characters-\\\';,./\"");
				document.eventForm.eventDescription.focus();
				return false;
			}
		}
		return true;
	}
}

function validateinviteNeighbours() {
	var length = document.inviteNeighboursForm.invite.length;
	alert("Number of neighbours " + length);
	if (length == 0) {
		alert("Please select atleast one neighbours to invite to event");
		return false;
	}
	return true;
}