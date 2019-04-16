<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<%

	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		Statement statement = connection.createStatement();
		
		

		int auctionID = Integer.parseInt(request.getParameter("auction_id"));
		int listingID = Integer.parseInt(request.getParameter("list_id"));
		double bid = Double.parseDouble(request.getParameter("bid"));
		double autoBid = Double.parseDouble(request.getParameter("auto_bid"));
				
	    java.util.Date dt = new java.util.Date();
		Timestamp timestamp0 = new Timestamp(dt.getTime());

		// INSERT IN BID		
		String insert = "INSERT INTO bid(buyer_id,amount,auction_id,date_time)"
				+ "VALUES (?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement preparedStatement = connection.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		preparedStatement.setString(1, (String)session.getAttribute("username"));
		preparedStatement.setDouble(2, bid);
		preparedStatement.setInt(3, auctionID);
		preparedStatement.setTimestamp(4, timestamp0);
		preparedStatement.executeUpdate();
		
		
		// UPDATE AUCTION HIGHEST BID W/ THE NEW BID
		//insert = "UPDATE auction SET highest_bid=" + bid + " WHERE auction_id=" + auctionID;
		insert = "UPDATE auction SET highest_bid=? WHERE auction_id=?";
		preparedStatement = connection.prepareStatement(insert);
		preparedStatement.setDouble(1, bid);
		preparedStatement.setInt(2, auctionID);
		preparedStatement.executeUpdate();

		boolean flag = false;
		String flagQuery = "SELECT * FROM bid_alerts WHERE user_id=\"" + (String)session.getAttribute("username") + "\" AND auction_id=\"" + auctionID + "\"";
		ResultSet flagResult = statement.executeQuery(flagQuery);
		if(flagResult.next()){
			flag = true;
		}
		
		
		if(flag == false){
			// ENROLL USER TO BID ALERTS
			String insert2 = "INSERT INTO bid_alerts(user_id,auction_id,listing_id)"
					+ "VALUES (?,?,?)";
			PreparedStatement preparedStatement2 = connection.prepareStatement(insert2);
			preparedStatement2.setString(1, (String)session.getAttribute("username"));
			preparedStatement2.setInt(2, auctionID);
			preparedStatement2.setInt(3, listingID);
			preparedStatement2.executeUpdate();
		}
			// SEND ALERT TO user_id WHO BID ON auction_id
			// SEARCH THRU alert TABLE AND MATCHES THE 3 FIELDS
		String fetchUsers = "SELECT * FROM bid_alerts WHERE auction_id=\"" + auctionID + "\"";
		ResultSet resultUsers = statement.executeQuery(fetchUsers);
					
		java.util.Date dt2 = new java.util.Date();
		Timestamp timestamp2 = new Timestamp(dt2.getTime());
	
	
		while(resultUsers.next()){
			// how to get info from set
			String userID = resultUsers.getString("user_id");
			// SEND EMAIL/ALERT
			String insert3 = "INSERT INTO email(from_to,to_from,date_time,subject,content)"
				+ "VALUES (?,?,?,?,?)";
			PreparedStatement preparedStatement3 = connection.prepareStatement(insert3);
	
			preparedStatement3.setString(1, "admin");
			preparedStatement3.setString(2, userID);
			preparedStatement3.setTimestamp(3, timestamp2);
			preparedStatement3.setString(4, "You've Been Outbid!");
			preparedStatement3.setString(5, "You've been outbid on Listing ID: " + listingID);
						
			preparedStatement3.executeUpdate();
		}
	
			
	
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			connection.close();
			out.print("Bid was successfully placed!");
		

	}
	catch (Exception e){
		out.print(e);
	}
	
	

%>

</body>
</html>