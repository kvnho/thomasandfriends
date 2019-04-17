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
	int i = 0;
	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		
		Statement statement = connection.createStatement();
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String address = request.getParameter("address");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if(firstName.length() == 0 || lastName.length() == 0 || address.length() == 0 || username.length() == 0 || password.length() == 0){
			i = 1;
			throw new IllegalArgumentException("Form fields cannot be blank");
		}
		
		String insert = "INSERT INTO account(first_name,last_name,address,username,password,account_type)"
				+ "VALUES (?,?,?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement preparedStatement = connection.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		preparedStatement.setString(1, firstName);
		preparedStatement.setString(2, lastName);
		preparedStatement.setString(3, address);
		preparedStatement.setString(4, username);
		preparedStatement.setString(5, password);
		try{
			if(((String)session.getAttribute("username")).equals("admin")){
				preparedStatement.setInt(6, 2);
			}
		}
		catch(Exception e){
			preparedStatement.setInt(6, 3);
		}


		//Run the query against the DB
		preparedStatement.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		connection.close();
		
		out.println("Account Created! <br> <a href='index.jsp'> Log in </a>");

	}
	catch (Exception e){
		out.print(e);
		if(i == 0){
			out.println("Username already in use <br> <a href='index.jsp'> Try again </a>");
			
		}
		else if(i == 1){
			out.println("Form fields cannot be blank <br> <a href='index.jsp'> Try again </a>");
		}
		
		i = 0;
	}
%>


</body>
</html>