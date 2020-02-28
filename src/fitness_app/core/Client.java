package fitness_app.core;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Scanner;

public class Client {
    private static ArrayList<Person> list_with_people = new ArrayList<>();

    //takes userinput and processes it
    public static void take_input() {

        Scanner user_input = new Scanner(System.in);

        System.out.print("Name: ");
        String User_Name = user_input.nextLine();

        System.out.println("Last name: ");
        String User_lastname = user_input.nextLine();

        System.out.println("Age: ");
        int User_Age = user_input.nextInt();

        System.out.println("weight(optional): ");
        int User_weight = user_input.nextInt();

        System.out.println("Height(optional): ");
        int User_height = user_input.nextInt();

        //create new person with fields from input, store this new person in a temponary variable
        Person new_user = new Person(User_Name, User_lastname, User_weight, User_height, User_Age, "female", "Denmark",
                "Sjælland", "Roskilde", "CoronaVirus 5");
        //Puts the new user in the list we have
        list_with_people.add(new_user);
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
        take_input();
        for(Person a_person_in_theList : list_with_people){
            a_person_in_theList.print_person_details();
        }
    }
}