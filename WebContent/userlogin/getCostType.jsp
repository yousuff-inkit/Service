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
		
		String strSql = "select costtype,costgroup from my_costunit where status=1";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String costtype="";
		String costtypeid="";
		while(rs.next()) {
			costtype+=rs.getString("costgroup")+",";
			costtypeid+=rs.getString("costtype")+",";
	  		} 
		
		costtype=costtype.substring(0, costtype.length()>0?costtype.length()-1:0);
		
		response.getWriter().write(costtype+"####"+costtypeid);   
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
