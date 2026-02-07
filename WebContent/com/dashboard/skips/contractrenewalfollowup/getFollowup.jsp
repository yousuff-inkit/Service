<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select name,doc_no from cm_qotfollowstatus where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String prio="",sr="";
		while(rs.next()) {
			prio+=rs.getString("name")+",";
					sr+=rs.getString("doc_no")+",";
	    } 
		if(!prio.equalsIgnoreCase("")){
			String procc[]=prio.split(",");
			String brnId[]=sr.split(",");
			
			prio=prio.substring(0, prio.length()-1);
			sr=sr.substring(0, sr.length()-1);
		}  
		
		response.getWriter().write(sr+"####"+prio);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  