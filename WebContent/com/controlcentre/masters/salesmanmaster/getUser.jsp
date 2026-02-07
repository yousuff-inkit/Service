<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection conobj= new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select user_id,doc_no from my_user where status<>7";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String user="";
		String userid="";
		while(rs.next()) {
			user+=rs.getString("user_id")+",";		
			userid+=rs.getString("doc_no")+",";
	  		} 
		
		user=user.substring(0, user.length()>0?user.length()-1:0);
		
		response.getWriter().write(user+"####"+userid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
