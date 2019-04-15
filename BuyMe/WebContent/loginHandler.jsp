<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String query = "SELECT * FROM account WHERE username=\"" + username + "\" AND password=\"" + password + "\"";

		ResultSet result = statement.executeQuery(query);
		if(result.next()){
			session.setAttribute("username", username);
			if(username.equals("admin")){
				session.setAttribute("level", "1");
				response.sendRedirect("adminWelcome.jsp");
			}
			else{
				session.setAttribute("level", "3");
				response.sendRedirect("welcome.jsp");
			}
		}
		else{
			out.println("Login failed! Wrong credentials <br> <a href='index.jsp'> Try again </a>");
		}

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();

	}
	catch (Exception e){
		out.print(e);
	}

%>

</body>
</html>