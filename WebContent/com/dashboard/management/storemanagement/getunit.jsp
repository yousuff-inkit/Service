  <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 
Connection conn =null;
 try
{
	 			ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String doc_no="";
	String type="";
	 		String strSql = "select unit code,doc_no from my_unitm where status=3  ";
		
		ResultSet rs = stmt.executeQuery(strSql);
	 
	 
		while(rs.next()) {
			doc_no+=rs.getInt("doc_no")+",";
			type+=rs.getString("code")+",";
		 
	  		} 
	 	response.getWriter().write(doc_no+"####"+type);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>
  
 