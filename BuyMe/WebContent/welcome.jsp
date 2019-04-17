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


<%

	/*
	Defining the winner of the auction:
		First: SELECT * FROM auction WHERE expired=1
			Second: If highest_bid > secret_min_bid, then SELECT * bid WHERE auction_id=? ORDER BY amount DESC LIMIT 1
				Third: Take the buyer_id from bid and UPDATE auction SET winner_id=? WHERE auction_id=?
	*/
	
	// DEFINES THE WINNER OF THE AUCTION AND SENDS OUT AN ALERT
	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		Statement statement = connection.createStatement();
		
		String query = "SELECT * FROM auction WHERE expired=1 AND winner_id IS NULL";
		ResultSet result = statement.executeQuery(query);
		
		while(result.next()){
			double highestBid = result.getDouble("highest_bid");
			double minSecretBid = result.getDouble("secret_min_bid");
			int auctionID = result.getInt("auction_id");
			String winnerID = "";
						
			if(highestBid >= minSecretBid){
				// declare the winner

				// find the winnerID
				String getWinnerID = "SELECT * FROM bid WHERE auction_id=\"" + auctionID + "\" ORDER BY amount DESC LIMIT 1";
				ResultSet winnerIDSet = statement.executeQuery(getWinnerID);
				if(winnerIDSet.next()){
				    winnerID = winnerIDSet.getString("buyer_id");
				}
				
				// update the auction with the winnerID
				String insert = "UPDATE auction SET winner_id=? WHERE auction_id=?";
				PreparedStatement preparedStatement2 = connection.prepareStatement(insert);
				preparedStatement2.setString(1, winnerID);
				preparedStatement2.setInt(2, auctionID);
				preparedStatement2.executeUpdate();
				
				
				java.util.Date dt = new java.util.Date();
				Timestamp timestamp0 = new Timestamp(dt.getTime());
				
				
				// send the winner alert ONLY IF THEY HAVE NOT RECEIVED IT BEFORE
				String sendAlert = "INSERT INTO email(from_to,to_from,date_time,subject,content)"
						+ "VALUES (?,?,?,?,?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement preparedStatement = connection.prepareStatement(sendAlert);

				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				preparedStatement.setString(1, "admin");
				preparedStatement.setString(2, winnerID);
				preparedStatement.setTimestamp(3, timestamp0);
				preparedStatement.setString(4, "You won an auction!");
				preparedStatement.setString(5, "Congratulations! You won auction ID: " + auctionID);

				preparedStatement.executeUpdate();

			}
		}
	
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();
	
	}
	catch (Exception e){
		//out.print(e);
	}
%>

<%



%>


<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="auctions.jsp">SEE AUCTIONS</a></li>
			<li><a href="forum.jsp">FORUM</a></li>
			<li><a href="alerts.jsp">ALERTS</a></li>
			<li><a href="createAlert.jsp">CREATE ALERT</a></li>
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
				<li><a href="salesReport.jsp">Generate Sales Report</a></li>
				<li><a href="deleteBid.jsp">Remove Bids</a></li>
				<li><a href="deleteAuction.jsp">Remove Auction</a></li>
				
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
				<li><a href="deleteAuction.jsp">Remove Auction</a></li>
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