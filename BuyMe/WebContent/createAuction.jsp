<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Auction</title>
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
	<%
   	 	java.util.Date dt = new java.util.Date();
		Timestamp timestamp0 = new Timestamp(dt.getTime());
		String s = timestamp0.toString();
		s = s.substring(0, s.indexOf(' ')) + "T" + s.substring(s.indexOf(' ')+1, (s.indexOf('.')));

	
	%>
	
	<div>
		<h1>Create Auction</h1>
		<form action="createAuctionHandler.jsp" method="POST">
			<label>Listing Name: </label>
			<br>
			<input type="text" name="listing_name">
			
			<br>
			<label>Listing Description: </label>
			<br>
			<textarea type="text" name="listing_description"></textarea>
			<br>
			<br>
			<label>Select a category: </label>
			<select name="category">
				<option value="Car">Car</option>
				<option value="Plane">Plane</option>
				<option value="Motorcycle">Motorcycle</option>
			</select>
			<br>
			<br>
			<label>Starting Bid: </label>
			<br>
			<input type="number" min="0" name="starting_bid" step="any" value="0"/>
			<br>
			<label>Optional Reserve Price: </label>
			<br>
			<input type="number" min="0" name="hidden_minimum" step="any" value="0"/>
			<br>
			<label>End Date: </label>
			<br>
			<input type="datetime-local" min="<%=s%>" name="sell_date">
			<br>
			<br>
			<br>
			<input type="submit" value="Create Auction">		
			<br>
		</form>
	</div>

</body>
</html>