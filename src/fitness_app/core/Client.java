package fitness_app.core;

import java.util.*;

public class Client {
    public static ArrayList<Person> list_with_people = new ArrayList<>();
    private static ArrayList<String> commands = new ArrayList<>(Arrays.asList("QUIT",
            "CREATE PERSON",
            "DELETE PERSON",
            "LOGIN",
            "LOGOUT"
    ));
    static Person this_person = new Person();


    public static void main(String[] args) {
        main_loop();
    }

    private static void print_commands_available(){
        if(this_person.is_logged_in()){System.out.printf("Logged in as: %s", this_person.getUsername());}
        System.out.println("\nCommands:");
        for(String s : commands){
            System.out.printf("|%s", s);
        }
        System.out.print("|\n");
    }

    private static void main_loop()  {
        Scanner input_reader = new Scanner(System.in);
        try {
            while(true){
                print_commands_available();
                String input = input_reader.nextLine().toUpperCase();
                switch (input){
                    case "QUIT":
                        System.exit(0);
                        break;
                    case "CREATE PERSON":
                        Database_functions.create_person_from_user_input();
                        break;
                    case "DELETE PERSON":
                        if(!this_person.is_logged_in()){break;}
                        System.out.print("delete user by: 'email'|'id'\n:");
                        input = input_reader.nextLine().toUpperCase();
                        switch (input) {
                            case "ID":
                                System.out.print("id: ");
                                int id = input_reader.nextInt();
                                Database_functions.delete_person_by_id(id);
                                break;
                            case "EMAIL":
                                System.out.print("email: ");
                                String email = input_reader.nextLine();
                                Database_functions.delete_person_by_email(email);
                                break;
                            default:
                                System.out.println("Input should be 'email' or 'id'");
                            }
                        break;
                    case "LOGIN":
                        Database_functions.login_user();
                        break;
                    case "LOGOUT":
                        this_person = new Person();
                        System.out.println("Logged out user");
                        break;
                    default:
                        System.out.println("Command not found");
                }
            }
        }
        catch (InputMismatchException e){ //InputMismatchException
            System.out.println("Error: " + e + " Input mismatch" );
        }
    }
}
