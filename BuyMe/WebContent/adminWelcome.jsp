<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>

	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="adminWelcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="listings.jsp">SEE LISTINGS</a></li>
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
		<a href='logoutHandler.jsp'>LOGOUT</a>
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
	</div>
</body>
</html>