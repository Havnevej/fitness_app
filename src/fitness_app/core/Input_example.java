package fitness_app.core;

import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class Input_example {
    static List<String> commands = Arrays.asList("help", "item", "quit");

    public static void main(String[] args) {
        main_loop_2();

    }
    static void main_loop(){
        //We need to initialize a string to and empty string, so that we can start the while loop
        String input = "";
        Scanner input_reader = new Scanner(System.in);

        //run loop until the input is quit eg: user types quit
        while (!input.equals("quit")){
            //take user input and put into input variable
            System.out.print("Enter command: ");
            input = input_reader.nextLine();

            // we check if wthe thing user entered is a command in our command list
            if(commands.contains(input)){
                System.out.println(input + " is a command");
            } else {
                System.out.println(input + " Is not a recognized command");
            }
        }
    }
    static void main_loop_2(){
        //We need to initialize a string to and empty string, so that we can start the while loop
        String input = "";
        Scanner input_reader = new Scanner(System.in);

        //run loop until the input is quit eg: user types quit
        while (true){
            //take user input and put into input variable
            System.out.print("Enter command: ");
            input = input_reader.nextLine();

            //checks if the user input is quit, if it is, we break the while loop. This avoids the print statements
            if(input.equals("quit")){break;}

            // we check if wthe thing user entered is a command in our command list
            if(commands.contains(input)){
                System.out.println(input + " is a command");
            } else {
                System.out.println(input + " Is not a recognized command");
            }
        }
    }
}
