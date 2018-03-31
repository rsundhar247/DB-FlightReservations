<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*, java.util.Date, java.util.Enumeration" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - My Account</title>
<script src="/FlightReservation/js/library/jquery-1.11.1.min.js"></script>

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
		if(session.getAttribute("userType") == null || ! session.getAttribute("userType").equals("customer")) {
			response.sendRedirect("http://localhost:8080/FlightReservation/");
		}
	%>
	
	
	<section class="content">
	<header>
		<h1>Geek Users - My Account</h1>
	</header>
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
			
			<%
			if(session.getAttribute("userType") != null && session.getAttribute("userType").equals("customer"))	{
			String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, "admin", "database");
				Statement stmt = con.createStatement();
				
				String query = "Select u.FirstName, u.LastName, a.Address, a.City, a.Country, a.Zipcode from Users u Left Outer Join Address a" +
								" on u.Users_Id = a.Users_Id where lower(u.EmailAddress) ='" + ((String)session.getAttribute("EmailId")).toLowerCase() + "'";
				ResultSet result = stmt.executeQuery(query);
				
				String fName = "", lName = "", address = "", city = "", country = "", zipCode = "";
				
				if(result.next()){
					fName = result.getString(1);
					lName = result.getString(2);
					address = result.getString(3);	
					city = result.getString(4);
					country = result.getString(5);
					zipCode = result.getString(6); 
				}
				
				pageContext.setAttribute("fName", fName);
				pageContext.setAttribute("lName", lName);
				pageContext.setAttribute("address", address);
				pageContext.setAttribute("city", city);
				pageContext.setAttribute("country", country);
				pageContext.setAttribute("zipCode", zipCode);
				
				
				query = "Select NickName, CardNumber, CVV, ExpirationDate from CardDetails where Users_Id in("+
							"Select Users_Id from Users where lower(EmailAddress) ='" + ((String)session.getAttribute("EmailId")).toLowerCase() + "')";
				
				result = stmt.executeQuery(query);
				
				String nickName = "", ccNumber = "", ccCVV = "", ccExp = "";
				
				if(result.next()){
					nickName = result.getString(1);
					ccNumber = result.getString(2);
					ccCVV = result.getString(3);	
					ccExp = result.getString(4);
				}
				
				pageContext.setAttribute("nickName", nickName);
				pageContext.setAttribute("ccNumber", ccNumber);
				pageContext.setAttribute("ccCVV", ccCVV);
				pageContext.setAttribute("ccExp", ccExp);
				
				
			} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			}

			%>
			
			<div class="row rightNav">
				<input type="hidden" name="sessionEmail" id="sessionEmail" value=<%= session.getAttribute("EmailId") %>>
				<div class="ccDetails">
					<div class="infoarea">
						<h2 class="info">Update Credit Card Details</h2>
						<p class="error" id="changeCCMsg"></p>
					 </div>
					 
					 <div class="changeCCform myAcntForm">
						<div class="row">
							<label id="CCError" class="error">&nbsp;</label>
							<%if(pageContext.getAttribute("nickName") != null && ! pageContext.getAttribute("nickName").equals("")){ %>
								<input type="text" name="ccNickName" id="ccNickName" value=<%= pageContext.getAttribute("nickName") %> />
							<%} else{ %>
								<input type="text" name="ccNickName" id="ccNickName" placeholder="Nick Name" />
							<%} %>
							
							<%if(pageContext.getAttribute("ccNumber") != null && ! pageContext.getAttribute("ccNumber").equals("")){ %>
								<input type="number" name="ccNumber" id="ccNumber" value=<%= pageContext.getAttribute("ccNumber") %> />
							<%} else{ %>
								<input type="number" name="ccNumber" id="ccNumber" placeholder="Credit Card Number" />
							<%} %>
							
							<%if(pageContext.getAttribute("ccCVV") != null && ! pageContext.getAttribute("ccCVV").equals("")){ %>
								<input type="password" name="ccCVV" id="ccCVV" value=<%= pageContext.getAttribute("ccCVV") %> />
							<%} else{ %>
								<input type="password" name="ccCVV" id="ccCVV" placeholder="CVV" />
							<%} %>
							
							<%if(pageContext.getAttribute("ccExp") != null && ! pageContext.getAttribute("ccExp").equals("")){ %>
								<input type="text" name="ccExp" id="ccExp" value=<%= pageContext.getAttribute("ccExp") %> />
							<%} else{ %>
								<input type="text" name="ccExp" id="ccExp" placeholder="Expiration Date mm/yy" />
							<%} %>
						</div>
						<button id="changeCCBtn" class="fullwidthbtn btn right">Update</button>
					</div>
				</div>
				
				<div class="changeEmail">
					<div class="infoarea">
						<h2 class="info">Change Email Address</h2>
						<p class="error" id="changeEmailMsg"></p>
					 </div>
					 
					 <div class="changeEmailform myAcntForm">
						<div class="row">
							<label id="emailError" class="error">&nbsp;</label>
							<input type="text" name="oldEmailId" id="oldEmailId" value=<%= session.getAttribute("EmailId") %> readonly />
							<input type="text" name="newEmailId" id="newEmailId" placeholder="New Email Id" />
							<input type="password" name="userPwd" id="userPwd" placeholder="Password" />
						</div>
						<button id="changeEmailBtn" class="fullwidthbtn btn right">Change</button>
					</div>
				</div>
				
				<div class="changePassword">
					<div class="infoarea">
						<h2 class="info">Change Password</h2>
						<p class="error" id="changePwdMsg"></p>
					 </div>
					 
					 <div class="changePwdform myAcntForm">
						<div class="row">
							<label id="pwdError" class="error">&nbsp;</label>
							<input type="text" name="emailId" id="emailId" value=<%= session.getAttribute("EmailId") %> readonly />
							<input type="password" name="curUserPwd" id="curUserPwd" placeholder="Current Password" />
							<input type="password" name="newUserPwd" id="newUserPwd" placeholder="New Password" />
						</div>
						<button id="changePwdBtn" class="fullwidthbtn btn right">Change</button>
					</div>
				</div>
				
				<div class="changeAddress">
					<div class="infoarea">
						<h2 class="info">Change Billing Address</h2>
						<p class="error" id="changeAddressMsg"></p>
					 </div>
					 
					 <div class="changeAddressform myAcntForm">
						<div class="row">
							<label id="addressError" class="error">&nbsp;</label>
							<%if(pageContext.getAttribute("fName") != null && ! pageContext.getAttribute("fName").equals("")){ %>
								<input type="text" name="fName" id="fName" value=<%= pageContext.getAttribute("fName") %> />
							<%} else{ %>
								<input type="text" name="fName" id="fName" placeholder="First Name" />
							<%} %>
							
							<%if(pageContext.getAttribute("lName") != null && ! pageContext.getAttribute("lName").equals("")){ %>
								<input type="text" name="lName" id="lName" value=<%= pageContext.getAttribute("lName") %> />
							<%} else{ %>
								<input type="text" name="lName" id="lName" placeholder="Last Name" />
							<%} %>
							
							<%if(pageContext.getAttribute("address") != null && ! pageContext.getAttribute("address").equals("")){ %>
								<input type="text" name="address" id="address" value=<%= pageContext.getAttribute("address") %> />
							<%} else{ System.out.println("7"); %>
								<input type="text" name="address" id="address" placeholder="Address" />
							<%} %>
							
							<%if(pageContext.getAttribute("city") != null && ! pageContext.getAttribute("city").equals("")){ %>
								<input type="text" name="city" id="city" value=<%= pageContext.getAttribute("city") %> />
							<%} else{ %>
								<input type="text" name="city" id="city" placeholder="City" />
							<%} %>
							
							<%if(pageContext.getAttribute("country") != null && ! pageContext.getAttribute("country").equals("")){ %>
								<input type="text" name="country" id="country" value=<%= pageContext.getAttribute("country") %> />
							<%} else{ %>
								<input type="text" name="country" id="country" placeholder="Country" />
							<%} %>
							
							<%if(pageContext.getAttribute("zipCode") != null && ! pageContext.getAttribute("zipCode").equals("")){ %>
								<input type="text" name="zipCode" id="zipCode" value=<%= pageContext.getAttribute("zipCode") %> />
							<%} else{ %>
								<input type="text" name="zipCode" id="zipCode" placeholder="ZipCode" />
							<%}
							} %>
						</div>
						<button id="changeAddressBtn" class="fullwidthbtn btn right">Change</button>
					</div>
				</div>
			</div>
		</section>
	

	<script src="/FlightReservation/js/myAccount.js"></script>
	
</body>
</html>