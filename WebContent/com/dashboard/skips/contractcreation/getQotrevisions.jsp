<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection conobj= new ClsConnection();
	Connection conn = null;
	int revno = request.getParameter("revno")==null || request.getParameter("revno").trim().equals("")?0:Integer.parseInt(request.getParameter("revno").trim().toString());  
	try{
	 	conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();
		String group="";
		String groupid="";
		int i=revno;
		while(i>=0) {
			group+=i+",";		
			groupid+=i+","; 
			i--;  
	    } 
		
		group=group.substring(0, group.length()>0?group.length()-1:0);
		response.getWriter().write(group+"####"+groupid);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
