package fitness_app.core;
import java.lang.reflect.Array;
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
    private static ArrayList<String> commands = new ArrayList<>(Arrays.asList("QUIT",
            "CREATE_PERSON",
            "LOGIN"));


    public static void main(String[] args) {
        while(!login_user()){

        }
        main_loop();
    }

    private static boolean login_user() {

        return false;
    }

    private static void main_loop()  {
        //needs cleanup
        Scanner input_reader = new Scanner(System.in);
        System.out.println("To create a person type: 'create person'");
        try {
            while(true){
                String input = input_reader.nextLine().toUpperCase();
                if(commands.contains(input)){
                    if(input.equals("QUIT")){System.exit(0);} // quit
                    else if(input.equals("CREATE PERSON")){
                        Database_functions.create_person_from_user_input(); //need implementation
                    } else if(input.equals("DELETE PERSON")){
                        Database_functions.delete_person(); //need implementation
                    } else if(input.equals("LOGIN")){
                        Database_functions.login_user(); //need implementation
                    }

                }

            }
        }
        catch (InputMismatchException e){ //InputMismatchException
            System.out.println("Error: " + e + " Input can only be numbers" );
        }
    }
}
