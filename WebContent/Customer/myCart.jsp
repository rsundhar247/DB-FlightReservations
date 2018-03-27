<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - Your Cart</title>
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
			<h1>Geek Users Your Cart</h1>
		</header>
		<section class="content maincontainer">
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="bookYourTravel">Book your travel</a></li>
						<li><a href="myAccount">My account</a></li>
						<li><a href="myBookings">My bookings</a></li>
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class="confirmTktsArea">
					<div class="dispTktsArea">
						You are Booking American Airlines - Between New York and Chicago - 20 Mar - 09:00 to 17:00<br><br><br><br><br><br><br><br>
					</div>
					
					<div class="ccPaymentArea">
						<label for="ccPaymentForm">Enter Credit Card Information</label><br>
						<div class="ccPaymentForm">
							<label for="ccNumber">Credit Card Number</label>
							<input type="number" name="ccNumber" id="ccNumber" placeholder="Credit Card Number" />
							<label for="ccExp">Expiration Date</label>
							<input type="text" name="ccExp" id="ccExp" placeholder="Exp - MM/YY" />
							<label for="ccCVV">CVV</label>
							<input type="number" name="ccCVV" id="ccCVV" placeholder="CVV Number" />
							<label for="ccName">CC Holder Name</label>
							<input type="text" name="ccName" id="ccName" placeholder="Name" />
							
							<div class="bookbtn">
								<button id="confirmTkts" class="fullwidthbtn btn">Book</button>
							</div>
							
						</div>
					</div>
				</div>
				
			</div>
		</section>
	</section>
</body>
</html>