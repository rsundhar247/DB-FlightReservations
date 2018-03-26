<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - Bookings</title>
<script src="js/library/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="css/reset.css" />
<style>
html {
	background: linear-gradient(#11bab4 ,#fff) no-repeat;
	height: auto;	
}
html,body{margin:0;padding:0;}
header {
	text-align:center;
}
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
.travelType {width: 98%; margin:1%;padding-left: 1%; }
label {cursor:pointer;}
select {padding:0.5%; margin-right: 5%;}
.travelForm {width: 98%; margin: 1%; overflow:hidden;}
.citySelect {
	width: 25%;
    float: left;
    padding: 1%;
}
.classType {
	width: 80%;
	padding: 1%;
	float: left;
}
.citySelect input {
	letter-spacing:1px;
	width: 85%;
	padding: 10px;
	margin-bottom: 5%;
	font-size: 15px;
}
.citySelect input:focus {outline:none;}
.dateSelect {
	float: left;
	width: 70%;
	padding: 1%;
}
.dateSelect label {
	width: 14%;
    display: inline-block;
    margin-bottom: 5%;
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
.bookbtn {padding:1%;float:left;width:100%}
.dateSelect .rDate {display:none;}

* {margin:0;padding:0;-moz-box-sizing: border-box;-webkit-box-sizing: border-box;box-sizing: border-box;}
.row {
	width: 100%;
    margin-left: auto;
    margin-right: auto;
    margin-top: 0;
    margin-bottom: 0;
    max-width: 62.5em;
	overflow:hidden;
	font-family: monospace;
}
.book-det {
    padding: 0.5em 0;
    margin-bottom: 0.5em;
}
.flightInfo {
    margin: 0.5em;
}
.book-det span {font-size: 14px;}
.b-num {font-weight: bold;}
.from-to {
    background: #e4e4e4;
    padding: 0.5em;
}
.from-to-det {
    padding: 0.5em;
}
.from-to span {
    font-size: 16px;
}
.col1,.col2,.col3,.col4{
	width: 25%;
    float: left;
}
.col1 img {
    width: 30px;
    height: 30px;
}
.col2 h2 {
	background: url(img/takeoff.png) no-repeat center 3px;
}
.col4 h2 {
	background: url(img/land.png) no-repeat center 3px;
}
.col3 span {color: #847777; font-size: 14px;}
.left {float:left;}
.right {float:right;}
.c {text-align:center;display:block;}
.separator {border-bottom: 1px solid #dadada; margin:0.25em 0;}
.col2 {text-align: right;}
.city-code {display: block;}
.city{display: block;}
.airport {display: block;font-size:12px;margin-bottom: 5px;}
.terminal {display: block; background: url('img/location.png') no-repeat center;font-size: 14px;color:#26a1e4;cursor: pointer;}

</style>
</head>
<body>


	<section class="container">
		<section class="content maincontainer">
			<header>
				<h1>Geek Users - Bookings</h1>
			</header>
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="bookYourTravel">Book your travel</a></li>
						<li><a href="myAccount">My account</a></li>
						<li><a href="myBookings">My bookings</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class="flightInfo">
				
					<%
					
					String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
					try {
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "admin", "database");
						Statement stmt = con.createStatement();
						String query = "Select RD.BookingId, RD.Class, AL.AirlineName, AL.Airline_Id, f.Flight_Id, DATE(R.Date_Of_Flying) as Date_Of_Flying, " +
								"R.DepartureCity, R.FinalDestinationCity, f.DepartureAirport, f.ArrivalAirport, f.DepartureTime, f.TravelTime, " +
								"DATE_ADD(f.DepartureTime, INTERVAL f.TravelTime HOUR) as ArrivalTime from " +
								"ReservationDetails RD, Reservations R, Airlines AL, Flights f where " + 
								"RD.Reservation_Id = R.Reservation_Id and RD.Airline_Id = AL.Airline_Id and " +
								"f.Airline_Id = AL.Airline_Id and f.Flight_Id = RD.Flight_Id " +
								"and R.Users_Id in (Select Users_Id from Users where lower(EmailAddress) = '" + ((String)session.getAttribute("EmailId")).toLowerCase() + "')";
								
						ResultSet result = stmt.executeQuery(query);
						
						String bookingId = "", seatClass = "", airlineName = "", airlineId = "", flightId = "", dateOfFlying = "", depCity = "";
						String arrCity = "", depAirport = "", arrAirport = "", depTime = "", travelTime = "", arrTime = "";
						
						while(result.next()){
							bookingId = result.getString(1);
							seatClass = result.getString(2);
							airlineName = result.getString(3);
							airlineId = result.getString(4);
							flightId = result.getString(5);
							dateOfFlying = result.getString(6);
							depCity = result.getString(7); 
							arrCity = result.getString(8);
							depAirport = result.getString(9);
							arrAirport = result.getString(10);	
							depTime = result.getString(11);
							travelTime = result.getString(12);
							arrTime = result.getString(13);
							
							
							pageContext.setAttribute("bookingId", bookingId);
							pageContext.setAttribute("seatClass", seatClass);
							pageContext.setAttribute("airlineName", airlineName);
							pageContext.setAttribute("airlineId", airlineId);
							pageContext.setAttribute("flightId", flightId);
							pageContext.setAttribute("dateOfFlying", dateOfFlying);
							pageContext.setAttribute("depCity", depCity);
							pageContext.setAttribute("arrCity", arrCity);
							pageContext.setAttribute("depAirport", depAirport);
							pageContext.setAttribute("arrAirport", arrAirport);
							pageContext.setAttribute("depTime", depTime);
							pageContext.setAttribute("travelTime", travelTime);
							pageContext.setAttribute("arrTime", arrTime);
							
					%>
					
					<div class="row book-det">
						<span class="left">FLIGHT DETAILS</span>
						<span class="right">Booking ID <span class="b-num"><%= pageContext.getAttribute("bookingId") %></span></span>
					</div>
					<div class="row from-to">
						<span><%= pageContext.getAttribute("dateOfFlying") %> <%= pageContext.getAttribute("depCity") %> TO <%= pageContext.getAttribute("arrCity") %></span>
					</div>
					<div class="row from-to-det">
						<div class="col1">
							<img src="img/airplane.png" alt=""/>
							<h3><%= pageContext.getAttribute("airlineName") %></h3>
							<span><%= pageContext.getAttribute("airlineId") %> - <%= pageContext.getAttribute("flightId") %></span>
						</div>
						<div class="col2">
							<h2 class="city-code"><%= pageContext.getAttribute("depAirport") %></h2>
							<span class="city"><%= pageContext.getAttribute("depCity") %></span>
							<div class="separator"></div>
							<span class="timestamp"><%= pageContext.getAttribute("depTime") %></span>
							<div class="separator"></div>
						</div>
						<div class="col3">
							<span class="c"><img src="img/arrow.png" alt=""/></span>
							<span class="c"><%= pageContext.getAttribute("travelTime") %> hr(s)</span>
							<span class="c"><%= pageContext.getAttribute("seatClass") %></span>
						</div>
						<div class="col4">
							<h2 class="city-code"><%= pageContext.getAttribute("arrAirport") %></h2>
							<span class="city"><%= pageContext.getAttribute("arrCity") %></span>
							<div class="separator"></div>
							<span class="timestamp"><%= pageContext.getAttribute("arrTime") %></span>
							<div class="separator"></div>
						</div>
					</div>
						
					<%
						}
						
						
					} catch (SQLException | ClassNotFoundException e) {
						e.printStackTrace();
					}
					
					%>
				
				</div>
				
				
				
				
				
				
				
				
				
				
			</div>
		</section>
	</section>
</body>
</html>