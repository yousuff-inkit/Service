<%@page import="com.abzreports.ClsABZReportsDAO"%>   
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	Connection conn=null;
	JSONObject objchartdata=new JSONObject();
	ClsABZReportsDAO dao=new ClsABZReportsDAO();   
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();  
		java.sql.Date sqldate=null;
		String cldocno="0";  
	
		objchartdata=dao.getChartCountData(conn);      
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().print(objchartdata);
%>