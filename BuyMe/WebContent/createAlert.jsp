<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Alert</title>
</head>
<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="auctions.jsp">SEE AUCTIONS</a></li>
			<li><a href="createAlert.jsp">CREATE ALERT</a></li>
			<li><a href="alerts.jsp">ALERTS</a></li>
			<li><a href="searchUsers.jsp">SEARCH USERS</a></li>
		</ul>
		<hr>
	</div>
	<div>
		<h1>Create Alert</h1>
		<form action="createAlertHandler.jsp" method="POST">
			<label>Listing Name: </label>
			<br>
			<input type="text" name="listing_name">
			<br>
			<br>
			<label>Listing Description: </label>
			<br>
			<textarea type="text" name="listing_description"></textarea>
			<br>
			<p>Select a category: </p>
			<select name="category">
				<option value="Car">Car</option>
				<option value="Plane">Plane</option>
				<option value="Motorcylce">Motorcycle</option>
			</select>
			<br>
			<br>
			<br>
			<input type="submit" value="Create Alert">		
			<br>
		</form>
		
	
	</div>

</body>
</html>