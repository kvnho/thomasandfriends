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
	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		Statement statement = connection.createStatement();
		
		String user = (String)session.getAttribute("username");
		String listingName = request.getParameter("listing_name");
		String listingDescription = request.getParameter("listing_description");
		String listingCategory = request.getParameter("category");
	
		
		// INSERTS INTO alert TABLE
		String insert = "INSERT INTO alert(user_id,listing_name,listing_description,item_category)"
				+ "VALUES (?,?,?,?)";
		PreparedStatement preparedStatement = connection.prepareStatement(insert);
		preparedStatement.setString(1, user);
		preparedStatement.setString(2, listingName);
		preparedStatement.setString(3, listingDescription);
		preparedStatement.setString(4, listingCategory);
		preparedStatement.executeUpdate();
				
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();
		
	    response.sendRedirect("welcome.jsp");
	}
	catch (Exception e){
	}
%>


</body>
</html>