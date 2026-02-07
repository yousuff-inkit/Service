<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%        
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String dates=request.getParameter("date")==null?"NA":request.getParameter("date").trim();
	String clientid=request.getParameter("clientid").trim().toString();
	
	java.sql.Date masterdate = null;
	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))&&!(dates.equalsIgnoreCase("NA"))){
		masterdate=ClsCommon.changeStringtoSqlDate(dates);
		
	}
	
	String due_date="";
	
	String strSql = "select adddate('"+masterdate+"',coalesce(period2,0))due_date from my_acbook where dtype='CRM' and cldocno="+clientid;
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	if(rs.next()) {
		due_date=rs.getString("due_date");
	}
	
	stmt.close();
	conn.close();
	response.getWriter().print(due_date);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally {
	conn.close();
}
%>