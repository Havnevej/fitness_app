package fitness_app.core;
import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Client {
    public static ArrayList<Person> list_with_people = new ArrayList<>();

    private static void optional_input(String field, Person p) throws NoSuchFieldException, IllegalAccessException { // field is not found in class
        Scanner user_input = new Scanner(System.in); //start a new user input scanner
        Field the_field = Person.class.getField(field); //gets the field from the string (if it does not exist eg. we type weighs and not weight like it is in person class, it throws no such field)
        Type t = the_field.getType(); //gets the field from the field

        System.out.printf("%s (optional):", field); //prints eg. weight (optional):
        String optional_input = user_input.nextLine();
        System.out.println(t.getTypeName()); // prints the type of the field that we got (debugging)

        if(!optional_input.isEmpty()) {
            switch (t.getTypeName()) {
                case "string":
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
    private static void take_input() {
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
                take_input();
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
            optional_input("Country", user_we_are_creating);
            //Region(optional)
            optional_input("Region", user_we_are_creating);
            //City(optional)
            optional_input("City", user_we_are_creating);
            //Address(optional)
            optional_input("Address", user_we_are_creating);

            //email
            System.out.println("Email: ");
            String mail_input = user_input.nextLine();
            if(isValidEmailAddress(mail_input) == true){ //temporary
                user_we_are_creating.setEmail(mail_input);
            }

        } catch (Exception e) { //InputMismatchException
            System.out.println(e.getMessage() + "You have entered a wrong datatype for a field, try [A]gain or press any key to exit creating a person");
            String response = user_input.nextLine();
            if(response.toUpperCase().equals("A")) {
                take_input();
            } // if the user does not enter "a" the function quits, which also prevents the adding of the person to the list
            return;
        }
        Datastore.insert_person(user_we_are_creating);
        list_with_people.add(user_we_are_creating);
    }
    public static int age_calculator(String s) throws ParseException {
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
    public static void main(String[] args) {
        // DEBUG PEOPLE, SHOULD BE A TEST FOR THE FUTURE ///////////////////////////
        Person Hussein = new Person("Hussein", "Miari", 92, 190, 20, "male", "Denmark",
                "Sjælland", "Smørum", "Erantishaven 4","hussein@hotmail.com");
        Person Line = new Person("Line", "noob", 112, 157, 57, "female", "Denmark",
                "Sjælland", "Roskilde", "CoronaVirus 5", "blabla@gmail.com");
        list_with_people.add(Hussein);
        Hussein.getBmi();
        list_with_people.add(Line);
        // DEBUG PEOPLE, SHOULD BE A TEST FOR THE FUTURE ///////////////////////////
        main_loop();
    }
    private static void main_loop()  {
        //needs cleanup
        Scanner input_reader = new Scanner(System.in);
        System.out.println("Type: 'Create person'");
        try {
            while(true){
                String input =input_reader.nextLine();
                if (input.toUpperCase().equals("CREATE PERSON")) {
                    take_input();
                    for(Person a_person_in_theList : list_with_people){
                        a_person_in_theList.print_person_details();
                    }
                } else if(!(input.equals("quit"))){
                    System.out.println("Input is unacceptable - Type: 'Create person'");
                }
                System.out.println("To exit type: 'quit'");
                if(input.equals("quit")){break;}
            }
        }
        catch (InputMismatchException e){ //InputMismatchException
            System.out.println("Error: " + e + " Input can only be numbers" );
        }
    }
    public static boolean isValidEmailAddress (String email) {
        String ePattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"; //Reg-ex Provided from OWASP Validation Regex repository.
        Pattern p = Pattern.compile(ePattern);
        Matcher m = p.matcher(email);
        return m.matches();
        //System.out.println(isValidEmailAddress("asfas@hotmail.com"));
    }
}
