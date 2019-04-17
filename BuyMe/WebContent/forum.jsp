<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forum Page</title>
</head>
<body>
	<div>
		<h3>NAV BAR</h3>
		<ul>
			<li><a href="welcome.jsp">HOME</a></li>
			<li><a href="createAuction.jsp">CREATE AUCTION</a></li>
			<li><a href="auctions.jsp">SEE AUCTIONS</a></li>
			<li><a href="forum.jsp">FORUM</a></li>
			<li><a href="createAlert.jsp">CREATE ALERT</a></li>
			<li><a href="alerts.jsp">ALERTS</a></li>
			<li><a href="searchUsers.jsp">SEARCH USERS</a></li>
		</ul>
		<hr>
	</div>
	
	<h1>Search Question</h1>
	<form action="searchedForum.jsp" method="GET">
		<label>Search field: </label>
		<input type="text" name="search_string">
		<input type="submit" value="Search">		
	</form>
	<br>
	<br>
	<hr>
	<br>
	<h3>Post a Question:</h3>
	<form action="forumHandler.jsp" method="POST">
		<input type="hidden" name="query" value=1>		 
		<label>Auction ID: </label>
		<input type="number" name="auction_id">
		<br>
		<br>
		<label>Question: </label>
		<textarea required="required" name="question_asked"></textarea>
		<br>
		<br>
		<input type="submit" value="Post Question">		
	</form>
	<br>
	<br>
	<br>
	<hr>
	<%
		try{
			String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
			Statement statement = connection.createStatement();
			
			String user = (String)session.getAttribute("username");
			String getUserType = "SELECT account_type FROM account WHERE username=\"" + user + "\"";
			ResultSet userType = statement.executeQuery(getUserType);
			int type = 0; 
			if(userType.next())
			{
				type = userType.getInt("account_type");
			}
			
			String getQuestions = "SELECT * FROM question;";
			ResultSet result = statement.executeQuery(getQuestions);
			while(result.next())
			{
				String questionID = result.getString("question_id");
				String userID = result.getString("user_id");
				String auctionID = result.getString("auction_id");
				String questionAsked = result.getString("question");
				String ans = result.getString("answer");
				
				%>
				<p>ASKED BY USER: <%out.print(userID); %></p>
				<p>REGARDING AUCTION: <%out.print(auctionID); %></p>
				<p>QUESTION: <%out.print(questionAsked); %></p>
				<%
				if(ans.length() == 0)
				{
					ans = "";
				}
				%>
				<p>ANSWER: <%out.print(ans); %></p>
				
				<%
					if(type == 1 || type == 2)
					{
				%>
						<form action="forumHandler.jsp" method="POST">
						<label> response: </label>
						<input type="hidden" name="question_id" value=<%=questionID%>>
						<input type="text" required="required" name="response">
						<input type="hidden" name="query" value=2>
						<input type="hidden" name="question_asked" value=<%=questionAsked%>>
						<input type="submit" value="Submit Response">
						</form>
				<%
					};
				%>
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

</body>
<script type="text/javascript">
	function alertName(){

		alert("a");
	} 
</script> 
</html>