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
	<%
		out.print("<h1>Listings Page</h1>");
		out.print("<br>");

		//session = request.getSession();
		try{
			String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
			Statement statement = connection.createStatement();
			
			String query = "SELECT * FROM Listing";
			ResultSet result = statement.executeQuery(query);
			while(result.next()){
				out.print("<p>LISTING ID: "+result.getString("listing_id")+"</p>");
				out.print("<p>ITEM NAME: "+result.getString("listing_name")+"</p>");
				out.print("<p>ITEM DESCRIPTION: "+result.getString("listing_description")+"</p>");
				out.print("<p>ITEM CATEGORY: "+result.getString("item_category")+"</p>");
				out.print("<button>Show/Hide Bid History</button>");
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