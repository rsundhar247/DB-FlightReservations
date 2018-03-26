$(document).ready(function(){
	$('#editCustBtn').on("click", function(){
		
		var radioBtn = $('input[name=editCust]:checked').val();
		var selUser = $('tr.row'+radioBtn+' td.usersId'+radioBtn).html();
		
		window.location = "http://localhost:8080/FlightReservation/manager/editCustomer?users_Id="+selUser.trim();
		
	});
	
	$('#addCustBtn').on("click", function(){
			
		window.location = "http://localhost:8080/FlightReservation/manager/addCustomer";
		
	});
	
	$('#deleteCustBtn').on("click", function(){
		
		var radioBtn = $('input[name=editCust]:checked').val();
		var selUser = $('tr.row'+radioBtn+' td.usersId'+radioBtn).html();
		
		$.ajax({
	        type: "POST",
	        url: "EditCustomer",
	        data: { 
	        	option: 'delete',
	        	usersId: selUser,
	        },
	        success: function(data){
	        	
	        	if(data == "Delete Successful"){
        			window.location = "http://localhost:8080/FlightReservation/manager/viewCustomers";
        		} else{
        			document.getElementById("updateCustMsg").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
		
	});
	
	$('#addBtn').on("click", function(){
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
			$('#addCustMsg').text("First Id is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!lName){
			$('#addCustMsg').text("Last Name is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!emailId){
			$('#addCustMsg').text("Email Id is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!pass){
			$('#addCustMsg').text("Password is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!phNo){
			$('#addCustMsg').text("Phone Number Id is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!address){
			$('#addCustMsg').text("Address is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!city){
			$('#addCustMsg').text("City is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!country){
			$('#addCustMsg').text("Country is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		if(!zCode){
			$('#addCustMsg').text("ZipCode is mandatory");
			return false;
		} else {
			$('#addCustMsg').text("");
		}
		
		
		$.ajax({
	        type: "POST",
	        url: "EditCustomer",
	        data: { 
	        	option: 'add',
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
	        	
	        	if(data == "Add Successful"){
        			window.location = "http://localhost:8080/FlightReservation/manager/viewCustomers";
        		} else if(data == "User Already Exists"){
        			document.getElementById("addCustMsg").innerHTML = "User Already Exists";
        		} else{
        			document.getElementById("addCustMsg").innerHTML = "Failed. Try again later.";
        		}
	        }
		});
		
	});
});