<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Flights List</title>
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
		<h1>Geek Managers - View Flights List</h1>
	</header>
		<section class="content maincontainer">
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="viewCustomers">View Customers Info</a></li>
						<li><a href="viewFlightList">View Flights/Report</a></li>
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class = "viewFlightListTable">
					
					<li><a href="filterFlights?flights=all">List All Flights</a></li> <br>
					<li><a href="filterFlights?flights=active">Most Active Flights</a></li> <br>	
					
					<div class="flightNoform">
						<div class="row">
							<label id="flightNoError" class="error">&nbsp;</label>
							<label for="airlineNo"> Reservations by Airline Id : </label>
							<input type="text" name="airlineNo" id="airlineNo" placeholder="Airline Id (AA/BA/..)" />
							<label for="flightNo"> and Flight Id : </label>
							<input type="text" name="flightNo" id="flightNo" placeholder="Flight Number (1/2/..)" />
							<button id="filterFlightOnNos" class="fullwidthbtn btn right">Filter</button> <br><br>
						</div>
						
						<div class="row">
							<label id="flightCustError" class="error">&nbsp;</label>
							<label for="custName">Reservations  by Customer Full Name : </label>
							<input type="text" name="custName" id="custName" placeholder="Customer Full Name" />
							<button id="filterFlightOnCustName" class="fullwidthbtn btn right">Filter</button> <br><br>
						</div>
						
						<div class="row">
							<label id="flightAirportError" class="error">&nbsp;</label>
							<label for="airportName">View Flights by Airport Code : </label>
							<input type="text" name="airportName" id="airportName" placeholder="Airport Name (JFK/DFW/..)" />
							<button id="filterFlightOnAirportName" class="fullwidthbtn btn right">Filter</button> <br><br>
						</div>
						
						<li><a href="filterCustomers?filter=revenue">Customers with Most Revenue</a></li> <br>
						
						<div class="row">
							<label id="filterCustomersError" class="error">&nbsp;</label>
							<label for="airNo"> Customers who Booked seats in Airline Id : </label>
							<input type="text" name="airNo" id="airNo" placeholder="Airline Id (AA/BA/..)" />
							<label for="fltNo"> and Flight Id : </label>
							<input type="text" name="fltNo" id="fltNo" placeholder="Flight Number (1/2/..)" />
							<button id="filterCustomersOnAirportName" class="fullwidthbtn btn right">Filter</button> <br><br>
						</div>
						
						<li><a href="SummaryListing">Revenue generated - Grouped by Flight / Destination City / Customer</a></li> <br>
						
						<div class="row">
							<label id="filterMonthError" class="error">&nbsp;</label>
							<label for="month"> Sales Report for Month : </label>
							<select name="month" id="month"">
								<option value="1">Jan</option>
								<option value="2">Feb</option>
								<option value="3">Mar</option>
								<option value="4">Apr</option>
								<option value="5">May</option>
								<option value="6">Jun</option>
								<option value="7">Jul</option>
								<option value="8">Aug</option>
								<option value="9">Sep</option>
								<option value="10">Oct</option>
								<option value="11">Nov</option>
								<option value="12">Dec</option>
							</select>
							<label for="year"> and Year : </label>
							<input type="text" name="year" id="year" placeholder="Year (2018/..)" />
							<button id="filterCustomersOnMonth" class="fullwidthbtn btn right">Filter</button> <br><br>
						</div>
						
					</div>
				
				</div>				
			</div>
		</section>
	</section>
	
	
	<script src="/FlightReservation/js/viewFlightList.js"></script>
	
</body>
</html>