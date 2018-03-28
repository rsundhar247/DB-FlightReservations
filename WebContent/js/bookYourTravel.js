$(document).ready(function(){
	$('.bookTktsform #bookTkts').on("click", function(){
		
		var originCity = $(".bookTktsform #originCity").val();
		var destinationCity = $(".bookTktsform #destinationCity").val();
		var depDate = $(".bookTktsform #depDate").val();
		var returnDate = $(".bookTktsform #returnDate").val();
		var prefClass = $(".bookTktsform #prefClass").val();
		var adultTkts = $(".bookTktsform #adultTkts").val();
		
		if(document.getElementById('travelWay1').checked) {
			var travelWay = "One Way";
		}else if(document.getElementById('travelWay2').checked) {
			var travelWay = "Return";
		}
		
		if(!originCity){
			$('.bookTktsform #bookTktsError').text("Origin City Id is mandatory");
			return false;
		} else {
			$('.bookTktsform #bookTktsError').text("");
		}
		
		if(!destinationCity){
			$('.bookTktsform #bookTktsError').text("Destination City is mandatory");
			return false;
		} else {
			$('.bookTktsform #bookTktsError').text("");
		}
		
		if(!depDate){
			$('.bookTktsform #bookTktsError').text("Departure Date is mandatory");
			return false;
		} else {
			$('.bookTktsform #bookTktsError').text("");
		}
		
		if(travelWay == "Return" && !returnDate){
			$('.bookTktsform #bookTktsError').text("Return Date is mandatory");
			return false;
		} else {
			$('.bookTktsform #bookTktsError').text("");
		}
		
		if(!destinationCity){
			$('.bookTktsform #bookTktsError').text("Destination City is mandatory");
			return false;
		} else {
			$('.bookTktsform #bookTktsError').text("");
		}
		
		if(!destinationCity){
			$('.bookTktsform #bookTktsError').text("Destination City is mandatory");
			return false;
		} else {
			$('.bookTktsform #bookTktsError').text("");
		}
		
		window.location = "http://localhost:8080/FlightReservation/customer/viewFlights?oCity="+originCity+"&dCity="+destinationCity+"&dDate="+depDate+
	        						"&rDate="+returnDate+"&pClass="+prefClass+"&aTkts="+adultTkts+"&travelWay="+travelWay;
	       
	});
});