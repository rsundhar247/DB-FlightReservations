<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Geek Reservations - Flights - Domestic & International</title>
<link rel="stylesheet" href="css/custom.css" />
<script src="js/library/jquery-1.11.1.min.js"></script>
<style>
html {
	background: linear-gradient(#11bab4 ,#fff) no-repeat;
}
</style>
</head>
<body>

	<section class="container">
		<header>
			<h1>Geek Users Sign-In or Register</h1>
		</header>
		<section class="content">
			<div class="row">
				<div class="loginarea">
					<div class="infoarea">
						<h2 class="info">Login to our Geek Store</h2>
						<p>Enter username and password to log on</p>
						<p class="error" id="logInErrorMsg"></p>
						<p id="logoutMsg"></p>
					 </div>
					 <div class="loginform">
						<div class="row">
							<label id="emailError" class="error">&nbsp;</label>
							<input type="text" name="emailId" id="emailId" placeholder="Email Id" />
							<input type="password" name="userPwd" id="userPwd" placeholder="Password" />
						</div>
						<button id="loginBtn" class="fullwidthbtn btn">Log In</button>
						
						<form name="forgotPwdForm" action="ForgotPassword" method="">
							<div class="row">
								<a class="link" href="#">Forgot Password?</a>
							</div>
						</form>
					</div>
				</div>
				<div class="signupArea">
					<div class="infoarea">
						<h2 class="">Sign up Now</h2>
						<p>Instant access to awesome deals</p>
						<p class="error" id="regErrorMsg"></p>
					</div>
					<div class="signUpForm">
						<label id="regError" class="error">&nbsp;</label>
						<div class="row"><input type="text" id="custFirstname" name="custFirstname" placeholder="First Name" required/></div>
						<div class="row"><input type="text" id="custLastname" name="custLastname" placeholder="Last Name" required/></div>
						<div class="row"><input type="email" id="custemail" name="custemail" placeholder="E-Mail" required/></div>
						<div class="row"><input type="password" id="userpwd" name="userpwd" placeholder="Password" required/></div>
						<div class="row"><input type="password" id="userpwd_confirm" name="userpwd_confirm" placeholder="Confirm Password" required/></div>
						<div class="row"><input type="number" id="phone" name="phone" placeholder="Phone Number" min = "1000000000" max = "9999999999" required/></div>
						<button id="signUpBtn" class="btn fullwidthbtn">Register</button>
					</div>
				</div>
			</div>
		</section>
	</section>


	<script src="js/login.js"></script>
</body>
</html>