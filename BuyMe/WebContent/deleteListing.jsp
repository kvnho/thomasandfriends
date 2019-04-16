<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Listing</title>
</head>
<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			
		</ul>
		<hr>
	</div>
	<div>
		<h1>Delete Listing</h1>
		<form action="repHandler.jsp" method="POST">
			<label>Listing ID: </label>
			<br>
			<input type="number" name="listing_id">
			<input type="submit" value="Delete Listing">
			<input type="hidden" name="sender" value=2>	
			<br>
		</form>
	</div>

</body>
</html>