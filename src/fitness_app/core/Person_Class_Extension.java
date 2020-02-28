package fitness_app.core;
import java.util.Scanner;

public class Person_Class_Extension {

    public static void yes() { //person_create

        Scanner user_input = new Scanner(System.in);

        System.out.println("Type Name: ");
        String User_Name = user_input.nextLine();
            //System.out.print(User_Name);

        System.out.println("Type Last name: ");
        String User_lastname = user_input.nextLine();
            //System.out.println(User_lastname);

        System.out.println("Type Age: ");
        int User_Age = user_input.nextInt();
            //System.out.println(User_Age);

        System.out.println("Type weight(optional): ");
        int User_weight = user_input.nextInt();
            //System.out.println(User_weight);

        System.out.println("Type height(optional): ");
        int User_height = user_input.nextInt();
            //System.out.println(User_height);

        Person New_user = new Person(User_Name, User_lastname, User_weight, User_height, User_Age, "female", "Denmark",
                "Sjælland", "Roskilde", "CoronaVirus 5");

    }
}