<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Delete Auction</title>
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
		<h1>Delete Listing</h1>
		<form action="repHandler.jsp" method="POST">
			<label>Auction ID: </label>
			<br>
			<input type="number" name="auction_id">
			<input type="submit" value="Delete Auction">
			<input type="hidden" name="sender" value=2>	
			<br>
		</form>
	</div>

</body>
</html>
