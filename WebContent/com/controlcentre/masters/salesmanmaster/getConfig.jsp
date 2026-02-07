<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select  method from gl_config where field_nme in('helper')";
	ResultSet rs = stmt.executeQuery(strSql);
	int helper=0;
	if(rs.next()) {
		helper=rs.getInt("method");
	}
	
	System.out.println("=====method==========="+helper);
	
	response.getWriter().write(helper+"###");
	
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>
  
