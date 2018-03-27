<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Flights Info</title>
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
		<h1>Geek Managers - View Flights Info</h1>
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
						    <th>Airline Id</th> 
						    <th>Flight Id</th>
						    <th>Airline Name</th>
						    <th>Seat Capacity</th>
						    <th>Departure City</th>
						    <th>Departure Airport</th>
						    <th>Departure Time</th>
						    <th>Arrival City</th>
						    <th>Arrival Airport</th>
						    <th>Travel Time</th>
						  </tr>
							<%
									
								String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
								try {
									String param = request.getParameter("flights");
									Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection(url, "admin", "database");
									Statement stmt = con.createStatement();
									String query = "";
									if(param.equals("all")){
										query = "Select Flight_Id, F.Airline_Id, A.AirlineName, SeatCapacity, DepartureCity, DepartureAirport, DepartureTime, "+
											"ArrivalCity, ArrivalAirport, TravelTime from Flights F, Airlines A where F.Airline_Id = A.Airline_Id";
									} else if(param.equals("active")){
										query = "Select F.Flight_Id, F.Airline_Id, A.AirlineName, SeatCapacity, DepartureCity, DepartureAirport, " +
											"DepartureTime, ArrivalCity, ArrivalAirport, TravelTime, T.Total from Flights F, Airlines A, " + 
											"(Select RD.Flight_Id, RD.Airline_Id, SUM(R.NumberOfPassengers) as Total from " +
											"Reservations R Join ReservationDetails RD using(Reservation_Id) group by RD.Flight_Id) T " +
											"where F.Airline_Id = A.Airline_Id and T.Flight_Id = F.Flight_Id and F.Airline_Id = T.Airline_Id order by T.Total desc";
									}else if(param.equals("airportId")){
										String airportName = request.getParameter("AirportName");
										
										query = "Select Flight_Id, F.Airline_Id, A.AirlineName, SeatCapacity, DepartureCity, DepartureAirport, " +
												"DepartureTime, ArrivalCity, ArrivalAirport, TravelTime from Flights F, Airlines A " +
												"where F.Airline_Id = A.Airline_Id and lower(DepartureAirport) = '" + airportName.toLowerCase() + "'";
									}
									
									ResultSet result = stmt.executeQuery(query);
									
									String flightId = "", airlineId = "", airlineName = "", seatCapacity = "", depCity = "", depAirport = "", depTime = "";
									String arrCity = "", arrAirport = "", tavelTime = "";
									while(result.next()){
										flightId = result.getString(1);
										airlineId = result.getString(2);
										airlineName = result.getString(3);
										seatCapacity = result.getString(4);
										depCity = result.getString(5);
										depAirport = result.getString(6);
										depTime = result.getString(7); 
										arrCity = result.getString(8);
										arrAirport = result.getString(9);
										tavelTime = result.getString(10);	
										
										pageContext.setAttribute("flightId", flightId);
										pageContext.setAttribute("airlineId", airlineId);
										pageContext.setAttribute("airlineName", airlineName);
										pageContext.setAttribute("seatCapacity", seatCapacity);
										pageContext.setAttribute("depCity", depCity);
										pageContext.setAttribute("depAirport", depAirport);
										pageContext.setAttribute("depTime", depTime);
										pageContext.setAttribute("arrCity", arrCity);
										pageContext.setAttribute("arrAirport", arrAirport);
										pageContext.setAttribute("tavelTime", tavelTime);
										
							%>	
								<tr class="row">
								    <td> <%= pageContext.getAttribute("airlineId") %> </td> 
								    <td> <%= pageContext.getAttribute("flightId") %> </td>
								    <td> <%= pageContext.getAttribute("airlineName") %> </td>
								    <td> <%= pageContext.getAttribute("seatCapacity") %> </td>
								    <td> <%= pageContext.getAttribute("depCity") %> </td>
								    <td> <%= pageContext.getAttribute("depAirport") %> </td>
								    <td> <%= pageContext.getAttribute("depTime") %> </td>
								    <td> <%= pageContext.getAttribute("arrCity") %> </td>
									<td> <%= pageContext.getAttribute("arrAirport") %> </td>
									<td> <%= pageContext.getAttribute("tavelTime") %> </td>
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