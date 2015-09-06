<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta name="keywords" content="neighbourhood,social,location" >
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script type="text/javascript" src="inviteNeighbours.js"></script>
<script type="text/javascript">
	function show_confirm() {
		decision = confirm("Are you sure you wish to log out?");
		if (decision) {
			document.logout.submit();

		}

	}
</script>
<script type="text/javascript" src="disableRightClick.js"></script>
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
	var geocoder;

	if (navigator.geolocation) {
		navigator.geolocation
				.getCurrentPosition(successFunction, errorFunction);
	}
	//Get the latitude and the longitude;
	function successFunction(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		codeLatLng(lat, lng)
	}

	function errorFunction() {
		alert("Please Enable location service in your browser");

	}

	function initialize() {
		geocoder = new google.maps.Geocoder();

	}

	function codeLatLng(lat, lng) {

		var latlng = new google.maps.LatLng(lat, lng);
		geocoder
				.geocode(
						{
							'latLng' : latlng
						},
						function(results, status) {
							if (status == google.maps.GeocoderStatus.OK) {
								console.log(results)
								if (results[1]) {
									//formatted address
									//alert(results[0].formatted_address)
									//find country name
									for ( var i = 0; i < results[0].address_components.length; i++) {
										for ( var b = 0; b < results[0].address_components[i].types.length; b++) {
											//	alert(results[0].address_components[i].types[b]);
											//there are different types that might hold a city admin_area_lvl_1 usually does in come cases looking for sublocality type will be more appropriate
											/*               if (results[0].address_components[i].types[b] == "administrative_area_level_1") {
											                  //this is the object you are looking for
											                  city= results[0].address_components[i];
											                  break;
											 */if (results[0].address_components[i].types[b] == "postal_code") {
												//this is the object you are looking for
												zipcode = results[0].address_components[i];
												break;

											}
										}
									}
									//city data
									// alert(zipcode.short_name + " " + zipcode.long_name)
									/* document.getElementById("location").innerHTML=city.short_name; */
									document.getElementById("locationUpdate").value = zipcode.short_name;
									document.getElementById("updateLocation").disabled = false;
								} else {
									alert("No results found");
								}
							} else {
								alert("Geocoder failed due to: " + status);
							}
						});
	}
</script>

</head>
<body bgcolor="white" onload="initialize()">

	<%
	if(session.getAttribute("currentUserNeighbour")!=null)
	{
		session.removeAttribute("currentUserNeighbour");
	}
	if(session.getAttribute("otherUser")!=null)
	{
		session.removeAttribute("otherUser");
	}
	/* if(session.getAttribute("eventTopic") !=null)
	{
		session.removeAttribute("eventTopic");
		session.removeAttribute("eventDescription");
		session.removeAttribute("date_time_event");
		session.removeAttribute("flag");
			
	} */
		String username = null;

		if (session != null && session.getAttribute("username") != null) {
			username = session.getAttribute("username").toString();
		} else {
			response.sendRedirect("index.jsp");
		}
	%>
	<table bgcolor="white">
		<tr>
			<td><img alt="Neighbourhood" src="Logo.png" height="60"
				width="150"></td>
			<td>
				<table align="center" border="0" width="auto" height="5"
					cellpadding="5" cellspacing="5" bgcolor="white">
					<tr>

						<td><a href="user.jsp" target="_top"
							style="text-decoration: none;"><font color="black" size="2"
								style="font-family: cursive;">Home</font></a></td>
						<td><a href="uploadPics.jsp" target="main"
							style="text-decoration: none;"><font color="black" size="2"
								style="font-family: cursive;">Upload Pictures</font></a></td>
						<td><a href="showAllPics.jsp" target="main"
							style="text-decoration: none;"><font size="2" color="black"
								style="font-family: cursive;">Show all Pics</font></a></td>
						<td>
						<a href="createEvent.jsp" target="main"
							style="text-decoration: none;"><font size="2" color="black"
								style="font-family: cursive;">Create Event</font></a>
						</td>
						<td>
							<!-- <a href="inviteNeighbours.jsp" target="main">Invite Neighbours</a> -->
							<form method="post" action="InviteNeighbour"
								name="inviteNeighbour" onsubmit="return validateInvite();"
								target="_top">
								<input type="text" name="inviteEmail" id="inviteEmail"
									style="font-size: 2; font-family: cursive; color: black; background-color: white;" /><input
									type="hidden" value="<%=username%>" name="username" /> <input
									type="submit" value="Invite"
									style="font-size: 2; font-family: cursive; color: black; background-color: white;" />
							</form>

						</td>

						<td>
							<!-- <a href="searchForm.html" target="main">Search</a> -->
							<form method="post" action="Search" name="search"
								onsubmit="return validateSearch();" target="main">
								<select name="attribute" id="attribute"
									style="font-family: cursive; font-size: 2; color: black; background-color: white;">
									<option value="Username"
										style="background-color: white; color: black;">Username</option>
									<option value="Name">Name</option>
									<option value="Zipcode">Zipcode</option>
									<option value="Email">Email Address</option>
								</select> <input type="text" name="searchValue" id="searchValue"
									size="10"
									style="font-size: 2; font-family: cursive; color: black; background-color: white;" />
								<input type="submit" value="Search"
									style="font-size: 2; font-family: cursive; color: black; background-color: white;" />
							</form>

						</td>
						<td>

							<form action="UpdateLocation" method="post" target="_top">
								<input type="text" id="locationUpdate" readonly="readonly"
									required="required" name="locationUpdate"
									style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
								<input type="hidden" name="username" value="<%=username%>" /> <input
									type="submit" value="Update Location" id="updateLocation"
									disabled="disabled"
									style="font-family: cursive; font-size: 2; color: black; background-color: white;" />

							</form>

						</td>
						<td></td>
						<td>
							<form name="logout" action="LogOut" target="_top">
								<!-- <a href="LogOut" target="_top"
				onclick="show_confirm()"
				style="text-decoration: none;"> -->
								<input type="button" onclick=" show_confirm()" value="Log Out"
									style="color: black; font-size: 2; font-family: cursive;background-color: white " />
								<!-- </a> -->
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- <form action="LogOut" method="get" target="_top">
		 -->
	<!-- <input type="submit" value="Log Out" onsubmit="confirm('Are you sure you wish to log out')" /> -->
	<!-- </form> -->

</center>
</body>
</html>