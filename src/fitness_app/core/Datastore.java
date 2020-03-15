package fitness_app.core;

import java.sql.*;


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

    public static void insert_person(Person p) {
        String sql = "INSERT INTO PERSON(person_firstname,person_lastname, person_email) VALUES(?,?,?)"; //statement

        try (Connection conn = get_connection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, p.getFirstName());
            statement.setString(2, p.getLastName());
            statement.setString(3, p.getEmail());
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void selectData(Person p){
        String sql2 = "SELECT * FROM PERSON WHERE person_email = 'hkmiari@ruc.dk'";

        try (Connection conn = get_connection();
             Statement statement = conn.createStatement()) {

            ResultSet rs = statement.executeQuery(sql2);
                while (rs.next()){
                    System.out.println(rs.getString("person_firstname") + "\t" +
                            rs.getString("person_lastname"));
                }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void main(String[] args) {

        Person hussein = new Person("Ha", "Hansen", 92, 190, 20, "male", "Denmark",
                "Sjælland", "Smørum", "Erantishaven 4", "hkmiari@ruc.dk");
        insert_person(hussein);
        selectData(hussein);
    }
}
