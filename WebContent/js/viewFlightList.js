$(document).ready(function(){
	$('#filterFlightOnNos').on("click", function(){
		var airlineNo = $("#airlineNo").val();
		var flightNo = $("#flightNo").val();
		
		if(!airlineNo){
			$('#flightNoError').text("Airline Number is mandatory");
			return false;
		} else {
			$('#flightNoError').text("");
		}
		
		if(!flightNo){
			$('#flightNoError').text("Flight Number is mandatory");
			return false;
		} else {
			$('#flightNoError').text("");
		}
        window.location = "http://localhost:8080/FlightReservation/manager/filterReservations?airlineNo="+airlineNo+"&flightNo="+flightNo;
	});
	
	$('#filterFlightOnCustName').on("click", function(){
		var custName = $("#custName").val();
		
		if(!custName){
			$('#flightCustError').text("Customer Name is mandatory");
			return false;
		} else {
			$('#flightCustError').text("");
		}
		
        window.location = "http://localhost:8080/FlightReservation/manager/filterReservations?custName="+custName;
	});
	
	$('#filterFlightOnAirportName').on("click", function(){
		var airportName = $("#airportName").val();
		
		if(!custName){
			$('#flightAirportError').text("Airport Name is mandatory");
			return false;
		} else {
			$('#flightAirportError').text("");
		}
		
        window.location = "http://localhost:8080/FlightReservation/manager/filterFlights?flights=airportId&AirportName="+airportName;
	});
	
	$('#filterCustomersOnAirportName').on("click", function(){
		var airNo = $("#airNo").val();
		var fltNo = $("#fltNo").val();
		
		if(!airNo){
			$('#filterCustomersError').text("Airport Id is mandatory");
			return false;
		} else {
			$('#filterCustomersError').text("");
		}
		
		if(!fltNo){
			$('#filterCustomersError').text("Flight Id is mandatory");
			return false;
		} else {
			$('#filterCustomersError').text("");
		}
		
        window.location = "http://localhost:8080/FlightReservation/manager/filterCustomers?filter=flight&airNo="+airNo+"&fltNo="+fltNo;
	});
	
	$('#filterCustomersOnMonth').on("click", function(){
		var month = $("#month").val();
		var year = $("#year").val();
		
		if(!year){
			$('#filterMonthError').text("Year is mandatory");
			return false;
		} else {
			$('#filterMonthError').text("");
		}
		
        window.location = "http://localhost:8080/FlightReservation/manager/filterMonth?month="+month+"&year="+year;
	});
});