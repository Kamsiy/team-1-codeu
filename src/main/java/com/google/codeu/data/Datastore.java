/*
 * Copyright 2019 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.codeu.data;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/** Provides access to the data stored in Datastore. */
public class Datastore {

  private DatastoreService datastore;
  private List<Laptop> laptopList; 

  //in future, change to generic type to go more than laptops 
  public Datastore() {
    datastore = DatastoreServiceFactory.getDatastoreService();
    laptopList= new ArrayList<>();
    this.addLaptopData();
  }

  /** Stores the Message in Datastore. */
  public void storeMessage(Message message) {
    Entity messageEntity = new Entity("Message", message.getId().toString());
    messageEntity.setProperty("user", message.getUser());
    messageEntity.setProperty("text", message.getText());
    messageEntity.setProperty("timestamp", message.getTimestamp());

    datastore.put(messageEntity);
  }

  /**
   * Gets messages posted by a specific user.
   *
   * @return a list of messages posted by the user, or empty list if user has never posted a
   *     message. List is sorted by time descending.
   */
  public List<Message> getMessages(String user) {
    Query query =
        new Query("Message")
            .setFilter(new Query.FilterPredicate("user", FilterOperator.EQUAL, user))
            .addSort("timestamp", SortDirection.DESCENDING);
    PreparedQuery results = datastore.prepare(query);

    return convertResults(results);
  }

  /**
   * Returns a List containing all messages posted by every user. List is sorted by time descending.
   */
  public List<Message> getAllMessages(){
    Query query = new Query("Message")
        .addSort("timestamp", SortDirection.DESCENDING);
    PreparedQuery results = datastore.prepare(query);

    return convertResults(results);
  }

  /**
   * Converts the PreparedResults containing Message entities to a List of Message instances.
   */
  private List<Message> convertResults(PreparedQuery results){

    List<Message> messages = new ArrayList<>();

    for (Entity entity : results.asIterable()) {
      try {
        String idString = entity.getKey().getName();
        UUID id = UUID.fromString(idString);
        String user = (String) entity.getProperty("user");
        String text = (String) entity.getProperty("text");
        long timestamp = (long) entity.getProperty("timestamp");

        Message message = new Message(id, user, text, timestamp);
        messages.add(message);
      } catch (Exception e) {
        System.err.println("Error reading message.");
        System.err.println(entity.toString());
        e.printStackTrace();
      }
    }

    return messages;
  }
  
  public Set<String> getUsers(){
	  Set<String> users = new HashSet<>();
	  Query query = new Query("Message");
	  PreparedQuery results = datastore.prepare(query);
	  for(Entity entity : results.asIterable()) {
	    users.add((String) entity.getProperty("user"));
	  }
	  return users;
	}
  
  /** Stores the User in Datastore. */
  public void storeUser(User user) {
   Entity userEntity = new Entity("User", user.getEmail());
   userEntity.setProperty("email", user.getEmail());
   userEntity.setProperty("aboutMe", user.getAboutMe());
   datastore.put(userEntity);

  }

  /**
   * Returns the User owned by the email address, or
   * null if no matching User was found.
   */

  public User getUser(String email) {
   Query query = new Query("User")
     .setFilter(new Query.FilterPredicate("email", FilterOperator.EQUAL, email));
   PreparedQuery results = datastore.prepare(query);
   Entity userEntity = results.asSingleEntity();
   
   if(userEntity == null) {
    return null;
   }
   
   String aboutMe = (String) userEntity.getProperty("aboutMe");
   User user = new User(email, aboutMe);
   return user;

  }

  /** Returns the total number of messages for all users. */
  public int getTotalMessageCount(){
    Query query = new Query("Message");
    PreparedQuery results = datastore.prepare(query);
    return results.countEntities(FetchOptions.Builder.withLimit(1000));
  }
  
  /* Returns all laptops */
  public List<Laptop> getAllLaptops(){
	Query query = new Query("Laptop")
		            .addSort("price", SortDirection.ASCENDING);
	PreparedQuery results = datastore.prepare(query);
	//return this.laptopList;
	return convertLaptopResults(results);	 
	
  }
  
  /**
   * Converts the PreparedResults containing laptop entities to a List of laptop instances.
   */
  private List<Laptop> convertLaptopResults(PreparedQuery results){

    List<Laptop> laptops = new ArrayList<>();

    for (Entity entity : results.asIterable()) {
      try {
        String brand = (String) entity.getProperty("brand");
        String color = (String) entity.getProperty("color");
        String os = (String) entity.getProperty("os");
        long size = (long)entity.getProperty("size");
        double price = (double) entity.getProperty("price");
        String description = (String) entity.getProperty("description");

        Laptop laptop = new Laptop(brand, color, os, size, price,description );
        laptops.add(laptop);
      } catch (Exception e) {
        System.err.println("Error reading laptop data.");
        System.err.println(entity.toString());
        e.printStackTrace();
      }
    }
    return laptops;
  }
  
