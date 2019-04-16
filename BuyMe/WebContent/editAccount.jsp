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