<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
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

	<%
		if(session.getAttribute("userType") == null || ! session.getAttribute("userType").equals("manager")) {
			response.sendRedirect("http://localhost:8080/FlightReservation/");
		}
	%>
	
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
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class = "viewFlightsTable">
					<table style="width:100%">
						 
							<%
									
								String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
								try {
									String param = request.getParameter("filter");
									Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection(url, "admin", "database");
									Statement stmt = con.createStatement();
									String query = "";
									if(param.equals("revenue")){
										query = "Select u.FirstName, u.LastName, u.EmailAddress, t.Revenue from Users u, " +
												"(SELECT Users_Id, SUM(TotalFee) AS Revenue FROM Reservations GROUP BY Users_Id) t " +
												"where u.Users_id = t.Users_id order by t.Revenue desc";
										%>
											<tr>
											    <th>First Name</th> 
											    <th>Last Name</th>
											    <th>Email Address</th>
											    <th>Revenue</th>
											  </tr>
										<%
									} else if(param.equals("flight")){
										String airNo = request.getParameter("airNo");
										String fltNo = request.getParameter("fltNo");
										
										query = "Select U.FirstName, U.LastName, U.EmailAddress, concat(RD.Airline_Id, '-', RD.Flight_Id) as AirlineNo from " +
												"Users U, ReservationDetails RD, Reservations R " +
												"where U.Users_id = R.Users_id and R.Users_Id = U.Users_Id and RD.Flight_Id =" + fltNo + " and RD.Airline_Id = '" + airNo + "'";
										
										%>
										<tr>
										    <th>First Name</th> 
										    <th>Last Name</th>
										    <th>Email Address</th>
										    <th>Airline Number</th>
										  </tr>
									<%
									}
									
									ResultSet result = stmt.executeQuery(query);
									
									String fName = "", lName = "", emailId = "", revAirNo = "";
									while(result.next()){
										fName = result.getString(1);
										lName = result.getString(2);
										emailId = result.getString(3);
										revAirNo = result.getString(4);
										
										pageContext.setAttribute("fName", fName);
										pageContext.setAttribute("lName", lName);
										pageContext.setAttribute("emailId", emailId);
										pageContext.setAttribute("revAirNo", revAirNo);
										
							%>	
								<tr class="row">
								    <td> <%= pageContext.getAttribute("fName") %> </td> 
								    <td> <%= pageContext.getAttribute("lName") %> </td>
								    <td> <%= pageContext.getAttribute("emailId") %> </td>
								    <td> <%= pageContext.getAttribute("revAirNo") %> </td>
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