<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	int i = 0;
	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		
		Statement statement = connection.createStatement();
		
		String listingName = request.getParameter("listing_name");
		String listingDescription = request.getParameter("listing_description");
		String listingCategory = request.getParameter("category");
		String startingBidString = request.getParameter("starting_bid");
		double startingBid = Double.parseDouble(startingBidString);
		String hiddenMinimumString = request.getParameter("hidden_minimum");
		double hiddenMinimum = Double.parseDouble(hiddenMinimumString);
		
		// how to get date time from html
		String endDateString = request.getParameter("sell_date");
	    LocalDateTime currentTime = LocalDateTime.now();
	    LocalDateTime endTime = LocalDateTime.now();
		
		
		String insert = "INSERT INTO Listing(listing_id,listing_name,listing_description,item_category)"
				+ "VALUES (?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement preparedStatement = connection.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		preparedStatement.setString(2, listingName);
		preparedStatement.setString(3, listingDescription);
		preparedStatement.setString(4, listingCategory);

		//Run the query against the DB
		preparedStatement.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();

	}
	catch (Exception e){
	}
%>


</body>
</html>