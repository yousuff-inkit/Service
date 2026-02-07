<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
String part=request.getParameter("partno");
String docno=request.getParameter("docno");
 	try{
	Statement stmt = conn.createStatement ();
	String strSql = "select * from my_main where status <>7 and trim(part_no)='"+part+"' and doc_no!="+docno;
	ResultSet rs = stmt.executeQuery(strSql);
	String scategory="";
	String scategoryid="";
	if(rs.next()) {
		scategory="1";		
  	} 
	response.getWriter().write(scategory);
	
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	}
 	finally{
 		conn.close();
 	}
  %>
  
