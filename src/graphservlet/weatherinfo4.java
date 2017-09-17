

package graphservlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*; 

import org.jfree.chart.ChartUtilities;
import org.jfree.chart.ChartFactory; 
import org.jfree.chart.JFreeChart; 
import org.jfree.data.general.DefaultPieDataset;




import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.jdbc.JDBCCategoryDataset;
import org.jfree.data.jdbc.JDBCPieDataset;

import graph.weatherData;

public class weatherinfo4 extends HttpServlet {
        private static final long serialVersionUID = 1L;
        private Connection dbConnection = null;

        public weatherinfo4() {
                dbConnection = weatherData.getConnection();
        }

        public void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
	JDBCCategoryDataset dataset = new JDBCCategoryDataset(dbConnection);
	//JDBCCategoryDataset dataset1 = new JDBCCategoryDataset(dbConnection);

        try {
        	
        dataset.executeQuery("SELECT datetime,PHvalueType FROM weathervalue ORDER by weathervalueID limit 0,9 ");
        String ph;
        ph=("PHvalueType");
        System.out.println(ph);
        
        JFreeChart chart = ChartFactory.createLineChart(
                "PHvalue", "datetime", "PHvalue",
                dataset, PlotOrientation.VERTICAL, true, false, true);           
                chart.setBorderVisible(true);
         
         if (chart != null) {
                 int width = 300;
                 int height = 220;
                 response.setContentType("image/jpeg");
                 OutputStream out = response.getOutputStream();
                 ChartUtilities.writeChartAsJPEG(out, chart, width, height);
         }
         
                
         
         
        }
        catch (SQLException e) {
                System.err.println(e.getMessage());
        }
        
}
}