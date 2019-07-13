package com.google.codeu.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.codeu.data.Datastore;
import com.google.gson.Gson;
import com.google.codeu.data.Laptop;

@WebServlet("/laptops")
public class LaptopServlet extends HttpServlet{

	  private Datastore datastore;

	  @Override
	  public void init() {
	    datastore = new Datastore();
	    // add inital Laptop list
	    datastore.addLaptopData();
	  }

	  /**
	   * Responds with a JSON representation of Message data for all users.
	   */
	  @Override
	  public void doGet(HttpServletRequest request, HttpServletResponse response)
	      throws IOException {

	    List<Laptop> laptops = datastore.getAllLaptops();
	    
	    // get search criteria
	    String brand = request.getParameter("brand");
	    String color = request.getParameter("color");;
	    String os = request.getParameter("os");
	    String strSize = request.getParameter("size");
	    int size = 0;
	    if(strSize != null && strSize.length() > 0)
	    	size = Integer.parseInt(strSize);
	    
	    List<Laptop> filteredResult = getFilteredResult(laptops, brand, color, os, size);
	    
	    Gson gson = new Gson();
	    String json = gson.toJson(filteredResult);

	    response.setContentType("application/json");
	    response.getOutputStream().println(json);
	  }
	  
	  // filter the result by searching criteria
	  private List<Laptop> getFilteredResult(List<Laptop> laptops, String brand, String color, String os, int size)
	  {
		  List<Laptop> resultList = new ArrayList<>();

		  for(Laptop laptop : laptops)
		  {
			  boolean isValidRecord = true;
			  if(brand != null && laptop.getBrand().compareTo(brand) != 0)
				  isValidRecord = false;
			  if(color != null && laptop.getColor().compareTo(color) != 0)
				  isValidRecord = false;
			  if (os != null && laptop.getOS().compareTo(os) != 0)
				  isValidRecord = false;
			  if (size > 0 && laptop.getSize() != size)
				  isValidRecord = false;
			  
			  if(isValidRecord)
				  resultList.add(laptop);
		  }
		  return resultList;
	  }
}
