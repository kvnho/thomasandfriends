<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<div>
		<h1>Login Page</h1>
		<form action="loginHandler.jsp" method="GET">
			<input type="text" name="username" placeholder="Username">
			<br>
			<input type="password" name="password" placeholder="Password">
			<br>
			<input type="submit" value="Login">		
			<br>
		</form>
	</div>
	<br>
	<div>
		<a href="register.jsp">Register</a>
	</div>
</body>
</html>