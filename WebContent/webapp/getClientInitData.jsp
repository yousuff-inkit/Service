<%@page import="webapp.ClsWebAppDAO"%>   
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
Connection conn=null;
String refname="";
JSONObject objstock=new JSONObject(); 
JSONObject objsurvey=new JSONObject(); 
ClsWebAppDAO dao=new ClsWebAppDAO(); 
String userid="1";

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	JSONArray brancharray=dao.getBranch(session,conn);
	objstock.put("branchdata",brancharray);
	JSONArray stockarray=dao.getStockData(userid,conn);
	objstock.put("stockdata", stockarray);
	JSONArray delnotearray=dao.getDeliveryNotes(conn);
	objstock.put("delnotedata",delnotearray);
	/* JSONArray surveyarray=dao.getSurveyData(userid,conn);
	objsurvey.put("surveydata", surveyarray);   */      
}      
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(refname+" :: "+objstock+" :: "+userid+" :: "+objsurvey);    
%>