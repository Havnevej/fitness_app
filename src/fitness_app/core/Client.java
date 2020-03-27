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
                String input =input_reader.nextLine();
                if (input.toUpperCase().equals("CREATE PERSON")) {
                    Database_functions.take_input();
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
