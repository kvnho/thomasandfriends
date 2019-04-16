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
			<li><a href="searchUsers.jsp">SEARCH USERS</a></li>
			
			
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
		try{
			String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
			Statement statement = connection.createStatement();
			
			String query = "SELECT * FROM Listing";
			ResultSet result = statement.executeQuery(query);
			while(result.next()){
				
				String listingID = result.getString("listing_id");
				String itemCategory = result.getString("item_category");
				
				Statement auctionStatement = connection.createStatement();
				String auctionQuery = "SELECT * FROM auction WHERE listing_id=\"" + listingID + "\"";
				ResultSet auctionResult = auctionStatement.executeQuery(auctionQuery);
				
				
				double highestBid = 0;
				int auctionID = 0;
				double minPossible = 0;
				String datePosted = "";
				
				if(auctionResult.next()){
					highestBid = auctionResult.getDouble("highest_bid");
					auctionID = auctionResult.getInt("auction_id");
					minPossible = highestBid + 1;
					datePosted = auctionResult.getString("date_time_posted");
				}%>
				<p>LISTING ID: <%out.print(result.getString("listing_id")); %></p>
				<p>ITEM NAME: <%out.print(result.getString("listing_name")); %></p>
				<p>ITEM DESCRIPTION: <%out.print(result.getString("listing_description")); %></p>
				<p>ITEM CATEGORY: <%out.print(result.getString("item_category")); %></p>
				<p>AUCTION ENDS: <%out.print(datePosted); %></p>
				<br>
				<p>HIGHEST BID: $<%out.print(highestBid); %></p>
				<form action="showAllBids.jsp" method="POST">
					<input type="hidden" name="a_id" value="<%=auctionID%>">	
					<input type="submit" value="Show Previous Bids">		
				</form>
				<br>
				<form action="bidHandler.jsp" method="POST">
					<br>
					<label>Insert Bid: </label>
					<input type="hidden" name="list_id" value="<%=listingID%>">							
					<input type="hidden" name="auction_id" value="<%=auctionID%>">					
					<input type="number" min="<%=minPossible%>" name="bid" step="any" value="<%=minPossible%>"/>
					<br>
					<label>Enter value to enable automatic bidding?: </label>
					<input type="number" min="<%=minPossible %>" name="auto_bid" step="any" value="0"/>
					<br>
					<br>
					<input type="submit" value="Submit Bid">	
				</form>
				<br>
				<br>
				<br>
				<form action="similarListings.jsp" method="POST">
					<input type="hidden" name="item_category" value="<%=itemCategory%>">	
					<input type="submit" value="See Similar Listings">		
				</form>
				<br>
				<hr>
				<br>
				

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
<script type="text/javascript">
	function alertName(){

		alert("a");
	} 
</script> 
</html>