<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>


<%	
Connection conn =null;
Statement stmt =null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

try{
String usertoid=request.getParameter("usertoid").trim();
//System.out.println("===usertoid==="+usertoid);

String msg=request.getParameter("msg").trim();
String userfrmid=request.getParameter("userfrmid").trim();
//System.out.println("===userfrmid==="+userfrmid);
   java.util.Date date=new java.util.Date();
   //System.out.println("==date====="+date);
   java.sql.Date sd=ClsCommon.getSqlDate(date);
   
 	 conn = ClsConnection.getMyConnection();
	 stmt = conn.createStatement ();
	String strSql = "insert into gw_mesngr(userfrm, userto, mesg, date,udate) values("+userfrmid+",'"+usertoid+"','"+msg+"','"+sd+"','"+date+"')";
	//System.out.println("strSql======"+strSql);
	int rs = stmt.executeUpdate(strSql);
	
	//System.out.println("result set"+rs);
	
	response.getWriter().print(rs);
	//System.out.println("aaaaaa       "+rs);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	stmt.close();
	conn.close();
}
	
	  
  %>
  
