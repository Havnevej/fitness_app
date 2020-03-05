package fitness_app.core;

public class Person {
    private String firstName;
    private String lastName;
    private float weight;
    private float height;
    private int age;
    private String gender;
    private String country;
    private String region;
    private String city;
    private String address;
    private boolean valid_person = false;
    private float bmi;
    //private void setBmi (float bmi){this.bmi = (weight / height); }


    public Person (){
        firstName = "";
        lastName = "";
        age = -1;
        weight = -1;
        height = -1;
        gender = "";
        country = "";
        region = "";
        city = "";
        address = "";
        bmi = -1;


    }
    //overloaded constructor for when we have all the data.
    public Person(String setFirstName, String setLastName, float setWeight, float setHeight, int setAge, String setGender, String setCountry, String setRegion, String setCity, String setAddress, float setBmi
    ){
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
        bmi = setBmi;


    }
    // setters
    public void setAge(int age){ this.age = age; }
    public void setFirstName (String firstName){ this.firstName = firstName; }
    public void setLastName (String lastName){ this.lastName = lastName; }
    public void setWeight (float weight){ this.weight = weight; }
    public void setHeight(float height){ this.height = height; }
    public void setGender (String gender){ this.gender = gender; }
    public void setCountry(String country){ this.country = country; }
    public void setRegion (String region){ this.region = region; }
    public void setCity (String city){ this.city = city; }
    public void setAddress (String address){ this.address = address; }
    public void setBmi(float bmi){ this.bmi = this.weight / (this.height/100); }



    //getters
    public int getAge (){  return this.age; }
    public String getFirstName (){  return this.firstName; }
    public String getLastName (){  return this.lastName; }
    public float getWeight (){  return this.weight; }
    public float getHeight (){  return this.height; }
    public String getGender (){  return this.gender; }
    public String getCountry (){  return this.country; }
    public String getRegion (){  return this.region; }
    public String getCity (){  return this.city; }
    public String getAddress (){  return this.address; }
    public float getBmi (){ return this.bmi; }


    //not implemented
    //Could be moved to "Person handler wrapper class" around "Person" class
    boolean is_valid_person (Person this){
        //check if this instance of person class is valid, does it have the correct values?
        valid_person = false;
        return false;
    }

    public void print_person_details(){
        System.out.printf("Person: %s %s weighs %s, is %s cm tall, and is %s years old. %s is %s, lives in " +
                "%s, %s, %s and has the address %s \n bmi: %s", firstName, lastName, weight, height, age, firstName, gender, country, region, city, address, bmi);
    }
    public void getBMI(){
        getBmi();
        System.out.println(getBmi());
    }

}