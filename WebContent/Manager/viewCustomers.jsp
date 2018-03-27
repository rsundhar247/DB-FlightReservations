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
						<li><a href="viewFlightList">View Flights/Report</a></li>
						<li><a href="/FlightReservation/">Log Off</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class="infoarea">
					<h2 class="info">View Customers</h2>
					<p class="error" id="updateCustMsg"></p>
				 </div>
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
							<%
									
								String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
								try {
									Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection(url, "admin", "database");
									Statement stmt = con.createStatement();
									String query = "Select U.Users_Id, FirstName, LastName, EmailAddress, Password, PhoneNumber, Address, City, Country, Zipcode " +
													"from Users U, Address A where U.Users_Id = A.Users_Id and U.UserType = 'customer'";
									ResultSet result = stmt.executeQuery(query);
									
									String usersId = "", fName = "", lName = "", emailId = "", password = "", phoneNumber = "", address = "";
									String city = "", country = "", zipCode = "";
									int count = 1;
									while(result.next()){
										usersId = result.getString(1);
										fName = result.getString(2);
										lName = result.getString(3);
										emailId = result.getString(4);
										password = result.getString(5);
										phoneNumber = result.getString(6);
										address = result.getString(7); 
										city = result.getString(8);
										country = result.getString(9);
										zipCode = result.getString(10);	
										
										pageContext.setAttribute("usersId", usersId);
										pageContext.setAttribute("fName", fName);
										pageContext.setAttribute("lName", lName);
										pageContext.setAttribute("emailId", emailId);
										pageContext.setAttribute("password", password);
										pageContext.setAttribute("phoneNumber", phoneNumber);
										pageContext.setAttribute("address", address);
										pageContext.setAttribute("city", city);
										pageContext.setAttribute("country", country);
										pageContext.setAttribute("zipCode", zipCode);
										pageContext.setAttribute("count", count);
										
							%>	
								<tr class="row<%= pageContext.getAttribute("count") %>">
									<%
										if(count == 1){
									%>
								    	<td> <input type="radio" name="editCust" checked value="<%= pageContext.getAttribute("count") %>"> </td>
								    <%
										} else {
									%>
										<td> <input type="radio" name="editCust" value="<%= pageContext.getAttribute("count") %>"> </td>
									<%
										}
									%>
								    <td class="usersId<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("usersId") %> </td>
								    <td class="fName<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("fName") %> </td> 
								    <td class="lName<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("lName") %> </td>
								    <td class="emailId<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("emailId") %> </td>
								    <td class="password<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("password") %> </td>
								    <td class="phoneNumber<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("phoneNumber") %> </td>
								    <td class="address<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("address") %> </td>
								    <td class="city<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("city") %> </td>
									<td class="country<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("country") %> </td>
									<td class="zipCode<%= pageContext.getAttribute("count") %>"> <%= pageContext.getAttribute("zipCode") %> </td>
							  	</tr>
							<%
										++count;
									}
								} catch (SQLException | ClassNotFoundException e) {
									e.printStackTrace();
								}	
							%>

			</table>				
			</div>
			<div class="bookbtn">
					<button id="addCustBtn" class="fullwidthbtn btn">Add</button>   <button id="editCustBtn" class="fullwidthbtn btn">Edit</button>  <button id="deleteCustBtn" class="fullwidthbtn btn">Delete</button>
			</div>
		
			</div>
		</section>
	</section>
	
	<script src="/FlightReservation/js/viewCustomer.js"></script>
	
</body>
</html>