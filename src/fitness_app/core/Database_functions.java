package fitness_app.core;

import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Database_functions {
    private static void optional_input(String field, Person p) throws NoSuchFieldException, IllegalAccessException { // field is not found in class
        Scanner user_input = new Scanner(System.in); //start a new user input scanner
        Field the_field = Person.class.getField(field); //gets the field from the string (if it does not exist eg. we type weighs and not weight like it is in person class, it throws no such field)
        Type t = the_field.getType(); //gets the field from the field

        System.out.printf("%s (optional):", field); //prints eg. weight (optional):
        String optional_input = user_input.nextLine();
        //System.out.println(t.getTypeName()); // prints the type of the field that we got (debugging)

        if(!optional_input.isEmpty()) {
            switch (t.getTypeName()) {
                case "java.lang.String":
                    the_field.set(p, optional_input);
                    break;
                case "integer":
                    the_field.set(p, Integer.parseInt(optional_input));
                    break;
                case "float":
                    the_field.set(p, Float.parseFloat(optional_input));
                    break;
            }
        }
        //if the input is empty we dont do anything because it is already null, we will handle this case when we insert into database.
    }

    //takes userinput and processes it
    private static void create_user_manual_take_input() {
        Scanner user_input = new Scanner(System.in);    //Take input from system.in (stdin)
        Person user_we_are_creating = new Person();     //using the first constructor as we pass no arguments
        try {

            //Gender
            System.out.println("Gender: Male || Female ");
            String gender = user_input.nextLine();
            if(gender.toUpperCase().equals("MALE") || gender.toUpperCase().equals("FEMALE")){ //temporary?
                user_we_are_creating.setGender(gender);
            }
            else {
                System.out.println("invalid input - try again:");
                create_user_manual_take_input();
            }
            //firstname
            System.out.println("first name:");
            user_we_are_creating.setFirstName(user_input.nextLine());
            //lastname
            System.out.println("last name:");
            user_we_are_creating.setLastName(user_input.reset().nextLine());
            //age
            System.out.println("Date of birth: (dd/MM/yyyy)");

            String s =  user_input.nextLine();
            user_we_are_creating.setAge(age_calculator(s));

            //Weight(optional)
            optional_input("weight", user_we_are_creating);
            //Height(optional)
            optional_input("height", user_we_are_creating);
            //Country(optional)
            optional_input("country", user_we_are_creating);
            //Region(optional)
            optional_input("region", user_we_are_creating);
            //City(optional)
            optional_input("city", user_we_are_creating);
            //Address(optional)
            optional_input("address", user_we_are_creating);

            //email
            System.out.println("Email: ");
            String mail_input = user_input.nextLine();
            if(email_is_valid_Address(mail_input)){ //temporary
                user_we_are_creating.setEmail(mail_input);
            }

            //username
            System.out.println("Enter Username: ");
            user_we_are_creating.setUsername(user_input.nextLine());

            //password
            System.out.println("Enter password");
            user_we_are_creating.setPassword(user_input.nextLine());


        } catch (Exception e) { //InputMismatchException
            System.out.println(e.getMessage() + "You have entered a wrong datatype for a field, try [A]gain or press any key to exit creating a person");
            String response = user_input.nextLine();
            if(response.toUpperCase().equals("A")) {
                create_user_manual_take_input();
            } // if the user does not enter "a" the function quits, which also prevents the adding of the person to the list
            return;
        }
        Datastore.insert_person(user_we_are_creating);
    }

    private static int age_calculator(String s) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date d = sdf.parse(s);
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH) + 1;
        int date = c.get(Calendar.DATE);
        LocalDate l1 = LocalDate.of(year, month, date);
        LocalDate now1 = LocalDate.now();
        Period diff1 = Period.between(l1, now1);
        return diff1.getYears();
    }

    public static boolean email_is_valid_Address(String email) {
        String ePattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"; //Reg-ex Provided from OWASP Validation Regex repository.
        Pattern p = Pattern.compile(ePattern);
        Matcher m = p.matcher(email);
        return m.matches();
    }

    public static void delete_person_by_email(String email) { 
        if(email_is_valid_Address(email)) {
            System.out.printf("Delete by email: %s", email);
        } else {
            System.out.printf("Email format not valid for: %s", email);
        }
    }
    public static void delete_person_by_id(int id) {
        System.out.printf("Delete by id: %s", id);
    }

    public static void login_user() {

    Scanner input_reader = new Scanner(System.in);

        System.out.println("Email: ");
        String email = input_reader.nextLine();

        if(email_is_valid_Address(email)) {
            System.out.println("Username: ");
            String username = input_reader.nextLine();
            System.out.println("Password: ");
            String password = input_reader.nextLine();

            if(Datastore.login_user(email,username,password)){

            } else {

            }

        } else {
            System.out.printf("Email format not valid for: %s", email);
        }
    }

    static void create_person_from_user_input(){
        create_user_manual_take_input();
    }
}
