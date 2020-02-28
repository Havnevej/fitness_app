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

    Person(String firstName, String lastName, float weight, int height, int age, String gender, String country, String region, String city, String address){
        firstName = this.firstName;
        lastName = this.lastName;
        weight = this.weight;
        height = this.height;
        age = this.age;
        gender = this.gender;
        country = this.country;
        region = this.region;
        city = this.city;
        address = this.address;
    }

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
    public int getAge (int age){  return this.age; }
    public String getFirstName (String firstName){  return this.firstName; }
    public String getLastName (String lastName){  return this.lastName; }
    public float getWeight (float weight){  return this.weight; }
    public int getHeight (String height){  return this.height; }
    public String getGender (String gender){  return this.gender; }
    public String getCountry (String country){  return this.country; }
    public String getRegion (String region){  return this.region; }
    public String getCity (String city){  return this.city; }
    public String getAddress (String address){  return this.address; }

    // printer personens detaljer ud
    void print_person_details(){
        System.out.printf("Person: %s %s weighs %s, is %s cm tall, and is %s years old. %s is %s, lives in " +
                "%s, %s, %s and has the address %s \n", firstName, lastName, weight, height, age, firstName, gender, country, region, city, address);
    }
}