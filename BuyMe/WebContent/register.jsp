<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>

	

	<div>
		<h1>Register Page</h1>
		<form action="registerHandler.jsp" method="POST">
			<label>First Name</label>
			<input type="text" name="firstName" placeholder="First Name">
			<br>
			
			<label>Last Name</label>
			<input type="text" name="lastName" placeholder="Last Name">
			<br>
			
			<label>Address</label>
			<input type="text" name="address" placeholder="Address">
			<br>
			
			<label>Username</label>
			<input type="text" name="username" placeholder="Username">
			<br>
			
			<label>Password</label>
			<input type="password" name="password" placeholder="Password">
			<br>
			
			<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>