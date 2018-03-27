<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - View Revenue Info</title>
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
		<h1>Geek Managers - View Revenue Info</h1>
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
				<div class = "viewRevTable">
					<h2>Revenue Grouped by Flight</h2>	
					<table style="width:20%">
						 <tr>
						    <th>Airline Number</th> 
						    <th>Revenue</th>
						  </tr>
						<%
								
							String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
							try {
								
								String airNo = "", revenue1 = "", destCity = "", revenue2 = "", name = "", emailId = "", revenue3 = "";
								
								
								Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection(url, "admin", "database");
								Statement stmt = con.createStatement();
								String query = "";
								query = "Select concat(Airline_Id, '-', Flight_Id) as AirlineNumber, SUM(TotalFee) as Revenue " +
										"From ReservationDetails Group by Flight_Id, Airline_Id";
								ResultSet result = stmt.executeQuery(query);
								
								while(result.next()){
									airNo = result.getString(1);
									revenue1 = result.getString(2);
									
									pageContext.setAttribute("airNo", airNo);
									pageContext.setAttribute("revenue1", revenue1);
									%>
										<tr class="row">
										    <td> <%= pageContext.getAttribute("airNo") %> </td> 
										    <td> <%= pageContext.getAttribute("revenue1") %> </td>
									    </tr>
									<% 
								}
								
								%>
						</table>
						<br>
						<br>
						<h2>Revenue Grouped by Destination City</h2>				
						<table style="width:20%">
							 <tr>
							    <th>Destination City</th> 
							    <th>Revenue</th>
							  </tr>
									
									<%
									query = "Select ArrivalCity, SUM(TotalFee) as Revenue "+
											"From ReservationDetails Group by ArrivalCity";
									result = stmt.executeQuery(query);
									
									while(result.next()){
										destCity = result.getString(1);
										revenue2 = result.getString(2);
										
										pageContext.setAttribute("destCity", destCity);
										pageContext.setAttribute("revenue2", revenue2);
										
										%>
										<tr class="row">
										    <td> <%= pageContext.getAttribute("destCity") %> </td> 
										    <td> <%= pageContext.getAttribute("revenue2") %> </td>
									    </tr>
								<% 
									}
									
								%>
						</table>
						<br>
						<br>
						<h2>Revenue Grouped by Users</h2>		
						<table style="width:40%">
							 <tr>
						  	  <th>Name</th> 
						  	  <th>Email Address</th>
						  	  <th>Revenue</th>
						  	</tr>
								
								<%
									query = "Select concat(U.FirstName, ' ', U.LastName) as Name, U.EmailAddress, T.Revenue from " +
											"Users U, (Select R.Users_Id, SUM(RD.TotalFee) as Revenue From ReservationDetails RD, Reservations R " +
											"Where RD.Reservation_Id = R.Reservation_Id Group by R.Users_Id) T where U.Users_Id = T.Users_Id";
									result = stmt.executeQuery(query);
									
									while(result.next()){
										name = result.getString(1);
										emailId = result.getString(2);
										revenue3 = result.getString(3);
										
										pageContext.setAttribute("name", name);
										pageContext.setAttribute("emailId", emailId);
										pageContext.setAttribute("revenue3", revenue3);
										
								%>	
									<tr class="row">
									    <td> <%= pageContext.getAttribute("name") %> </td> 
									    <td> <%= pageContext.getAttribute("emailId") %> </td>
									    <td> <%= pageContext.getAttribute("revenue3") %> </td>
								  	</tr>
								<%
										}
									} catch (SQLException | ClassNotFoundException e) {
										e.printStackTrace();
									}	
								%>

						</table>				
					</div>
			</div>
		</section>
	</section>
	
</body>
</html>