<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auctions Page</title>
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
	
	<%
		// compare dates to check for expired auctions	
		
		try{
			String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
			Statement statement = connection.createStatement();
			
			String query = "SELECT * FROM auction WHERE expired=0";
			ResultSet result = statement.executeQuery(query);
			while(result.next()){
				// get end_date_time, and compare it with the current time to see if it expired, if expired, update expired=1
				Timestamp now = new Timestamp(new java.util.Date().getTime());
				Timestamp endDate = result.getTimestamp("end_date_time");
				int auctionID = result.getInt("auction_id");
				if(endDate.before(now)){
					String insert = "UPDATE auction SET expired=1 WHERE auction_id=?";
					PreparedStatement preparedStatement = connection.prepareStatement(insert);
					preparedStatement.setInt(1, auctionID);
					preparedStatement.executeUpdate();
				}
			}
		}
		catch(Exception e){
			
		}
		
	%>
	
	
	<h1>Auctions Page</h1>
	<form action="searchAuctions.jsp" method="GET">
		<label>Search field: </label>
		<input type="text" name="search_string">
		<input type="submit" value="Search">		
	</form>
	<br>
	<br>
	<br>
	<p>Order by: </p>
	<form action="auctions.jsp" method="GET">
		<input type="hidden" name="order_by" value="1">
		<input type="submit" value="$ - $$$">		
	</form>
	<form action="auctions.jsp" method="GET">
		<input type="hidden" name="order_by" value="2">
		<input type="submit" value="$$$ - $">		
	</form>
	<form action="auctions.jsp" method="GET">
		<input type="hidden" name="order_by" value="3">
		<input type="submit" value="Ending Soonest">		
	</form>
	<form action="auctions.jsp" method="GET">
		<input type="hidden" name="order_by" value="4">
		<input type="submit" value="Ending Latest">		
	</form>
	<br>
	<br>
	<hr>
	
	<%
		int order = -1;
		try{
			order = Integer.parseInt(request.getParameter("order_by"));
		}
		catch(Exception e){
			
		}
	%>
	
	
	
	<%
		try{
			String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
			Statement statement = connection.createStatement();
			
			String query = "SELECT * FROM auction WHERE expired=0";
			if(order == 1) query = "SELECT * FROM auction WHERE expired=0 ORDER BY highest_bid ASC";
			else if(order == 2) query = "SELECT * FROM auction WHERE expired=0 ORDER BY highest_bid DESC";
			else if(order == 3) query = "SELECT * FROM auction WHERE expired=0 ORDER BY end_date_time ASC";
			else if(order == 4) query = "SELECT * FROM auction WHERE expired=0 ORDER BY end_date_time DESC";
			ResultSet result = statement.executeQuery(query);
			while(result.next()){
				double highestBid = result.getDouble("highest_bid");
				int auctionID = result.getInt("auction_id");
				double minPossible = highestBid + 1;
				String datePosted = result.getString("date_time_posted");
				
				
				String listingID = result.getString("listing_id");
				Statement listingStatement = connection.createStatement();
				String listingQuery = "SELECT * FROM Listing WHERE listing_id=\"" + listingID + "\"";
				ResultSet listingResult = listingStatement.executeQuery(listingQuery);
				
				String listingName = "";
				String listingDescription = "";
				String itemCategory = "";
				if(listingResult.next()){
					listingName = listingResult.getString("listing_name");
					listingDescription = listingResult.getString("listing_description");
					itemCategory = listingResult.getString("item_category");
				}
				%>
					<p>AUCTION ID: <%out.print(auctionID); %></p>
					<p>ITEM NAME: <%out.print(listingName); %></p>
					<p>ITEM DESCRIPTION: <%out.print(listingDescription); %></p>
					<p>ITEM CATEGORY: <%out.print(itemCategory); %></p>
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
						<input type="number" name="auto_bid" step="any" value="0"/>
						<br>
						<br>
						<input type="submit" value="Submit Bid">	
					</form>
					<br>
					<br>
					<br>
					<form action="similarAuctions.jsp" method="POST">
						<input type="hidden" name="item_category" value="<%=itemCategory%>">	
						<input type="submit" value="See Similar Auctions">		
					</form>
					<br>
					<hr>
					<br>
				<%
				}
				%>

			<%

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