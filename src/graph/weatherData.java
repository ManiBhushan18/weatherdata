package graph;

import java.sql.Connection;
import java.sql.DriverManager;

public class weatherData {
        private static Connection connection = null;

        public static Connection getConnection() {
                if (connection != null)
                        return connection;
                else {
                        // Store the database URL in a string
                	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
                	String DB_URL = "jdbc:mysql:///weather";
                	String USER = "root";
                	String PASS = "mani17";
                try {
                Class.forName("com.mysql.jdbc.Driver");
                // set the url, username and password for the database
                connection = DriverManager.getConnection(DB_URL, USER, PASS);
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return connection;
                
        }
        }
}
