package fitness_group.portefølje;

import java.sql.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        Scanner user_input = new Scanner(System.in);
        //AVERAGE STUDENT GRADE
        System.out.println("Enter student full name: ");

        String[] navn;
        navn = user_input.nextLine().split(" ");
        String fornavn = navn[0];
        String efternavn = navn[1];

        get_average_grades(fornavn,efternavn);

        //AVERAGE COURSE
        System.out.println("Enter course name: ");
        String course = user_input.nextLine();
        get_average_grades_for_course(course);


    }
    private static Connection get_connection() {
        Connection conn;
        try {
            // link to the database explanation - jdbc (java database connectivity) : sqlite (type of database connectivity) : location to the actual database
            String location = "jdbc:sqlite:database/portefølje2.db";
            // create a connection to the database
            conn = DriverManager.getConnection(location);
            //System.out.println("Connection to SQLite has been established.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return null;
        }
        return conn;
    }
    private static void get_average_grades(String fornavn, String efternavn){

        String sql = ("SELECT FORNAVN, EFTERNAVN, AVG(grade) as average_grade \n" +
                "FROM(\n" +
                "SELECT* FROM ES1_2019\n" +
                "UNION\n" +
                "SELECT* FROM SD_2019\n" +
                "UNION\n" +
                "SELECT* FROM SD_2020) \n" +
                "WHERE fornavn ='"+fornavn+"' AND efternavn = '"+efternavn+"'");


        try (Connection conn = get_connection();
             Statement statement = conn.createStatement()) {

            ResultSet rs = statement.executeQuery(sql);
            while(rs.next()){
                System.out.print(rs.getString("fornavn")+"\t");
                System.out.print(rs.getString("average_grade"));
                System.out.println();
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private static void get_average_grades_for_course(String course){

        String sql = String.format("SELECT AVG(grade)  as average_grade_%s FROM %s", course, course);

        try (Connection conn = get_connection();
             Statement statement = conn.createStatement()) {

            ResultSet rs = statement.executeQuery(sql);
            while(rs.next()){
                System.out.printf("Average grade for %s: " + rs.getString("average_grade_"+course), course);
                System.out.println();
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
