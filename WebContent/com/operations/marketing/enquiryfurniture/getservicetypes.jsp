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
		String strSql = "select groupname,grpno docno from my_groupvals where grptype='service' and status=3";
		//System.out.println("strSql = "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String enqbid="",enqbname="";
		while(rs.next()) {
			enqbid+=rs.getInt("docno")+",";
			enqbname+=rs.getString("groupname")+",";
		} 
		response.getWriter().write(enqbid+"####"+enqbname);    
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>