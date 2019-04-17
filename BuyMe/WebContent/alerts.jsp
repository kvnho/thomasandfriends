<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*,  java.sql.*, java.text.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alerts Page</title>
</head>

<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="auctions.jsp">SEE AUCTIONS</a></li>
			<li><a href="createAlert.jsp">CREATE ALERT</a></li>
			<li><a href="alerts.jsp">ALERTS</a></li>
			<li><a href="searchUsers.jsp">SEARCH USERS</a></li>
		</ul>
		<hr>
	</div>
	<div>
		<% 
			String userID = (String)session.getAttribute("username");
			try{
				String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
				Statement statement = connection.createStatement();
								
				String query = "SELECT * FROM email WHERE to_from=\"" + userID + "\"";
				
				ResultSet result = statement.executeQuery(query);
				
				out.print("<h3>MESSAGES: </h3>");
				out.print("<hr><br>");
	
				while(result.next()){
					%>
					<p>FROM: <%out.print(result.getString("from_to")); %>
					<p>TO: <%out.print(result.getString("to_from")); %>
					<p>DATE: <%out.print(result.getString("date_time")); %>
					<p>SUBJECT: <%out.print(result.getString("subject")); %>
					<p>MESSAGE: <%out.print(result.getString("content")); %>
					<br>
					<hr>
					<br>
										
				<%	
				}
	
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				connection.close();
	
			}
			catch (Exception e){
				out.print(e);
			}
		
		%>
	</div>
</body>
</html>