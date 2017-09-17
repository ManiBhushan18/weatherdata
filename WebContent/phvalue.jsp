
import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.data.jdbc.JDBCPieDataset;

public class JfreeChartServlet extends HttpServlet {
    
        private static Connection connection = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            JDBCPieDataset dataset = new JDBCPieDataset(getConnection());
            dataset.executeQuery("select * from result");
            JFreeChart chart = ChartFactory.createPieChart("Result Chart", dataset, true, true, false);
            chart.setBorderPaint(Color.black);
            chart.setBorderStroke(new BasicStroke(4.0f));
            chart.setBorderVisible(true);
            if (chart != null) {
                int width = 500;
                int height = 350;
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                response.setContentType("image/png");
                OutputStream out = response.getOutputStream();
                ChartUtilities.writeChartAsPNG(out, chart, width, height, info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    
    public static Connection getConnection() {
        if (connection != null)
            return connection;
        else {
            try {
                String driver = "com.mysql.jdbc.Driver";
                String url = "jdbc:mysql://localhost:3306/test";
                String user = "root";
                String password = "******";
                Class.forName(driver);
                connection = DriverManager.getConnection(url, user, password);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            } 
            return connection;
        }

    }
    
    public static ArrayList<Result> getData() {
     connection = getConnection();
        ArrayList<Result> resultList = new ArrayList<Result>();
        try {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from result");
        
            while(rs.next()) { 
             Result result=new Result();
             result.setStatus(rs.getString("status"));
             result.setCount(rs.getInt("count"));
             resultList.add(result);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultList;
    }
