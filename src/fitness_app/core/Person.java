package fitness_app.core;


public class Person {
    private String firstName;
    private String lastName;
    public float weight;
    public float height;
    public int age;
    public String gender;
    public String country;
    public String region;
    public String city;
    public String address;
    public String email;
    public String username;
    public String password;

    private boolean is_logged_in = false;
    private boolean valid_person = false;
    private float bmi;
    private int id = Client.list_with_people.size();


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
        email = "";
        username = "";
        password = "";
    }

    //overloaded constructor for when we have all the data.
    public Person(String setFirstName, String setLastName, float setWeight, float setHeight, int setAge, String setGender, String setCountry, String setRegion, String setCity, String setAddress, String setEmail, String setUsername, String setPassword){
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
        email = setEmail;
        username = setUsername;
        password = setPassword;

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
    public void setEmail (String email) { this.email = email; }
    public void setUsername (String username) { this.username = username; }
    public void setPassword (String password) { this.password = password; }
    public void setIs_logged_in(boolean is_logged_in) { this.is_logged_in = is_logged_in; }

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
    public String getEmail (){ return this.email; }
    public String getUsername() {return this.username; }
    public String getPassword() {return this.password; }
    public boolean isIs_logged_in() { return is_logged_in; }

    public int getId() { return id; }
    public float getBmi(){
        calcBMI();
        return bmi;
    }

    private void calcBMI(){
        bmi = (float) Math.round(weight/Math.pow(height/100,2));
    }

    //not implemented
    //Could be moved to "Person handler wrapper class" around "Person" class
    boolean is_valid_person (Person this){
        //check if this instance of person class is valid, does it have the correct values?
        valid_person = false;
        return false;
    }

    public void print_person_details(){
        System.out.println(getId());
        System.out.printf("Person: %s %s weighs %s, is %s cm tall, and is %s years old. %s is %s, lives in " +
                "%s, %s, %s and has the address %s, Email: %s, Username: %s, Password: %s ,\nBMI: %s.\n", firstName, lastName, weight, height, age, firstName, gender, country, region, city, address, email, username, password, getBmi());
    }
}
