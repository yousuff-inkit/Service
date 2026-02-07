<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;      
	try{	
		ClsConnection ClsConnection=new ClsConnection();
		conn= ClsConnection.getMyConnection();  
		Statement stmt = conn.createStatement ();  
		int doc=0;
		String strSql = "select r.attachdelete from my_user u left join my_urole r on r.doc_no=u.role_id where u.doc_no='"+session.getAttribute("USERID")+"'";
		//System.out.println("strsql==="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);         
		while(rs.next()) {         
			doc=rs.getInt("attachdelete");  
  		}       
		stmt.close();
		conn.close();  

		response.getWriter().print(doc);        
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
%>