<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Customers Info</title>
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
		<h1>Geek Managers - View Customers Info</h1>
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
				<div class = "viewCustomersTable">
				<table style="width:100%">
			  <tr>
			  	<th>Select</th>
			    <th>User Id</th>
			    <th>First Name</th> 
			    <th>Last Name</th>
			    <th>Email Address</th>
			    <th>Password</th>
			    <th>Phone Number</th>
			    <th>Address</th>
			    <th>City</th>
			    <th>Country</th>
			    <th>Zip Code</th>
			  </tr>
			  <tr>
			    <td><input type="radio" name="editCust" checked id="editCust1" value="1"></td>
			    <td>12345</td>
			    <td>John</td> 
			    <td>Winchester</td>
			    <td>john.win@gmail.com</td>
			    <td>London</td>
			    <td>1234567890</td>
			    <td>Times Square, NYC</td>
			    <td>NY</td>
				<td>USA</td>
				<td>78965</td>
			  </tr>
			  <tr>
			  	<td><input type="radio" name="editCust" id="editCust2" value="2"></td>
			    <td>98765</td>
			    <td>Marie</td> 
			    <td>Winchester</td>
			    <td>marie.win@gmail.com</td>
			    <td>Chicago</td>
			    <td>9876543210</td>
			    <td>Park Street, Los Angeles</td>
			    <td>CA</td>
				<td>USA</td>
				<td>78345</td>
			  </tr>
			</table>				
			</div>
			<div class="bookbtn">
					<button id="editCustBtn" class="fullwidthbtn btn">Edit</button>
			</div>
				
			</div>
		</section>
	</section>
	
	<script src="/FlightReservation/js/viewCustomer.js"></script>
	
</body>
</html>