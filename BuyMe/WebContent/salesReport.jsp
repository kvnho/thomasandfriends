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
	<hr>
	
	<div>
		<% 
			double sum = 0;
			int count = 0;
			double earningsPerItem = 0;
			
			double epcCarSum = 0;
			int epcCarCount = 0;
			double earningsPerCategoryCar = 0;
			
			double epcPlaneSum = 0;
			int epcPlaneCount = 0;
			double earningsPerCategoryPlane = 0;
			
			double epcMotorcycleSum = 0;
			int epcMotorcycleCount = 0;
			double earningsPerCategoryMotorcycle = 0;
			
			double endUserHighest = 0;
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
				
				out.print("<h3>Total Earnings: $" + sum + "</h3>");
				out.print("<h3>Earnings per item: $" + earningsPerItem + "</h3>");
				out.print("<br>");
				out.print("<hr>");


				
				
				
				//  ============================================================
						
						
				// ======================= EARNINGS PER CATEGORY =====================
				/*
				
				Natural Join Listing and auction so I can get access to item_category(Listing) and winner_id(auction)
					- get sum of that
					- get count of that
				*/
				
				String epc = "SELECT SUM(highest_bid) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL AND item_category='Car'";
				ResultSet epcSetCar = statement.executeQuery(epc);
				if(epcSetCar.next()){
					epcCarSum = epcSetCar.getDouble(1);
				}
				
				String epc2 = "SELECT COUNT(*) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL AND item_category='Car'";
				ResultSet epcSetCar2 = statement.executeQuery(epc2);
				if(epcSetCar2.next()){
					epcCarCount = epcSetCar2.getInt(1);
				}
				
				if(epcCarCount != 0) earningsPerCategoryCar = epcCarSum  / epcCarCount;
				
				
				
				
				
				epc = "SELECT SUM(highest_bid) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL AND item_category='Plane'";
				ResultSet epcSetPlane = statement.executeQuery(epc);
				if(epcSetPlane.next()){
					epcPlaneSum = epcSetPlane.getDouble(1);
				}
				
				epc2 = "SELECT COUNT(*) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL AND item_category='Plane'";
				ResultSet epcSetPlane2 = statement.executeQuery(epc2);
				if(epcSetPlane2.next()){
					epcPlaneCount = epcSetPlane2.getInt(1);
				}
				
				if(epcPlaneCount != 0) earningsPerCategoryPlane = epcPlaneSum  / epcPlaneCount;
				
				
				
				
				
				epc = "SELECT SUM(highest_bid) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL AND item_category='Motorcycle'";
				ResultSet epcSetMotorcycle = statement.executeQuery(epc);
				if(epcSetMotorcycle.next()){
					epcMotorcycleSum = epcSetMotorcycle.getDouble(1);
				}
				
				epc2 = "SELECT COUNT(*) FROM auction NATURAL JOIN Listing WHERE winner_id IS NOT NULL AND item_category='Motorcycle'";
				ResultSet epcSetMotorcycle2 = statement.executeQuery(epc2);
				if(epcSetMotorcycle2.next()){
					epcMotorcycleCount = epcSetMotorcycle2.getInt(1);
				}
				
				if(epcMotorcycleCount != 0) earningsPerCategoryMotorcycle = epcMotorcycleSum  / epcMotorcycleCount;
				
				
				
				out.print("<h2>Earnings per Item/Category:</h2>");
				out.print("Earning per Car: $" + earningsPerCategoryCar);
				out.print("<br>");
				out.print("Earning per Airplane: $" + earningsPerCategoryPlane);
				out.print("<br>");
				out.print("Earning per Motorcycle: $" + earningsPerCategoryMotorcycle);
				out.print("<br>");
				out.print("<br>");
				out.print("<hr>");


				
				
				
				
				
				//  ============================================================

						
				// ======================= EARNINGS PER END-USER =====================
				// select *, sum(highest_bid) from auction where winner_id is not null group by seller_id
				// while resultset is not empty, print out the seller_id, and how much they earned
				String perEndUserHighest = "SELECT *, SUM(highest_bid) AS sum FROM auction WHERE winner_id IS NOT NULL GROUP BY seller_id";
				ResultSet perEndUserHighestSet = statement.executeQuery(perEndUserHighest);
				out.print("<h2>Earnings Per  End-User:</h2>");
				while(perEndUserHighestSet.next()){
					String user = perEndUserHighestSet.getString("seller_id");
					double highest = perEndUserHighestSet.getDouble("sum");
					
					out.print("<p>End-User: " + "<b>" + user + "</b>" + " earned a total of: $" + highest + "</p>");
					out.print("<br>");
				}
				out.print("<hr>");
				//  ============================================================

				
				// ======================= BEST SELLING ITEMS =====================
				
				String bestItems = "SELECT auction_id, listing_id, listing_name, COUNT(*) AS count FROM bid NATURAL JOIN auction NATURAL JOIN Listing GROUP BY auction_id ORDER BY count DESC LIMIT 3";
				ResultSet bestItemsSet = statement.executeQuery(bestItems);
				out.print("<h2>Best Items (Top 3):</h2>");
				int inc = 1;
				while(bestItemsSet.next()){
					String listingName = bestItemsSet.getString("listing_name");
					int numBids = bestItemsSet.getInt(4);
					
					out.print("<p>" + inc + ". " + "<b>" + listingName + "</b>" + " had a total of: " + numBids + " bids</p>");
					out.print("<br>");
					
					inc++;
				}
				out.print("<hr>");
				
				
				
				//  ============================================================
				
				// ======================= BEST BUYERS =====================
				String bestBuyers = "SELECT *, COUNT(*) AS count FROM auction WHERE winner_id IS NOT NULL GROUP BY winner_id ORDER BY count DESC LIMIT 3";
				ResultSet bestBuyersSet = statement.executeQuery(bestBuyers);
				out.print("<h2>Best Buyers (Top 3):</h2>");
				inc = 1;
				while(bestBuyersSet.next()){
					String user = bestBuyersSet.getString("seller_id");
					int countBuy = bestBuyersSet.getInt("count");
					
					out.print("<p>" + inc + ". " + "<b>" + user + "</b>" + " bought a total of: " + countBuy + " items</p>");
					out.print("<br>");
					inc++;
				}
				out.print("<hr>");

				
				
				
				
				
				//  ============================================================


				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				connection.close();
	
			}
			catch (Exception e){
				out.print(e);
			}
			
			/*
			out.print("Total Earnings: $" + sum);
			out.print("<br>");
			out.print("Earnings per item: $" + earningsPerItem);
			out.print("<br>");
			out.print("Earning per Car: $" + earningsPerCategoryCar);
			out.print("<br>");
			out.print("Earning per Airplane: $" + earningsPerCategoryPlane);
			out.print("<br>");
			out.print("Earning per Motorcycle: $" + earningsPerCategoryMotorcycle);
			*/
		%>
		<hr>
	</div>
</body>
</html>