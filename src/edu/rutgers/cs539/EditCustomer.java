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

public class EditCustomer extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public EditCustomer() {
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
		
		
		if(option.equals("edit")) {
				String usersId = request.getParameter("usersId");
				String fName =request.getParameter("fName");
				String lName =request.getParameter("lName");
				String emailId =request.getParameter("emailId");
				String pass =request.getParameter("pass");
				String phNo =request.getParameter("phNo");
				String address =request.getParameter("address");
				String city =request.getParameter("city");
				String country =request.getParameter("country");
				String zCode =request.getParameter("zCode");
				
				String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
		
				try {
					Class.forName("com.mysql.jdbc.Driver");
					Connection con = DriverManager.getConnection(url, "admin", "database");
					Statement stmt = con.createStatement();
					String query = "Update Users set FirstName='"+fName+"', LastName='" + lName + "', EmailAddress='" + emailId + "', Password='" + pass + 
									"', PhoneNumber='" + phNo + "', LastUpdate= NOW() where Users_Id="+usersId;
					stmt.executeUpdate(query);
					
					query = "Select * from Address where Users_Id="+usersId;
					ResultSet res = stmt.executeQuery(query);
					
					if(res.next()) {
						query = "Update Address set Address='"+address+"', City='" + city +"', Country='" + country+"', Zipcode='" + zCode+"' where Users_Id="+usersId;
						stmt.executeUpdate(query);
					} else {
						query = "Insert into Address values("+usersId+",'"+address+",'"+city+",'"+country+",'"+zCode+"')";
						stmt.executeUpdate(query);
					}
					
					System.out.println("Update Successful");
					json = new Gson().toJson("Update Successful");
				} catch (SQLException | ClassNotFoundException e) {
					json = new Gson().toJson("Failed. Try again later.");
					e.printStackTrace();
				}
		} else if(option.equals("delete")) {
			String usersId = request.getParameter("usersId");
			
			String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, "admin", "database");
				Statement stmt = con.createStatement();
				String query ="Delete from Address where Users_Id="+usersId;
				stmt.executeUpdate(query);
				
				query ="Delete from CardDetails where Users_Id="+usersId;
				stmt.executeUpdate(query);
				
				query ="Delete from CustomerPreferences where Users_Id="+usersId;
				stmt.executeUpdate(query);
				
				query ="Delete from Users where Users_Id="+usersId;
				stmt.executeUpdate(query);
				
				System.out.println("Delete Successful");
				json = new Gson().toJson("Delete Successful");
			} catch (SQLException | ClassNotFoundException e) {
				json = new Gson().toJson("Failed. Try again later.");
				e.printStackTrace();
			}
		} else if(option.equals("add")) {
			String fName =request.getParameter("fName");
			String lName =request.getParameter("lName");
			String emailId =request.getParameter("emailId");
			String pass =request.getParameter("pass");
			String phNo =request.getParameter("phNo");
			String address =request.getParameter("address");
			String city =request.getParameter("city");
			String country =request.getParameter("country");
			String zCode =request.getParameter("zCode");
			
			String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, "admin", "database");
				Statement stmt = con.createStatement();
				String query ="Select * from Users where EmailAddress='"+emailId+"'";
				ResultSet res = stmt.executeQuery(query);
				
				if(res.next()) {
					System.out.println("User Already Exists");
					json = new Gson().toJson("User Already Exists");
				} else {
					query ="Insert into Users values((Select userId from (Select max(Users_id)+1 as userId from Users) as User), 'customer', '"+
							fName +"', '"+ lName +"', '"+ emailId +"', '"+ pass + "', '"+ phNo +"', NOW(), NOW())";
					stmt.executeUpdate(query);
					
					query ="Insert into Address values((Select Users_Id from Users where EmailAddress='"+emailId+"'), '"+ address +"', '"+ city +"', '"+ country +"', '"+ zCode +"')";
					stmt.executeUpdate(query);
					
					System.out.println("Add Successful");
					json = new Gson().toJson("Add Successful");
				}
				
				
				
			} catch (SQLException | ClassNotFoundException e) {
				json = new Gson().toJson("Failed. Try again later.");
				e.printStackTrace();
			}
		}
		
		pw.write(json);
	}
}