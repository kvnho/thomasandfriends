<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listings Page</title>
</head>
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
	
	<h1>Listings Page</h1>
	<form action="searchedListings.jsp" method="GET">
		<label>Search field: </label>
		<input type="text" name="search_string">
		<input type="submit" value="Search">		
	</form>
	<br>
	<br>
	<br>
	<hr>
	<%

		//session = request.getSession();
		try{
			String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
			Statement statement = connection.createStatement();
			
			String query = "SELECT * FROM Listing WHERE listing_name LIKE '%" + request.getParameter("search_string") + "%'" + "OR listing_description LIKE '%" +  request.getParameter("search_string") + "%'";

			ResultSet result = statement.executeQuery(query);
			while(result.next()){
				
				String listingID = result.getString("listing_id");
				
				Statement auctionStatement = connection.createStatement();
				String auctionQuery = "SELECT * FROM auction WHERE listing_id=\"" + listingID + "\"";
				ResultSet auctionResult = auctionStatement.executeQuery(auctionQuery);
				
				
				double highestBid = 0;
				
				if(auctionResult.next()){
					highestBid = auctionResult.getDouble("highest_bid");
				}
								
				
				out.print("<p>LISTING ID: "+result.getString("listing_id")+"</p>");
				out.print("<p>ITEM NAME: "+result.getString("listing_name")+"</p>");
				out.print("<p>ITEM DESCRIPTION: "+result.getString("listing_description")+"</p>");
				out.print("<p>ITEM CATEGORY: "+ result.getString("item_category")+"</p>");
				out.print("<p>HIGHEST BID: $"+ highestBid +"</p>");

				//out.print("<button>Show/Hide Bid History</button>");
				out.print("<br>");
				out.print("<hr>");
				out.print("<br>");
				
			}

			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			connection.close();
	
		}
		catch (Exception e){
			out.print(e);
		}
	%>

	<%
	/*
		for(int i = 0; i < 100; i++){
			out.print("<p>Item</p>");
		}
	*/
	%>
</body>
</html>