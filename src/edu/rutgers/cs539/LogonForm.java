package edu.rutgers.cs539;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class LogonForm extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public LogonForm() {
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
		
		String emailId =request.getParameter("emailId");
		String userPwd =request.getParameter("userPwd");
		
		String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";

		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "admin", "database");
			Statement stmt = con.createStatement();
			
			String query = "Select lower(EmailAddress) from Users where lower(EmailAddress) ='" + emailId.toLowerCase() + "' and Password ='" + userPwd + "'";
			/*String query = "Select EmailAddress from Users where lower(EmailAddress) = ? and Password = ?;";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, emailId.toLowerCase());
			pst.setString(2, userPwd);*/
			ResultSet result = stmt.executeQuery(query);
			
			if(result.next()){
				String email = result.getString(1);	
				if(email.equals(emailId)){
					System.out.println("Login Successful");
					json = new Gson().toJson("Successful");

				} 
			} else {
				System.out.println("Login Not Successful");
				json = new Gson().toJson("Not Successful");
			}			
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		pw.write(json);
		
	}
}
