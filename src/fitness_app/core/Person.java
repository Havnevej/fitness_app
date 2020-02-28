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
    public static void main(String[] args) {
        ArrayList<Person> list_with_persons = new ArrayList<>();
        Person Hussein = new Person("Hussein", "Miari", 92, 190, 20, "male", "Denmark",
                "Sjælland", "Smørum", "Erantishaven 4");
        Person Line = new Person("Line", "noob", 112, 157, 57, "female", "Denmark",
                "Sjælland", "Roskilde", "CoronaVirus 5");

        // adds the new person to our arraylist of persons
        list_with_persons.add(Hussein);
        list_with_persons.add(Line);

        // assigning new attributes
        Hussein.setAge(23);
        Hussein.setFirstName("Karl");
        Hussein.setLastName("Karlsen");
        Hussein.setAddress("Erantishaven 5");
        Hussein.setCity("København");
        Hussein.setCountry("Sverige");
        Hussein.setGender("female");
        Hussein.setWeight(119);
        Hussein.setHeight(215);
        Hussein.setRegion("Jylland");

        Line.setAge((20));
        Line.setFirstName("Line");
        Line.setLastName("Bøv");
        Line.setAddress("Corona");
        Line.setCity("København");
        Line.setCountry("Kina");
        Line.setGender("Demigirl");
        Line.setWeight(121);
        Line.setHeight(120);
        Line.setRegion("Jylland");

        for(Person a_person_in_theList : list_with_persons){
            a_person_in_theList.print_person_details();
        }
    }
}