<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>weatherData</title>
</head>
<body>
<% 
Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection("jdbc:mysql:///weather","root","mani17");


    Statement ss=con.createStatement();
    String q="select * from weathervalue";
    ResultSet rs =ss.executeQuery(q);
 %>
 
    <table cellpadding="7" cellspacing="1.5" border="0.75" bgcolor="">
      <tr>
        <td>weatherDataID</td>
        <td>datetime</td>
        <td>humidity</td>
         <td>tempC</td>
        
        
        
      </tr>
      
 <%
   while(rs.next())  
    {
	   %>
	    <tr>
	   <td><%=rs.getInt(1)%></td>
	   <td><%=rs.getString(2)%></td>
	   <td><%=rs.getDouble(3)%></td>
	 <td><%=rs.getDouble(4)%></td>
	
	       
	       
       <%}%>
</body>
</html>