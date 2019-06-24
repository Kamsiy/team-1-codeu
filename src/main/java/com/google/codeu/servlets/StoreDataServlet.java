package com.google.codeu.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Scanner;

/**
 * Returns StoreData data as a JSON array, e.g. [{"lat": 38.4404675, "lng": -122.7144313}]
 */
@WebServlet("/StoreData-data")
public class StoreDataServlet extends HttpServlet {

  private JsonArray StoreDataSightingArray;

  @Override
  public void init() {
    StoreDataSightingArray = new JsonArray();
    Gson gson = new Gson();
    Scanner scanner = new Scanner(getServletContext().getResourceAsStream("/WEB-INF/StoreData-data.csv"));
    while(scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] cells = line.split(",");

      double lat = Double.parseDouble(cells[0]);
      double lng = Double.parseDouble(cells[1]);

      StoreDataSightingArray.add(gson.toJsonTree(new StoreDataSighting(lat, lng)));
    }
    scanner.close();
  }

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setContentType("application/json");
    response.getOutputStream().println(StoreDataSightingArray.toString());
  }

  // This class could be its own file if we needed it outside this servlet
  private static class StoreDataSighting{
    double lat;
    double lng;

    private StoreDataSighting(double lat, double lng) {
      this.lat = lat;
      this.lng = lng;
    }
  }
}