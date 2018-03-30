$(document).ready(function(){
	$('#bookTktsBtn').on("click", function(){

		var emailId = $("#sessionEmail").val();
		var aTkts = $("#aTkts").val();
		var dDate = $("#dDate").val();
		var rDate = $("#rDate").val();
		var pClass = $("#pClass").val();
		
		
		var radioBtnDep = $('input[name=travelBook1]:checked').val();
		var airNameDep = $('tr.row'+radioBtnDep+' td.airName'+radioBtnDep).html();
		var fNumberDep = $('tr.row'+radioBtnDep+' td.fNumber'+radioBtnDep).html();
		var depAirportDep = $('tr.row'+radioBtnDep+' td.depAirport'+radioBtnDep).html();
		var arrAirportDep = $('tr.row'+radioBtnDep+' td.arrAirport'+radioBtnDep).html();
		var airFareDep = $('tr.row'+radioBtnDep+' td.airFare'+radioBtnDep).html();
		var depTimeDep = $('tr.row'+radioBtnDep+' td.depTime'+radioBtnDep).html();
		var travelTimeDep = $('tr.row'+radioBtnDep+' td.travelTime'+radioBtnDep).html();
		
		
		if (document.getElementsByName("travelBook2")) {
			var radioBtnRet = $('input[name=travelBook2]:checked').val();
			var airNameRet = $('tr.rowR'+radioBtnRet+' td.airNameR'+radioBtnRet).html();
			var fNumberRet = $('tr.rowR'+radioBtnRet+' td.fNumberR'+radioBtnRet).html();
			var depAirportRet = $('tr.rowR'+radioBtnRet+' td.depAirportR'+radioBtnRet).html();
			var arrAirportRet = $('tr.rowR'+radioBtnRet+' td.arrAirportR'+radioBtnRet).html();
			var airFareRet = $('tr.rowR'+radioBtnRet+' td.airFareR'+radioBtnRet).html();
			var depTimeRet = $('tr.rowR'+radioBtnRet+' td.depTimeR'+radioBtnRet).html();
			var travelTimeRet = $('tr.rowR'+radioBtnRet+' td.travelTimeR'+radioBtnRet).html();
		}
		
		$.ajax({
	        type: "POST",
	        url: "FlightsReservation",
	        data: { 
	        	emailId: emailId,
	        	aTkts: aTkts,
	        	pClass: pClass,
	        	dDate: dDate,
	        	rDate: rDate,
	        	
	        	fNumberDep: fNumberDep,
	        	airNameDep: airNameDep,
	        	depAirportDep: depAirportDep,
	        	arrAirportDep: arrAirportDep,
	        	airFareDep: airFareDep,
	        	depTimeDep: depTimeDep,
	        	travelTimeDep: travelTimeDep,
	        	
	        	fNumberRet: fNumberRet,
	        	airNameRet: airNameRet,
	        	depAirportRet: depAirportRet,
	        	arrAirportRet: arrAirportRet,
	        	airFareRet: airFareRet,
	        	depTimeRet: depTimeRet,
	        	travelTimeRet: travelTimeRet
	        },
	        success: function(data){
	        	if(data == "Failed. Try again later."){
	        		
	        	} else {
	        		window.location = "http://localhost:8080/FlightReservation/customer/myCart?resId="+data;
	        	}
	        }
	        
		}); 
	});
});