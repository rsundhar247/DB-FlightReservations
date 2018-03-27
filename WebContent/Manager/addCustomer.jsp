<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Managers - Add Customer</title>
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
		if(session.getAttribute("userType") == null || ! session.getAttribute("userType").equals("manager")) {
			response.sendRedirect("http://localhost:8080/FlightReservation/");
		}
	%>
	
	
	<section class="container">
		<header>
			<h1>Geek Managers - Add Customer</h1>
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
				<div class="infoarea">
					<h2 class="info">Add New Customer</h2>
					<p class="error" id="addCustMsg"></p>
				 </div>
			
							
				<div class = "row">
					<label for="fName"> First Name </label>
					<input type="text" name="fName" id="fName" placeholder="First Name"><br><br>
					<label for="lName"> Last Name </label>
					<input type="text" name="lName" id="lName" placeholder="Last Name"><br><br>
					<label for="emailId"> Email Address </label>
					<input type="text" name="emailId" id="emailId" placeholder="Email Address"><br><br>
					<label for="pass"> Password </label>
					<input type="text" name="pass" id="pass" placeholder="Password"><br><br>
					<label for="phNo"> Phone Number </label>
					<input type="text" name="phNo" id="phNo" placeholder="Phone Number"><br><br>
					<label for="address"> Address </label>
					<input type="text" name="address" id="address" placeholder="Address"><br><br>
					<label for="city"> City </label>
					<input type="text" name="city" id="city" placeholder="City"><br><br>
					<label for="country"> Country </label>
					<input type="text" name="country" id="country" placeholder="Country"><br><br>
					<label for="zCode"> Zip Code </label>
					<input type="text" name="zCode" id="zCode" placeholder="Zip Code"><br><br>
				</div>
				<button id="addBtn" class="fullwidthbtn btn">Add</button>
			</div>
		</section>
	</section>
	
	<script src="/FlightReservation/js/viewCustomer.js"></script>
</body>
</html>