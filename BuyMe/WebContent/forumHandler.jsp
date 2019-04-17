<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>


<%

	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		Statement statement = connection.createStatement();
		
		int type = Integer.parseInt(request.getParameter("query"));
		if(type == 1){
			String question = request.getParameter("question_asked");
			int auctionID = Integer.parseInt(request.getParameter("auction_id"));
			
			
			String addQuestion = "INSERT INTO question(user_id, question, auction_id)" + "VALUES(?,?,?)";
			PreparedStatement preparedStatement = connection.prepareStatement(addQuestion);
			preparedStatement.setString(1, (String)session.getAttribute("username"));
			preparedStatement.setString(2, question);
			preparedStatement.setInt(3, auctionID);
			preparedStatement.executeUpdate();
		}
		if(type == 2){
			int questionID = Integer.parseInt(request.getParameter("question_id"));
			String answer = request.getParameter("response");
			String question = request.getParameter("question_asked");
			
			String addAnswerQuery = "UPDATE question SET answer=? WHERE question_id=?";
			PreparedStatement preparedStatement = connection.prepareStatement(addAnswerQuery);
			preparedStatement.setString(1, answer);
			preparedStatement.setInt(2, questionID);
			preparedStatement.executeUpdate();
		}
		connection.close();
		
	    response.sendRedirect("forum.jsp");
	}
	catch (Exception e){
	}
	
%>


</body>
</html>