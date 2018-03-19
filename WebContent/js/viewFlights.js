$(document).ready(function(){
	$('#bookTktsBtn').on("click", function(){

		
		
		$.ajax({
	        type: "POST",
	        url: "FlightsReservation",
	        data: { 
	        	asd: "asd"
	        },
	        success: function(data){
	        	window.location = "http://localhost:8080/FlightReservation/myCart";
	        }
	        
		}); 
	});
});