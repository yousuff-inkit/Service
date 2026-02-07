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
		
		String strSql = "select compname,dbname from intercompany.my_intrcomp where status=3";   
		ResultSet rs = stmt.executeQuery(strSql);
		
		String emp="";
		String empid="";
		while(rs.next()) {
			emp+=rs.getString("compname")+",";
			empid+=rs.getString("dbname")+",";
	  		} 
		
		emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
		
		response.getWriter().write(emp+"####"+empid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
