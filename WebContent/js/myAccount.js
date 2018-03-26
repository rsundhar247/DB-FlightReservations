$(document).ready(function(){
	$('.changeEmailform #changeEmailBtn').on("click", function(){
		var oldEmailId = $(".changeEmailform #oldEmailId").val();
		var newEmailId = $(".changeEmailform #newEmailId").val();
		var userPwd = $(".changeEmailform #userPwd").val();
		
		var regExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		if (! regExp.test(oldEmailId)) {
			$('.changeEmailform #emailError').text("Please enter a valid email in Old Email field");
			return false;
		} else {
			$('.changeEmailform #emailError').text("");
		}
		
		var regExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		if (! regExp.test(newEmailId)) {
			$('.changeEmailform #emailError').text("Please enter a valid email in New Email field");
			return false;
		} else {
			$('.changeEmailform #emailError').text("");
		}
		
		if(!oldEmailId){
			$('.changeEmailform #emailError').text("Old Email Id is mandatory");
			return false;
		} else {
			$('.changeEmailform #emailError').text("");
		}
		
		if(!newEmailId){
			$('.changeEmailform #emailError').text("New Email Id is mandatory");
			return false;
		} else {
			$('.changeEmailform #emailError').text("");
		}
		
		if(!userPwd){
			$('.changeEmailform #emailError').text("User Password is mandatory");
			return false;
		} else {
			$('.changeEmailform #emailError').text("");
		}
		
		if(oldEmailId == newEmailId){
			$('.changeEmailform #emailError').text("Old Email and New Email are Same");
			return false;
		} else {
			$('.changeEmailform #emailError').text("");
		}
		
		
		$.ajax({
	        type: "POST",
	        url: "MyAccountDetails",
	        data: { 
	        	option: 1,
	        	oldEmailId: oldEmailId,
	        	newEmailId: newEmailId,
	        	userPwd: userPwd
	        },
	        success: function(data){
	        	
	        	if(data == "Updated Successfully"){
        			document.getElementById("emailError").innerHTML = "Updated Successfully";
        			window.location = "http://localhost:8080/FlightReservation/myAccount";
        		} else if(data == "New Email Exists") {
        			document.getElementById("emailError").innerHTML = "New Email Already Exists";
        		} else if(data == "Email and Password don't match") {
        			document.getElementById("emailError").innerHTML = "Email and Password don't match";
        		} else{
        			document.getElementById("emailError").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
	});
	
	$('.changePwdform #changePwdBtn').on("click", function(){
		var emailId = $(".changePwdform #emailId").val();
		var curUserPwd = $(".changePwdform #curUserPwd").val();
		var newUserPwd = $(".changePwdform #newUserPwd").val();
		
		var regExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		if (! regExp.test(emailId)) {
			$('.changePwdform #pwdError').text("Please enter a valid email");
			return false;
		} else {
			$('.changePwdform #pwdError').text("");
		}
		
		if(!emailId){
			$('.changePwdform #pwdError').text("Email Id is mandatory");
			return false;
		} else {
			$('.changePwdform #pwdError').text("");
		}
		
		if(!curUserPwd){
			$('.changePwdform #pwdError').text("Current Password is mandatory");
			return false;
		} else {
			$('.changePwdform #pwdError').text("");
		}
		
		if(!newUserPwd){
			$('.changePwdform #pwdError').text("New Password is mandatory");
			return false;
		} else {
			$('.changePwdform #pwdError').text("");
		}
		
		if(curUserPwd == newUserPwd){
			$('.changePwdform #pwdError').text("Old Password and New Password are Same");
			return false;
		} else {
			$('.changePwdform #pwdError').text("");
		}
		
		
		$.ajax({
	        type: "POST",
	        url: "MyAccountDetails",
	        data: { 
	        	option: 2,
	        	emailId: emailId,
	        	curUserPwd: curUserPwd,
	        	newUserPwd: newUserPwd
	        },
	        success: function(data){
	        	if(data == "Updated Successfully"){
        			document.getElementById("pwdError").innerHTML = "Updated Successfully";
        		} else if(data == "Email and Password don't match") {
        			document.getElementById("pwdError").innerHTML = "Email and Password don't match";
        		} else{
        			document.getElementById("pwdError").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
	});
	
	$('.changeAddressform #changeAddressBtn').on("click", function(){
		var fName = $(".changeAddressform #fName").val();
		var lName = $(".changeAddressform #lName").val();
		var address = $(".changeAddressform #address").val();
		var city = $(".changeAddressform #city").val();
		var country = $(".changeAddressform #country").val();
		var zipCode = $(".changeAddressform #zipCode").val();
		var emailId = $("#sessionEmail").val();
		
		if(!fName){
			$('.changeAddressform #addressError').text("First Name is mandatory");
			return false;
		} else {
			$('.changeAddressform #addressError').text("");
		}
		
		if(!lName){
			$('.changeAddressform #addressError').text("Last Name is mandatory");
			return false;
		} else {
			$('.changeAddressform #addressError').text("");
		}
		
		if(!address){
			$('.changeAddressform #addressError').text("Address is mandatory");
			return false;
		} else {
			$('.changeAddressform #addressError').text("");
		}
		
		if(!city){
			$('.changeAddressform #addressError').text("City is mandatory");
			return false;
		} else {
			$('.changeAddressform #addressError').text("");
		}
		
		if(!country){
			$('.changeAddressform #addressError').text("Country is mandatory");
			return false;
		} else {
			$('.changeAddressform #addressError').text("");
		}
		
		if(!zipCode){
			$('.changeAddressform #addressError').text("ZipCode is mandatory");
			return false;
		} else {
			$('.changeAddressform #addressError').text("");
		}
		
		$.ajax({
	        type: "POST",
	        url: "MyAccountDetails",
	        data: { 
	        	option: 3,
	        	fName: fName,
	        	lName: lName,
	        	address: address,
	        	city: city,
	        	country: country,
	        	zipCode: zipCode,
	        	emailId: emailId
	        },
	        success: function(data){
	        	if(data == "Updated Successfully"){
        			document.getElementById("addressError").innerHTML = "Updated Successfully";
        		} else{
        			document.getElementById("addressError").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
	});
	
	
	$('.changeCCform #changeCCBtn').on("click", function(){
		var ccNickName = $(".changeCCform #ccNickName").val();
		var ccNumber = $(".changeCCform #ccNumber").val();
		var ccExp = $(".changeCCform #ccExp").val();
		var ccCVV = $(".changeCCform #ccCVV").val();
		var emailId = $("#sessionEmail").val();
		
		if(!ccNickName){
			$('.changeCCform #CCError').text("Nick Name is mandatory");
			return false;
		} else {
			$('.changeCCform #CCError').text("");
		}
		
		if(!ccNumber){
			$('.changeCCform #CCError').text("Credit Card Number is mandatory");
			return false;
		} else {
			$('.changeCCform #CCError').text("");
		}
		
		if(!ccExp){
			$('.changeCCform #CCError').text("Expiration Date is mandatory");
			return false;
		} else {
			$('.changeCCform #CCError').text("");
		}
		
		if(!ccCVV){
			$('.changeCCform #CCError').text("CVV is mandatory");
			return false;
		} else {
			$('.changeCCform #CCError').text("");
		}
		
		$.ajax({
	        type: "POST",
	        url: "MyAccountDetails",
	        data: { 
	        	option: 4,
	        	ccNickName: ccNickName,
	        	ccNumber: ccNumber,
	        	ccExp: ccExp,
	        	ccCVV: ccCVV,
	        	emailId: emailId
	        },
	        success: function(data){
	        	if(data == "Updated Successfully"){
        			document.getElementById("CCError").innerHTML = "Updated Successfully";
        		} else{
        			document.getElementById("CCError").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
	});
	
});