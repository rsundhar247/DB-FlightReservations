package edu.rutgers.cs539;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

public class RegisterForm extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public RegisterForm() {
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
		
		String custFirstname = request.getParameter("custFirstname");
		String custLastname = request.getParameter("custLastname");
		String custemail = request.getParameter("custemail");
		String userpwd = request.getParameter("userpwd");
		String userType = "B"; //request.getParameter("userType");
		String phone = request.getParameter("phone");
		String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";

		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "admin", "database");
			Statement stmt = con.createStatement();
			
			String query = "Select lower(EmailAddress) from Users where lower(EmailAddress) ='" + custemail.toLowerCase() + "'";
			System.out.println(query);
			ResultSet result = stmt.executeQuery(query);
			
			if(result.next()){
				String email = result.getString(1);	
				if(email.equals(custemail)){
					System.out.println("EmailId already Present");
					json = new Gson().toJson("EmailId already Present. Please try with different EmailId.");
				} 
			} else {
				
				java.util.Date dt = new java.util.Date();
				java.text.SimpleDateFormat sdf = 
				     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				String currentTime = sdf.format(dt);
				
				String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
				query = "Insert into Users values(" + "(Select userId from (Select max(Users_id)+1 as userId from Users) as User)" + ", '" + userType + "', '" + custFirstname + "', '" + custLastname + "', '" +
										custemail.toLowerCase() + "', '" + userpwd + "'," + phone + ", '" + currentTime + "', '" + currentTime +"')";
				
				System.out.println(query);
				int res = stmt.executeUpdate(query);
				if(res == 1){
					System.out.println("User Created");
					json = new Gson().toJson("User Created.");
					
					HttpSession session = request.getSession();
					session.setAttribute("EmailId", custemail.toLowerCase());
				} else {
					System.out.println("Error Occured. Try again later.");
					json = new Gson().toJson("Error Occured. Try again later.");
				}
			}			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		pw.write(json);
		
	}

}