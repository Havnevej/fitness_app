package fitness_app.core;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;


public class Client {
    public static ArrayList<Person> list_with_people = new ArrayList<>();

    //takes userinput and processes it
    public static void take_input() {
        Scanner user_input = new Scanner(System.in);    //Take input from system.in (stdin)
        Person user_we_are_creating = new Person();     //using the first constructor as we pass no arguments

        try {
            //firstname
            System.out.print("first name:");
            user_we_are_creating.setFirstName(user_input.nextLine());
            //lastname
            System.out.print("last name:");
            user_we_are_creating.setLastName(user_input.nextLine());
            //optional weight, we could continue to add all the fields under here and allow empty input
            System.out.print("weight (optional):");
            user_we_are_creating.setWeight(user_input.nextFloat());
            System.out.print("height (optional):");
            user_we_are_creating.setHeight(user_input.nextFloat());


        } catch (InputMismatchException e) {
            System.out.println(e.getMessage() + "You have entered a wrong datatype for a field, try [A]gain or press any key to exit creating a person");
            String response = user_input.reset().nextLine();
            if(response.toUpperCase().equals("A")) {
                take_input();
            } // if the user does not enter "a" the function quits, which also prevents the adding of the person to the list
            return;
        }

        list_with_people.add(user_we_are_creating);
    }
    public static void main() {
        // DEBUG PEOPLE, SHOULD BE A TEST FOR THE FUTURE ///////////////////////////
        Person Hussein = new Person("Hussein", "Miari", 92, 190, 20, "male", "Denmark",
                "Sjælland", "Smørum", "Erantishaven 4");
        list_with_people.add(Hussein);
        Person Line = new Person("Line", "noob", 112, 157, 57, "female", "Denmark",
                "Sjælland", "Roskilde", "CoronaVirus 5");
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
                if (input.equals("Create person")) {
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
        catch (Exception e){ //InputMismatchException
            System.out.println("Error: " + e + " Input can only be numbers" );
        }
    }
}