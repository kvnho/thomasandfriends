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
	else{
%>
<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="listings.jsp">SEE LISTINGS</a></li>
			<li><a href="createAlert.jsp">CREATE ALERT</a></li>
			<li><a href="alerts.jsp">ALERTS</a></li>
			<li><a href="searchUsers.jsp">SEARCH USERS</a></li>
			
		</ul>
		<hr>
	</div>
	<div>
		<% 
			String name = (String)session.getAttribute("username");
		%>
		<h1>Welcome <%out.println(name);%></h1>
		
		<%
		if(((String)session.getAttribute("level")).equals("1")){
			%>
			<br>
			<br>
			<hr>
			<h3>Admin Actions: </h3>
			<ul>
				<li><a href="register.jsp">Create Customer Representative Account</a></li>
				<li><a href="">Generate Sales Report</a></li>
				<li><a href="">Remove Bids</a></li>
				<li><a href="">Remove Auctions</a></li>
				
			</ul>
			<%
		}
		
		%>
		
		<%
		if(((String)session.getAttribute("level")).equals("2")){
			%>
			<br>
			<br>
			<hr>
			<h3>Customer Rep Actions: </h3>
			<ul>
				<li><a href="deleteBid.jsp">Delete Bid</a></li>
				<li><a href="deleteListing.jsp">Delete Listing</a></li>
				<li><a href="editAccount.jsp">Edit Account</a></li>
				<li><a href="">Answer Question</a></li>
				
			</ul>
			<%
		}
		
		%>
		
		
		<a href='logoutHandler.jsp'>LOGOUT</a>
	</div>
</body>
<%
	}
%>
</html>