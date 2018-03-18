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

public class MyAccountForm extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public MyAccountForm() {
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
		
		String option = request.getParameter("option");
		
		if(option.equals("1")) { // Change Email
			
			String oldEmailId =request.getParameter("oldEmailId").toLowerCase();
			String newEmailId =request.getParameter("newEmailId").toLowerCase();
			String userPwd =request.getParameter("userPwd");
			
			String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, "admin", "database");
				Statement stmt = con.createStatement();
				
				String query = "Select Users_Id from Users where lower(EmailAddress) ='" + oldEmailId + "' and Password ='" + userPwd + "'";

				ResultSet result = stmt.executeQuery(query);
				if(result.next()){
					String Users_Id = result.getString(1);	
						
					query = "Update Users set EmailAddress ='" + newEmailId + "' where Users_Id ="+ Users_Id;
					int res = stmt.executeUpdate(query);
					
					System.out.println("Updated Successfully");
					json = new Gson().toJson("Updated Successfully");

				} else {
					System.out.println("Email and Password don't match");
					json = new Gson().toJson("Email and Password don't match");
				}			
				
			} catch (SQLException | ClassNotFoundException e) {
				json = new Gson().toJson("Failed. Try again later.");
				e.printStackTrace();
			}
			
		} else if(option.equals("2")) { // Change Password
			
			String emailId = request.getParameter("emailId").toLowerCase();
			String curUserPwd = request.getParameter("curUserPwd");
			String newUserPwd = request.getParameter("newUserPwd");
			
			String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, "admin", "database");
				Statement stmt = con.createStatement();
				
				String query = "Select Users_Id from Users where lower(EmailAddress) ='" + emailId + "' and Password ='" + curUserPwd + "'";

				ResultSet result = stmt.executeQuery(query);
				if(result.next()){
					String Users_Id = result.getString(1);	
						
					query = "Update Users set Password ='" + newUserPwd + "' where Users_Id ="+ Users_Id;
					int res = stmt.executeUpdate(query);
					
					System.out.println("Updated Successfully");
					json = new Gson().toJson("Updated Successfully");

				} else {
					System.out.println("Email and Password don't match");
					json = new Gson().toJson("Email and Password don't match");
				}			
				
			} catch (SQLException | ClassNotFoundException e) {
				json = new Gson().toJson("Failed. Try again later.");
				e.printStackTrace();
			}
			
		} else if(option.equals("3")) { // Change Address
			
			String fName = request.getParameter("fName");
			String lName = request.getParameter("lName");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String country = request.getParameter("country");
			String zipCode = request.getParameter("zipCode");
			
			String emailId = request.getParameter("emailId").toLowerCase();
			
			String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
			String query = "Select Users_Id from Address where Users_Id in (Select Users_Id from Users where lower(EmailAddress) = '" + emailId + "')";
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, "admin", "database");
				Statement stmt = con.createStatement();
				ResultSet result = stmt.executeQuery(query);
				if(result.next()){
					String Users_Id = result.getString(1);	
					query = "Update Address set Address ='" + address +"', City ='" + city +"', Country ='" + country + "', Zipcode ='" + zipCode + "' where Users_Id =" + Users_Id;
					int res = stmt.executeUpdate(query);
					
					query = "Update Users set FirstName ='" + fName +"', LastName ='" + lName +"' where Users_Id =" + Users_Id;
					res = stmt.executeUpdate(query);
					
					System.out.println("Updated Successfully");
					json = new Gson().toJson("Updated Successfully");
				} else {
					query = "Select Users_Id from Users where lower(EmailAddress) = '" + emailId + "'";
					result = stmt.executeQuery(query);
					if(result.next()){
						String Users_Id = result.getString(1);
						query = "Insert into Address(Users_Id, Address, City, Country, Zipcode) values(" + Users_Id + ", '" + address + "', '" + city + "', '" + country + "', '" + zipCode + "')";
						int res = stmt.executeUpdate(query);
						
						query = "Update Users set FirstName ='" + fName +"', LastName ='" + lName +"' where Users_Id =" + Users_Id;
						res = stmt.executeUpdate(query);
					}
					
					System.out.println("Updated Successfully");
					json = new Gson().toJson("Updated Successfully");
				}
			} catch (SQLException | ClassNotFoundException e) {
				json = new Gson().toJson("Failed. Try again later.");
				e.printStackTrace();
			}
		}
		
		
		pw.write(json);
		
	}
}