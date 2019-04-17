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
	
	<h1>SALES REPORT</h1>	
	
	<div>
		<% 
			double sum = 0;
			int count = 0;
			double earningsPerItem = 0;
			
			double epcCarSum = 0;
			int epcCarCount = 0;
			double earningsPerCategoryCar = 0;
			try{
				String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
				Statement statement = connection.createStatement();
							
				
				// ============ TOTAL EARNINGS AND EARNINGS PER ITEM ===========
				String query = "SELECT SUM(highest_bid) FROM auction WHERE winner_id IS NOT NULL";
				ResultSet result = statement.executeQuery(query);
				if(result.next()){
					sum = result.getDouble(1);
				}
				
				String countQuery = "SELECT COUNT(*) FROM auction WHERE winner_id IS NOT NULL";
				ResultSet countResult = statement.executeQuery(countQuery);
				if(countResult.next()){
					count = countResult.getInt(1);
				}
				
				earningsPerItem = sum / count;
				//  ============================================================
						
						
				// ======================= EARNINGS PER CATEGORY =====================
				/*
				
				Natural Join Listing and auction so I can get access to item_category(Listing) and winner_id(auction)
					- get sum of that
					- get count of that
				*/
				
				String epc = "SELECT SUM(highest_bid) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL";
				ResultSet epcSetCar = statement.executeQuery(epc);
				if(epcSetCar.next()){
					epcCarSum = epcSetCar.getDouble(1);
				}
				
				String epc2 = "SELECT COUNT(*) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL";
				ResultSet epcSetCar2 = statement.executeQuery(epc2);
				if(epcSetCar2.next()){
					epcCarCount = epcSetCar2.getInt(1);
				}
				
				earningsPerCategoryCar = epcCarSum  / epcCarCount;
				
				//  ============================================================


				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				connection.close();
	
			}
			catch (Exception e){
				out.print(e);
			}
			out.print("Total Earnings: $" + sum);
			out.print("<br>");
			out.print("Earnings per item: $" + earningsPerItem);
			out.print("<br>");
			out.print("Earning per Car: $" + earningsPerCategoryCar);
			out.print("<br>");
			out.print("Earning per Airplane: $" + earningsPerCategoryCar);
			out.print("<br>");
			out.print("Earning per Boat: $" + earningsPerCategoryCar);
		%>
		<hr>
	</div>
</body>
</html>