package fitness_app.core;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Client {
    private static ArrayList<Person> list_with_people = new ArrayList<>();

    //takes userinput and processes it
    public static void take_input() {
        Scanner user_input = new Scanner(System.in);    //Take input from system.in (stdin)
        Person user_we_are_creating = new Person();     //using the first constructor as we pass no arguments
        try {
            //firstname
            System.out.println("first name:");
            user_we_are_creating.setFirstName(user_input.nextLine());
            //lastname
            System.out.println("last name:");
            user_we_are_creating.setLastName(user_input.reset().nextLine());

            //age
            System.out.println("Date of birth: (dd/MM/yyyy)");

            System.out.println("dd");
            int day = Integer.parseInt(user_input.nextLine());
            System.out.println("MM");
            int month = Integer.parseInt(user_input.nextLine());
            System.out.println("yyyy");
            int year = Integer.parseInt(user_input.nextLine());

            LocalDate start = LocalDate.of(year, month, day);
            LocalDate end = LocalDate.now();
            // Calculates how long it has been since input date:
            long years = ChronoUnit.YEARS.between(start, end);
            // convert long to int since setAge expects an int.
            int years_int = (int)years;
            user_we_are_creating.setAge(years_int);


            System.out.println("Weight (optional):");
            String optional_input = user_input.nextLine();
            if(optional_input.isEmpty()){user_we_are_creating.setWeight(0f);}else
            {user_we_are_creating.setWeight(Float.parseFloat(optional_input));
            }
            System.out.println("Height (optional):");
            optional_input = user_input.nextLine();
            if(optional_input.isEmpty()){user_we_are_creating.setHeight(0);}else
            {user_we_are_creating.setHeight(Integer.parseInt(optional_input));
            }

        } catch (Exception e) { //InputMismatchException
            System.out.println(e.getMessage() + "You have entered a wrong datatype for a field, try [A]gain or press any key to exit creating a person");
            String response = user_input.nextLine();
            if(response.toUpperCase().equals("A")) {
                take_input();
            } // if the user does not enter "a" the function quits, which also prevents the adding of the person to the list
            return;
        }

        list_with_people.add(user_we_are_creating);
    }
    public static void main(String[] args) {
        // DEBUG PEOPLE, SHOULD BE A TEST FOR THE FUTURE ///////////////////////////
        Person Hussein = new Person("Hussein", "Miari", 92, 190, 20, "male", "Denmark",
                "Sjælland", "Smørum", "Erantishaven 4");
        Person Line = new Person("Line", "noob", 112, 157, 57, "female", "Denmark",
                "Sjælland", "Roskilde", "CoronaVirus 5");
        list_with_people.add(Hussein);
        list_with_people.add(Line);
        // DEBUG PEOPLE, SHOULD BE A TEST FOR THE FUTURE ///////////////////////////
        main_loop();
    }
    static void main_loop()  {
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
}
