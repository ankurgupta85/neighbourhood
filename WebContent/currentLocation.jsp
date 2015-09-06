<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

<title>Reverse Geocoding</title>

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
<body onload="initialize()" bgcolor="white">
	<%
		String username = null;
		if (session == null || session.getAttribute("username") == null) {
	%>
	<font style="font-size: 2; font-family: cursive;color: black;background-color: white;">Problem in
		getting username</font>
	<%
		} else {
			username = session.getAttribute("username").toString();
	%>


	<form action="UpdateLocation" method="post" target="_top">
		<input type="text" id="locationUpdate" readonly="readonly"
			required="required" name="locationUpdate"
			style="font-family: cursive; font-size: 2; color: black; background-color: white;" /> <input type="hidden"
			name="username" value="<%=username%>" /> <input type="submit"
			value="Update Location" id="updateLocation" disabled="disabled"
			style="font-family: cursive; font-size: 2; color: black; background-color: white;" />
		<%
			}
		%>
	</form>
</body>
</html>
