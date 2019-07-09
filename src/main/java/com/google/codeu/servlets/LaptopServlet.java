package com.google.codeu.servlets;

import java.io.IOException;
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
	  }

	  /**
	   * Responds with a JSON representation of Message data for all users.
	   */
	  @Override
	  public void doGet(HttpServletRequest request, HttpServletResponse response)
	      throws IOException {

	    List<Laptop> laptops = datastore.getAllLaptops();
	    Gson gson = new Gson();
	    String json = gson.toJson(laptops);

	    response.setContentType("application/json");
	    response.getOutputStream().println(json);
	  }
}
