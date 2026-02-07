<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>

<%	ClsConnection connDAO=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn =null;

	String date=request.getParameter("date");
	String months=request.getParameter("months");
 	try
 	{
 	  	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		java.sql.Date sqlDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		String strSql = "SELECT DATE_FORMAT(DATE_ADD('"+sqlDate+"', INTERVAL "+months+" MONTH),'%d.%m.%Y') to_date;";
		ResultSet rs = stmt.executeQuery(strSql); 
		
		String toDate="";
		while(rs.next()) {
			toDate=rs.getString("to_date");
  		} 

		response.getWriter().write(toDate);
		stmt.close();
		conn.close();
 	}
 	catch(Exception e0)
 	{
 		conn.close();
 	}
 	
  %>
  
