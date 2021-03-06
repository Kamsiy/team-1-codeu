package com.google.codeu.data;

import java.util.UUID;

public class Laptop {
	//all lower case
	  private UUID id;
	  private String brand;
	  private String color;
	  private String os;
	  private long size;
	  private double price;
	  private String description;
	  
	  public Laptop() {
		  id=UUID.randomUUID();
		  brand=null;
		  color=null;
		  os=null;
		  size=0;
		  price=0;
		  description = null;
	  }
	  public Laptop(String brand, String color, String os, long size, double price, String description)  {
		    this(UUID.randomUUID(), brand.toLowerCase(), color.toLowerCase(), os.toLowerCase(), size, price, description);
		  }

	  public Laptop(UUID id, String brand, String color, String os, long size, double price, String description) {
		this.id = id;
	    this.brand = brand.toLowerCase();
	    this.color = color.toLowerCase();
	    this.os = os.toLowerCase();
	    this.size = size;
	    this.price = price;
	    this.description = description;

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
	  
	  public long getSize() {
		  return size;
	  }

	  public double getPrice() {
		  return price;
	  }
	  public void setId(UUID i) {
		     id=i;
	  }
	  
	  public void setBrand(String b){
	     brand=b.toLowerCase();
	  }

	  public void setColor(String c) {
	     color=c.toLowerCase();
	  }
	  
	  public void setOS(String o) {
		   os=o.toLowerCase();
	  }
	  
	  public void setSize(int s) {
		   size=s;
	  }

	  public void setPrice(double p) {
		   price=p;
	  }
	  
	  public String getDescription()
	  {
		  return description;
	  }
	  
	  public void setDescription(String d)
	  {
		  this.description = d;
	  }
}
