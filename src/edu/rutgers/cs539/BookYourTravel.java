package edu.rutgers.cs539;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class BookYourTravel extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public BookYourTravel() {
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
		
		String originCity = request.getParameter("originCity");
		String destinationCity = request.getParameter("destinationCity");
		String depDate = request.getParameter("depDate");
		String returnDate = request.getParameter("returnDate");
		String prefClass = request.getParameter("prefClass");
		String adultTkts = request.getParameter("adultTkts");
		String childTkts = request.getParameter("childTktsv");
		String travelWay = request.getParameter("travelWay");
		
		
		String url = "jdbc:mysql://msdsdbs.ccnr1cm6zd1l.us-east-2.rds.amazonaws.com:3306/project1";
		
		json = new Gson().toJson("Success");
		pw.write(json);
	}

}
