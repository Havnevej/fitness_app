package fitness_app.core;
import java.sql.Time;
import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Client {
    private static ArrayList<Person> list_with_people = new ArrayList<>();

    //takes userinput and processes it
    public static void take_input() {

        Scanner user_input = new Scanner(System.in);
        //For future work the inputs with characters and numbers can be split into two cases where the scanner is limited to only number etc. input.

        //NAME
        System.out.print("Name: ");
        String User_Name = user_input.nextLine();

        System.out.print("Last name: ");
        String User_lastname = user_input.nextLine();
        //AGE
        System.out.print("Age: ");
        int User_Age =0;
        try {User_Age = Integer.parseInt(user_input.nextLine());} catch(Exception e){
            System.out.print(" Age is a number dummie");
        }

        //Optional inputs: Making a condition where the program sets the optional values equal to 0 when no values are given by user.
        //WEIGHT
        System.out.print("weight(optional): ");
        String gg;
        int User_weight = 0;
        try{
            gg = user_input.nextLine();
            if (gg.isEmpty()){
                User_weight = User_weight + 0;}
            else if(!gg.isEmpty()){User_weight=Integer.parseInt(gg);}} catch (Exception e){
            System.out.print(" Weight is a number!");
            }

        //HEIGHT
        System.out.print("Height(optional): ");
        String haha = user_input.nextLine();
        int User_height =0;
        try{
        if(haha.isEmpty()){
            User_height=User_height+0;}
        else if(!haha.isEmpty()){User_height=Integer.parseInt(haha);}}catch (Exception e){
            System.out.print(" Height is a number!");
        }

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