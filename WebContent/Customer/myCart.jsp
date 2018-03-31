<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - Your Cart</title>
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
			<h1>Geek Users Your Cart</h1>
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
				<input type="hidden" name="sessionEmail" id="sessionEmail" value=<%= session.getAttribute("EmailId") %>>
				<input type="hidden" name="resId" id="resId" value=<%= request.getParameter("resId") %>>
				
				<div class="confirmTktsArea">
					<div class="dispTktsArea">
						<%
							String resId = request.getParameter("resId");
							String[] resIds = resId.split(",");
							
						
							String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
							try {
								Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection(url, "admin", "database");
								Statement stmt = con.createStatement();
								
								for(int i=0; i<resIds.length; i++) {
									String query = "Select AR.AirlineName, concat(RD.Airline_Id, '-', RD.Flight_Id), R.DepartureCity, R.FinalDestinationCity, " + 
											"DATE(Date_Of_Flying) from Reservations R, ReservationDetails RD, Airlines AR " + 
											"where R.Reservation_Id = RD.Reservation_Id and AR.Airline_Id = RD.Airline_Id and R.Reservation_Id=" + resIds[i];
									ResultSet result = stmt.executeQuery(query);
									
									String airName = "", airCode = "", dCity = "", aCity = "", dateOfFlying = "";
									
									if(result.next()){
										airName = result.getString(1);
										airCode = result.getString(2);
										dCity = result.getString(3);	
										aCity = result.getString(4);
										dateOfFlying = result.getString(5);
									}
									
									pageContext.setAttribute("airName", airName);
									pageContext.setAttribute("airCode", airCode);
									pageContext.setAttribute("dCity", dCity);
									pageContext.setAttribute("aCity", aCity);
									pageContext.setAttribute("dateOfFlying", dateOfFlying);
						%>
						
							<label>You are Traveling with&nbsp;&nbsp;&nbsp;<%= pageContext.getAttribute("airName") %> <%= pageContext.getAttribute("airCode") %>
									- From &nbsp;&nbsp;&nbsp;<%= pageContext.getAttribute("dCity") %>&nbsp;&nbsp;&nbsp;To&nbsp;&nbsp;&nbsp;<%= pageContext.getAttribute("aCity") %>
									&nbsp;&nbsp;&nbsp;on&nbsp;&nbsp;&nbsp;<%= pageContext.getAttribute("dateOfFlying") %><br><br></label>
						<%						
								}
							} catch (SQLException | ClassNotFoundException e) {
								e.printStackTrace();
							}
			
						%>
				
						
					</div>
					
					<div class="ccPaymentArea">
						<h2>Enter Credit Card Information you saved in My Account Section</h2><br>
						<div class="ccPaymentForm">
							<div class = "row">
								<label id="bookTktsError" class="error">&nbsp;</label>
							</div>
							<label for="ccNumber">Credit Card Number</label>
							<input type="number" name="ccNumber" id="ccNumber" placeholder="Credit Card Number" />
							<label for="ccExp">Expiration Date</label>
							<input type="text" name="ccExp" id="ccExp" placeholder="Exp - MM/YY" />
							<label for="ccCVV">CVV</label>
							<input type="password" name="ccCVV" id="ccCVV" placeholder="CVV Number" />
							
							<div class="bookbtn">
								<button id="confirmTktsBtn" class="fullwidthbtn btn">Book</button>
							</div>
							
						</div>
					</div>
				</div>
				
			</div>
		</section>
	</section>
	
	<script>
	
	$(document).ready(function(){
		$('#confirmTktsBtn').on("click", function(){

			var ccNumber = $("#ccNumber").val();
			var ccExp = $("#ccExp").val();
			var ccCVV = $("#ccCVV").val();
			var sessionEmail = $("#sessionEmail").val();
			var resId = $("#resId").val();
			
			if(!ccNumber){
				$('.ccPaymentForm #bookTktsError').text("Credit Card Number is mandatory");
				return false;
			} else {
				$('.ccPaymentForm #bookTktsError').text("");
			}
			
			if(!ccExp){
				$('.ccPaymentForm #bookTktsError').text("Expiration Date is mandatory");
				return false;
			} else {
				$('.ccPaymentForm #bookTktsError').text("");
			}
			
			if(!ccCVV){
				$('.ccPaymentForm #bookTktsError').text("CVV is mandatory");
				return false;
			} else {
				$('.ccPaymentForm #bookTktsError').text("");
			}
			
			$.ajax({
		        type: "POST",
		        url: "MyCartServlet",
		        data: { 
		        	ccNumber: ccNumber,
		        	ccExp: ccExp,
		        	ccCVV: ccCVV,
		        	sessionEmail: sessionEmail,
		        	resId: resId
		        },
		        success: function(data){
		        	if(data == "Paid"){
		        		window.location = "http://localhost:8080/FlightReservation/customer/myBookings?resId="+resId;
		        	} else{
	        			document.getElementById("bookTktsError").innerHTML = "Payment Declined";
	        		}
		        }
			});
			
		});
	});
	</script>
</body>
</html>