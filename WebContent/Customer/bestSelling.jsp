<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - Book Your Travel</title>
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
			<h1>Geek Users Book Your Travel</h1>
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
				<div class="bestSellingArea">
					<div class="bestSellingInfo">
						<br><br><label id="bestSellingError" class="error">&nbsp;</label><br><br><br><br>
						<div class="row">
							<label for="bookId"> Search by Departure and Arrival City : </label>
							<% if(request.getParameter("dCity") != null){ %>
								<input type="text" name="dCity" id="dCity" value= <%= request.getParameter("dCity") %> />
							<%} else{ %>
								<input type="text" name="dCity" id="dCity" placeholder="Departure Airport (JFK/..)" />
							<%} %>
							<% if(request.getParameter("rCity") != null){ %>
								<input type="text" name="rCity" id="rCity" value= <%= request.getParameter("rCity") %> />
							<%} else{ %>
								<input type="text" name="rCity" id="rCity" placeholder="Arrival Airport (FRA/..)" />
							<%} %>
							<button id="filterBestSelling" class="fullwidthbtn btn right">Filter</button> <br><br>
						</div>
					</div>
				
					<div class = "bestSellingList">
					
							<table style="width:100%">
							  <tr>
							    <th>Airline Name</th>
							    <th>Airline Code</th> 
							    <th>Departure City</th>
							    <th>Departure Time</th>
							    <th>Arrival City</th>
							    <th>Travel Time</th>
							  </tr>
						<%
					String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
					try {
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "admin", "database");
						Statement stmt = con.createStatement();
						String query = "Select AI.AirlineName, concat(FL.Airline_Id, '-', FL.Flight_Id) as AirlineCode, FL.DepartureCity, " +
								"TIME_FORMAT(FL.DepartureTime, '%h:%i%p') as DepartureTime, FL.ArrivalCity, FL.TravelTime, T1.Count FROM " + 
								"Flights FL, Airlines AI, (SELECT Airline_id, Flight_Id, COUNT(Airline_id) as Count " + 
								"FROM ReservationDetails GROUP BY Airline_Id, Flight_Id ORDER BY Count desc) T1 " +
								"WHERE  FL.Flight_Id = T1.Flight_Id and FL.Airline_Id = T1.Airline_Id and AI.Airline_Id = FL.Airline_Id";
								
						if(request.getParameter("dCity") != null && !request.getParameter("dCity").equals("")) {
							query += " and FL.DepartureAirport = '" + request.getParameter("dCity") +"'";
						}
						
						if(request.getParameter("rCity") != null && !request.getParameter("rCity").equals("")) {
							query += " and FL.ArrivalAirport = '" + request.getParameter("rCity") +"'";
						}
						
						ResultSet result = stmt.executeQuery(query);
						String airName = "", airCode = "", depCity = "", depTime = "", arrCity = "", travelTime = "", count = "";
						
						while(result.next()){
							airName = result.getString(1);
							airCode = result.getString(2);
							depCity = result.getString(3);
							depTime = result.getString(4);
							arrCity = result.getString(5);
							travelTime = result.getString(6);
							count = result.getString(7); 
							
							
							pageContext.setAttribute("airName", airName);
							pageContext.setAttribute("airCode", airCode);
							pageContext.setAttribute("depCity", depCity);
							pageContext.setAttribute("depTime", depTime);
							pageContext.setAttribute("arrCity", arrCity);
							pageContext.setAttribute("travelTime", travelTime);
							pageContext.setAttribute("count", count);
					%>
					
					<tr class="row">
					    <td class="airName" align="center"><%= pageContext.getAttribute("airName") %></td> 
					    <td class="airCode" align="center" ><%= pageContext.getAttribute("airCode") %></td>
					    <td class="depCity" align="center" ><%= pageContext.getAttribute("depCity") %></td>
					    <td class="depTime" align="center" ><%= pageContext.getAttribute("depTime") %></td>
					    <td class="arrCity" align="center" ><%= pageContext.getAttribute("arrCity") %></td>
					    <td class="travelTime" align="center" ><%= pageContext.getAttribute("travelTime") %></td>
					  </tr>
							  
			<%
					}
						
						
				} catch (SQLException | ClassNotFoundException e) {
					e.printStackTrace();
				}
			%>
					</div>
				
				</div>
			</div>
		</section>
	</section>
			
	<script>
	$(document).ready(function(){
		$('#filterBestSelling').on("click", function(){
			var dCity = $("#dCity").val();
			var rCity = $("#rCity").val();
			
			var param = "";
			if(dCity != ""){
				param += "dCity="+dCity;
			}
			if(rCity != "" ){
				if(param == ""){
					param += "rCity="+rCity;
				} else{
					param += "&rCity="+rCity;
				}
			}
	        window.location = "http://localhost:8080/FlightReservation/customer/bestSelling?"+param;
		});
	});
	</script>
	
</body>
</html>