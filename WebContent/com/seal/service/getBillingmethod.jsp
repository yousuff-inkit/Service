<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	 
    ClsConnection conobj= new ClsConnection();
 	Connection conn = conobj.getMyConnection();
	Statement stmt = conn.createStatement ();

	String strSql = "select doc_no, name from sa_billmethod where status=3";  
	ResultSet rs = stmt.executeQuery(strSql);
	String currId="",currCode="";
	while(rs.next()) {   
	         	currId+=rs.getString("doc_no")+",";
	        	currCode+=rs.getString("name")+",";  
	}
	if(!currId.equals("")){
		    currId = currId.substring(0, currId.length()-1);
		    currCode = currCode.substring(0, currCode.length()-1);
   	}    
   
    response.getWriter().write(currId+"####"+currCode);    
	stmt.close();
	conn.close();
  %>