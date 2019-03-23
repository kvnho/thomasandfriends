<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		
		String url = "jdbc:mysql://127.0.0.1:3306/firstconnection?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(url, "root", "placeholder");
		Statement statement = connection.createStatement();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String query = "SELECT * FROM account WHERE username=\"" + username + "\" AND password=\"" + password + "\"";

		ResultSet result = statement.executeQuery(query);
		if(result.next()){
				out.println("Login successful!");
		}
		else{
			out.println("Login failed! Wrong credentials");
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