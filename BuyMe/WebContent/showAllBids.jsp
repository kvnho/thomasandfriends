<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bid History</title>
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
	<h1>Bid History</h1>

<%

	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		Statement statement = connection.createStatement();
		
		int auctionID = Integer.parseInt(request.getParameter("a_id"));
		
		String query = "SELECT * FROM bid WHERE auction_id=\"" + auctionID + "\"";
		
		ResultSet result = statement.executeQuery(query);
		
		out.print("<h3>AUCTION ID: " + auctionID + "</h3>");

		while(result.next()){
			%>
			<p>BID ID: <%out.print(result.getString("bid_id") + " ----------- " + "TIME: " + result.getString("date_time") + " ----------- " + "BUYER ID: " + result.getString("buyer_id") + " ----------- " + "BID AMOUNT: " + result.getString("amount")); %></p>
			
			
		<%	
		}

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();

	}
	catch (Exception e){
		out.print(e);
	}

%>

</body>
</html>