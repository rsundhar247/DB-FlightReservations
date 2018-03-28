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

public class MyCart extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public MyCart() {
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

    	String ccNumber = request.getParameter("ccNumber");
		String ccExp = request.getParameter("ccExp");
		String ccCVV = request.getParameter("ccCVV");
		String sessionEmail = request.getParameter("sessionEmail");
		String resId = request.getParameter("resId");
		
		String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "admin", "database");
			Statement stmt = con.createStatement();
			
			String query = "Select NickName from CardDetails C, Users U where C.users_Id = U.Users_Id and " +
					"U.EmailAddress = '" + sessionEmail + "' and C.CardNumber = " + ccNumber + " and C.CVV = " + ccCVV + " and C.ExpirationDate = '" + ccExp +"'";
			System.out.println("1 : " + query);
			ResultSet res = stmt.executeQuery(query);
			
			if(res.next()) {
				
				query = "Update Reservations set status = 'Paid' where Reservation_Id in ("+resId+")";
				System.out.println("2 : " + query);
				stmt.executeUpdate(query);
				
				System.out.println("Placing Order");
				json = new Gson().toJson("Paid");
			} else {
				System.out.println("Payment Declined");
				json = new Gson().toJson("Payment Declined");
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			json = new Gson().toJson("Payment Declined");
			e.printStackTrace();
		}
		
		pw.write(json);
	}
}