<!DOCTYPE html>
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
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class="bookTktsArea">
					<div class="bookTktsform">
						<div class = "row">
							<label id="bookTktsError" class="error">&nbsp;</label>
						</div>
						<div class="travelType">
							<input type="radio" name="travelWay" checked id="travelWay1" value="oneWay"> <label for="travelWay1">One Way</label>
							<input type="radio" name="travelWay" id="travelWay2" value="roundTrip"> <label for="travelWay2">Round Trip</label>
						</div>
						<div class="travelForm">
							<div class="citySelect">
								<input type="text" name="originCity" id="originCity" placeholder="Origin Airport Code (JFK/..)" />
								<input type="text" name="destinationCity" id="destinationCity" placeholder="Destination Airport Code (EWR/..)" />
							</div>
							<div class="dateSelect">
								<label for="depDate" class="date">Departure Date :</label> <input type="date" name="depDate" id="depDate"> <br/>
								<label for="returnDate" class="date rDate" id="rDateLabel"> Return Date :</label> <input type="date" name="returnDate" id="returnDate" class="rDate">
							</div>
							<div class="classType">
								<label for="prefClass" class="date">	Preferred Class : </label>
								<select name="prefClass" id="prefClass">
									<option value="Economy">Economy</option>
									<option value="First Class">First Class</option>
								</select>
								<label for="adultTkts">Number of Tickets : </label>
							<select name="adultTkts" id="adultTkts"">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>

							</div>
							<div class="bookbtn">
								<button id="bookTkts" class="fullwidthbtn btn">Book</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</section>
	
	<script src="/FlightReservation/js/bookYourTravel.js"></script>
	
</body>
<script>
$(document).ready(function(){
	$("input[name='travelWay']").on("click",function(){
		var trType=$(this).val();
		if(trType=='roundTrip')
			$("#returnDate,#rDateLabel").removeClass('rDate');
		else 
			$("#returnDate,#rDateLabel").addClass('rDate');
	});
});
</script>
</html>