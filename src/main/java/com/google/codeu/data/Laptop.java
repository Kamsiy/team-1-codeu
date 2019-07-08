package com.google.codeu.data;

import java.util.UUID;

public class Laptop {
	  private UUID id;
	  private String brand;
	  private String color;
	  private String os;
	  private int size;
	  private double price;
	  
	  public Laptop(String brand, String color, String os, int size, double price)  {
		    this(UUID.randomUUID(), brand, color, os, size, price);
		  }

	  public Laptop(UUID id, String brand, String color, String os, int size, double price) {
		this.id = id;
	    this.brand = brand;
	    this.color = color;
	    this.os = os;
	    this.size = size;
	    this.price = price;

	  }
	  
	  public UUID getId() {
		    return id;
	 }


	  public String getBrand(){
	    return brand;

	  }

	  public String getColor() {
	    return color;

	  }
	  
	  public String getOS() {
		  return os;
	  }
	  
	  public int getSize() {
		  return size;
	  }

	  public double getPrice() {
		  return price;
	  }
	  
}
