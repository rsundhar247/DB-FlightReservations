package edu.rutgers.cs539;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class FlightsReservation extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public FlightsReservation() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
        // Writing the message on the web page      
        PrintWriter out = response.getWriter();      
        out.println("<p>" + "Hello Friends!" + "</p>");  
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		String json = null;

    	String emailId = request.getParameter("emailId");
		String aTkts = request.getParameter("aTkts");
		String pClass = request.getParameter("pClass");
		String dDate = request.getParameter("dDate");
		String rDate = request.getParameter("rDate");
		
		String fNumberDep = request.getParameter("fNumberDep");
		//String airNameDep = request.getParameter("airNameDep");
		String depAirportDep = request.getParameter("depAirportDep");
		String arrAirportDep = request.getParameter("arrAirportDep");
		String airFareDep = request.getParameter("airFareDep");
		//String depTimeDep = request.getParameter("depTimeDep");
		//String travelTimeDep = request.getParameter("travelTimeDep");
    	String resId = "", bookId = "", response1 = "";
    	
		String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "admin", "database");
			Statement stmt = con.createStatement();
			
			String[] fNumberDepArr = fNumberDep.split("<br>");
			if(fNumberDepArr.length == 1) {
				String[] fNumberDepArr1 = fNumberDepArr[0].split("-");
				int airFare = Integer.parseInt(airFareDep) * Integer.parseInt(aTkts);
				String query = "Select max(Reservation_Id)+1, max(BookingId)+1 from ReservationDetails";
				ResultSet res = stmt.executeQuery(query);
				if(res.next()) {
					resId = res.getString(1);
					bookId = res.getString(2);
				}
				
				query = "Insert into Reservations values("+resId+", (Select Users_Id from Users where EmailAddress='"+ emailId + "'), NOW(), " +
						(airFare * 0.833) + "," + airFare + "," + Integer.parseInt(aTkts) + ", (Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportDep + "')" +
						", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportDep + "'), '" + dDate + "', 'Initiate')";
				stmt.executeUpdate(query);
				
				
				query = "Insert into ReservationDetails values("+resId+", " + fNumberDepArr1[1] + ", '" + fNumberDepArr1[0] + "', " +
						"(Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportDep + "')" +
						", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportDep + "'), " + airFare +
						", " + (airFare * 0.833) + ", " + bookId + ", '" + pClass + "')";
				stmt.executeUpdate(query);
				
				if(response1.equals("")) {
					response1 += resId;
				} else {
					response1 += ","+resId;
				}
			} else {
				
				String[] depAirportDepArr = depAirportDep.split("<br>");
				String[] arrAirportDepArr = arrAirportDep.split("<br>");
				String[] airFareDepArr = airFareDep.split("<br>");
				
				for(int i=0; i<2; i++) {
					String[] fNumberDepArr1 = fNumberDepArr[i].split("-");
					int airFare = Integer.parseInt(airFareDepArr[i]) * Integer.parseInt(aTkts);
					
					String query = "Select max(Reservation_Id)+1, max(BookingId)+1 from ReservationDetails";
					ResultSet res = stmt.executeQuery(query);
					if(res.next()) {
						resId = res.getString(1);
						bookId = res.getString(2);
					}
					
					query = "Insert into Reservations values("+resId+", (Select Users_Id from Users where EmailAddress='"+ emailId + "'), NOW(), " +
							(airFare * 0.833) + "," + airFare + "," + Integer.parseInt(aTkts) + ", (Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportDepArr[i] + "')" +
							", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportDepArr[i] + "'), '" + dDate + "', 'Initiate')";
					stmt.executeUpdate(query);
					
					
					query = "Insert into ReservationDetails values("+resId+", " + fNumberDepArr1[1] + ", '" + fNumberDepArr1[0] + "', " +
							"(Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportDepArr[i] + "')" +
							", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportDepArr[i] + "'), " + airFare +
							", " + (airFare * 0.833) + ", " + bookId + ", '" + pClass + "')";
					stmt.executeUpdate(query);
					
					if(response1.equals("")) {
						response1 += resId;
					} else {
						response1 += ","+resId;
					}
				}
			}
			
			
			if(request.getParameter("fNumberRet") != null) {
					String fNumberRet = request.getParameter("fNumberRet");
					//String airNameRet = request.getParameter("airNameRet");
					String depAirportRet = request.getParameter("depAirportRet");
					String arrAirportRet = request.getParameter("arrAirportRet");
					String airFareRet = request.getParameter("airFareRet");
					//String depTimeRet = request.getParameter("depTimeRet");
					//String travelTimeRet = request.getParameter("travelTimeRet");
					
					String[] fNumberRetArr = fNumberRet.split("<br>");
					if(fNumberRetArr.length == 1) {
						String[] fNumberRetArr1 = fNumberRetArr[0].split("-");
						int airFare = Integer.parseInt(airFareRet) * Integer.parseInt(aTkts);
						String query = "Select max(Reservation_Id)+1, max(BookingId)+1 from ReservationDetails";
						ResultSet res = stmt.executeQuery(query);
						if(res.next()) {
							resId = res.getString(1);
							bookId = res.getString(2);
						}
						
						query = "Insert into Reservations values("+resId+", (Select Users_Id from Users where EmailAddress='"+ emailId + "'), NOW(), " +
								(airFare * 0.833) + "," + airFare + "," + Integer.parseInt(aTkts) + ", (Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportRet + "')" +
								", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportRet + "'), '" + rDate + "', 'Initiate')";
						stmt.executeUpdate(query);
						
						
						query = "Insert into ReservationDetails values("+resId+", " + fNumberRetArr1[1] + ", '" + fNumberRetArr1[0] + "', " +
								"(Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportRet + "')" +
								", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportRet + "'), " + airFare +
								", " + (airFare * 0.833) + ", " + bookId + ", '" + pClass + "')";
						stmt.executeUpdate(query);
						
						if(response1.equals("")) {
							response1 += resId;
						} else {
							response1 += ","+resId;
						}
					} else {
						
						String[] depAirportRetArr = depAirportRet.split("<br>");
						String[] arrAirportRetArr = arrAirportRet.split("<br>");
						String[] airFareRetArr = airFareRet.split("<br>");
						
						for(int i=0; i<2; i++) {
							String[] fNumberRetArr1 = fNumberRetArr[i].split("-");
							int airFare = Integer.parseInt(airFareRetArr[i]) * Integer.parseInt(aTkts);
							
							String query = "Select max(Reservation_Id)+1, max(BookingId)+1 from ReservationDetails";
							ResultSet res = stmt.executeQuery(query);
							if(res.next()) {
								resId = res.getString(1);
								bookId = res.getString(2);
							}
							
							query = "Insert into Reservations values("+resId+", (Select Users_Id from Users where EmailAddress='"+ emailId + "'), NOW(), " +
									(airFare * 0.833) + "," + airFare + "," + Integer.parseInt(aTkts) + ", (Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportRetArr[i] + "')" +
									", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportRetArr[i] + "'), '" + dDate + "', 'Initiate')";
							stmt.executeUpdate(query);
							
							
							query = "Insert into ReservationDetails values("+resId+", " + fNumberRetArr1[1] + ", '" + fNumberRetArr1[0] + "', " +
									"(Select distinct DepartureCity from Flights where DepartureAirport='" + depAirportRetArr[i] + "')" +
									", (Select distinct ArrivalCity from Flights where ArrivalAirport='" + arrAirportRetArr[i] + "'), " + airFare +
									", " + (airFare * 0.833) + ", " + bookId + ", '" + pClass + "')";
							stmt.executeUpdate(query);
							
							if(response1.equals("")) {
								response1 += resId;
							} else {
								response1 += ","+resId;
							}
						}
					}
			}	
			System.out.println("Update Successful");
			json = new Gson().toJson(response1);
		} catch (SQLException | ClassNotFoundException e) {
			json = new Gson().toJson("Failed. Try again later.");
			e.printStackTrace();
		}
		
		/*String fNumberRet = request.getParameter("fNumberRet");
		String airNameRet = request.getParameter("airNameRet");
		String depAirportRet = request.getParameter("depAirportRet");
		String arrAirportRet = request.getParameter("arrAirportRet");
		String airFareRet = request.getParameter("airFareRet");
		String depTimeRet = request.getParameter("depTimeRet");
		String travelTimeRet = request.getParameter("travelTimeRet");*/
		
		pw.write(json);
	}

}
