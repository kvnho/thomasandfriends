<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Account</title>
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
		<h1>Edit Account</h1>
		<form action="repHandler.jsp" method="POST">
			<label>User name</label>
			<input type="text" name="username" required="required" placeholder="Username">
			<br>
			
			<label>First Name</label>
			<input type="text" name="firstName" placeholder="First Name">
			<br>
			
			<label>Last Name</label>
			<input type="text" name="lastName" placeholder="Last Name">
			<br>
			
			<label>Address</label>
			<input type="text" name="address" placeholder="Address">
			<br>
			
			<label>Password</label>
			<input type="password" name="password" placeholder="Password">
			<br>
			<input type="hidden" name="sender" value=3>	
			<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>