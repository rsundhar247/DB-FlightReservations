<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - My Account</title>
<script src="js/library/jquery-1.11.1.min.js"></script>

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
	<section class="content">
	<header>
		<h1>Geek Users - My Account</h1>
	</header>
			<div class="leftnav">
				<nav>
					<ul>
						<li><a href="bookYourTravel">Book your travel</a></li>
						<li><a href="myAccount">My account</a></li>
						<li><a href="myBookings">My bookings</a></li>
					</ul>
				</nav>
			</div>
			<div class="row rightNav">
				<div class="changeEmail">
					<div class="infoarea">
						<h2 class="info">Change Email Address</h2>
						<p class="error" id="changeEmailMsg"></p>
					 </div>
					 
					 <div class="changeEmailform myAcntForm">
						<div class="row">
							<label id="emailError" class="error">&nbsp;</label>
							<input type="text" name="oldEmailId" id="oldEmailId" placeholder="Old Email Id" />
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
							<input type="text" name="emailId" id="emailId" placeholder="Email Id" />
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
							<input type="text" name="fName" id="fName" placeholder="First Name" />
							<input type="text" name="lName" id="lName" placeholder="Last Name" />
							<input type="text" name="address" id="address" placeholder="Address" />
							<input type="text" name="city" id="city" placeholder="City" />
							<input type="text" name="country" id="country" placeholder="Country" />
							<input type="text" name="zipCode" id="zipCode" placeholder="ZipCode" />
						</div>
						<button id="changeAddressBtn" class="fullwidthbtn btn right">Change</button>
					</div>
				</div>
				
			</div>
		</section>
	

	<script src="js/myAccount.js"></script>
	
</body>
</html>