<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Reservations Info</title>
<script src="/FlightReservation/js/library/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/FlightReservation/css/reset.css" />

<style>
html {
	background: linear-gradient(#11bab4 ,#fff);
	height: auto;
}
html,body{margin:0;padding:0;}
header {
	text-align:center;
}
.content {overflow:hidden;}
.leftnav {
	width: 15%;
    float: left;
    margin-top: 8%;
}
nav ul li {
	list-style: none;
	padding: 10px;
}
nav ul li a{
	text-decoration: none;
	display: inline-block;
	font-size: 20px;
}
nav ul li a:hover{
	border-bottom: 1px solid black;
}
.rightNav{
	float: left;
	width: 80%;
	padding: 1%;
}
.btn {
	background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);
    border-radius: 0 5px;
    color: #fff;
    cursor: pointer;
    outline: none;
    padding: 0.5% 1%;
    font-weight: bold;
    border: 1px solid #b6b6b6;
}
.btn.right {margin-left: 17%;}
.rightNav >div {padding: 1%;}
.bookbtn {padding:1%;float:left;width:100%}
.myAcntForm .row {margin-left:1%;}
.myAcntForm input {
	display: block;
	margin-bottom: 3%;
	width: 250px;
	padding: 0.5% 1%;
	letter-spacing: 1px;
	border: 1px solid #2fc8d8;
}
.myAcntForm input:focus {
	outline: none;
	border: 1px solid #888;
	box-shadow: 5px 3px 10px #d8d8d8;
}
</style>

</head>
<body>


	<%
		if(session.getAttribute("userType") == null || ! session.getAttribute("userType").equals("manager")) {
			response.sendRedirect("http://localhost:8080/FlightReservation/");
		}
	%>
	
	
	<section class="container">
	<header>
		<h1>Geek Managers - View Reservations Info</h1>
	</header>
		<section class="content maincontainer">
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="viewCustomers">View Customers Info</a></li>
						<li><a href="viewFlightList">View Flights</a></li>
						<li><a href="getReport">Report</a></li>
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class = "viewFlightsTable">
					<table style="width:100%">
						 <tr>
						    <th>Booking Id</th> 
						    <th>Name</th>
						    <th>Email Address</th>
						    <th>Departure City</th>
						    <th>Arrival City</th>
						    <th>Total Fee</th>
						    <th>Airline Fee</th>
						    <th>Class</th>
						    <th>Date Of Flying</th>
						    <th>Booking TimeStamp</th>
						  </tr>
							<%
									
								String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
								try {
									Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection(url, "admin", "database");
									Statement stmt = con.createStatement();
									String query = "";
									if(request.getParameter("airlineNo") != null){
										String airId = request.getParameter("airlineNo");
										String flightId = request.getParameter("flightNo");
										query = "Select RD.BookingId, concat(U.FirstName, ' ', U.LastName) as Name, U.EmailAddress, RD.DepartureCity, " + 
												"RD.ArrivalCity, RD.TotalFee, RD.AirlineFee, RD.Class, DATE(R.Date_Of_Flying), R.BookingTimeStamp " +
												"from Reservations R, ReservationDetails RD, Users U where " +
												"RD.Reservation_Id = R.Reservation_Id and U.Users_Id = R.Users_Id and RD.Flight_Id = " + flightId + " and RD.Airline_Id = '" + airId + "'" +
												"order by R.BookingTimeStamp desc";
										
									} else if(request.getParameter("custName") != null){
										String custName = request.getParameter("custName");
										query = "Select RD.BookingId, concat(U.FirstName, ' ', U.LastName) as Name, U.EmailAddress, RD.DepartureCity, " + 
												"RD.ArrivalCity, RD.TotalFee, RD.AirlineFee, RD.Class, DATE(R.Date_Of_Flying), R.BookingTimeStamp " +
												"from Reservations R, ReservationDetails RD, Users U where " +
												"RD.Reservation_Id = R.Reservation_Id and U.Users_Id = R.Users_Id and lower(concat(U.FirstName, ' ', U.LastName)) = '" + custName.toLowerCase() + "' " +
												"order by R.BookingTimeStamp desc";
									
									}
									
									ResultSet result = stmt.executeQuery(query);
									
									String bookId = "", custName = "", emailId = "", depCity = "", arrCity = "", totalFee = "", airlineFee = "";
									String seatClass = "", dateOfFlying = "", bookTimeStamp = "";
									while(result.next()){
										bookId = result.getString(1);
										custName = result.getString(2);
										emailId = result.getString(3);
										depCity = result.getString(4);
										arrCity = result.getString(5);
										totalFee = result.getString(6);
										airlineFee = result.getString(7); 
										seatClass = result.getString(8);
										dateOfFlying = result.getString(9);
										bookTimeStamp = result.getString(10);	
										
										pageContext.setAttribute("bookId", bookId);
										pageContext.setAttribute("custName", custName);
										pageContext.setAttribute("emailId", emailId);
										pageContext.setAttribute("depCity", depCity);
										pageContext.setAttribute("arrCity", arrCity);
										pageContext.setAttribute("totalFee", totalFee);
										pageContext.setAttribute("airlineFee", airlineFee);
										pageContext.setAttribute("seatClass", seatClass);
										pageContext.setAttribute("dateOfFlying", dateOfFlying);
										pageContext.setAttribute("bookTimeStamp", bookTimeStamp);
										
							%>	
								<tr class="row">
								    <td> <%= pageContext.getAttribute("bookId") %> </td> 
								    <td> <%= pageContext.getAttribute("custName") %> </td>
								    <td> <%= pageContext.getAttribute("emailId") %> </td>
								    <td> <%= pageContext.getAttribute("depCity") %> </td>
								    <td> <%= pageContext.getAttribute("arrCity") %> </td>
								    <td> <%= pageContext.getAttribute("totalFee") %> </td>
								    <td> <%= pageContext.getAttribute("airlineFee") %> </td>
								    <td> <%= pageContext.getAttribute("seatClass") %> </td>
									<td> <%= pageContext.getAttribute("dateOfFlying") %> </td>
									<td> <%= pageContext.getAttribute("bookTimeStamp") %> </td>
							  	</tr>
							<%
									}
								} catch (SQLException | ClassNotFoundException e) {
									e.printStackTrace();
								}	
							%>

			</table>				
			</div>
			</div>
		</section>
	</section>
	
</body>
</html>