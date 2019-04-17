<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information Page</title>
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
	
	<h1>User Information Page</h1>
	<form action="" method="GET">
		<label>Search field: </label>
		<input type="text" name="search_string">
		<input type="submit" value="Search">		
	</form>
	<br>
	<br>
	<br>
	<hr>
	<%
		String search = request.getParameter("search_string");
		if(search != null){
			try{
				String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
				Statement statement = connection.createStatement();
				
				String query = "SELECT * FROM bid WHERE buyer_id=\"" + search + "\"";
				ResultSet result = statement.executeQuery(query);
				
				out.print("<h1>USER: " + search + "</h1>");
				out.print("<h3>AUCTIONS BIDDED ON: </h3>");

				while(result.next()){
					%>
					<p>TIME: <%out.print(result.getString("date_time") + " ----------- " + "AUCTION ID: " + result.getString("auction_id")); %></p>
				<%	
				}
				
				out.print("<hr>");
				out.print("<h3>LISTINGS CREATED: </h3>");
				
				query = "SELECT * FROM auction WHERE seller_id=\"" + search + "\"";
				result = statement.executeQuery(query);
				
				while(result.next()){
					%>
					<p>TIME: <%out.print(result.getString("date_time_posted") + " ----------- " + "LISTING ID: " + result.getString("listing_id")); %></p>	
				<%
				}
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				connection.close();
		
			}
			catch (Exception e){
				out.print(e);
			}
		}
	%>
</body>
</html>