  /* Stores the laptop in Datastore. */
  public void storeLaptop(Laptop laptop) {
   Entity laptopEntity = new Entity("Laptop", laptop.getId().toString());
   laptopEntity.setProperty("brand", laptop.getBrand());
   laptopEntity.setProperty("color", laptop.getColor());
   laptopEntity.setProperty("os",laptop.getOS());
   laptopEntity.setProperty("size", laptop.getSize());
   laptopEntity.setProperty("price", laptop.getPrice());
   laptopEntity.setProperty("description", laptop.getDescription());
   datastore.put(laptopEntity);
  }  
  
  /* Add hardcoded data to datastore */
  public void addLaptopData()
  {
	  
	  this.deleteAllLaptop();
	  storeLaptop(new Laptop("Dell","Black","Windows",15,1380.00,"Dell XPS 15 inch 9560 black"));
	  storeLaptop(new Laptop("Thinkpad","Black","Windows",13,899.00,"Lenovo - ThinkPad L380 Yoga Touch-Screen 8GB RAM black"));
	  storeLaptop(new Laptop("Dell","Black","Windows",13,599.00,"Dell Inspiron 13 inch Touch Screen AMD 8GB RAM black"));
	  storeLaptop(new Laptop("Dell","Black","Linux",13,850.00,"Dell XPS 13 inch Developer Edition Black"));
	  storeLaptop(new Laptop("Thinkpad","Black","Windows",15,2100.00,"Lenovo - ThinkPad X1 Extreme 15 inch 16GB RAM black"));
	  storeLaptop(new Laptop("Macbook Pro","Silver","Mac",13,1399.00, "MacBook Pro 13 inc 8GB RAM Silver"));
	  storeLaptop(new Laptop("MacBook Pro","Silver","Mac",15,2400.00,"MacBook Pro 15 inc with Touch Bar 16GB RAM Silver"));
	  storeLaptop(new Laptop("MacBook Pro","Grey","Mac",13,1399.00,"MacBook Pro 13 inch 8GB RAM Space Grey"));
	  storeLaptop(new Laptop("Dell","Grey","Windows",15,590.00,"Dell Inspiron 15 inch 5000 Series Grey"));
	  storeLaptop(new Laptop("MacBook Pro","Grey","Mac",15,2400.00, "MacBook Pro 15 inc with Touch Bar 16GB RAM Space Grey"));
  }
  
  /** Adds a laptop to the LaptopList
   * @param Laptop to add to the list 
   */
  public void addLaptop(Laptop newLaptop) {
	  laptopList.add(newLaptop);
  }
  
  /* clean up laptop data */
  public void deleteAllLaptop()
  {
		Query query = new Query("Laptop")
	            .addSort("price", SortDirection.ASCENDING);
		PreparedQuery results = datastore.prepare(query);
		for (Entity entity : results.asIterable()) {
	        try {
	          String id = (String) entity.getProperty("id");
	          datastore.delete(entity.getKey());
	        } catch (Exception e) {
	          System.err.println("Error reading laptop data.");
	          System.err.println(entity.toString());
	          e.printStackTrace();
	        }
		}
	  
  }
  
  /**Returns a laptop list with laptops of a certain brand*/
  public List<Laptop> searchBrand(String brand){
	  //list of laptops that meet the brand requirements 
	  List<Laptop> brandreturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getBrand().equals(brand.toLowerCase()))
			  brandreturn.add(e);
	  }
	  return brandreturn; 
  }
  
  /**Returns a laptop list with laptops of a certain OS*/
  public List<Laptop> searchOs(String os){
	  List<Laptop> osreturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getOS().equals(os.toLowerCase()))
			  osreturn.add(e);
	  }
	  return osreturn; 
  }
  
  /**Returns a laptop list with laptops of a certain color*/
  public List<Laptop> searchColor(String color){
	  List<Laptop> colorreturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getColor().equals(color.toLowerCase()))
			  colorreturn.add(e);
	  }
	  return colorreturn; 
  }

  /**Returns all laptops above that size, inclusive*/ 
  public List<Laptop> searchSizeAbove(int size){
	  List<Laptop> sizeAboveReturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getSize()>=size)
			  sizeAboveReturn.add(e);
	  }
	  return sizeAboveReturn;  
  }
  
  /**Returns all laptops below that size, inclusive*/ 
  public List<Laptop> searchSizeBelow(int size){
	  List<Laptop> sizeBelowReturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getSize()<=size)
			  sizeBelowReturn.add(e);
	  }
	  return sizeBelowReturn;	  
  }
  
  /**Returns all laptops above the price limit, inclusive*/ 
  public List<Laptop> searchPriceAbove(double price){
	  List<Laptop> priceAboveReturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getPrice()>=price)
			  priceAboveReturn.add(e);
	  }
	  return priceAboveReturn;	  
  }
  
  /**Returns all laptops below the price limit, inclusive*/ 
  public List<Laptop> searchPriceBelow(double price){
	  List<Laptop> priceBelowReturn=new ArrayList<>();
	  for(Laptop e:laptopList) {
		  if(e.getPrice()<=price)
			  priceBelowReturn.add(e);
	  }
	  return priceBelowReturn;	  
  }
  
  
}