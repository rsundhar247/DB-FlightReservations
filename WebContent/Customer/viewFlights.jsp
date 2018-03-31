<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Flights</title>
<script src="/FlightReservation/js/library/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/FlightReservation/css/reset.css" />
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
</style>
</head>
<body>

	<%
		if(session.getAttribute("userType") != null && session.getAttribute("userType").equals("manager")) {
			response.sendRedirect("http://localhost:8080/FlightReservation/manager/viewCustomers");
		}	
		if(session.getAttribute("userType") == null || ! session.getAttribute("userType").equals("customer")) {
			response.sendRedirect("http://localhost:8080/FlightReservation/");
		}
	%>
	
	<section class="container">
		<header>
			<h1>Geek Managers - View Flights</h1>
		</header>
		<section class="content maincontainer">
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="/FlightReservation/customer/bookYourTravel">Book your travel</a></li>
						<li><a href="/FlightReservation/customer/myAccount">My account</a></li>
						<li><a href="/FlightReservation/customer/myBookings">My bookings</a></li>
						<li><a href="/FlightReservation/customer/bestSelling">Best Selling Flights</a></li>
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
			<div class = "viewFlightsTable">
				<input type="hidden" name="sessionEmail" id="sessionEmail" value=<%= session.getAttribute("EmailId") %>>
				<input type="hidden" name="aTkts" id="aTkts" value=<%= request.getParameter("aTkts") %>>
				<input type="hidden" name="pClass" id="pClass" value=<%= request.getParameter("pClass") %>>
				<input type="hidden" name="dDate" id="dDate" value=<%= request.getParameter("dDate") %>>
				<input type="hidden" name="rDate" id="rDate" value=<%= request.getParameter("rDate") %>>
				
						<%
								String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
								try {
									Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection(url, "admin", "database");
									Statement stmt = con.createStatement();
									String query = "", isSame = "";
									
									query = "Select if(T1.Country = T2.Country,1,0) from (Select Country from Airports where Airport_Id='" + request.getParameter("oCity") + "') T1, " +
											"(Select Country from Airports where Airport_Id='" + request.getParameter("dCity") + "') T2";
									
									ResultSet result = stmt.executeQuery(query);
									
									if(result.next()){
										isSame = result.getString(1);
									}
									
									if(isSame.equals("0")){
						%>
						
							<h2> International Flight Bookings</h2><br>
						<%} else { %>
							<h2> Domestic Flight Bookings</h2><br>
						<%} %>
							<table style="width:100%">
							  <tr>
							    <th>Select</th>
							    <th>Airline Name</th> 
							    <th>Airline Code</th>
							    <th>Departure Airport</th>
							    <th>Arrival Airport</th>
							    <th>Departure Time</th>
							    <th>Travel Time</th>
							    <th>Fare</th>
							  </tr>
						
						<%			
									query = "SELECT AR.AirlineName, concat(FL.Airline_Id, '-', FL.Flight_Id) as FlightNumber, FL.DepartureAirport, FL.ArrivalAirport, " +
											"FL.DepartureTime, FL.TravelTime, FA.AirlineFare, datediff('" + request.getParameter("dDate") + "', NOW()) FROM Airlines AR, Flights FL, Fare FA  " +
											"WHERE AR.airline_ID = FL.Airline_Id and FL.Airline_Id = FA.Airline_Id and FL.Flight_Id = FA.Flight_Id AND " +
											"(lower(FL.DepartureAirport) = '"+ request.getParameter("oCity").toLowerCase() +
											"' AND lower(FL.ArrivalAirport) = '"+ request.getParameter("dCity").toLowerCase() +
											"' AND lower(FA.WorkingDay) = lower(DAYNAME('" + request.getParameter("dDate") +"')))";

									result = stmt.executeQuery(query);
									
									String airName = "", fNumber = "", depAirport = "", arrAirport = "", depTime = "", travelTime = "", airFare = "", dayDiff = "";
									int count = 1;
									
									while(result.next()){
											airName = result.getString(1);
											fNumber = result.getString(2);
											depAirport = result.getString(3);
											arrAirport = result.getString(4);
											depTime = result.getString(5);
											travelTime = result.getString(6);
											airFare = result.getString(7); 
											dayDiff = result.getString(8); 
											
											pageContext.setAttribute("airName", airName);
											pageContext.setAttribute("fNumber", fNumber);
											pageContext.setAttribute("depAirport", depAirport);
											pageContext.setAttribute("arrAirport", arrAirport);
											pageContext.setAttribute("depTime", depTime);
											pageContext.setAttribute("travelTime", travelTime);
											//pageContext.setAttribute("airFare", airFare);
											pageContext.setAttribute("count", count);
											pageContext.setAttribute("dayDiff", dayDiff);
											
											int diffDays = Integer.parseInt(dayDiff);
											int price = Integer.parseInt(airFare);
											int noOfTkts = Integer.parseInt(request.getParameter("aTkts"));
											
											if(diffDays < 3){
												price = (int) (price * noOfTkts * 1.8);
											} else if(diffDays >= 3 && diffDays < 7){
												price = (int) (price * noOfTkts * 1.6);
											} else if(diffDays >= 7 && diffDays < 14){
												price = (int) (price * noOfTkts * 1.4);
											} else if(diffDays >= 14 && diffDays < 21){
												price = (int) (price * noOfTkts * 1.2);
											} else {
												price = (int) (price * noOfTkts * 1);
											}
											
											pageContext.setAttribute("airFare", price);
										
							%>	
				
				
							  <tr class="row<%= pageContext.getAttribute("count") %>">
							  	<%if(count == 1){ %>
							   	 	<td><input type="radio" name="travelBook1" checked value=<%= pageContext.getAttribute("count") %>></td>
							    <%} else { %>
							     	<td><input type="radio" name="travelBook1" value=<%= pageContext.getAttribute("count") %>></td>
							    <%} %>
							    <td class="airName<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("airName") %></td> 
							    <td class="fNumber<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("fNumber") %></td>
							    <td class="depAirport<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("depAirport") %></td>
							    <td class="arrAirport<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("arrAirport") %></td>
							    <td class="depTime<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("depTime") %></td>
							    <td class="travelTime<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("travelTime") %></td>
							    <td class="airFare<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("airFare") %></td>
							  </tr>
				  
						  <%
						  				++count;
									} 
									
									query = "Select T1.AirlineName as L1_AirlineName, T1.AirlineCode as L1_AirlineCode, T1.DepartureAirport as L1_DepartureAirport, " +
											"T1.ArrivalAirport as L1_ArrivalAirport, T1.AirlineFare as L1_AirlineFare, " +
											"T1.DepartureTime as L1_DepartureTime, T1.TravelTIme as L1_TravelTime, " +
											"T2.AirlineName as L2_AirlineName, T2.AirlineCode as L2_AirlineCode, T2.DepartureAirport as L2_DepartureAirport, " + 
											"T2.ArrivalAirport as L2_ArrivalAirport, T2.AirlineFare as L2_AirlineFare, " +
											"T2.DepartureTime as L2_DepartureTime, T2.TravelTIme as L2_TravelTime, T1.datediff from " +
											"(SELECT AR.AirlineName, concat(FL.Airline_Id, '-', FL.Flight_Id) as AirlineCode, FL.DepartureAirport, " + 
											"FL.ArrivalAirport, FA.WorkingDay, FA.AirlineFare, FL.DepartureTime, FL.TravelTime, " +
											"datediff('" + request.getParameter("dDate") + "', NOW()) as datediff " +
											"FROM Flights FL, Fare FA, Airlines AR " +
											"WHERE FL.Airline_Id = FA.Airline_Id AND AR.Airline_Id = FL.Airline_Id AND " +
											"FL.Flight_Id = FA.Flight_Id AND lower(FL.DepartureAirport) = '" + request.getParameter("oCity").toLowerCase() + 
											"' AND lower(FA.WorkingDay) = lower(DAYNAME('" + request.getParameter("dDate") + "'))) T1, (SELECT AR.AirlineName, " +
											"concat(FL.Airline_Id, '-', FL.Flight_Id) as AirlineCode, " +
											"FL.DepartureAirport, FL.ArrivalAirport, FA.WorkingDay, FA.AirlineFare, FL.DepartureTime, FL.TravelTime " +
											"FROM Flights FL, Fare FA, Airlines AR WHERE FL.Airline_Id = FA.Airline_Id AND AR.Airline_Id = FL.Airline_Id AND " +
											"FL.Flight_Id = FA.Flight_Id AND lower(FL.ArrivalAirport) = '" + request.getParameter("dCity").toLowerCase() + 
											"' AND lower(FA.WorkingDay) = lower(DAYNAME('" + request.getParameter("dDate") + "'))) T2 where T1.ArrivalAirport = T2.DepartureAirport";
									
									result = stmt.executeQuery(query);
									
									String L1airName = "", L1fNumber = "", L1depAirport = "", L1arrAirport = "", L1airFare = "", L1depTime = "", L1travelTime = "";
									String L2airName = "", L2fNumber = "", L2depAirport = "", L2arrAirport = "", L2airFare = "", L2depTime = "", L2travelTime = "";
									int diffDays = 0;
									while(result.next()){
											L1airName = result.getString(1);
											L1fNumber = result.getString(2);
											L1depAirport = result.getString(3);
											L1arrAirport = result.getString(4);
											L1airFare = result.getString(5);
											L1depTime = result.getString(6);
											L1travelTime = result.getString(7); 
											
											L2airName = result.getString(8);
											L2fNumber = result.getString(9);
											L2depAirport = result.getString(10);
											L2arrAirport = result.getString(11);
											L2airFare = result.getString(12);
											L2depTime = result.getString(13);
											L2travelTime = result.getString(14);
											
											diffDays = Integer.parseInt(result.getString(15));
											
											pageContext.setAttribute("L1airName", L1airName);
											pageContext.setAttribute("L1fNumber", L1fNumber);
											pageContext.setAttribute("L1depAirport", L1depAirport);
											pageContext.setAttribute("L1arrAirport", L1arrAirport);
											pageContext.setAttribute("L1depTime", L1depTime);
											pageContext.setAttribute("L1travelTime", L1travelTime);
											
											pageContext.setAttribute("L2airName", L2airName);
											pageContext.setAttribute("L2fNumber", L2fNumber);
											pageContext.setAttribute("L2depAirport", L2depAirport);
											pageContext.setAttribute("L2arrAirport", L2arrAirport);
											pageContext.setAttribute("L2depTime", L2depTime);
											pageContext.setAttribute("L2travelTime", L2travelTime);
											pageContext.setAttribute("count", count);
											
											
											int price = Integer.parseInt(L1airFare);
											int noOfTkts = Integer.parseInt(request.getParameter("aTkts"));
											
											
											if(diffDays < 3){
												price = (int) (price * noOfTkts * 1.8);
											} else if(diffDays >= 3 && diffDays < 7){
												price = (int) (price * noOfTkts * 1.6);
											} else if(diffDays >= 7 && diffDays < 14){
												price = (int) (price * noOfTkts * 1.4);
											} else if(diffDays >= 14 && diffDays < 21){
												price = (int) (price * noOfTkts * 1.2);
											} else {
												price = (int) (price * noOfTkts * 1);
											}
											
											pageContext.setAttribute("L1airFare", price);
													
													
											price = Integer.parseInt(L2airFare);
											
											if(diffDays < 3){
												price = (int) (price * noOfTkts * 1.8);
											} else if(diffDays >= 3 && diffDays < 7){
												price = (int) (price * noOfTkts * 1.6);
											} else if(diffDays >= 7 && diffDays < 14){
												price = (int) (price * noOfTkts * 1.4);
											} else if(diffDays >= 14 && diffDays < 21){
												price = (int) (price * noOfTkts * 1.2);
											} else {
												price = (int) (price * noOfTkts * 1);
											}
											
											pageContext.setAttribute("L2airFare", price);
										
							%>	
				
				
							  <tr class="row<%= pageContext.getAttribute("count") %>">
							  	<%if(count == 1){ %>
							   	 	<td><input type="radio" name="travelBook1" checked value=<%= pageContext.getAttribute("count") %>></td>
							    <%} else { %>
							     	<td><input type="radio" name="travelBook1" value=<%= pageContext.getAttribute("count") %>></td>
							    <%} %>
							    <td class="airName<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1airName") %><br><%= pageContext.getAttribute("L2airName") %></td> 
							    <td class="fNumber<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1fNumber") %><br><%= pageContext.getAttribute("L2fNumber") %></td>
							    <td class="depAirport<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1depAirport") %><br><%= pageContext.getAttribute("L2depAirport") %></td>
							    <td class="arrAirport<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1arrAirport") %><br><%= pageContext.getAttribute("L2arrAirport") %></td>
							    <td class="depTime<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1depTime") %><br><%= pageContext.getAttribute("L2depTime") %></td>
							    <td class="travelTime<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1travelTime") %><br><%= pageContext.getAttribute("L2travelTime") %></td>
							    <td class="airFare<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1airFare") %><br><%= pageContext.getAttribute("L2airFare") %></td>
							  </tr>
				  
						  <%
						  				++count;
								} 
									
								} catch (SQLException | ClassNotFoundException e) {
									e.printStackTrace();
								}	
							%>
						</table>	
				
				<br>
				<br>
				<br>
				<br>
				
				<% if(! request.getParameter("rDate").equals("")) { %>
					<h2> Return Flights</h2><br>
					<table style="width:100%">
					  <tr>
					   <th>Select</th>
						    <th>Airline Name</th> 
						    <th>Airline Code</th>
						    <th>Departure Airport</th>
						    <th>Arrival Airport</th>
						    <th>Departure Time</th>
						    <th>Travel Time</th>
						    <th>Fare</th>
					  </tr>
					 
					 <%
									
								url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
								try {
									Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection(url, "admin", "database");
									Statement stmt = con.createStatement();
									
									String query = "SELECT AR.AirlineName, concat(FL.Airline_Id, '-', FL.Flight_Id) as FlightNumber, FL.DepartureAirport, FL.ArrivalAirport, " +
											"FL.DepartureTime, FL.TravelTime, FA.AirlineFare, datediff('" + request.getParameter("rDate") + "', NOW()) FROM Airlines AR, Flights FL, Fare FA  " +
											"WHERE AR.airline_ID = FL.Airline_Id and FL.Airline_Id = FA.Airline_Id and FL.Flight_Id = FA.Flight_Id AND " +
											"(lower(FL.DepartureAirport) = '"+ request.getParameter("dCity").toLowerCase() +
											"' AND lower(FL.ArrivalAirport) = '"+ request.getParameter("oCity").toLowerCase() +
											"' AND lower(FA.WorkingDay) = lower(DAYNAME('" + request.getParameter("rDate") +"')))";
									
									ResultSet result = stmt.executeQuery(query);
									
									String airName = "", fNumber = "", depAirport = "", arrAirport = "", depTime = "", travelTime = "", airFare = "", dayDiff = "";
									int count = 1;
									
									while(result.next()){
											airName = result.getString(1);
											fNumber = result.getString(2);
											depAirport = result.getString(3);
											arrAirport = result.getString(4);
											depTime = result.getString(5);
											travelTime = result.getString(6);
											airFare = result.getString(7); 
											dayDiff = result.getString(8); 
											
											pageContext.setAttribute("airName", airName);
											pageContext.setAttribute("fNumber", fNumber);
											pageContext.setAttribute("depAirport", depAirport);
											pageContext.setAttribute("arrAirport", arrAirport);
											pageContext.setAttribute("depTime", depTime);
											pageContext.setAttribute("travelTime", travelTime);
											//pageContext.setAttribute("airFare", airFare);
											pageContext.setAttribute("count", count);
											
											int diffDays = Integer.parseInt(dayDiff);
											int price = Integer.parseInt(airFare);
											int noOfTkts = Integer.parseInt(request.getParameter("aTkts"));
											
											if(diffDays < 3){
												price = (int) (price * noOfTkts * 1.8);
											} else if(diffDays >= 3 && diffDays < 7){
												price = (int) (price * noOfTkts * 1.6);
											} else if(diffDays >= 7 && diffDays < 14){
												price = (int) (price * noOfTkts * 1.4);
											} else if(diffDays >= 14 && diffDays < 21){
												price = (int) (price * noOfTkts * 1.2);
											} else {
												price = (int) (price * noOfTkts * 1);
											}
											
											pageContext.setAttribute("airFare", price);
										
							%>	
					  <tr class="rowR<%= pageContext.getAttribute("count") %>">
				    		<%if(count == 1){ %>
						   	 	<td><input type="radio" name="travelBook2" checked value=<%= pageContext.getAttribute("count") %>></td>
						    <%} else { %>
						     	<td><input type="radio" name="travelBook2" value=<%= pageContext.getAttribute("count") %>></td>
						    <%} %>
						    <td class="airNameR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("airName") %></td> 
						    <td class="fNumberR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("fNumber") %></td>
						    <td class="depAirportR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("depAirport") %></td>
						    <td class="arrAirportR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("arrAirport") %></td>
						    <td class="depTimeR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("depTime") %></td>
						    <td class="travelTimeR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("travelTime") %></td>
						    <td class="airFareR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("airFare") %></td>
					  </tr>
				  	 	<%
					  				++count;
								} 

								
								query = "Select T1.AirlineName as L1_AirlineName, T1.AirlineCode as L1_AirlineCode, T1.DepartureAirport as L1_DepartureAirport, " +
										"T1.ArrivalAirport as L1_ArrivalAirport, T1.AirlineFare as L1_AirlineFare, " +
										"T1.DepartureTime as L1_DepartureTime, T1.TravelTIme as L1_TravelTime, " +
										"T2.AirlineName as L2_AirlineName, T2.AirlineCode as L2_AirlineCode, T2.DepartureAirport as L2_DepartureAirport, " + 
										"T2.ArrivalAirport as L2_ArrivalAirport, T2.AirlineFare as L2_AirlineFare, " +
										"T2.DepartureTime as L2_DepartureTime, T2.TravelTIme as L2_TravelTime, T1.datediff from " +
										"(SELECT AR.AirlineName, concat(FL.Airline_Id, '-', FL.Flight_Id) as AirlineCode, FL.DepartureAirport, " + 
										"FL.ArrivalAirport, FA.WorkingDay, FA.AirlineFare, FL.DepartureTime, FL.TravelTime, datediff('" + request.getParameter("rDate") + "', NOW()) as datediff " +
										"FROM Flights FL, Fare FA, Airlines AR " +
										"WHERE FL.Airline_Id = FA.Airline_Id AND AR.Airline_Id = FL.Airline_Id AND " +
										"FL.Flight_Id = FA.Flight_Id AND lower(FL.DepartureAirport) = '" + request.getParameter("dCity").toLowerCase() + 
										"' AND lower(FA.WorkingDay) = lower(DAYNAME('" + request.getParameter("rDate") + "'))) T1, (SELECT AR.AirlineName, " +
										"concat(FL.Airline_Id, '-', FL.Flight_Id) as AirlineCode, FL.DepartureAirport,  " +
										"FL.ArrivalAirport, FA.WorkingDay, FA.AirlineFare, FL.DepartureTime, FL.TravelTime " +
										"FROM Flights FL, Fare FA, Airlines AR WHERE FL.Airline_Id = FA.Airline_Id AND AR.Airline_Id = FL.Airline_Id AND " +
										"FL.Flight_Id = FA.Flight_Id AND lower(FL.ArrivalAirport) = '" + request.getParameter("oCity").toLowerCase() + 
										"' AND lower(FA.WorkingDay) = lower(DAYNAME('" + request.getParameter("rDate") + "'))) T2 where T1.ArrivalAirport = T2.DepartureAirport";
								
								result = stmt.executeQuery(query);
								
								String L1airName = "", L1fNumber = "", L1depAirport = "", L1arrAirport = "", L1airFare = "", L1depTime = "", L1travelTime = "";
								String L2airName = "", L2fNumber = "", L2depAirport = "", L2arrAirport = "", L2airFare = "", L2depTime = "", L2travelTime = "";
								int diffDays = 0;
								count = 1;
								
								while(result.next()){
										L1airName = result.getString(1);
										L1fNumber = result.getString(2);
										L1depAirport = result.getString(3);
										L1arrAirport = result.getString(4);
										L1airFare = result.getString(5);
										L1depTime = result.getString(6);
										L1travelTime = result.getString(7); 
										
										L2airName = result.getString(8);
										L2fNumber = result.getString(9);
										L2depAirport = result.getString(10);
										L2arrAirport = result.getString(11);
										L2airFare = result.getString(12);
										L2depTime = result.getString(13);
										L2travelTime = result.getString(14);
										
										diffDays = Integer.parseInt(result.getString(15));
										
										pageContext.setAttribute("L1airName", L1airName);
										pageContext.setAttribute("L1fNumber", L1fNumber);
										pageContext.setAttribute("L1depAirport", L1depAirport);
										pageContext.setAttribute("L1arrAirport", L1arrAirport);
										//pageContext.setAttribute("L1airFare", L1airFare);
										pageContext.setAttribute("L1depTime", L1depTime);
										pageContext.setAttribute("L1travelTime", L1travelTime);
										
										pageContext.setAttribute("L2airName", L2airName);
										pageContext.setAttribute("L2fNumber", L2fNumber);
										pageContext.setAttribute("L2depAirport", L2depAirport);
										pageContext.setAttribute("L2arrAirport", L2arrAirport);
										//pageContext.setAttribute("L2airFare", L2airFare);
										pageContext.setAttribute("L2depTime", L2depTime);
										pageContext.setAttribute("L2travelTime", L2travelTime);
										pageContext.setAttribute("count", count);
										
										int price = Integer.parseInt(L1airFare);
										int noOfTkts = Integer.parseInt(request.getParameter("aTkts"));
										if(diffDays < 3){
											price = (int) (price * noOfTkts * 1.8);
										} else if(diffDays >= 3 && diffDays < 7){
											price = (int) (price * noOfTkts * 1.6);
										} else if(diffDays >= 7 && diffDays < 14){
											price = (int) (price * noOfTkts * 1.4);
										} else if(diffDays >= 14 && diffDays < 21){
											price = (int) (price * noOfTkts * 1.2);
										} else {
											price = (int) (price * noOfTkts * 1);
										}
										
										pageContext.setAttribute("L1airFare", price);
										
										price = Integer.parseInt(L2airFare);
										noOfTkts = Integer.parseInt(request.getParameter("aTkts"));
										if(diffDays < 3){
											price = (int) (price * noOfTkts * 1.8);
										} else if(diffDays >= 3 && diffDays < 7){
											price = (int) (price * noOfTkts * 1.6);
										} else if(diffDays >= 7 && diffDays < 14){
											price = (int) (price * noOfTkts * 1.4);
										} else if(diffDays >= 14 && diffDays < 21){
											price = (int) (price * noOfTkts * 1.2);
										} else {
											price = (int) (price * noOfTkts * 1);
										}
										
										pageContext.setAttribute("L2airFare", price);
						%>	
			
			
						  <tr class="rowR<%= pageContext.getAttribute("count") %>">
						  	<%if(count == 1){ %>
						   	 	<td><input type="radio" name="travelBook2" checked value=<%= pageContext.getAttribute("count") %>></td>
						    <%} else { %>
						     	<td><input type="radio" name="travelBook2" value=<%= pageContext.getAttribute("count") %>></td>
						    <%} %>
						    <td class="airNameR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1airName") %><br><%= pageContext.getAttribute("L2airName") %></td> 
						    <td class="fNumberR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1fNumber") %><br><%= pageContext.getAttribute("L2fNumber") %></td>
						    <td class="depAirportR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1depAirport") %><br><%= pageContext.getAttribute("L2depAirport") %></td>
						    <td class="arrAirportR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1arrAirport") %><br><%= pageContext.getAttribute("L2arrAirport") %></td>
						    <td class="depTimeR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1depTime") %><br><%= pageContext.getAttribute("L2depTime") %></td>
						    <td class="travelTimeR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1travelTime") %><br><%= pageContext.getAttribute("L2travelTime") %></td>
						  	<td class="airFareR<%= pageContext.getAttribute("count")%>" ><%= pageContext.getAttribute("L1airFare") %><br><%= pageContext.getAttribute("L2airFare") %></td>
						   </tr>
			  
					  <%
					  				++count;
								}
							} catch (SQLException | ClassNotFoundException e) {
								e.printStackTrace();
							}	
						%>
					</table>			
				<%} %>
				
				<div class="bookbtn">
					<button id="bookTktsBtn" class="fullwidthbtn btn">Book</button>
				</div>
				</div>			
			</div>
		</section>
	</section>
	
	<script src="/FlightReservation/js/viewFlights.js"></script>
	
</body>
</html>