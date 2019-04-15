<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Page</title>
</head>

<%
	if((String)session.getAttribute("username") == null){
	    response.sendRedirect("index.jsp");
	}

%>
<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="listings.jsp">SEE LISTINGS</a></li>
			<li><a href="alerts.jsp">ALERTS</a>
		</ul>
		<hr>
	</div>
	<div>
		<% 
			String name = (String)session.getAttribute("username");
		%>
		<h1>Welcome <%out.println(name);%></h1>
		<a href='logoutHandler.jsp'>LOGOUT</a>
	</div>
</body>
</html>