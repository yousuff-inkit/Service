<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<% int statusid =request.getParameter("statusid")==null || request.getParameter("statusid")==""?0:Integer.parseInt(request.getParameter("statusid"));%>
<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select rowno srno,name process from sk_dispatchstatus where status=1 and dispatch=0 and process=1 order by rowno";
		ResultSet rs = stmt.executeQuery(strSql);  
		  
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("process")+",";
					sr+=rs.getString("srno")+",";
				} 
		
		String procc[]=pro.split(",");
		String brnId[]=sr.split(",");
		
		pro=pro.substring(0, pro.length()-1);
		sr=sr.substring(0, sr.length()-1);
		
		response.getWriter().write(sr+"####"+pro);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  