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
		String endDateString = request.getParameter("sell_date");
		
	    
	    
	    java.util.Date dt = new java.util.Date();
	    java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	    //String currTime = format.format(dt);
		//out.println("dt: " + dt.toString());
		
		
		
		java.util.Date parsed;
		java.text.SimpleDateFormat format2 = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		parsed = format2.parse(endDateString);
	    //String endTime = format.format(parsed);
		//out.println("parsed: " + parsed.toString());

		
		Timestamp timestamp0 = new Timestamp(dt.getTime());
		Timestamp timestamp = new Timestamp(parsed.getTime());
	


	
		
		// INSERTS THE NEW LISTING DETAILS INTO Listing TABLE
		String insert = "INSERT INTO Listing(listing_name,listing_description,item_category)"
				+ "VALUES (?,?,?)";
		PreparedStatement preparedStatement = connection.prepareStatement(insert);
		preparedStatement.setString(1, listingName);
		preparedStatement.setString(2, listingDescription);
		preparedStatement.setString(3, listingCategory);
		preparedStatement.executeUpdate();
		
		
		
		// FETCHES THE LISTINGID FOR THE NEWLY CREATED LISTING
		int lastRowListingId = 0;
		String query = "SELECT listing_id FROM Listing ORDER BY listing_id DESC LIMIT 1";
		ResultSet result = statement.executeQuery(query);
		if(result.next()){
		    lastRowListingId = result.getInt("listing_id");
		}		

		// INSERTS THE NEW LISTING DETAILS INTO auction TABLE
		String insert2 = "INSERT INTO auction(seller_id,listing_id,date_time_posted,end_date_time,highest_bid,secret_min_bid)"
				+ "VALUES (?,?,?,?,?,?)";
		PreparedStatement preparedStatement2 = connection.prepareStatement(insert2);
		preparedStatement2.setString(1, (String)session.getAttribute("username"));
		preparedStatement2.setInt(2, lastRowListingId);
		preparedStatement2.setTimestamp(3, timestamp0);
		preparedStatement2.setTimestamp(4, timestamp);
		preparedStatement2.setDouble(5, startingBid);
		preparedStatement2.setDouble(6, hiddenMinimum);
		preparedStatement2.executeUpdate();
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();
		
	    response.sendRedirect("welcome.jsp");
	}
	catch (Exception e){
	}
%>


</body>
</html>