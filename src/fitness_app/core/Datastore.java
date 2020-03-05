package fitness_app.core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Datastore {
    public static void connect() {
        Connection conn = null;
        try {
            // link
            String location = "jdbc:sqlite:database/datastore.db";
            // create a connection to the database
            conn = DriverManager.getConnection(location);
            System.out.println("Connection to SQLite has been established.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
    }
    public static void main(String[] args) {
        connect();
    }
}
