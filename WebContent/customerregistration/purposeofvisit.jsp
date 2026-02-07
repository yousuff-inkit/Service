<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select doc_no,purpose  from rl_purposem where status<>7";     
		ResultSet rs = stmt.executeQuery(strSql);
		
		String purpose="";
		String doc_no="";
		while(rs.next()) {
			purpose+=rs.getString("purpose")+",";
			doc_no+=rs.getString("doc_no")+",";
	  		} 
		
		purpose=purpose.substring(0, purpose.length()>0?purpose.length()-1:0);   
		
		response.getWriter().write(purpose+"####"+doc_no);      
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
