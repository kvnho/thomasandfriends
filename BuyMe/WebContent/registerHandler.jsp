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
		Connection connection = DriverManager.getConnection(url, "root", "placeholder@");
		
		Statement statement = connection.createStatement();
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		

		String insert = "INSERT INTO account(first_name,last_name,address,email,username,password)"
				+ "VALUES (?,?,?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement preparedStatement = connection.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		preparedStatement.setString(1, firstName);
		preparedStatement.setString(2, lastName);
		preparedStatement.setString(3, address);
		preparedStatement.setString(4, email);
		preparedStatement.setString(5, username);
		preparedStatement.setString(6, password);
		//Run the query against the DB
		preparedStatement.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();
		out.println("Account Created!");

	}
	catch (Exception e){
		out.print(e);
	}
%>

</body>
</html>