2<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Actions</title>
</head>
<body>


<%
	try{
		String url = "jdbc:mysql://cs336db.cvs3tkn3ttbi.us-east-1.rds.amazonaws.com/BuyMe?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=UTC";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection(url, "cs336", "thomasandfriends");
		
		Statement statement = connection.createStatement();
		int requestor = Integer.parseInt(request.getParameter("sender"));
		
		
		if(requestor == 1){
			String bidID = request.getParameter("bid_id");
			String fetchAuctionID = "SELECT auction_id FROM bid WHERE bid_id=\"" + bidID + "\"";
			ResultSet result = statement.executeQuery(fetchAuctionID);
			int auctionID = -1;
			if(result.next()){
				auctionID = result.getInt("auction_id");
			}
			
			//Delete the bid
			String deleteBid = "DELETE FROM bid WHERE bid_id=\"" + bidID + "\""; 
			PreparedStatement deleteBidStatement = connection.prepareStatement(deleteBid);
			deleteBidStatement.executeUpdate();
			
			if(auctionID != -1){
				//Select new highest bid
				String updateBid = "SELECT MAX(amount) FROM bid WHERE auction_id=\"" + auctionID + "\"";
				ResultSet resultSetAmount = statement.executeQuery(updateBid);
				double bidAmount = 0;
				if(resultSetAmount.next()){
					bidAmount = resultSetAmount.getDouble(1);
				}
				//Update auction to reflect the new highest bid in case you deleted the highest bid
				String insert = "UPDATE auction SET highest_bid=? WHERE auction_id=?";
				PreparedStatement preparedStatement2 = connection.prepareStatement(insert);
				preparedStatement2.setDouble(1, bidAmount);
				preparedStatement2.setInt(2, auctionID);
				preparedStatement2.executeUpdate();
			}
			
			
			
			//After we delete bid, update the auction table's highest_bid to reflect the bid amount of the last bid
			//deleteBid();
		}
		else if(requestor == 2){
			String listingID = request.getParameter("listing_id");
			//Select listing_id from auction. Delete from listing where listing_id=?
			String deleteListing = "DELETE FROM Listing WHERE listing_id=\"" + listingID + "\""; 
			PreparedStatement deleteAuctionStatement = connection.prepareStatement(deleteListing);
			deleteAuctionStatement.executeUpdate();
			//deleteAuction();
		}
		else if(requestor == 3){
			String userName = request.getParameter("username");
			String fName = request.getParameter("firstName");
			String lName = request.getParameter("lastName");
			String addr = request.getParameter("address");
			String pass = request.getParameter("password");
			
			
			if(fName.length() != 0){
				//String updateFname = "UPDATE account SET first_name=\"" + fName + "WHERE username=\"" + userName + "\"";
				String updateFname = "UPDATE account SET first_name=? WHERE username=?";
				PreparedStatement preparedStatement = connection.prepareStatement(updateFname);
				preparedStatement.setString(1, fName);
				preparedStatement.setString(2, userName);
				preparedStatement.executeUpdate();
			}

			if(lName.length() != 0){
				String updateLname = "UPDATE account SET last_name=? WHERE username=?";
				PreparedStatement preparedStatement = connection.prepareStatement(updateLname);
				preparedStatement.setString(1, lName);
				preparedStatement.setString(2, userName);
				preparedStatement.executeUpdate();
			}
			
			if(addr.length() != 0){
				String updateAddr = "UPDATE account SET address=? WHERE username=?";
				PreparedStatement preparedStatement = connection.prepareStatement(updateAddr);
				preparedStatement.setString(1, addr);
				preparedStatement.setString(2, userName);
				preparedStatement.executeUpdate();
			}
			
			if(pass.length() != 0){
				String updatePass = "UPDATE account SET password=? WHERE username=?";
				PreparedStatement preparedStatement = connection.prepareStatement(updatePass);
				preparedStatement.setString(1, pass);
				preparedStatement.setString(2, userName);
				preparedStatement.executeUpdate();
			}
			//editAccount();
		}
		connection.close();
	    response.sendRedirect("welcome.jsp");
	}
	catch (Exception e){
		out.print(e);
	}

	
	
%>


</body>
</html>