$(document).ready(function(){
	$('#editBtn').on("click", function(){
		var usersId = $("#usersId").val();
		var fName = $("#fName").val();
		var lName = $("#lName").val();
		var emailId = $("#emailId").val();
		var pass = $("#pass").val();
		var phNo = $("#phNo").val();
		var address = $("#address").val();
		var city = $("#city").val();
		var country = $("#country").val();
		var zCode = $("#zCode").val();
		
		
		if(!fName){
			$('#updateCustMsg').text("First Id is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!lName){
			$('#updateCustMsg').text("Last Name is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!emailId){
			$('#updateCustMsg').text("Email Id is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!pass){
			$('#updateCustMsg').text("Password is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!phNo){
			$('#updateCustMsg').text("Phone Number Id is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!address){
			$('#updateCustMsg').text("Address is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!city){
			$('#updateCustMsg').text("City is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!country){
			$('#updateCustMsg').text("Country is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		if(!zCode){
			$('#updateCustMsg').text("ZipCode is mandatory");
			return false;
		} else {
			$('#updateCustMsg').text("");
		}
		
		
		$.ajax({
	        type: "POST",
	        url: "EditCustomer",
	        data: { 
	        	option: 'edit',
	        	usersId: usersId,
	        	fName: fName,
	        	lName: lName,
	        	emailId: emailId,
	        	pass: pass,
	        	phNo: phNo,
	        	address: address,
	        	city: city,
	        	country: country,
	        	zCode: zCode
	        },
	        success: function(data){
	        	
	        	if(data == "Update Successful"){
        			window.location = "http://localhost:8080/FlightReservation/manager/viewCustomers";
        		} else{
        			document.getElementById("updateCustMsg").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
		
	});
});