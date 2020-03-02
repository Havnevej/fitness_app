package fitness_app.core;

import java.util.ArrayList;

public class Person {
    private String firstName;
    private String lastName;
    private float weight;
    private int height;
    private int age;
    private String gender;
    private String country;
    private String region;
    private String city;
    private String address;

    Person (){
        firstName = "";
        lastName = "";
        weight = -1;
        height = -1;
        gender = "";
        country = "";
        region = "";
        city = "";
        address = "";
    }

    Person(String setFirstName, String setLastName, float setWeight, int setHeight, int setAge, String setGender, String setCountry, String setRegion, String setCity, String setAddress){
        firstName = setFirstName;
        lastName = setLastName;
        weight = setWeight;
        height = setHeight;
        age = setAge;
        gender = setGender;
        country = setCountry;
        region = setRegion;
        city = setCity;
        address = setAddress;
    }
    //Person(){
      //  height = 0;
        //age = 0;
    //}

    // setters
    void setAge(int age){ this.age = age; }
    public void setFirstName (String firstName){ this.firstName = firstName; }
    public void setLastName (String lastName){ this.lastName = lastName; }
    public void setWeight (float weight){ this.weight = weight; }
    public void setHeight(int height){ this.height = height; }
    public void setGender (String gender){ this.gender = gender; }
    public void setCountry(String country){ this.country = country; }
    public void setRegion (String region){ this.region = region; }
    public void setCity (String city){ this.city = city; }
    public void setAddress (String address){ this.address = address; }

    //getters
    public int getAge (){  return this.age; }
    public String getFirstName (){  return this.firstName; }
    public String getLastName (){  return this.lastName; }
    public float getWeight (){  return this.weight; }
    public int getHeight (){  return this.height; }
    public String getGender (){  return this.gender; }
    public String getCountry (){  return this.country; }
    public String getRegion (){  return this.region; }
    public String getCity (){  return this.city; }
    public String getAddress (){  return this.address; }


    void print_person_details(){
        System.out.printf("Person: %s %s weighs %s, is %s cm tall, and is %s years old. %s is %s, lives in " +
                "%s, %s, %s and has the address %s \n", firstName, lastName, weight, height, age, firstName, gender, country, region, city, address);
    }
}