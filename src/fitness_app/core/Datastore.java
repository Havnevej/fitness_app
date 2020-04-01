package fitness_app.core;

import java.sql.*;
import java.util.Scanner;


public class Datastore {
    //Ignore this, for future use
    public static Connection get_connection(String database_descriptor, String database_location_url) {
        Connection conn = null;
        try {
            // link to the database (jdbc java database connectivity) : sqlite (type of database connectivity) : location to the actual database
            String location = String.format("jdbc:%s:%s",database_descriptor,database_location_url);
            // create a connection to the database
            conn = DriverManager.getConnection(location);
            System.out.println("Connection to SQLite has been established.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return null;
        }
        return conn;
    }

    //dont ignore this, our actual database connection as of now, we use the local database located in PROJECT_ROOT/database/datastore.db
    public static Connection get_connection() {
        Connection conn;
        try {
            // link to the database explanation - jdbc (java database connectivity) : sqlite (type of database connectivity) : location to the actual database
            String location = "jdbc:sqlite:database/datastore.db";
            // create a connection to the database
            conn = DriverManager.getConnection(location);
            System.out.println("Connection to SQLite has been established.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return null;
        }
        return conn;
    }
    public boolean login_user(String email, String username, String password){
        return false;
    }

    public static void insert_person(Person p) {
        String sql = "INSERT INTO PERSON(firstname,lastname, email, weight, height," +
                "age, gender, country, region, city, address) VALUES(?,?,?,?,?,?,?,?,?,?,?)"; //statement

        try (Connection conn = get_connection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, p.getFirstName());
            statement.setString(2, p.getLastName());
            statement.setString(3, p.getEmail());
            statement.setFloat(4, p.getWeight());
            statement.setFloat(5, p.getHeight());
            statement.setInt(6, p.getAge());
            statement.setString(7, p.getGender());
            statement.setString(8, p.getCountry());
            statement.setString(9, p.getRegion());
            statement.setString(10, p.getCity());
            statement.setString(11, p.getAddress());

            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static Person select_data(String email){
        Person person = new Person();
        String sql = String.format("SELECT * FROM PERSON WHERE email = '%s'", email);
        try (Connection conn = get_connection();
             Statement statement = conn.createStatement()) {

            ResultSet rs = statement.executeQuery(sql);
            person.setFirstName(rs.getString("firstname"));
            person.setLastName(rs.getString("lastname"));
            person.setEmail(email);
            person.setWeight(rs.getInt("weight"));
            person.setHeight(rs.getInt("height"));
            person.setAge(rs.getInt("age"));
            person.setGender(rs.getString("gender"));
            person.setCountry(rs.getString("country"));
            person.setRegion(rs.getString("region"));
            person.setCity(rs.getString("city"));
            person.setAddress(rs.getString("address"));
            rs = statement.executeQuery(String.format("SELECT * FROM PERSON_DETAILS WHERE email = '%s'", email));
            person.setUsername(rs.getString("username"));
            person.setPassword(rs.getString("password"));

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return person;
    }

    public static void log_in_database(String email){
        Scanner input_reader = new Scanner(System.in);
        if(Database_functions.email_is_valid_Address(email)) {
            String sql = String.format("SELECT username,password FROM PERSON_DETAILS WHERE email = '%s'",email);

            try (Connection conn = Datastore.get_connection(); Statement statement = conn.createStatement()) {

                ResultSet rs = statement.executeQuery(sql);
                String Username = (rs.getString("username"));
                String Password = (rs.getString("password"));

                System.out.println("Username: ");
                String user_username = input_reader.nextLine();
                System.out.println("Password: ");
                String user_password = input_reader.nextLine();

                if(Username.equals(user_username) && Password.equals(user_password)){
                    System.out.println("Login successful!");
                    Client.this_person = Datastore.select_data(email);
                    Client.this_person.setIs_logged_in(true);
                }
                else{
                    System.out.println("Login failed: Username and or password are wrong");
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }



    public static void main(String[] args) {
        Person person = select_data("abdue@ruc.dk");
        System.out.println(person.getFirstName() + person.getLastName());
    }
}

