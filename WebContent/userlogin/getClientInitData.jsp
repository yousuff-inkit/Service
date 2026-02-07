<%@page import="userlogin.ClsUserLoginDAO"%>   
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
Connection conn=null;
String refname="";
JSONObject objservice=new JSONObject(); 
JSONObject objsurvey=new JSONObject(); 
ClsUserLoginDAO dao=new ClsUserLoginDAO(); 
String userid=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="select coalesce(user_name,'') refname from my_user where doc_no="+userid+"";
	ResultSet rs=stmt.executeQuery(strsql);     
	while(rs.next()){
		refname=rs.getString("refname");
	}
	JSONArray contractarray=dao.getContractData(userid,conn);
	objservice.put("contractdata", contractarray);
	
	JSONArray surveyarray=dao.getSurveyData(userid,conn);
	objsurvey.put("surveydata", surveyarray);        
}      
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(refname+" :: "+objservice+" :: "+userid+" :: "+objsurvey);    
%>