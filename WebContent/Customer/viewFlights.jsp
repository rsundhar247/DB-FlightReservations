<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Flights</title>
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
</style>
</head>
<body>
	<section class="container">
		<header>
			<h1>Geek Managers - View Flights</h1>
		</header>
		<section class="content maincontainer">
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
			<div class = "viewFlightsTable">
				<label> Flights to Destination</label><br>
				<table style="width:100%">
				  <tr>
				    <th>Airline Name</th> 
				    <th>Airline Code</th>
				    <th>Departure City</th>
				    <th>Arrival City</th>
				    <th>Departure Time</th>
				    <th>Arrival Time</th>
				    <th>Travel Time</th>
				    <th>Select</th>
				  </tr>
				  <tr>
				    <td>American Airlines</td> 
				    <td>AA123</td>
				    <td>New York</td>
				    <td>London</td>
				    <td>21:45</td>
				    <td>06:45</td>
				    <td>09:00</td>
					<td><input type="radio" name="travelBook1" checked id="travelBook11" value="1"></td>
				  </tr>
				  <tr>
				    <td>British Airlines</td> 
				    <td>BA143</td>
				    <td>London</td>
				    <td>Chicago</td>
				    <td>08:45</td>
				    <td>15:45</td>
				    <td>07:00</td>
					<td><input type="radio" name="travelBook1" id="travelBook12" value="2"></td>
				  </tr>
				</table>	
				
				<br>
				<br>
				<br>
				<br>
				
				<label> Return Flights</label><br>
				<table style="width:100%">
				  <tr>
				    <th>Airline Name</th> 
				    <th>Airline Code</th>
				    <th>Departure City</th>
				    <th>Arrival City</th>
				    <th>Departure Time</th>
				    <th>Arrival Time</th>
				    <th>Travel Time</th>
				    <th>Select</th>
				  </tr>
				  <tr>
				    <td>American Airlines</td> 
				    <td>AA123</td>
				    <td>New York</td>
				    <td>London</td>
				    <td>21:45</td>
				    <td>06:45</td>
				    <td>09:00</td>
					<td><input type="radio" name="travelBook2" checked id="travelBook21" value="1"></td>
				  </tr>
				  <tr>
				    <td>British Airlines</td> 
				    <td>BA143</td>
				    <td>London</td>
				    <td>Chicago</td>
				    <td>08:45</td>
				    <td>15:45</td>
				    <td>07:00</td>
					<td><input type="radio" name="travelBook2" id="travelBook22" value="2"></td>
				  </tr>
				</table>			
				
				
				<div class="bookbtn">
					<button id="bookTktsBtn" class="fullwidthbtn btn">Book</button>
				</div>
				</div>			
			</div>
		</section>
	</section>
	
	<script src="js/viewFlights.js"></script>
	
</body>
</html>