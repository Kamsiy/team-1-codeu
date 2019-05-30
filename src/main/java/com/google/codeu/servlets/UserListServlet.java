package com.google.codeu.servlets;

import java.io.*;
import java.util.Set;

import com.google.codeu.data.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Handles fetching all users for the community page.
 */
@WebServlet("/user-list")
public class UserListServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException {

    response.getOutputStream().println("this will be my user list");
    Datastore myDataStore = new Datastore();
    Set<String> myList = myDataStore.getUsers();
    
    for (String s:myList) {

    	response.getOutputStream().println(s);
    }
  }
}