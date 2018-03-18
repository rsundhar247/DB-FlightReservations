$(document).ready(function(){
	$('.loginform #loginBtn').on("click", function(){
		var emailId = $(".loginform #emailId").val();
		var userPwd = $(".loginform #userPwd").val();
		
		var regExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		if (! regExp.test(emailId)) {
			$('.loginform #emailError').text("Please enter a valid email");
			return false;
		} else {
			$('.loginform #emailError').text("");
		}
		
		if(!emailId || !userPwd){
			$('.loginform #emailError').text("Email/Password is Empty");
			return false;
		} else {
			$('.loginform #emailError').text("");
		}
		
		$.ajax({
	        type: "POST",
	        url: "Logon",
	        data: { 
	        	emailId: emailId,
	        	userPwd: userPwd
	        },
	        success: function(data){
	        	if(data != null){
	        		if(data == "Successful"){
	        			window.location = "http://localhost:8080/FlightReservation/myAccount";
	        		} else if(data == "Not Successful"){
	        			document.getElementById("logInErrorMsg").innerHTML = "EmailId and Password Combination is wrong";
	        		} else {
	        			document.getElementById("logInErrorMsg").innerHTML = "Error Occured. Try again later.";
	        		} 
	        	}
	        }
		});
	});
	
	$('.signUpForm #signUpBtn').on("click", function(){
		var custFirstname = $(".signUpForm #custFirstname").val();
		var custLastname = $(".signUpForm #custLastname").val();
		var custemail = $(".signUpForm #custemail").val();
		var userpwd = $(".signUpForm #userpwd").val();
		var userpwd_confirm = $(".signUpForm #userpwd_confirm").val();
		var phone = $(".signUpForm #phone").val();
		var regExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		
		if(!custFirstname){
			$('.signUpForm #regError').text("First Name is Mandatory");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		if(!custLastname){
			$('.signUpForm #regError').text("Last Name is Mandatory");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		if(!regExp.test(custemail) || !custemail){
			$('.signUpForm #regError').text("Please enter a valid email");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		if(!userpwd){
			$('.signUpForm #regError').text("Password is Mandatory");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		if(!userpwd_confirm){
			$('.signUpForm #regError').text("Confirm Password is Mandatory");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		if(userpwd != userpwd_confirm){
			$('.signUpForm #regError').text("Password and Confirm Password should match");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		if(!phone){
			$('.signUpForm #regError').text("Phone Number is Mandatory");
			return false;
		} else {
			$('.signUpForm #regError').text("");
		}
		
		$.ajax({
	        type: "POST",
	        url: "Register",
	        data: { 
	        	custFirstname: custFirstname,
	        	custLastname: custLastname,
	        	custemail: custemail,
	        	userpwd: userpwd,
	        	phone: phone
	        },
	        success: function(data){
	        	if(data != null){
	        		if(data == "User Created."){
	        			window.location = "http://localhost:8080/FlightReservation/myAccount";
	        		} else if(data == "EmailId already Present. Please try with different EmailId."){
	        			document.getElementById("regErrorMsg").innerHTML = "EmailId already Present. Please try with different EmailId.";
	        		} else if(data == "Error Occured. Try again later."){
	        			document.getElementById("regErrorMsg").innerHTML = "Error Occured. Try again later.";
	        		} else {
	        			document.getElementById("regErrorMsg").innerHTML = "Error Occured. Try again later.";
	        		} 
	        	}
	        }
		});
	});
	



});