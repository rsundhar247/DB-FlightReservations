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
	<section class="container">
	<header>
		<h1>Geek Managers - View Flights List</h1>
	</header>
		<section class="content maincontainer">
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="viewCustomers">View Customers Info</a></li>
						<li><a href="viewFlightList">View Flights</a></li>
						<li><a href="getReport">Report</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class = "viewFlightListTable">
					<table style="width:100%">
					  <tr>
					  	<th>Airline Id</th>
					    <th>Airline Name</th>
					    <th>Flight Id</th> 
					    <th>Departure City</th>
					    <th>Departure Airport</th>
					    <th>Departure Time</th>
					    <th>Arrival City</th>
					    <th>Arrival Airport</th>
					    <th>Arrival Time</th>
					    <th>Seat Capacity</th>
					    <th>Economy Capacity</th>
					    <th>First Class Capacity</th>
					  </tr>
					  <tr>
					    <td>AA123</td>
					    <td>American Airlines</td> 
					    <td>A456</td>
					    <td>New Jersey</td>
					    <td>Newark</td>
					    <td>13:00</td>
					    <td>Berkley</td>
					    <td>AAA</td>
						<td>19:00</td>
						<td>153</td>
						<td>130</td>
						<td>23</td>
					  </tr>
					   <tr>
					    <td>BA123</td>
					    <td>British Airlines</td> 
					    <td>Q123</td>
					    <td>New York</td>
					    <td>LaGuardia</td>
					    <td>03:00</td>
					    <td>Dallas</td>
					    <td>FortWorth</td>
						<td>07:00</td>
						<td>546</td>
						<td>356</td>
						<td>190</td>
					  </tr>
					</table>				
				
				</div>				
			</div>
		</section>
	</section>
	
</body>
</html>