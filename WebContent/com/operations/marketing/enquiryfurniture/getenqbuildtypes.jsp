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
		String strSql = "select name,doc_no from gl_enqbuildtype where status=3";
		//System.out.println("strSql = "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String enqbid="",enqbname="";
		while(rs.next()) {
			enqbid+=rs.getInt("doc_no")+",";
			enqbname+=rs.getString("name")+",";
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